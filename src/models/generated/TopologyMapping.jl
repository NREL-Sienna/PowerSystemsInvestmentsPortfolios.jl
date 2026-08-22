#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct TopologyMapping <: IS.SupplementalAttribute
        buses::Vector{String}
        ext::Dict
        internal::InfrastructureSystemsInternal
    end

Supplemental attributed used to store mapping between the PSIP Zone and the associated buses in the base system.

# Arguments
- `buses::Vector{String}`: (default: `Vector()`) List of buses in the base system that are associated with a zone
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
"""
mutable struct TopologyMapping <: IS.SupplementalAttribute
    "List of buses in the base system that are associated with a zone"
    buses::Vector{String}
    "Optional dictionary to provide additional data"
    ext::Dict
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
end


function TopologyMapping(; buses=Vector(), ext=Dict(), internal=InfrastructureSystemsInternal(), )
    TopologyMapping(buses, ext, internal, )
end

# Constructor for demo purposes; non-functional.
function TopologyMapping(::Nothing)
    TopologyMapping(;
        buses=InfrastructureSystemsInternal(),
        ext=InfrastructureSystemsInternal(),
        internal=InfrastructureSystemsInternal(),
    )
end

"""Get [`TopologyMapping`](@ref) `buses`."""
get_buses(value::TopologyMapping) = value.buses
"""Get [`TopologyMapping`](@ref) `ext`."""
get_ext(value::TopologyMapping) = value.ext
"""Get [`TopologyMapping`](@ref) `internal`."""
get_internal(value::TopologyMapping) = value.internal

"""Set [`TopologyMapping`](@ref) `buses`."""
set_buses!(value::TopologyMapping, val) = value.buses = val
"""Set [`TopologyMapping`](@ref) `ext`."""
set_ext!(value::TopologyMapping, val) = value.ext = val
"""Set [`TopologyMapping`](@ref) `internal`."""
set_internal!(value::TopologyMapping, val) = value.internal = val



function from_openapi(po::PI.TopologyMapping, refs::OpenAPIRefs)
    return TopologyMapping(;
        buses = po.buses,
    )
end

function to_openapi(value::TopologyMapping, refs::OpenAPIRefs)
    return PI.TopologyMapping(;
        id = get_id(value),
        buses = get_buses(value),
    )
end
