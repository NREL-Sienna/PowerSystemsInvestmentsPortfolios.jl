#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct RetirementPotential <: IS.SupplementalAttribute
        internal::InfrastructureSystemsInternal
        ext::Dict
        retirement_potential::Vector{PSY.Generator}
    end

Supplemental attribute used to define what existing generators are eligible for retirement for a SupplyTechnology

# Arguments
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `retirement_potential::Vector{PSY.Generator}`: (default: `Vector()`) Individual generation units mapped to a technology that are eligible for retirement
"""
mutable struct RetirementPotential <: IS.SupplementalAttribute
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Individual generation units mapped to a technology that are eligible for retirement"
    retirement_potential::Vector{PSY.Generator}
end


function RetirementPotential(; internal=InfrastructureSystemsInternal(), ext=Dict(), retirement_potential=Vector(), )
    RetirementPotential(internal, ext, retirement_potential, )
end

# Constructor for demo purposes; non-functional.
function RetirementPotential(::Nothing)
    RetirementPotential(;
        internal=Vector(),
        ext=Vector(),
        retirement_potential=Vector(),
    )
end

"""Get [`RetirementPotential`](@ref) `internal`."""
get_internal(value::RetirementPotential) = value.internal
"""Get [`RetirementPotential`](@ref) `ext`."""
get_ext(value::RetirementPotential) = value.ext
"""Get [`RetirementPotential`](@ref) `retirement_potential`."""
get_retirement_potential(value::RetirementPotential) = value.retirement_potential

"""Set [`RetirementPotential`](@ref) `internal`."""
set_internal!(value::RetirementPotential, val) = value.internal = val
"""Set [`RetirementPotential`](@ref) `ext`."""
set_ext!(value::RetirementPotential, val) = value.ext = val
"""Set [`RetirementPotential`](@ref) `retirement_potential`."""
set_retirement_potential!(value::RetirementPotential, val) = value.retirement_potential = val

function serialize_openapi_struct(technology::RetirementPotential, vals...)
    base_struct = APIServer.RetirementPotential(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:RetirementPotential}, vals::Dict)
    return IS.deserialize_struct(APIServer.RetirementPotential, vals)
end
