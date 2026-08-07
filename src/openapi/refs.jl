# Ported from PowerSystems.jl's src/openapi/refs.jl. PSY's version also carries the
# document's unit system and base power; PSIP has one unit representation and no
# system base, so both fields are absent.

function from_openapi end
function to_openapi end

"""
Bidirectional id<->component resolution context for one OpenAPI conversion pass.

Fields:

  - `by_id::Dict{Int, Any}`: Id → component, populated by `setindex!` as each component is
    converted.
  - `id_by_component::IdDict{Any, Int}`: Component → id, the reverse of `by_id`, keyed by
    object identity.

Populated in dependency order as components are converted (regions before the
technologies that reference them, etc.) An id or a component that has not been
registered yet is malformed input, not an absence to tolerate: [`Base.getindex`](@ref)
and [`component_id`](@ref) error loudly naming what was missing rather than returning
`nothing`. Use [`has_ref`](@ref) / [`has_component_id`](@ref) first when absence is
itself a valid outcome to branch on.
"""
struct OpenAPIRefs
    by_id::Dict{Int, Any}
    id_by_component::IdDict{Any, Int}
end

OpenAPIRefs() = OpenAPIRefs(Dict{Int, Any}(), IdDict{Any, Int}())

function Base.setindex!(refs::OpenAPIRefs, component, id::Integer)
    key = Int(id)
    if haskey(refs.by_id, key)
        error(
            "OpenAPIRefs: duplicate id $key — already registered as " *
            "$(summary(refs.by_id[key])), cannot register $(summary(component))",
        )
    end
    refs.by_id[key] = component
    refs.id_by_component[component] = key
    return component
end

function Base.getindex(refs::OpenAPIRefs, id::Integer)
    key = Int(id)
    if !haskey(refs.by_id, key)
        error(
            "OpenAPIRefs: unresolved id $key — no component registered under it; " *
            "expected every referenced component to be converted earlier, in " *
            "dependency order",
        )
    end
    return refs.by_id[key]
end

has_ref(refs::OpenAPIRefs, id::Integer) = haskey(refs.by_id, Int(id))

"""
Resolve an **optional** component reference from a document.

`nothing` in means `nothing` out: a schema-optional reference the document omits is an
absent relationship, not a malformed one. A reference that *is* stated still goes
through [`Base.getindex`](@ref) and so still errors when it names an unregistered id.
"""
resolve_ref(::OpenAPIRefs, ::Nothing) = nothing
resolve_ref(refs::OpenAPIRefs, id::Integer) = refs[id]

"""
Resolve a list of component references. An omitted list is an empty one.
"""
resolve_refs(::OpenAPIRefs, ::Nothing) = []
resolve_refs(refs::OpenAPIRefs, ids) = [refs[id] for id in ids]

function component_id(refs::OpenAPIRefs, component)
    if !haskey(refs.id_by_component, component)
        error(
            "OpenAPIRefs: component $(summary(component)) has no registered id — it " *
            "was never passed through setindex!",
        )
    end
    return refs.id_by_component[component]
end

component_ids(refs::OpenAPIRefs, components) =
    Int[component_id(refs, c) for c in components]

has_component_id(refs::OpenAPIRefs, component) = haskey(refs.id_by_component, component)
