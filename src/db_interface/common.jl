# Hand-written helpers shared by the SQLite db_interface (sqlite.jl, time_series.jl).
#
# `OpenAPIRefs` provides bidirectional id⇄component resolution in one object:
#   * export : register each component under its id, then `to_openapi(c, refs[, unit])` reads
#              the id back via `component_id(refs, c)` and resolves references to ids.
#   * import : `from_openapi(po, refs[, unit])` resolves reference ids to components, then the
#              caller registers the freshly built component under `po.id`.
#
# Two `OpenAPIRefs` types are in play, both with a `by_id::Dict{Int,Any}` field and integer
# `getindex`, so the helpers below are written untyped and work for either:
#   * PSIP's `OpenAPIRefs()`               (src/openapi/refs.jl) — portfolio types → `PI.*`
#   * `PSY.OpenAPIRefs(unit_system, base)` (PowerSystems)        — base system   → `PO.*`
#
# These helpers add a id⇄UUID view the relational schema needs: association rows
# and time-series-owner rows key on integer entity ids, while IS's own 
# association/metadata records key on UUIDs.

"""
    _db_uuid_to_id(refs) -> Dict{Base.UUID, Int}

Invert a populated `OpenAPIRefs` into a UUID→entity-id map. Used when writing rows that must
reference a component by its DB id but only have the UUID on hand — supplemental-attribute
association records (`component_uuid`/`attribute_uuid`) and time-series `owner_uuid`s.
"""
_db_uuid_to_id(refs) = Dict{Base.UUID, Int}(IS.get_uuid(c) => id for (id, c) in refs.by_id)

"""
    _db_resolve_owner(refs, id) -> component or supplemental attribute

Resolve the entity registered under DB `id`. Components and supplemental attributes share one
id space inside a single `OpenAPIRefs`, so this resolves either. Errors (via `OpenAPIRefs`'s
own `getindex`) on an unregistered id rather than returning `nothing`.
"""
_db_resolve_owner(refs, id::Integer) = refs[Int(id)]

"""
    _max_psip_entity_id(portfolio) -> Int

Largest domain `id` in use by any DB-stored portfolio component or supplemental attribute.
PSIP entities keep their own `id` field as their entity id, but base-system PSY components
have none and are assigned counter ids; seeding that counter above this value keeps the two
families disjoint in the shared `entities` table. Returns 0 for an empty portfolio.
"""
function _max_psip_entity_id(portfolio::Portfolio)
    max_id = 0
    for T in ALL_PSIP_TYPES
        for c in IS.get_components(T, portfolio.data)
            max_id = max(max_id, get_id(c))
        end
    end
    for T in ALL_SA_PSIP_TYPES
        for a in IS.get_supplemental_attributes(T, portfolio.data)
            max_id = max(max_id, get_id(a))
        end
    end
    return max_id
end

"""
    _convert_to_openapi(component, refs)

Convert a Sienna component/attribute to its OpenAPI transport struct through the present
converters, dispatched on the refs type: PSIP's `OpenAPIRefs` routes to this package's
`to_openapi(c, refs)` (→ `PI.*`); `PSY.OpenAPIRefs` routes to PowerSystems' unit-aware
`to_openapi(c, refs, PSY.NU)` (→ `PO.*`). Requires `refs` to already hold every component the
converter resolves references against (register in dependency order first).
"""
_convert_to_openapi(component, refs::OpenAPIRefs) = to_openapi(component, refs)
_convert_to_openapi(component, refs::PSY.OpenAPIRefs) =
    PSY.to_openapi(component, refs, PSY.NU)
# PSY supplemental attributes (e.g., GeographicInfo) use 2-arg converters.
_convert_to_openapi(component::IS.GeographicInfo, refs::PSY.OpenAPIRefs) =
    PSY.to_openapi(component, refs)

"""
    _convert_from_openapi(po, refs)

Inverse of [`_convert_to_openapi`](@ref): build a Sienna component/attribute from its OpenAPI
transport struct, dispatched on the refs type (PSIP `from_openapi(po, refs)` vs PSY
`from_openapi(po, refs, PSY.NU)`). Reference ids in `po` must already be registered in `refs`.
"""
_convert_from_openapi(po, refs::OpenAPIRefs) = from_openapi(po, refs)
_convert_from_openapi(po, refs::PSY.OpenAPIRefs) = PSY.from_openapi(po, refs, PSY.NU)
# PSY supplemental attributes (e.g., GeographicInfo) use 2-arg converters.
_convert_from_openapi(po::PC.GeographicInfo, refs::PSY.OpenAPIRefs) =
    PSY.from_openapi(po, refs)

"""
Monotonic integer id allocator for DB entity ids that have no domain `id` to read: base-system
PSY components (which carry no id field) and synthetic rows such as the `arcs` entry an
`AreaInterchange` expands into. Seeded above the portfolio's max domain id so the base-system
and portfolio id ranges stay disjoint in the shared `entities` table.
"""
mutable struct DBIdCounter
    next::Int
end

_next_id!(counter::DBIdCounter) = (id = counter.next; counter.next += 1; id)
