#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct HourlyMatching <: Requirement
        name::String
        id::Int64
        available::Bool
        ext::Dict
        internal::InfrastructureSystemsInternal
    end

Policy requirement that all DemandSideTechnologies in `qualified_demand` must have their demand met by an equal amount of electricity generation from `qualified_supply` at all hours, such that: `sum(P)_qualified_supply >= sum(D)_qualified_demand`

# Arguments
- `name::String`: The policy name
- `id::Int64`: ID for individual policy
- `available::Bool`: Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
"""
mutable struct HourlyMatching <: Requirement
    "The policy name"
    name::String
    "ID for individual policy"
    id::Int64
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
    "Optional dictionary to provide additional data"
    ext::Dict
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
end


function HourlyMatching(; name, id, available, ext=Dict(), internal=InfrastructureSystemsInternal(), )
    HourlyMatching(name, id, available, ext, internal, )
end

"""Get [`HourlyMatching`](@ref) `name`."""
get_name(value::HourlyMatching) = value.name
"""Get [`HourlyMatching`](@ref) `id`."""
get_id(value::HourlyMatching) = value.id
"""Get [`HourlyMatching`](@ref) `available`."""
get_available(value::HourlyMatching) = value.available
"""Get [`HourlyMatching`](@ref) `ext`."""
get_ext(value::HourlyMatching) = value.ext
"""Get [`HourlyMatching`](@ref) `internal`."""
get_internal(value::HourlyMatching) = value.internal

"""Set [`HourlyMatching`](@ref) `name`."""
set_name!(value::HourlyMatching, val) = value.name = val
"""Set [`HourlyMatching`](@ref) `id`."""
set_id!(value::HourlyMatching, val) = value.id = val
"""Set [`HourlyMatching`](@ref) `available`."""
set_available!(value::HourlyMatching, val) = value.available = val
"""Set [`HourlyMatching`](@ref) `ext`."""
set_ext!(value::HourlyMatching, val) = value.ext = val
"""Set [`HourlyMatching`](@ref) `internal`."""
set_internal!(value::HourlyMatching, val) = value.internal = val




function from_openapi(::Type{ HourlyMatching }, po, refs::OpenAPIRefs)
    return HourlyMatching(;
        name = po.name,
        id = po.id,
        available = po.available,
    )
end

function to_openapi(value::HourlyMatching, refs::OpenAPIRefs)
    return PI.HourlyMatching(;
        name = get_name(value),
        id = get_id(value),
        available = get_available(value),
    )
end
