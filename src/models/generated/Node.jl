#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct Node <: RegionTopology
        name::String
        bus_type::ACBusTypes
        internal::InfrastructureSystemsInternal
        id::Int64
        ext::Dict
    end

A unit of spatial aggregation for nodal capacity expansion models. Used to define locations for supply, demand, transport, and storage technologies and relevant policy requirements.

# Arguments
- `name::String`: Name of region
- `bus_type::ACBusTypes`: (default: `ACBusTypes.PQ`) AC Bus Type for a node
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
- `id::Int64`: A unique node identification number
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
"""
mutable struct Node <: RegionTopology
    "Name of region"
    name::String
    "AC Bus Type for a node"
    bus_type::ACBusTypes
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
    "A unique node identification number"
    id::Int64
    "Optional dictionary to provide additional data"
    ext::Dict
end


function Node(; name, bus_type=ACBusTypes.PQ, internal=InfrastructureSystemsInternal(), id, ext=Dict(), )
    Node(name, bus_type, internal, id, ext, )
end

"""Get [`Node`](@ref) `name`."""
get_name(value::Node) = value.name
"""Get [`Node`](@ref) `bus_type`."""
get_bus_type(value::Node) = value.bus_type
"""Get [`Node`](@ref) `internal`."""
get_internal(value::Node) = value.internal
"""Get [`Node`](@ref) `id`."""
get_id(value::Node) = value.id
"""Get [`Node`](@ref) `ext`."""
get_ext(value::Node) = value.ext

"""Set [`Node`](@ref) `name`."""
set_name!(value::Node, val) = value.name = val
"""Set [`Node`](@ref) `bus_type`."""
set_bus_type!(value::Node, val) = value.bus_type = val
"""Set [`Node`](@ref) `internal`."""
set_internal!(value::Node, val) = value.internal = val
"""Set [`Node`](@ref) `id`."""
set_id!(value::Node, val) = value.id = val
"""Set [`Node`](@ref) `ext`."""
set_ext!(value::Node, val) = value.ext = val

function serialize_openapi_struct(technology::Node, vals...)
    base_struct = APIServer.Node(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:Node}, vals::Dict)
    return IS.deserialize_struct(APIServer.Node, vals)
end
