#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct HourlyMatching <: Requirement
        name::String
        internal::InfrastructureSystemsInternal
        eligible_demand::Vector{Technology}
        id::Int64
        ext::Dict
        eligible_resources::Vector{Technology}
        available::Bool
    end

Policy requirement that all DemandSideTechnologies in `qualified_demand` must have their demand met by an equal amount of electricity generation from `qualified_supply` at all hours, such that: `sum(P)_qualified_supply >= sum(D)_qualified_demand`

# Arguments
- `name::String`: The policy name
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `eligible_demand::Vector{Technology}`: (default: `Vector{Technology}()`) List of demand side technologies that need to be met with hourly matching.
- `id::Int64`: ID for individual policy
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `eligible_resources::Vector{Technology}`: (default: `Vector{Technology}()`) List of technologies eligible to provide hourly matching for demand side technologies.
- `available::Bool`: Availability
"""
mutable struct HourlyMatching <: Requirement
    "The policy name"
    name::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "List of demand side technologies that need to be met with hourly matching."
    eligible_demand::Vector{Technology}
    "ID for individual policy"
    id::Int64
    "Option for providing additional data"
    ext::Dict
    "List of technologies eligible to provide hourly matching for demand side technologies."
    eligible_resources::Vector{Technology}
    "Availability"
    available::Bool
end


function HourlyMatching(; name, internal=InfrastructureSystemsInternal(), eligible_demand=Vector{Technology}(), id, ext=Dict(), eligible_resources=Vector{Technology}(), available, )
    HourlyMatching(name, internal, eligible_demand, id, ext, eligible_resources, available, )
end

"""Get [`HourlyMatching`](@ref) `name`."""
get_name(value::HourlyMatching) = value.name
"""Get [`HourlyMatching`](@ref) `internal`."""
get_internal(value::HourlyMatching) = value.internal
"""Get [`HourlyMatching`](@ref) `eligible_demand`."""
get_eligible_demand(value::HourlyMatching) = value.eligible_demand
"""Get [`HourlyMatching`](@ref) `id`."""
get_id(value::HourlyMatching) = value.id
"""Get [`HourlyMatching`](@ref) `ext`."""
get_ext(value::HourlyMatching) = value.ext
"""Get [`HourlyMatching`](@ref) `eligible_resources`."""
get_eligible_resources(value::HourlyMatching) = value.eligible_resources
"""Get [`HourlyMatching`](@ref) `available`."""
get_available(value::HourlyMatching) = value.available

"""Set [`HourlyMatching`](@ref) `name`."""
set_name!(value::HourlyMatching, val) = value.name = val
"""Set [`HourlyMatching`](@ref) `internal`."""
set_internal!(value::HourlyMatching, val) = value.internal = val
"""Set [`HourlyMatching`](@ref) `eligible_demand`."""
set_eligible_demand!(value::HourlyMatching, val) = value.eligible_demand = val
"""Set [`HourlyMatching`](@ref) `id`."""
set_id!(value::HourlyMatching, val) = value.id = val
"""Set [`HourlyMatching`](@ref) `ext`."""
set_ext!(value::HourlyMatching, val) = value.ext = val
"""Set [`HourlyMatching`](@ref) `eligible_resources`."""
set_eligible_resources!(value::HourlyMatching, val) = value.eligible_resources = val
"""Set [`HourlyMatching`](@ref) `available`."""
set_available!(value::HourlyMatching, val) = value.available = val

function serialize_openapi_struct(technology::HourlyMatching, vals...)
    base_struct = APIServer.HourlyMatching(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:HourlyMatching}, vals::Dict)
    return IS.deserialize_struct(APIServer.HourlyMatching, vals)
end
