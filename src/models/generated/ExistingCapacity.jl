#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct ExistingCapacity <: IS.SupplementalAttribute
        internal::InfrastructureSystemsInternal
        ext::Dict
        existing_capacity::Vector{PSY.Generator}
    end



# Arguments
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `existing_capacity::Vector{PSY.Generator}`: (default: `Vector()`) List of individual units to map to a specific SupplyTechnology
"""
mutable struct ExistingCapacity <: IS.SupplementalAttribute
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "List of individual units to map to a specific SupplyTechnology"
    existing_capacity::Vector{PSY.Generator}
end


function ExistingCapacity(; internal=InfrastructureSystemsInternal(), ext=Dict(), existing_capacity=Vector(), )
    ExistingCapacity(internal, ext, existing_capacity, )
end

# Constructor for demo purposes; non-functional.
function ExistingCapacity(::Nothing)
    ExistingCapacity(;
        internal=Vector(),
        ext=Vector(),
        existing_capacity=Vector(),
    )
end

"""Get [`ExistingCapacity`](@ref) `internal`."""
get_internal(value::ExistingCapacity) = value.internal
"""Get [`ExistingCapacity`](@ref) `ext`."""
get_ext(value::ExistingCapacity) = value.ext
"""Get [`ExistingCapacity`](@ref) `existing_capacity`."""
get_existing_capacity(value::ExistingCapacity) = value.existing_capacity

"""Set [`ExistingCapacity`](@ref) `internal`."""
set_internal!(value::ExistingCapacity, val) = value.internal = val
"""Set [`ExistingCapacity`](@ref) `ext`."""
set_ext!(value::ExistingCapacity, val) = value.ext = val
"""Set [`ExistingCapacity`](@ref) `existing_capacity`."""
set_existing_capacity!(value::ExistingCapacity, val) = value.existing_capacity = val

IS.serialize(val::ExistingCapacity) = IS.serialize_struct(val)

IS.deserialize(T::Type{<:ExistingCapacity}, val::Dict) = IS.deserialize_struct(T, val)
