#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct AggregateRetirementPotential <: IS.SupplementalAttribute
        internal::InfrastructureSystemsInternal
        ext::Dict
        retirement_potential::Float64
    end



# Arguments
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `retirement_potential::Float64`: (default: `0.0`) Amount of pre-existing capacity for a technology that is eligible for retirement
"""
mutable struct AggregateRetirementPotential <: IS.SupplementalAttribute
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Amount of pre-existing capacity for a technology that is eligible for retirement"
    retirement_potential::Float64
end


function AggregateRetirementPotential(; internal=InfrastructureSystemsInternal(), ext=Dict(), retirement_potential=0.0, )
    AggregateRetirementPotential(internal, ext, retirement_potential, )
end

# Constructor for demo purposes; non-functional.
function AggregateRetirementPotential(::Nothing)
    AggregateRetirementPotential(;
        internal=0.0,
        ext=0.0,
        retirement_potential=0.0,
    )
end

"""Get [`AggregateRetirementPotential`](@ref) `internal`."""
get_internal(value::AggregateRetirementPotential) = value.internal
"""Get [`AggregateRetirementPotential`](@ref) `ext`."""
get_ext(value::AggregateRetirementPotential) = value.ext
"""Get [`AggregateRetirementPotential`](@ref) `retirement_potential`."""
get_retirement_potential(value::AggregateRetirementPotential) = value.retirement_potential

"""Set [`AggregateRetirementPotential`](@ref) `internal`."""
set_internal!(value::AggregateRetirementPotential, val) = value.internal = val
"""Set [`AggregateRetirementPotential`](@ref) `ext`."""
set_ext!(value::AggregateRetirementPotential, val) = value.ext = val
"""Set [`AggregateRetirementPotential`](@ref) `retirement_potential`."""
set_retirement_potential!(value::AggregateRetirementPotential, val) = value.retirement_potential = val

function serialize_openapi_struct(technology::AggregateRetirementPotential, vals...)
    base_struct = APIServer.AggregateRetirementPotential(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:AggregateRetirementPotential}, vals...)
    base_struct = APIServer.AggregateRetirementPotential(; vals...)
    return base_struct
end
