#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct ExistingCapacity <: IS.SupplementalAttribute
        internal::InfrastructureSystemsInternal
        ext::Dict
        existing_technologies::Vector{String}
    end

Supplemental attributed used to map candidate technologies in a portfolio to the existing system. Contains a list of existing generators that correspond to a SupplyTechnology.

# Arguments
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `existing_technologies::Vector{String}`: (default: `Vector()`) List of individual units to map to a specific SupplyTechnology
"""
mutable struct ExistingCapacity <: IS.SupplementalAttribute
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "List of individual units to map to a specific SupplyTechnology"
    existing_technologies::Vector{String}
end


function ExistingCapacity(; internal=InfrastructureSystemsInternal(), ext=Dict(), existing_technologies=Vector(), )
    ExistingCapacity(internal, ext, existing_technologies, )
end

# Constructor for demo purposes; non-functional.
function ExistingCapacity(::Nothing)
    ExistingCapacity(;
        internal=Vector(),
        ext=Vector(),
        existing_technologies=Vector(),
    )
end

"""Get [`ExistingCapacity`](@ref) `internal`."""
get_internal(value::ExistingCapacity) = value.internal
"""Get [`ExistingCapacity`](@ref) `ext`."""
get_ext(value::ExistingCapacity) = value.ext
"""Get [`ExistingCapacity`](@ref) `existing_technologies`."""
get_existing_technologies(value::ExistingCapacity) = value.existing_technologies

"""Set [`ExistingCapacity`](@ref) `internal`."""
set_internal!(value::ExistingCapacity, val) = value.internal = val
"""Set [`ExistingCapacity`](@ref) `ext`."""
set_ext!(value::ExistingCapacity, val) = value.ext = val
"""Set [`ExistingCapacity`](@ref) `existing_technologies`."""
set_existing_technologies!(value::ExistingCapacity, val) = value.existing_technologies = val

function serialize_openapi_struct(technology::ExistingCapacity, vals...)
    base_struct = APIServer.ExistingCapacity(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:ExistingCapacity}, vals::Dict)
    return IS.deserialize_struct(APIServer.ExistingCapacity, vals)
end
