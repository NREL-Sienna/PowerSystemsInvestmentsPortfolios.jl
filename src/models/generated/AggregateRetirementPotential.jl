#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct AggregateRetirementPotential <: IS.SupplementalAttribute
        retirement_potential::Float64
        ext::Dict
        internal::InfrastructureSystemsInternal
    end

Supplemental attribute used to define a total amount of existing capacity that can be retired for a technology

# Arguments
- `retirement_potential::Float64`: (default: `0.0`) Amount of pre-existing capacity for a technology that is eligible for retirement
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
"""
mutable struct AggregateRetirementPotential <: IS.SupplementalAttribute
    "Amount of pre-existing capacity for a technology that is eligible for retirement"
    retirement_potential::Float64
    "Optional dictionary to provide additional data"
    ext::Dict
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
end


function AggregateRetirementPotential(; retirement_potential=0.0, ext=Dict(), internal=InfrastructureSystemsInternal(), )
    AggregateRetirementPotential(retirement_potential, ext, internal, )
end

# Constructor for demo purposes; non-functional.
function AggregateRetirementPotential(::Nothing)
    AggregateRetirementPotential(;
        retirement_potential=InfrastructureSystemsInternal(),
        ext=InfrastructureSystemsInternal(),
        internal=InfrastructureSystemsInternal(),
    )
end

"""Get [`AggregateRetirementPotential`](@ref) `retirement_potential`."""
get_retirement_potential(value::AggregateRetirementPotential) = value.retirement_potential
"""Get [`AggregateRetirementPotential`](@ref) `ext`."""
get_ext(value::AggregateRetirementPotential) = value.ext
"""Get [`AggregateRetirementPotential`](@ref) `internal`."""
get_internal(value::AggregateRetirementPotential) = value.internal

"""Set [`AggregateRetirementPotential`](@ref) `retirement_potential`."""
set_retirement_potential!(value::AggregateRetirementPotential, val) = value.retirement_potential = val
"""Set [`AggregateRetirementPotential`](@ref) `ext`."""
set_ext!(value::AggregateRetirementPotential, val) = value.ext = val
"""Set [`AggregateRetirementPotential`](@ref) `internal`."""
set_internal!(value::AggregateRetirementPotential, val) = value.internal = val

function serialize_openapi_struct(technology::AggregateRetirementPotential, vals...)
    base_struct = APIServer.AggregateRetirementPotential(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:AggregateRetirementPotential}, vals::Dict)
    return IS.deserialize_struct(APIServer.AggregateRetirementPotential, vals)
end
