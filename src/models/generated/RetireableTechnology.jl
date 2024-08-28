#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct RetireableTechnology <: IS.SupplementalAttribute
        name::String
        internal::InfrastructureSystemsInternal
        retireable_capacity::Dict{String, Float64}
    end



# Arguments
- `name::String`: The technology name
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `retireable_capacity::Dict{String, Float64}`: (default: `0.0`) Amount of existing capacity for technology that can retire
"""
mutable struct RetireableTechnology <: IS.SupplementalAttribute
    "The technology name"
    name::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Amount of existing capacity for technology that can retire"
    retireable_capacity::Dict{String, Float64}
end


function RetireableTechnology(; name, internal=InfrastructureSystemsInternal(), retireable_capacity=0.0, )
    RetireableTechnology(name, internal, retireable_capacity, )
end

"""Get [`RetireableTechnology`](@ref) `name`."""
get_name(value::RetireableTechnology) = value.name
"""Get [`RetireableTechnology`](@ref) `internal`."""
get_internal(value::RetireableTechnology) = value.internal
"""Get [`RetireableTechnology`](@ref) `retireable_capacity`."""
get_retireable_capacity(value::RetireableTechnology) = value.retireable_capacity

"""Set [`RetireableTechnology`](@ref) `name`."""
set_name!(value::RetireableTechnology, val) = value.name = val
"""Set [`RetireableTechnology`](@ref) `internal`."""
set_internal!(value::RetireableTechnology, val) = value.internal = val
"""Set [`RetireableTechnology`](@ref) `retireable_capacity`."""
set_retireable_capacity!(value::RetireableTechnology, val) = value.retireable_capacity = val
