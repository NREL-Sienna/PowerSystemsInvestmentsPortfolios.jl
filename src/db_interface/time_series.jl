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

    # Create a mapping from original time_series_uuid to new unique UUIDs for duplicates
    uuid_count = Dict{String, Int64}()
    uuid_mapping = Dict{String, Base.UUID}()

    for row in Tables.rows(time_series_uuids)
        uuid = row.time_series_uuid

        if haskey(uuid_count, uuid)
            # Duplicate found, assign a new UUID
            new_uuid = UUIDs.uuid4()
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

"""
Writes time series as rows (time_series_uuid, timestamp, value)
"""
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

"""
Writes time series as rows (time_series_uuid, timestamp, value)
"""
function serialize_timeseries_data!(
    db,
    ts::PSY.DeterministicSingleTimeSeries,
    time_series_uuid::Base.UUID,
)
    serialize_time_series_data(db, ts.single_time_series, time_series_uuid)
end

"""
Iterate through all metadata objects and serialize timeseries
"""
function serialize_all_timeseries_data!(db, sys::Union{PSY.System, Portfolio})
    time_series_uuid_to_metadata_uuids = get_example_metadata_uuids(sys)

    for (time_series_uuid, metadata_uuid) in eachrow(time_series_uuid_to_metadata_uuids)
        ts = get_time_series_from_metadata_uuid(sys, Base.UUID(metadata_uuid))
        serialize_timeseries_data!(db, ts, Base.UUID(time_series_uuid))
    end
end

function transform_associations!(
    sys::Union{PSY.System, Portfolio},
    associations,
    ids::IDGenerator,
)

    # Determine number of associations in the base system to offset IDs from portfolio
    if isa(sys, Portfolio)
        all_counts = PSY.get_time_series_counts(get_base_system(sys))
        counts = all_counts.components_with_time_series
    else
        counts = 0
    end

    associations = PSY.DataFrames.coalesce.(associations, nothing)
    # Convert IS's JSON-encoded scaling_factor_multiplier to dot-encoded string
    associations[!, "scaling_factor_multiplier"] =
        map(associations[!, "scaling_factor_multiplier"]) do val
            val === nothing && return nothing
            d = IS.JSON3.read(val, Dict{String, Any})
            meta = d["__metadata__"]
            return "$(meta["module"]).$(meta["function"])"
        end
    associations.id .+= counts
    deserializable_string(x) = haskey(TYPE_NAMES, x)

    associations = associations[deserializable_string.(associations[!, "owner_type"]), :]
    associations[!, "owner_id"] =
        map(owner_uuid -> getid!(ids, Base.UUID(owner_uuid)), associations[!, "owner_uuid"])
    PSY.DataFrames.select!(
        associations,
        Symbol.(collect(TABLE_SCHEMAS["time_series_associations"].names)),
    )
    return associations
end

function serialize_timeseries_associations!(
    db,
    sys::Union{PSY.System, Portfolio},
    ids::IDGenerator,
)
    associations = IS.sql(
        sys.data.time_series_manager.metadata_store,
        """SELECT $(join(INFRASYS_TS_SCHEMA.names, ", "))
FROM time_series_associations;""",
    )
    associations = transform_associations!(sys, associations, ids)

    statement = DBInterface.prepare(
        db,
        """INSERT INTO time_series_associations ($(join(TABLE_SCHEMAS["time_series_associations"].names, ", ")))
VALUES ($(join(repeat("?", length(TABLE_SCHEMAS["time_series_associations"].names)), ", ")))""",
    )

    for row in Tables.rowtable(associations)
        DBInterface.execute(statement, tuple(row...))
    end
end

function serialize_timeseries!(db, sys::Union{PSY.System, Portfolio}, ids::IDGenerator)
    DBInterface.transaction(db) do
        serialize_all_timeseries_data!(db, sys)
        serialize_timeseries_associations!(db, sys, ids)
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

# TODO: STOLEN FROM IS. This should be made an IS functions.
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
        # Special case because the table column does not match the field name.
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
            features_array = IS.JSON3.read(val, Array)
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

_owner_type_in_clause(
    names,
) = "owner_type IN ($(join(("'$k'" for k in keys(names)), ", ")))"

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
    resolver::Resolver,
    metadata,
    row,
)
    time_array = deserialize_timedata(db, metadata, row.time_series_uuid)
    ts = IS.time_series_metadata_to_data(metadata)(metadata, time_array)
    IS.add_time_series!(sys.data, resolve_owner(resolver, row.owner_id), ts)
end

function deserialize_timeseries!(
    sys::Union{PSY.System, Portfolio},
    db,
    resolver::Resolver,
)
    DBInterface.transaction(db) do
        # For each time_series_uuid, we'll pick a "real" metadata_uuid (so no DeterministicSingleTimeSeries),
        # then we will deserialize and add them to the system. Finally, we'll go through and add_metadata!
        # for all others.
        serialized_metadata = Set{String}()
        for row in get_example_metadata(db, sys)
            metadata = deserialize_metadata(row)
            deserialize_time_series_from_metadata!(sys, db, resolver, metadata, row)
            push!(serialized_metadata, row.metadata_uuid)
        end

        if isa(sys, PSY.System)
            clause = _owner_type_in_clause(PSY_TYPE_NAMES)
            associations = DBInterface.execute(
                db,
                "SELECT * FROM time_series_associations WHERE $clause",
            )
        elseif isa(sys, Portfolio)
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
            component = resolve_owner(resolver, row.owner_id)
            IS.add_metadata!(
                sys.data.time_series_manager.metadata_store,
                component,
                metadata,
            )
        end
    end
end

"""
Export time series from the database as a JSON-compatible dictionary.

Returns a Dict with:

  - `"associations"`: Vector of association metadata dicts
  - `"data"` (optional): Dict mapping time_series_uuid to Vector{Float64} of values

The `"data"` field is only included when `include_data=true`. When time series
values are stored externally (e.g., in an HDF5 file), omit it.
"""
function export_time_series_dict(db; include_data::Bool=false)
    ts_output = Dict{String, Any}()

    # Export associations
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
                val = JSON.parse(val)
            end
            assoc[key] = val
        end
        push!(ts_associations, assoc)
    end
    ts_output["associations"] = ts_associations

    # Optionally export raw time series values
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
