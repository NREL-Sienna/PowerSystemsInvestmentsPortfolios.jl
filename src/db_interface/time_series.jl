const INFRASYS_TS_SCHEMA = Tables.Schema(
    [
        "id",
        "time_series_uuid",
        "time_series_type",
        "initial_timestamp",
        "resolution",
        "horizon",
        "interval",
        "window_count",
        "length",
        "name",
        "owner_uuid",
        "owner_type",
        "owner_category",
        "features",
        "scaling_factor_multiplier",
        "metadata_uuid",
        "units",
    ],
    [
        Int64,
        String,
        String,
        String,
        String,
        Union{Missing, String},
        Union{Missing, String},
        Union{Missing, Int64},
        Union{Missing, Int64},
        String,
        String,
        String,
        String,
        String,
        Union{Missing, String},
        Base.UUID,
        Union{Missing, String},
    ],
)

function get_uuid_mapping(sys::PSY.System)
    metadata_store = sys.data.time_series_manager.metadata_store

    time_series_uuids = IS.sql(
        metadata_store,
        """
        SELECT DISTINCT metadata_uuid, time_series_uuid, time_series_type, initial_timestamp, resolution, horizon, interval, window_count, length
        FROM time_series_associations
        """,
    )

    uuid_count = Dict{String, Int64}()
    uuid_mapping = Dict{String, Base.UUID}()

    for row in Tables.rows(time_series_uuids)
        uuid = row.time_series_uuid

        if haskey(uuid_count, uuid)
            new_uuid = Base.UUIDs.uuid4()
            uuid_count[uuid] += 1
            uuid_mapping[row.metadata_uuid] = new_uuid
        else
            uuid_count[uuid] = 1
            uuid_mapping[row.metadata_uuid] = Base.UUID(uuid)
        end
    end

    return uuid_mapping
end

function get_example_metadata_uuids(sys::Union{PSY.System, Portfolio})
    metadata_store = sys.data.time_series_manager.metadata_store

    return IS.sql(
        metadata_store,
        """
        SELECT time_series_uuid, metadata_uuid
        FROM time_series_associations GROUP BY time_series_uuid;
        """,
    )
end

function get_time_series_from_metadata_uuid(
    sys::Union{PSY.System, Portfolio},
    metadata_uuid,
)
    ts_metadata = sys.data.time_series_manager.metadata_store.metadata_uuids[metadata_uuid]

    start_time = IS._check_start_time(nothing, ts_metadata)
    rows = IS._get_rows(start_time, nothing, ts_metadata)
    columns = IS._get_columns(start_time, nothing, ts_metadata)
    storage = sys.data.time_series_manager.data_store

    return IS.deserialize_time_series(
        IS.time_series_metadata_to_data(ts_metadata),
        storage,
        ts_metadata,
        rows,
        columns,
    )
end

function serialize_timeseries_data!(
    db,
    ts::PSY.SingleTimeSeries,
    time_series_uuid::Base.UUID,
)
    stmt = DBInterface.prepare(
        db,
        """
        INSERT INTO static_time_series (uuid, idx, value)
        VALUES (?, ?, ?)
        """,
    )
    for (i, timestamp_value) in enumerate(ts)
        _, value = timestamp_value
        DBInterface.execute(stmt, (string(time_series_uuid), i, value))
    end
end

function serialize_timeseries_data!(
    db,
    ts::PSY.DeterministicSingleTimeSeries,
    time_series_uuid::Base.UUID,
)
    serialize_timeseries_data!(db, ts.single_time_series, time_series_uuid)
end

function serialize_all_timeseries_data!(db, sys::Union{PSY.System, Portfolio})
    time_series_uuid_to_metadata_uuids = get_example_metadata_uuids(sys)

    for (time_series_uuid, metadata_uuid) in eachrow(time_series_uuid_to_metadata_uuids)
        ts = get_time_series_from_metadata_uuid(sys, Base.UUID(metadata_uuid))
        serialize_timeseries_data!(db, ts, Base.UUID(time_series_uuid))
    end
end

function transform_associations!(sys::Union{PSY.System, Portfolio}, associations, refs)
    # Keep id disjointness when serializing portfolio TS after base-system TS: portfolio
    # association ids must be offset past every base-system `time_series_associations` row
    # (that table's id is a shared INTEGER PRIMARY KEY). The offset is the base ROW count —
    # NOT `components_with_time_series`, which undercounts any component owning more than one
    # time series and would let portfolio ids collide with base ids.
    counts = if isa(sys, Portfolio)
        base_store = get_base_system(sys).data.time_series_manager.metadata_store
        result =
            IS.sql(base_store, "SELECT COUNT(*) AS n FROM time_series_associations")
        Int(first(Tables.rows(result)).n)
    else
        0
    end

    associations = PSY.DataFrames.coalesce.(associations, nothing)
    associations[!, "scaling_factor_multiplier"] =
        map(associations[!, "scaling_factor_multiplier"]) do val
            val === nothing && return nothing
            d = JSON3.read(val, Dict{String, Any})
            meta = d["__metadata__"]
            return "$(meta["module"]).$(meta["function"])"
        end

    type_names = isa(sys, Portfolio) ? PSIP_TYPE_NAMES : PSY_TYPE_NAMES
    associations = associations[haskey.(Ref(type_names), associations[!, "owner_type"]), :]
    associations.id .+= counts

    uuid_to_id = _db_uuid_to_id(refs)
    owner_ids = Vector{Union{Missing, Int}}(missing, size(associations, 1))
    keep = falses(size(associations, 1))
    for (i, owner_uuid) in enumerate(associations[!, "owner_uuid"])
        uuid = Base.UUID(owner_uuid)
        if haskey(uuid_to_id, uuid)
            owner_ids[i] = Int(uuid_to_id[uuid])
            keep[i] = true
        end
    end
    associations = associations[keep, :]
    associations[!, "owner_id"] = owner_ids[keep]

    PSY.DataFrames.select!(
        associations,
        Symbol.(collect(TABLE_SCHEMAS["time_series_associations"].names)),
    )
    return associations
end

function serialize_timeseries_associations!(db, sys::Union{PSY.System, Portfolio}, refs)
    associations = IS.sql(
        sys.data.time_series_manager.metadata_store,
        """SELECT $(join(INFRASYS_TS_SCHEMA.names, ", "))
FROM time_series_associations;""",
    )
    associations = transform_associations!(sys, associations, refs)

    statement = DBInterface.prepare(
        db,
        """INSERT INTO time_series_associations ($(join(TABLE_SCHEMAS["time_series_associations"].names, ", ")))
VALUES ($(join(repeat("?", length(TABLE_SCHEMAS["time_series_associations"].names)), ", ")))""",
    )

    for row in Tables.rowtable(associations)
        DBInterface.execute(statement, tuple(row...))
    end
end

function serialize_timeseries!(db, sys::Union{PSY.System, Portfolio}, refs)
    DBInterface.transaction(db) do
        serialize_all_timeseries_data!(db, sys)
        serialize_timeseries_associations!(db, sys, refs)
    end
end

function deserialize_timedata(db, sts_meta::IS.SingleTimeSeriesMetadata, time_series_uuid)
    stmt = DBInterface.prepare(
        db,
        """
        SELECT idx, value
        FROM static_time_series
        WHERE uuid = ?
        ORDER BY idx
        """,
    )
    rows = DBInterface.execute(stmt, (string(time_series_uuid),))
    column_table = Tables.columntable(rows)
    timestamps =
        range(sts_meta.initial_timestamp; length=sts_meta.length, step=sts_meta.resolution)
    return PSY.TimeSeries.TimeArray(timestamps, column_table.value)
end

function deserialize_timedata(_, ts::IS.DeterministicMetadata, _)
    error("Cannot deserialize deterministic timeseries $ts")
end

function deserialize_time_series_row!(sys, db, row)
    metadata = deserialize_metadata(row)
    if isa(metadata, IS.DeterministicMetadata) &&
       metadata.time_series_type <: IS.DeterministicSingleTimeSeries
        component = PSY.get_component(sys, row.owner_uuid)
        IS.add_metadata!(sys.data.time_series_manager.metadata_store, component, metadata)
    else
        time_array = deserialize_timedata(db, metadata, row.time_series_uuid)
        ts = IS.time_series_metadata_to_data(metadata)(metadata, time_array)
        PSY.add_time_series!(sys, PSY.get_component(sys, row.owner_uuid), ts)
    end
end

function deserialize_metadata(row)
    exclude_keys = Set((:metadata_uuid, :owner_uuid, :time_series_type))
    time_series_type = IS.TIME_SERIES_STRING_TO_TYPE[row.time_series_type]
    metadata_type = IS.time_series_data_to_metadata(time_series_type)
    fields = Set(fieldnames(metadata_type))
    data = Dict{Symbol, Any}(
        :internal =>
            IS.InfrastructureSystemsInternal(; uuid=Base.UUID(row.metadata_uuid)),
    )
    if time_series_type <: IS.Forecast
        data[:count] = row.window_count
    end
    if time_series_type <: IS.AbstractDeterministic
        data[:time_series_type] = time_series_type
    end
    for field in keys(row)
        if !in(field, fields) || field in exclude_keys
            continue
        end
        val = getproperty(row, field)
        if field == :initial_timestamp
            data[field] = Dates.DateTime(val)
        elseif field == :resolution
            data[field] = IS.from_iso_8601(val)
        elseif field == :horizon || field == :interval
            if !ismissing(val)
                data[field] = IS.from_iso_8601(val)
            end
        elseif field == :time_series_uuid
            data[field] = Base.UUID(val)
        elseif field == :features
            features_array = JSON3.read(val, Array)
            features_dict = Dict{String, Union{Bool, Int, String}}()
            for obj in features_array
                length(obj) != 1 && error("Invalid features: $obj")
                key = first(keys(obj))
                key in keys(features_dict) && error("Duplicate features: $key")
                features_dict[key] = obj[key]
            end
            data[field] = features_dict
        elseif field == :scaling_factor_multiplier
            if !ismissing(val)
                mod_str, func_str = split(val, ".")
                data[field] = IS.get_type_from_strings(String(mod_str), String(func_str))
            end
        else
            data[field] = val
        end
    end
    metadata = metadata_type(; data...)
    return metadata
end

_owner_type_in_clause(names) =
    "owner_type IN ($(join(("'$k'" for k in keys(names)), ", ")))"

function get_example_metadata(db, sys::PSY.System)
    clause = _owner_type_in_clause(PSY_TYPE_NAMES)
    time_series_uuid_rows = DBInterface.execute(
        db,
        "SELECT * FROM time_series_associations WHERE time_series_type != 'DeterministicSingleTimeSeries' AND $clause GROUP BY time_series_uuid",
    )
    return time_series_uuid_rows
end

function get_example_metadata(db, sys::Portfolio)
    clause = _owner_type_in_clause(PSIP_TYPE_NAMES)
    time_series_uuid_rows = DBInterface.execute(
        db,
        "SELECT * FROM time_series_associations WHERE time_series_type != 'DeterministicSingleTimeSeries' AND $clause GROUP BY time_series_uuid",
    )
    return time_series_uuid_rows
end

function deserialize_time_series_from_metadata!(
    sys::Union{PSY.System, Portfolio},
    db,
    refs,
    metadata,
    row,
)
    time_array = deserialize_timedata(db, metadata, row.time_series_uuid)
    ts = IS.time_series_metadata_to_data(metadata)(metadata, time_array)
    IS.add_time_series!(sys.data, _db_resolve_owner(refs, Int(row.owner_id)), ts)
end

function deserialize_timeseries!(sys::Union{PSY.System, Portfolio}, db, refs)
    DBInterface.transaction(db) do
        serialized_metadata = Set{String}()
        for row in get_example_metadata(db, sys)
            metadata = deserialize_metadata(row)
            deserialize_time_series_from_metadata!(sys, db, refs, metadata, row)
            push!(serialized_metadata, row.metadata_uuid)
        end

        if isa(sys, PSY.System)
            clause = _owner_type_in_clause(PSY_TYPE_NAMES)
            associations = DBInterface.execute(
                db,
                "SELECT * FROM time_series_associations WHERE $clause",
            )
        else
            clause = _owner_type_in_clause(PSIP_TYPE_NAMES)
            associations = DBInterface.execute(
                db,
                "SELECT * FROM time_series_associations WHERE $clause",
            )
        end

        for row in associations
            metadata = deserialize_metadata(row)
            if in(row.metadata_uuid, serialized_metadata)
                continue
            end
            component = _db_resolve_owner(refs, Int(row.owner_id))
            IS.add_metadata!(
                sys.data.time_series_manager.metadata_store,
                component,
                metadata,
            )
        end
    end
end

function export_time_series_dict(db; include_data::Bool=false)
    ts_output = Dict{String, Any}()

    association_cols = TABLE_SCHEMAS["time_series_associations"].names
    stmt = DBInterface.prepare(
        db,
        "SELECT $(join(association_cols, ", ")) FROM time_series_associations",
    )
    rows = DBInterface.execute(stmt)
    ts_associations = Vector{Dict{String, Any}}()
    for row in rows
        assoc = Dict{String, Any}()
        for col in association_cols
            val = getproperty(row, col)
            val = ismissing(val) ? nothing : val
            key = string(col)
            if key in JSON_COLUMNS && val isa String
                val = JSON3.read(val, Any)
            end
            assoc[key] = val
        end
        push!(ts_associations, assoc)
    end
    ts_output["associations"] = ts_associations

    if include_data
        data_stmt = DBInterface.prepare(
            db,
            "SELECT uuid, idx, value FROM static_time_series ORDER BY uuid, idx",
        )
        data_rows = DBInterface.execute(data_stmt)
        ts_data = Dict{String, Vector{Float64}}()
        for row in data_rows
            uuid = row.uuid
            if !haskey(ts_data, uuid)
                ts_data[uuid] = Vector{Float64}()
            end
            push!(ts_data[uuid], row.value)
        end
        ts_output["data"] = ts_data
    end

    return ts_output
end
