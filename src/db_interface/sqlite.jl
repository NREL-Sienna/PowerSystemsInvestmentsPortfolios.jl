import SQLite
import DBInterface
using Tables

_db_to_openapi_fields(::OpenAPIRefs) = DB_TO_PSIP_OPENAPI_FIELDS
_db_to_openapi_fields(::PSY.OpenAPIRefs) = DB_TO_OPENAPI_FIELDS
_openapi_to_db_fields(::OpenAPIRefs) = PSIP_OPENAPI_FIELDS_TO_DB
_openapi_to_db_fields(::PSY.OpenAPIRefs) = OPENAPI_FIELDS_TO_DB

function get_row_field(
    c::OpenAPI.APIModel,
    table_name::AbstractString,
    col_name::Symbol,
    db_to_openapi_fields,
)
    col_str = string(col_name)
    k = Symbol(get(db_to_openapi_fields, (table_name, col_str), col_name))

    hasproperty(c, k) || return nothing
    val = getproperty(c, k)

    if col_str in JSON_COLUMNS && val !== nothing
        if col_str == "fuel" && table_name == "thermal_generators"
            return val
        end
        # Route through OpenAPI.to_json, not JSON3.write: a `oneOf` field (ValueCurve,
        # OperationalCost, …) or a compound holding one must have its discriminator stamped
        # and wrappers unwrapped, which JSON3 does not do — the raw form fails `OpenAPI.from_json`
        # on import (`KeyError` on the missing discriminator). Also lowers APIModels nested in
        # Dict/Vector columns (e.g. `cofire_start_limits::Dict{String,MinMax}`).
        return OpenAPI.to_json(val)
    end

    return val
end

function _ignoreattribute(
    ::Type{T},
    table_name::AbstractString,
    schema::Tables.Schema,
    k::AbstractString,
    openapi_to_db_fields,
) where {T <: OpenAPI.APIModel}
    col_name = get(openapi_to_db_fields, (table_name, k), k)
    return in(Symbol(col_name), schema.names)
end

function _ignoreattribute(
    ::Type{PO.HydroReservoir},
    table_name::AbstractString,
    schema::Tables.Schema,
    k::AbstractString,
    openapi_to_db_fields,
)
    if k in ("upstream_turbines", "downstream_turbines", "upstream_reservoirs")
        return true
    end
    col_name = get(openapi_to_db_fields, (table_name, k), k)
    return in(Symbol(col_name), schema.names)
end

function insert_attributes!(
    ::Type{T},
    table_name::AbstractString,
    schema::Tables.Schema,
    attribute_statement,
    c::OpenAPI.APIModel,
    openapi_to_db_fields,
) where {T <: OpenAPI.APIModel}
    for (k, v) in JSON3.read(OpenAPI.to_json(c), Dict{String, Any})
        if !_ignoreattribute(T, table_name, schema, k, openapi_to_db_fields)
            DBInterface.execute(
                attribute_statement,
                (Int(c.id), "FromSienna", k, JSON3.write(v)),
            )
        end
    end
end

function get_row(
    table_name::AbstractString,
    schema::Tables.Schema,
    c::OpenAPI.APIModel,
    ::Union{PSY.Component, Technology, RegionTopology, Requirement},
    db_to_openapi_fields,
)
    return tuple(
        (
            get_row_field(c, table_name, col_name, db_to_openapi_fields) for
            (col_name, col_type) in zip(schema.names, schema.types)
        )...,
    )
end

function get_row(
    table_name::AbstractString,
    schema::Tables.Schema,
    c::PO.ThermalStandard,
    ::PSY.ThermalStandard,
    db_to_openapi_fields,
)
    return tuple(
        (
            col_name == :fuel ? c.fuel_type :
            get_row_field(c, table_name, col_name, db_to_openapi_fields) for
            (col_name, col_type) in zip(schema.names, schema.types)
        )...,
    )
end

function insert_uuid!(attribute_statement, table_name, id, uuid)
    DBInterface.execute(
        attribute_statement,
        (Int(id), table_name, "uuid", JSON3.write(string(uuid))),
    )
end

function add_components_to_tables!(
    ::Type{T},
    table_name::AbstractString,
    schema::Tables.Schema,
    table_statement::DBInterface.Statement,
    entity_statement::DBInterface.Statement,
    attribute_statement::DBInterface.Statement,
    components,
    refs,
) where {T <: OpenAPI.APIModel}
    db_to_openapi_fields = _db_to_openapi_fields(refs)
    openapi_to_db_fields = _openapi_to_db_fields(refs)
    for component in components
        uuid = IS.get_uuid(component)
        openapi_component = _convert_to_openapi(component, refs)
        row =
            get_row(table_name, schema, openapi_component, component, db_to_openapi_fields)
        try
            DBInterface.execute(entity_statement, (Int(openapi_component.id),))
            DBInterface.execute(table_statement, row)
        catch e
            if isa(e, SQLite.SQLiteException)
                error("Failed to insert into $(table_name): $(e.msg) with values $(row)")
            else
                rethrow(e)
            end
        end
        insert_attributes!(
            T,
            table_name,
            schema,
            attribute_statement,
            openapi_component,
            openapi_to_db_fields,
        )
        insert_uuid!(attribute_statement, table_name, Int(openapi_component.id), uuid)
    end
end

function prepare_schema_insert(db, table_name::AbstractString, schema::Tables.Schema)
    return DBInterface.prepare(
        db,
        """INSERT INTO $table_name ($(join(schema.names, ", ")))
          VALUES ($(join(repeat("?", length(schema.names)), ", ")))""",
    )
end

function prepare_entity_insert(db, table_name::AbstractString, obj_type::AbstractString)
    return DBInterface.prepare(
        db,
        "INSERT INTO entities (id, entity_table, entity_type) VALUES (?, '$table_name', '$obj_type')",
    )
end

function prepare_attributes_insert(db)
    return DBInterface.prepare(
        db,
        "INSERT INTO attributes (entity_id, type, name, value) VALUES (?, ?, ?, json(?))",
    )
end

function send_table_to_db!(
    ::Type{PO.AreaInterchange},
    db,
    components,
    refs::PSY.OpenAPIRefs,
    counter::DBIdCounter,
)
    table_name = "transmission_interchanges"
    obj_type = "AreaInterchange"
    schema = TABLE_SCHEMAS[table_name]
    table_statement = prepare_schema_insert(db, table_name, schema)
    arc_statement = prepare_schema_insert(db, "arcs", TABLE_SCHEMAS["arcs"])
    arc_entity_statement = prepare_entity_insert(db, "arcs", "Arc")
    attribute_statement = prepare_attributes_insert(db)
    entity_statement = prepare_entity_insert(db, table_name, obj_type)

    for c in components
        uuid = IS.get_uuid(c)
        c = _convert_to_openapi(c, refs)
        new_id = _next_id!(counter)
        DBInterface.execute(arc_entity_statement, (new_id,))
        DBInterface.execute(arc_statement, (new_id, Int(c.from_area), Int(c.to_area)))
        row = (Int(c.id), c.name, new_id, c.flow_limits.to_from, c.flow_limits.from_to)
        DBInterface.execute(entity_statement, (Int(c.id),))
        DBInterface.execute(table_statement, row)
        insert_attributes!(
            PO.AreaInterchange,
            table_name,
            schema,
            attribute_statement,
            c,
            OPENAPI_FIELDS_TO_DB,
        )
        insert_uuid!(attribute_statement, table_name, Int(c.id), uuid)
    end
end

function send_table_to_db!(::Type{PO.HydroReservoir}, db, components, refs)
    table_name = "hydro_reservoirs"
    obj_type = "HydroReservoir"
    schema = TABLE_SCHEMAS[table_name]
    table_statement = prepare_schema_insert(db, table_name, schema)
    entity_statement = prepare_entity_insert(db, table_name, obj_type)
    attribute_statement = prepare_attributes_insert(db)
    connection_statement = DBInterface.prepare(
        db,
        "INSERT INTO hydro_reservoir_connections (source_id, sink_id) VALUES (?, ?)",
    )

    for component in components
        uuid = IS.get_uuid(component)
        openapi_component = _convert_to_openapi(component, refs)
        row =
            get_row(table_name, schema, openapi_component, component, DB_TO_OPENAPI_FIELDS)
        DBInterface.execute(entity_statement, (Int(openapi_component.id),))
        DBInterface.execute(table_statement, row)
        insert_attributes!(
            PO.HydroReservoir,
            table_name,
            schema,
            attribute_statement,
            openapi_component,
            OPENAPI_FIELDS_TO_DB,
        )
        insert_uuid!(attribute_statement, table_name, Int(openapi_component.id), uuid)

        if !isnothing(openapi_component.downstream_turbines)
            for turbine_id in openapi_component.downstream_turbines
                DBInterface.execute(
                    connection_statement,
                    (Int(openapi_component.id), Int(turbine_id)),
                )
            end
        end

        if !isnothing(openapi_component.upstream_turbines)
            for turbine_id in openapi_component.upstream_turbines
                DBInterface.execute(
                    connection_statement,
                    (Int(turbine_id), Int(openapi_component.id)),
                )
            end
        end

        if !isnothing(openapi_component.upstream_reservoirs)
            for upstream_reservoir_id in openapi_component.upstream_reservoirs
                DBInterface.execute(
                    connection_statement,
                    (Int(upstream_reservoir_id), Int(openapi_component.id)),
                )
            end
        end
    end
end

function send_table_to_db!(::Type{T}, db, components, refs, counter=nothing) where {T}
    table_name = TYPE_TO_TABLE[T]
    obj_type = string(nameof(T))
    schema = TABLE_SCHEMAS[table_name]
    return add_components_to_tables!(
        T,
        table_name,
        schema,
        prepare_schema_insert(db, table_name, schema),
        prepare_entity_insert(db, table_name, obj_type),
        prepare_attributes_insert(db),
        components,
        refs,
    )
end

function _supplemental_type_zip(::PSY.System)
    return zip(ALL_SA_PSY_TYPES, ALL_SA_OPENAPI_TYPES)
end

function _supplemental_type_zip(::Portfolio)
    return zip(ALL_SA_PSIP_TYPES, ALL_SA_PSIP_OPENAPI_TYPES)
end

function serialize_supplemental_attributes!(db, sys::Union{PSY.System, Portfolio}, refs)
    entity_stmt = DBInterface.prepare(
        db,
        "INSERT INTO entities (id, entity_table, entity_type) VALUES (?, 'supplemental_attributes', ?)",
    )
    sa_stmt = DBInterface.prepare(
        db,
        "INSERT INTO supplemental_attributes (id, TYPE, value) VALUES (?, ?, json(?))",
    )

    for (SIENNA_T, OPENAPI_T) in _supplemental_type_zip(sys)
        for attr in IS.get_supplemental_attributes(SIENNA_T, sys.data)
            openapi_attr = _convert_to_openapi(attr, refs)
            type_name = string(nameof(OPENAPI_T))
            DBInterface.execute(entity_stmt, (Int(openapi_attr.id), type_name))
            DBInterface.execute(
                sa_stmt,
                (Int(openapi_attr.id), type_name, OpenAPI.to_json(openapi_attr)),
            )
        end
    end
end

function serialize_supplemental_attribute_associations!(
    db,
    sys::Union{PSY.System, Portfolio},
    refs,
)
    assoc_stmt = DBInterface.prepare(
        db,
        "INSERT INTO supplemental_attributes_association (attribute_id, entity_id) VALUES (?, ?)",
    )

    uuid_to_id = _db_uuid_to_id(refs)
    records = IS.to_records(sys.data.supplemental_attribute_manager.associations)
    for record in records
        attr_uuid = Base.UUID(record.attribute_uuid)
        comp_uuid = Base.UUID(record.component_uuid)
        if !haskey(uuid_to_id, attr_uuid) || !haskey(uuid_to_id, comp_uuid)
            continue
        end
        DBInterface.execute(
            assoc_stmt,
            (Int(uuid_to_id[attr_uuid]), Int(uuid_to_id[comp_uuid])),
        )
    end
end

function _warn_uncovered_psy_types(sys::PSY.System)
    allowed = Set{DataType}(ALL_PSY_TYPES)
    present = Set{DataType}()
    for c in IS.get_masked_components(IS.InfrastructureSystemsComponent, sys.data)
        c isa PSY.Component || continue
        push!(present, typeof(c))
    end
    missing = sort!([T for T in present if !(T in allowed)]; by=x -> string(x))
    isempty(missing) ||
        @warn "Skipping PSY component types not covered by ALL_PSY_TYPES" missing_types =
            missing
end

function _register_psy_refs!(refs::PSY.OpenAPIRefs, counter::DBIdCounter, sys::PSY.System)
    _warn_uncovered_psy_types(sys)
    for T in ALL_PSY_TYPES
        for c in PSY.get_components(T, sys)
            refs[_next_id!(counter)] = c
        end
    end
    for SA_T in ALL_SA_PSY_TYPES
        for attr in PSY.get_supplemental_attributes(SA_T, sys)
            refs[_next_id!(counter)] = attr
        end
    end
end

function _register_psip_refs!(portfolio::Portfolio)
    refs = OpenAPIRefs()
    for psip_type in ALL_PSIP_TYPES
        for component in IS.get_components(psip_type, portfolio.data)
            refs[Int(get_id(component))] = component
        end
    end
    for attribute_type in ALL_SA_PSIP_TYPES
        for attribute in IS.get_supplemental_attributes(attribute_type, portfolio.data)
            refs[Int(get_id(attribute))] = attribute
        end
    end
    return refs
end

function sys2db!(db, sys::PSY.System, start_id::Integer; time_series=false)
    counter = DBIdCounter(Int(start_id))
    refs = PSY.OpenAPIRefs("NATURAL_UNITS", PSY.get_base_power(sys))
    _register_psy_refs!(refs, counter, sys)

    DBInterface.transaction(db) do
        for (T, OPENAPI_T) in zip(ALL_PSY_TYPES, PSY_DESERIALIZABLE_TYPES)
            components = PSY.get_components(T, sys)
            if OPENAPI_T === PO.AreaInterchange
                send_table_to_db!(OPENAPI_T, db, components, refs, counter)
            else
                send_table_to_db!(OPENAPI_T, db, components, refs)
            end
        end
        serialize_supplemental_attributes!(db, sys, refs)
        serialize_supplemental_attribute_associations!(db, sys, refs)
    end

    if time_series
        serialize_timeseries!(db, sys, refs)
    end

    return (next_id=counter.next, refs=refs)
end

function sys2db!(db, sys::PSY.System; time_series=false)
    return sys2db!(db, sys, 1; time_series=time_series)
end

function get_entity_attributes(db)
    attributes_query = """
    SELECT entity_id,
           json_group_object(name, json(value)) AS attribute_json
    FROM attributes
    GROUP BY entity_id
    """

    attributes_result = DBInterface.execute(db, attributes_query, strict=true)
    attributes_dict = Dict{Int64, Dict{String, Any}}()
    for row in attributes_result
        attributes_dict[Int64(row.entity_id)] =
            JSON3.read(row.attribute_json, Dict{String, Any})
    end

    return attributes_dict
end

const JSON_COLUMNS = Set([
    "operation_cost",
    "active_power_limits",
    "reactive_power_limits",
    "ramp_limits",
    "time_limits",
    "outflow_limits",
    "storage_level_limits",
    "input_active_power_limits",
    "output_active_power_limits",
    "efficiency",
    "spillage_limits",
    "head_to_volume_factor",
    "region",
    "fuel",
    "capacity_limits",
    "capacity_limits_charge",
    "capacity_limits_discharge",
    "capacity_limits_energy",
    "co2",
    "capital_costs",
    "capital_costs_charge",
    "capital_costs_discharge",
    "capital_costs_energy",
    "operation_costs",
    "cofire_start_limits",
    "cofire_level_limits",
    "financial_data",
    "unserved_demand_curve",
    "duration_limits",
    "features",
])

_convert_sqlite_value(val, ::Type{T}) where {T} = val
_convert_sqlite_value(val::Integer, ::Type{Bool}) = val != 0
_convert_sqlite_value(val::Integer, ::Type{Union{Bool, Nothing}}) = val != 0
_convert_sqlite_value(::Missing, ::Type{Union{T, Nothing}}) where {T} = nothing
_convert_sqlite_value(::Nothing, ::Type{Union{T, Nothing}}) where {T} = nothing

function _get_column_type(table_name::AbstractString, col_name::Symbol)
    schema = get(TABLE_SCHEMAS, table_name, nothing)
    schema === nothing && return Any
    idx = findfirst(==(col_name), schema.names)
    idx === nothing && return Any
    return schema.types[idx]
end

function _build_openapi_dict(table_name::AbstractString, row, db_to_openapi_fields)
    dict = Dict{String, Any}()
    for (k, v) in zip(propertynames(row), row)
        expected_type = _get_column_type(table_name, k)
        val = _convert_sqlite_value(coalesce(v, nothing), expected_type)
        val === nothing && continue
        key = get(db_to_openapi_fields, (table_name, string(k)), string(k))
        if key in JSON_COLUMNS && val isa String
            if !(key == "fuel" && table_name == "thermal_generators")
                val = JSON3.read(val, Any)
            end
        end
        dict[key] = val
    end
    return dict
end

_is_psip_openapi_type(::Type{T}) where {T} = T in PSIP_DESERIALIZABLE_TYPES

function _dict_field_map(::Type{T}) where {T}
    return _is_psip_openapi_type(T) ? DB_TO_PSIP_OPENAPI_FIELDS : DB_TO_OPENAPI_FIELDS
end

function build_component_dict(
    ::Type{T},
    db,
    table_name::AbstractString,
    row,
    attributes::Dict{Int64, Dict{String, Any}},
) where {T}
    extra_attrs = get(attributes, Int(row.id), Dict{String, Any}())
    base_dict = _build_openapi_dict(table_name, row, _dict_field_map(T))
    return merge(base_dict, extra_attrs)
end

function build_component_dict(
    ::Type{PO.AreaInterchange},
    db,
    table_name::AbstractString,
    row,
    attributes::Dict{Int64, Dict{String, Any}},
)
    extra_attrs = get(attributes, Int(row.id), Dict{String, Any}())
    base_dict = _build_openapi_dict(table_name, row, DB_TO_OPENAPI_FIELDS)
    base_dict["flow_limits"] =
        Dict{String, Any}("from_to" => row.max_flow_to, "to_from" => row.max_flow_from)
    return merge(base_dict, extra_attrs)
end

function _prepare_hydro_stmts(db)
    return (
        downstream_turbines=DBInterface.prepare(
            db,
            """
            SELECT hrc.sink_id FROM hydro_reservoir_connections hrc
            JOIN entities e ON hrc.sink_id = e.id
            WHERE hrc.source_id = ? AND e.entity_table IN ('hydro_generators', 'storage_units')
            """,
        ),
        upstream_turbines=DBInterface.prepare(
            db,
            """
            SELECT hrc.source_id FROM hydro_reservoir_connections hrc
            JOIN entities e ON hrc.source_id = e.id
            WHERE hrc.sink_id = ? AND e.entity_table IN ('hydro_generators', 'storage_units')
            """,
        ),
        upstream_reservoirs=DBInterface.prepare(
            db,
            """
            SELECT hrc.source_id FROM hydro_reservoir_connections hrc
            JOIN entities e ON hrc.source_id = e.id
            WHERE hrc.sink_id = ? AND e.entity_table = 'hydro_reservoirs'
            """,
        ),
    )
end

function build_component_dict(
    ::Type{PO.HydroReservoir},
    table_name::AbstractString,
    row,
    attributes::Dict{Int64, Dict{String, Any}},
    hydro_stmts::NamedTuple,
)
    extra_attrs = get(attributes, Int(row.id), Dict{String, Any}())

    downstream_turbines = Int64[
        r.sink_id for
        r in DBInterface.execute(hydro_stmts.downstream_turbines, (Int(row.id),))
    ]
    upstream_turbines = Int64[
        r.source_id for
        r in DBInterface.execute(hydro_stmts.upstream_turbines, (Int(row.id),))
    ]
    upstream_reservoirs = Int64[
        r.source_id for
        r in DBInterface.execute(hydro_stmts.upstream_reservoirs, (Int(row.id),))
    ]

    base_dict = _build_openapi_dict(table_name, row, DB_TO_OPENAPI_FIELDS)
    base_dict["downstream_turbines"] = downstream_turbines
    base_dict["upstream_turbines"] = upstream_turbines
    base_dict["upstream_reservoirs"] = upstream_reservoirs
    return merge(base_dict, extra_attrs)
end

function foreach_component_dict(f, db, type_list)
    attributes = get_entity_attributes(db)
    hydro_stmts = _prepare_hydro_stmts(db)
    for OPENAPI_T in type_list
        table_name = TYPE_TO_TABLE[OPENAPI_T]
        type_name = string(nameof(OPENAPI_T))
        query = get_query_for_table_name(table_name)
        rows = DBInterface.execute(db, query, (type_name,))
        if OPENAPI_T === PO.HydroReservoir
            for row in rows
                dict = build_component_dict(
                    OPENAPI_T,
                    table_name,
                    row,
                    attributes,
                    hydro_stmts,
                )
                f(OPENAPI_T, dict)
            end
        else
            for row in rows
                dict = build_component_dict(OPENAPI_T, db, table_name, row, attributes)
                f(OPENAPI_T, dict)
            end
        end
    end
end

const ARC_QUERY = """
SELECT a.* FROM arcs a
LEFT JOIN entities e ON a.id = e.id
LEFT JOIN entities e_from ON a.from_id = e_from.id
WHERE e_from.entity_type IN ('ACBus', 'DCBus') AND
    e.entity_type = ? AND
    e.entity_table = 'arcs'
"""

const TRANSMISSION_INTERCHANGE_QUERY = """
SELECT t.*, a.from_id as from_area, a.to_id as to_area FROM transmission_interchanges t
JOIN entities e ON t.id = e.id
JOIN arcs a ON t.arc_id = a.id
WHERE e.entity_type = ? AND e.entity_table = 'transmission_interchanges'
"""

function get_query_for_table_name(table_name)
    if table_name == "arcs"
        ARC_QUERY
    elseif table_name == "transmission_interchanges"
        TRANSMISSION_INTERCHANGE_QUERY
    else
        """SELECT t.*
        FROM $table_name t
        JOIN entities e ON t.id = e.id
        WHERE e.entity_type = ? AND e.entity_table = '$table_name'
        """
    end
end

function deserialize_supplemental_attributes!(sys::Union{PSY.System, Portfolio}, db, refs)
    attr_by_id = Dict{Int, IS.SupplementalAttribute}()

    attr_types = isa(sys, PSY.System) ? ALL_SA_OPENAPI_TYPES : ALL_SA_PSIP_OPENAPI_TYPES

    for OPENAPI_T in attr_types
        type_name = string(nameof(OPENAPI_T))
        rows = DBInterface.execute(
            db,
            "SELECT id, value FROM supplemental_attributes WHERE TYPE = ?",
            (type_name,),
        )
        for row in rows
            dict = JSON3.read(row.value, Dict{String, Any})
            openapi_obj = OpenAPI.from_json(OPENAPI_T, dict)
            attr = _convert_from_openapi(openapi_obj, refs)
            if haskey(dict, "uuid")
                IS.set_uuid!(IS.get_internal(attr), Base.UUID(dict["uuid"]))
            end
            attr_by_id[Int(row.id)] = attr
            refs[Int(openapi_obj.id)] = attr
        end
    end

    assoc_rows = DBInterface.execute(
        db,
        "SELECT attribute_id, entity_id FROM supplemental_attributes_association",
    )
    for row in assoc_rows
        attr_id = Int(row.attribute_id)
        haskey(attr_by_id, attr_id) || continue
        attr = attr_by_id[attr_id]
        component = _db_resolve_owner(refs, Int(row.entity_id))
        IS.add_supplemental_attribute!(sys.data, component, attr)
    end
end

function db2sys!(sys::PSY.System, db, refs::PSY.OpenAPIRefs; time_series=false)
    row_counts = Dict{String, Int64}()

    foreach_component_dict(db, PSY_DESERIALIZABLE_TYPES) do OPENAPI_T, dict
        table_name = TYPE_TO_TABLE[OPENAPI_T]
        row_counts[table_name] = get(row_counts, table_name, 0) + 1

        openapi_obj = OpenAPI.from_json(OPENAPI_T, dict)
        sienna_obj = _convert_from_openapi(openapi_obj, refs)
        if haskey(dict, "uuid")
            IS.set_uuid!(IS.get_internal(sienna_obj), Base.UUID(dict["uuid"]))
        end
        PSY.add_component!(sys, sienna_obj)
        refs[Int(openapi_obj.id)] = sienna_obj
    end

    for (table_name, _) in TABLE_SCHEMAS
        if table_name in (
            "attributes",
            "entities",
            "prime_mover_types",
            "fuels",
            "entity_types",
            "time_series_associations",
            "static_time_series",
            "hydro_reservoir_connections",
            "supplemental_attributes",
            "supplemental_attributes_association",
            "demand_technologies",
            "transport_technologies",
            "storage_technologies",
            "supply_technologies",
        )
            continue
        end
        result = DBInterface.execute(db, "SELECT count(*) from $table_name")
        db_count = first(first(result))::Int64
        local_count = get(row_counts, table_name, 0)
        if db_count != local_count
            @warn "Table $table_name contains $db_count ids but $local_count were processed"
        end
    end

    deserialize_supplemental_attributes!(sys, db, refs)

    if time_series
        deserialize_timeseries!(sys, db, refs)
    end
end

function db2sys(db; time_series=false)
    sys = PSY.System(100)
    refs = PSY.OpenAPIRefs("NATURAL_UNITS", PSY.get_base_power(sys))
    db2sys!(sys, db, refs, time_series=time_series)
    return sys
end

function portfolio2db!(db, portfolio::Portfolio; time_series=false)
    psip_max = _max_psip_entity_id(portfolio)
    _ = sys2db!(db, get_base_system(portfolio), psip_max + 1; time_series=time_series)

    refs = _register_psip_refs!(portfolio)
    DBInterface.transaction(db) do
        for (T, OPENAPI_T) in zip(ALL_PSIP_TYPES, PSIP_TYPES)
            if T <: RegionTopology
                send_table_to_db!(OPENAPI_T, db, get_regions(T, portfolio), refs)
            elseif T <: Technology || T <: Requirement
                send_table_to_db!(OPENAPI_T, db, IS.get_components(T, portfolio.data), refs)
            end
        end
        serialize_supplemental_attributes!(db, portfolio, refs)
        serialize_supplemental_attribute_associations!(db, portfolio, refs)
    end

    if time_series
        serialize_timeseries!(db, portfolio, refs)
    end
end

function db2portfolio!(portfolio::Portfolio, db, refs::OpenAPIRefs; time_series=false)
    row_counts = Dict{String, Int64}()

    foreach_component_dict(db, PSIP_DESERIALIZABLE_TYPES) do OPENAPI_T, dict
        table_name = PSIP_TYPE_TO_TABLE[OPENAPI_T]
        row_counts[table_name] = get(row_counts, table_name, 0) + 1

        openapi_obj = OpenAPI.from_json(OPENAPI_T, dict)
        sienna_obj = _convert_from_openapi(openapi_obj, refs)
        if haskey(dict, "uuid")
            IS.set_uuid!(IS.get_internal(sienna_obj), Base.UUID(dict["uuid"]))
        end
        if sienna_obj isa RegionTopology
            add_region!(portfolio, sienna_obj)
        elseif sienna_obj isa Technology
            add_technology!(portfolio, sienna_obj)
        elseif sienna_obj isa Requirement
            add_requirement!(portfolio, sienna_obj)
        end
        refs[Int(openapi_obj.id)] = sienna_obj
    end

    for (table_name, _) in TABLE_SCHEMAS
        if table_name in (
            "attributes",
            "entities",
            "prime_mover_types",
            "fuels",
            "entity_types",
            "time_series_associations",
            "static_time_series",
            "hydro_reservoir_connections",
            "supplemental_attributes",
            "supplemental_attributes_association",
            "arcs",
            "thermal_generators",
            "hydro_generators",
            "hydro_reservoirs",
            "storage_units",
            "renewable_generators",
            "transmission_lines",
            "transmission_interchanges",
            "loads",
        )
            continue
        end
        result = DBInterface.execute(db, "SELECT count(*) from $table_name")
        db_count = first(first(result))::Int64
        local_count = get(row_counts, table_name, 0)
        if db_count != local_count
            @warn "Table $table_name contains $db_count ids but $local_count were processed"
        end
    end

    deserialize_supplemental_attributes!(portfolio, db, refs)

    if time_series
        deserialize_timeseries!(portfolio, db, refs)
    end
end

function db2portfolio(db; time_series=false)
    portfolio = Portfolio()
    refs = OpenAPIRefs()
    db2portfolio!(portfolio, db, refs; time_series=time_series)
    portfolio.base_system = db2sys(db; time_series=time_series)
    return portfolio
end

function db2openapi_json(
    db,
    output_path::AbstractString;
    system_name::AbstractString="",
    base_power::Real=100.0,
    description::AbstractString="",
    time_series::Bool=false,
    time_series_data::Bool=false,
)
    components_dict = Dict{String, Vector{Dict{String, Any}}}()

    foreach_component_dict(db, PSY_DESERIALIZABLE_TYPES) do OPENAPI_T, dict
        type_name = string(nameof(OPENAPI_T))
        if !haskey(components_dict, type_name)
            components_dict[type_name] = Vector{Dict{String, Any}}()
        end
        push!(components_dict[type_name], dict)
    end

    sa_dict = Dict{String, Vector{Dict{String, Any}}}()
    for OPENAPI_T in ALL_SA_OPENAPI_TYPES
        type_name = string(nameof(OPENAPI_T))
        rows = DBInterface.execute(
            db,
            "SELECT id, value FROM supplemental_attributes WHERE TYPE = ?",
            (type_name,),
        )
        for row in rows
            if !haskey(sa_dict, type_name)
                sa_dict[type_name] = Vector{Dict{String, Any}}()
            end
            push!(sa_dict[type_name], JSON3.read(row.value, Dict{String, Any}))
        end
    end

    sa_assocs = [
        Dict("attribute_id" => r.attribute_id, "entity_id" => r.entity_id) for r in
        DBInterface.execute(db, "SELECT * FROM supplemental_attributes_association")
    ]

    output = Dict{String, Any}(
        "system" => Dict{String, Any}(
            "name" => system_name,
            "base_power" => base_power,
            "description" => description,
        ),
        "components" => components_dict,
        "supplemental_attributes" => sa_dict,
        "supplemental_attribute_associations" => sa_assocs,
    )

    if time_series
        output["time_series"] = export_time_series_dict(db; include_data=time_series_data)
    end

    open(output_path, "w") do io
        JSON3.pretty(io, output)
    end

    return output_path
end

function serialize_time_series!(
    data::IS.SystemData,
    output::Dict{String, Any},
    output_path::AbstractString,
)
    if isempty(data.time_series_manager.data_store)
        output["data"]["time_series_compression_enabled"] =
            IS.get_compression_settings(data.time_series_manager.data_store).enabled
        output["data"]["time_series_in_memory"] =
            data.time_series_manager.data_store isa IS.InMemoryTimeSeriesStorage
    else
        base = splitext(basename(output_path))[1]
        time_series_base_name =
            IS._get_secondary_basename(base, IS.TIME_SERIES_STORAGE_FILE)
        time_series_storage_file = joinpath(dirname(output_path), time_series_base_name)
        IS.serialize(data.time_series_manager.data_store, time_series_storage_file)
        IS.to_h5_file(data.time_series_manager.metadata_store, time_series_storage_file)
        output["data"]["time_series_storage_file"] = time_series_storage_file
        output["data"]["time_series_storage_type"] =
            string(typeof(data.time_series_manager.data_store))
    end
end

function system2openapi_json(system, output_path::AbstractString; time_series::Bool=false)
    components_dict = Dict{String, Vector{Dict{String, Any}}}()

    counter = DBIdCounter(1)
    refs = PSY.OpenAPIRefs("NATURAL_UNITS", PSY.get_base_power(system))
    _register_psy_refs!(refs, counter, system)

    for (psy_type, OPENAPI_T) in zip(ALL_PSY_TYPES, PSY_DESERIALIZABLE_TYPES)
        type_name = string(nameof(OPENAPI_T))
        if !haskey(components_dict, type_name)
            components_dict[type_name] = Vector{Dict{String, Any}}()
        end
        components = PSY.get_components(psy_type, system)
        for component in components
            openapi_obj = _convert_to_openapi(component, refs)
            dict = JSON3.read(OpenAPI.to_json(openapi_obj), Dict{String, Any})
            push!(components_dict[type_name], dict)
        end
    end

    sa_dict = Dict{String, Vector{Dict{String, Any}}}()
    for OPENAPI_T in ALL_SA_OPENAPI_TYPES
        type_name = string(nameof(OPENAPI_T))
        psy_type = SA_OPENAPI_TO_PSY[OPENAPI_T]
        if !haskey(sa_dict, type_name)
            sa_dict[type_name] = Vector{Dict{String, Any}}()
        end
        attributes = PSY.get_supplemental_attributes(psy_type, system)
        for attribute in attributes
            openapi_obj = _convert_to_openapi(attribute, refs)
            dict = JSON3.read(OpenAPI.to_json(openapi_obj), Dict{String, Any})
            push!(sa_dict[type_name], dict)
        end
    end

    associations = system.data.supplemental_attribute_manager.associations
    sa_assocs = IS.to_records(associations)

    output = Dict{String, Any}(
        "frequency" => string(get_frequency(system)),
        "metadata" => IS.serialize(system.metadata),
        "data" => Dict{String, Any}(
            "subsystems" => IS.serialize(get_subsystems(system)),
            "components" => components_dict,
            "supplemental_attributes" => sa_dict,
            "supplemental_attribute_associations" => sa_assocs,
            "id2uuid" =>
                Dict(Int(id) => string(IS.get_uuid(c)) for (id, c) in refs.by_id),
        ),
    )

    if time_series
        serialize_time_series!(system.data, output, output_path)
    end

    open(output_path, "w") do io
        JSON3.pretty(io, output)
    end

    return output_path
end
