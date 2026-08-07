#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct AggregateRetirementPotential <: IS.SupplementalAttribute
        id::Int64
        retirement_potential::Float64
        ext::Dict
        internal::InfrastructureSystemsInternal
    end

Supplemental attribute used to define a total amount of existing capacity that can be retired for a technology

# Arguments
- `id::Int64`: ID for individual component
- `retirement_potential::Float64`: (default: `0.0`) Amount of pre-existing capacity for a technology that is eligible for retirement (MW). Units: MW.
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
"""
mutable struct AggregateRetirementPotential <: IS.SupplementalAttribute
    "ID for individual component"
    id::Int64
    "Amount of pre-existing capacity for a technology that is eligible for retirement (MW). Units: MW."
    retirement_potential::Float64
    "Optional dictionary to provide additional data"
    ext::Dict
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
end


function AggregateRetirementPotential(; id, retirement_potential=0.0, ext=Dict(), internal=InfrastructureSystemsInternal(), )
    AggregateRetirementPotential(id, retirement_potential, ext, internal, )
end

"""Get [`AggregateRetirementPotential`](@ref) `id`."""
get_id(value::AggregateRetirementPotential) = value.id
"""Get [`AggregateRetirementPotential`](@ref) `retirement_potential` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`get_retirement_potential_unitful`](@ref)."""
get_retirement_potential(value::AggregateRetirementPotential, units) = InfrastructureSystems._strip_units(get_value(value, Val(:retirement_potential), Val(:mw), units))
"""Get [`AggregateRetirementPotential`](@ref) `retirement_potential` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`get_retirement_potential`](@ref)."""
get_retirement_potential_unitful(value::AggregateRetirementPotential, units) = get_value(value, Val(:retirement_potential), Val(:mw), units)
InfrastructureSystems.display_units_arg(::typeof(get_retirement_potential), ::Type{AggregateRetirementPotential}) = InfrastructureSystems.NU
InfrastructureSystems.display_units_arg(::typeof(get_retirement_potential_unitful), ::Type{AggregateRetirementPotential}) = InfrastructureSystems.NU
"""Get [`AggregateRetirementPotential`](@ref) `ext`."""
get_ext(value::AggregateRetirementPotential) = value.ext
"""Get [`AggregateRetirementPotential`](@ref) `internal`."""
get_internal(value::AggregateRetirementPotential) = value.internal

"""Set [`AggregateRetirementPotential`](@ref) `id`."""
set_id!(value::AggregateRetirementPotential, val) = value.id = val
"""Set [`AggregateRetirementPotential`](@ref) `retirement_potential`."""
set_retirement_potential!(value::AggregateRetirementPotential, val, unit) = value.retirement_potential = set_value(value, Val(:retirement_potential), val, unit, Val(:mw))
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
