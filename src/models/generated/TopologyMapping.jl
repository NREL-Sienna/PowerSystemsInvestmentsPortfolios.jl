#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct TopologyMapping <: IS.SupplementalAttribute
        internal::InfrastructureSystemsInternal
        buses::Vector{String}
        ext::Dict
    end

Supplemental attributed used to store mapping between the PSIP Zone and the associated buses in the base system.

# Arguments
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `buses::Vector{String}`: (default: `Vector()`) List of buses in the base system that are associated with a zone
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
"""
mutable struct TopologyMapping <: IS.SupplementalAttribute
    "Internal field"
    internal::InfrastructureSystemsInternal
    "List of buses in the base system that are associated with a zone"
    buses::Vector{String}
    "Option for providing additional data"
    ext::Dict
end


function TopologyMapping(; internal=InfrastructureSystemsInternal(), buses=Vector(), ext=Dict(), )
    TopologyMapping(internal, buses, ext, )
end

# Constructor for demo purposes; non-functional.
function TopologyMapping(::Nothing)
    TopologyMapping(;
        internal=Dict(),
        buses=Dict(),
        ext=Dict(),
    )
end

"""Get [`TopologyMapping`](@ref) `internal`."""
get_internal(value::TopologyMapping) = value.internal
"""Get [`TopologyMapping`](@ref) `buses`."""
get_buses(value::TopologyMapping) = value.buses
"""Get [`TopologyMapping`](@ref) `ext`."""
get_ext(value::TopologyMapping) = value.ext

"""Set [`TopologyMapping`](@ref) `internal`."""
set_internal!(value::TopologyMapping, val) = value.internal = val
"""Set [`TopologyMapping`](@ref) `buses`."""
set_buses!(value::TopologyMapping, val) = value.buses = val
"""Set [`TopologyMapping`](@ref) `ext`."""
set_ext!(value::TopologyMapping, val) = value.ext = val

function serialize_openapi_struct(technology::TopologyMapping, vals...)
    base_struct = APIServer.TopologyMapping(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:TopologyMapping}, vals::Dict)
    return IS.deserialize_struct(APIServer.TopologyMapping, vals)
end
