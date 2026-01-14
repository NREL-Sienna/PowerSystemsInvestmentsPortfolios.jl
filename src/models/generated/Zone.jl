#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct Zone <: RegionTopology
        name::String
        internal::InfrastructureSystemsInternal
        id::Int64
        ext::Dict
    end

A unit of spatial aggregation for zonal capacity expansion models. Used to define locations for supply, demand, transport, and storage technologies and relevant policy requirements.

# Arguments
- `name::String`: Name of region
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
- `id::Int64`: A unique zone identification number
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
"""
mutable struct Zone <: RegionTopology
    "Name of region"
    name::String
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
    "A unique zone identification number"
    id::Int64
    "Optional dictionary to provide additional data"
    ext::Dict
end


function Zone(; name, internal=InfrastructureSystemsInternal(), id, ext=Dict(), )
    Zone(name, internal, id, ext, )
end

"""Get [`Zone`](@ref) `name`."""
get_name(value::Zone) = value.name
"""Get [`Zone`](@ref) `internal`."""
get_internal(value::Zone) = value.internal
"""Get [`Zone`](@ref) `id`."""
get_id(value::Zone) = value.id
"""Get [`Zone`](@ref) `ext`."""
get_ext(value::Zone) = value.ext

"""Set [`Zone`](@ref) `name`."""
set_name!(value::Zone, val) = value.name = val
"""Set [`Zone`](@ref) `internal`."""
set_internal!(value::Zone, val) = value.internal = val
"""Set [`Zone`](@ref) `id`."""
set_id!(value::Zone, val) = value.id = val
"""Set [`Zone`](@ref) `ext`."""
set_ext!(value::Zone, val) = value.ext = val

function serialize_openapi_struct(technology::Zone, vals...)
    base_struct = APIServer.Zone(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:Zone}, vals::Dict)
    return IS.deserialize_struct(APIServer.Zone, vals)
end
