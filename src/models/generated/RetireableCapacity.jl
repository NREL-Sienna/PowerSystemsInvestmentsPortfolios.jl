#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct RetireableCapacity <: IS.SupplementalAttribute
        name::String
        internal::InfrastructureSystemsInternal
        retireable_capacity::Dict{String, Float64}
    end



# Arguments
- `name::String`: The technology name
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `retireable_capacity::Dict{String, Float64}`: (default: `Dict()`) Amount of existing capacity for technology that can retire
"""
mutable struct RetireableCapacity <: IS.SupplementalAttribute
    "The technology name"
    name::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Amount of existing capacity for technology that can retire"
    retireable_capacity::Dict{String, Float64}
end


function RetireableCapacity(; name, internal=InfrastructureSystemsInternal(), retireable_capacity=Dict(), )
    RetireableCapacity(name, internal, retireable_capacity, )
end

"""Get [`RetireableCapacity`](@ref) `name`."""
get_name(value::RetireableCapacity) = value.name
"""Get [`RetireableCapacity`](@ref) `internal`."""
get_internal(value::RetireableCapacity) = value.internal
"""Get [`RetireableCapacity`](@ref) `retireable_capacity`."""
get_retireable_capacity(value::RetireableCapacity) = value.retireable_capacity

"""Set [`RetireableCapacity`](@ref) `name`."""
set_name!(value::RetireableCapacity, val) = value.name = val
"""Set [`RetireableCapacity`](@ref) `internal`."""
set_internal!(value::RetireableCapacity, val) = value.internal = val
"""Set [`RetireableCapacity`](@ref) `retireable_capacity`."""
set_retireable_capacity!(value::RetireableCapacity, val) = value.retireable_capacity = val
