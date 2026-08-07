# Hand-written: the OpenAPI round-trip ledger. Extends `src/openapi/refs.jl` conceptually;
# split into its own file because it needs `Portfolio`, defined in `portfolio.jl`, included
# after `refs.jl` and `document.jl` — see the include order note in the module file.
#
# id<->UUID persisted in `Portfolio.ext` under one reserved key. This is a deliberate
# TEMPORARY BRIDGE pending the planned UUID→id migration in IS/PSY — once component
# identity is natively id-based, this ext entry becomes redundant and should be DELETED,
# not migrated forward. Component object references do not survive a JSON round-trip of
# `ext` (a plain `Dict{String,Any}`), so the ledger stores UUIDs — strings — rather than
# the components `OpenAPIRefs` holds in memory during one conversion pass.
#
# PSY's ledger also persists a unit system alongside `id_to_uuid`. PSIP has exactly one
# unit representation, so only the id maps are stored here.
#
# Two maps, because a load pass mints new UUIDs. `id_to_uuid` always describes the
# in-memory components as they stand now. `source_id_to_uuid` is written only by
# [`store_ledger_after_load!`](@ref) and holds what the document on disk said, which is
# what a later export needs in order to reproduce that document's identities. Deserializing
# restores `internal` — and with it the file's own ledger — so without the two-key split the
# load pass would overwrite the document's mapping with the UUIDs it had just minted, which
# is precisely the record it exists to keep.

const OPENAPI_LEDGER_KEY = "_openapi_ledger"
const OPENAPI_ID_TO_UUID_KEY = "id_to_uuid"
const OPENAPI_SOURCE_ID_TO_UUID_KEY = "source_id_to_uuid"

"""
Persist `refs`' id<->component registry into `portfolio`'s `ext`, keyed under
`OPENAPI_LEDGER_KEY`, so a later export pass can reproduce the document's ids. See
[`store_ledger_after_load!`](@ref), [`load_ledger`](@ref), [`has_ledger`](@ref).
"""
function store_ledger!(portfolio::Portfolio, refs::OpenAPIRefs)
    id_to_uuid = Dict{String, String}(
        string(id) => string(IS.get_uuid(component)) for (id, component) in refs.by_id
    )
    get_ext(portfolio)[OPENAPI_LEDGER_KEY] =
        Dict{String, Any}(OPENAPI_ID_TO_UUID_KEY => id_to_uuid)
    return nothing
end

"""
Read the id→UUID map the document being loaded carried in its own `internal`'s `ext`,
before [`store_ledger!`](@ref) replaces it. Empty when the document carried no ledger.
"""
function _document_id_to_uuid(portfolio::Portfolio)
    if !has_ledger(portfolio)
        return Dict{String, String}()
    end
    ledger = load_ledger(portfolio)
    if !haskey(ledger, OPENAPI_ID_TO_UUID_KEY)
        return Dict{String, String}()
    end
    return Dict{String, String}(
        string(id) => string(uuid) for (id, uuid) in ledger[OPENAPI_ID_TO_UUID_KEY]
    )
end

"""
Store the ledger at the end of a load pass, keeping the document's own id→UUID map under
`OPENAPI_SOURCE_ID_TO_UUID_KEY` alongside the freshly-minted one. Use this instead of
[`store_ledger!`](@ref) on the read path.
"""
function store_ledger_after_load!(portfolio::Portfolio, refs::OpenAPIRefs)
    source_id_to_uuid = _document_id_to_uuid(portfolio)
    store_ledger!(portfolio, refs)
    load_ledger(portfolio)[OPENAPI_SOURCE_ID_TO_UUID_KEY] = source_id_to_uuid
    return nothing
end

"""
Whether `portfolio` carries an OpenAPI round-trip ledger. Use before [`load_ledger`](@ref)
when absence is a valid outcome to branch on, rather than an error to raise.
"""
has_ledger(portfolio::Portfolio) = haskey(get_ext(portfolio), OPENAPI_LEDGER_KEY)

"""
Read the OpenAPI round-trip ledger `store_ledger!` wrote into `portfolio`'s `ext`.

Errors when `portfolio` carries no ledger — it was never built via `from_openapi`, or the
`ext` key was cleared — naming the missing key, since reproducing the document's ids
cannot proceed without one.
"""
function load_ledger(portfolio::Portfolio)
    has_ledger(portfolio) || error(
        "Portfolio has no OpenAPI round-trip ledger under ext key \"$OPENAPI_LEDGER_KEY\" " *
        "— it was not built via from_openapi, or the ledger was removed from ext",
    )
    return get_ext(portfolio)[OPENAPI_LEDGER_KEY]
end

# PSY runs a counter here because its components have no id of their own. Every PSIP
# component carries `id::Int64` as a domain field and that id IS the document id, so
# ids are read, not assigned. A collision across types is a data bug, and
# `OpenAPIRefs.setindex!` raises on it rather than silently overwriting.
function _build_export_refs(portfolio::Portfolio)
    refs = OpenAPIRefs()
    for (psip_type, _key) in DOCUMENT_PLAN
        for component in IS.get_components(psip_type, portfolio.data)
            refs[get_id(component)] = component
        end
    end
    for (attribute_type, _key) in SUPPLEMENTAL_ATTRIBUTE_PLAN
        for attribute in IS.get_supplemental_attributes(attribute_type, portfolio.data)
            refs[get_id(attribute)] = attribute
        end
    end
    return refs
end
