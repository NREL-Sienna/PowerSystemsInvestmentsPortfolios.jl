#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct HourlyMatching <: Requirement
        name::String
        qualified_demand::Vector{Technology}
        internal::InfrastructureSystemsInternal
        qualified_supply::Vector{Technology}
        id::Int64
        ext::Dict
        available::Bool
    end



# Arguments
- `name::String`: The policy name
- `qualified_demand::Vector{Technology}`: (default: `Vector{Technology}()`) List of demand side technologies that need to be met with hourly matching.
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `qualified_supply::Vector{Technology}`: (default: `Vector{Technology}()`) List of technologies eligible to provide hourly matching for demand side technologies.
- `id::Int64`: ID for individual policy
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `available::Bool`: Availability
"""
mutable struct HourlyMatching <: Requirement
    "The policy name"
    name::String
    "List of demand side technologies that need to be met with hourly matching."
    qualified_demand::Vector{Technology}
    "Internal field"
    internal::InfrastructureSystemsInternal
    "List of technologies eligible to provide hourly matching for demand side technologies."
    qualified_supply::Vector{Technology}
    "ID for individual policy"
    id::Int64
    "Option for providing additional data"
    ext::Dict
    "Availability"
    available::Bool
end


function HourlyMatching(; name, qualified_demand=Vector{Technology}(), internal=InfrastructureSystemsInternal(), qualified_supply=Vector{Technology}(), id, ext=Dict(), available, )
    HourlyMatching(name, qualified_demand, internal, qualified_supply, id, ext, available, )
end

"""Get [`HourlyMatching`](@ref) `name`."""
get_name(value::HourlyMatching) = value.name
"""Get [`HourlyMatching`](@ref) `qualified_demand`."""
get_qualified_demand(value::HourlyMatching) = value.qualified_demand
"""Get [`HourlyMatching`](@ref) `internal`."""
get_internal(value::HourlyMatching) = value.internal
"""Get [`HourlyMatching`](@ref) `qualified_supply`."""
get_qualified_supply(value::HourlyMatching) = value.qualified_supply
"""Get [`HourlyMatching`](@ref) `id`."""
get_id(value::HourlyMatching) = value.id
"""Get [`HourlyMatching`](@ref) `ext`."""
get_ext(value::HourlyMatching) = value.ext
"""Get [`HourlyMatching`](@ref) `available`."""
get_available(value::HourlyMatching) = value.available

"""Set [`HourlyMatching`](@ref) `name`."""
set_name!(value::HourlyMatching, val) = value.name = val
"""Set [`HourlyMatching`](@ref) `qualified_demand`."""
set_qualified_demand!(value::HourlyMatching, val) = value.qualified_demand = val
"""Set [`HourlyMatching`](@ref) `internal`."""
set_internal!(value::HourlyMatching, val) = value.internal = val
"""Set [`HourlyMatching`](@ref) `qualified_supply`."""
set_qualified_supply!(value::HourlyMatching, val) = value.qualified_supply = val
"""Set [`HourlyMatching`](@ref) `id`."""
set_id!(value::HourlyMatching, val) = value.id = val
"""Set [`HourlyMatching`](@ref) `ext`."""
set_ext!(value::HourlyMatching, val) = value.ext = val
"""Set [`HourlyMatching`](@ref) `available`."""
set_available!(value::HourlyMatching, val) = value.available = val

function serialize_openapi_struct(technology::HourlyMatching, vals...)
    base_struct = APIServer.HourlyMatching(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:HourlyMatching}, vals::Dict)
    return IS.deserialize_struct(APIServer.HourlyMatching, vals)
end
