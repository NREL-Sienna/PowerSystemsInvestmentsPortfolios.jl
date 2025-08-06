#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct ExistingCapacity <: IS.SupplementalAttribute
        eligible_generators::Vector{String}
        internal::InfrastructureSystemsInternal
        ext::Dict
    end

Supplemental attributed used to map candidate technologies in a portfolio to the existing system. Contains a list of existing generators that correspond to a SupplyTechnology.

# Arguments
- `eligible_generators::Vector{String}`: (default: `Vector()`) List of individual units to map to a specific SupplyTechnology
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
"""
mutable struct ExistingCapacity <: IS.SupplementalAttribute
    "List of individual units to map to a specific SupplyTechnology"
    eligible_generators::Vector{String}
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
end


function ExistingCapacity(; eligible_generators=Vector(), internal=InfrastructureSystemsInternal(), ext=Dict(), )
    ExistingCapacity(eligible_generators, internal, ext, )
end

# Constructor for demo purposes; non-functional.
function ExistingCapacity(::Nothing)
    ExistingCapacity(;
        eligible_generators=Dict(),
        internal=Dict(),
        ext=Dict(),
    )
end

"""Get [`ExistingCapacity`](@ref) `eligible_generators`."""
get_eligible_generators(value::ExistingCapacity) = value.eligible_generators
"""Get [`ExistingCapacity`](@ref) `internal`."""
get_internal(value::ExistingCapacity) = value.internal
"""Get [`ExistingCapacity`](@ref) `ext`."""
get_ext(value::ExistingCapacity) = value.ext

"""Set [`ExistingCapacity`](@ref) `eligible_generators`."""
set_eligible_generators!(value::ExistingCapacity, val) = value.eligible_generators = val
"""Set [`ExistingCapacity`](@ref) `internal`."""
set_internal!(value::ExistingCapacity, val) = value.internal = val
"""Set [`ExistingCapacity`](@ref) `ext`."""
set_ext!(value::ExistingCapacity, val) = value.ext = val

function serialize_openapi_struct(technology::ExistingCapacity, vals...)
    base_struct = APIServer.ExistingCapacity(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:ExistingCapacity}, vals::Dict)
    return IS.deserialize_struct(APIServer.ExistingCapacity, vals)
end
