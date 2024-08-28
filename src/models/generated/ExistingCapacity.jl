#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct ExistingCapacity <: IS.SupplementalAttribute
        internal::InfrastructureSystemsInternal
        ext::Dict
        existing_capacity::Dict{String, Dict{String, Float64}}
    end



# Arguments
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `existing_capacity::Dict{String, Dict{String, Float64}}`: (default: `Dict()`) Map SupplyTechnologies to individual units in a zone and their existing capacity
"""
mutable struct ExistingCapacity <: IS.SupplementalAttribute
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Map SupplyTechnologies to individual units in a zone and their existing capacity"
    existing_capacity::Dict{String, Dict{String, Float64}}
end


function ExistingCapacity(; internal=InfrastructureSystemsInternal(), ext=Dict(), existing_capacity=Dict(), )
    ExistingCapacity(internal, ext, existing_capacity, )
end

# Constructor for demo purposes; non-functional.
function ExistingCapacity(::Nothing)
    ExistingCapacity(;
        internal=Dict(),
        ext=Dict(),
        existing_capacity=Dict(),
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
