#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct AggregateRetrofitPotential <: IS.SupplementalAttribute
        retrofit_id::Int64
        retrofit_potential::Float64
        retrofit_fraction::Float64
        ext::Dict
        internal::InfrastructureSystemsInternal
    end

Supplemental attribute used to define a total amount of capacity that can be retrofit for a SupplyTechnology

# Arguments
- `retrofit_id::Int64`: (default: `0`) Unique identifier to group retrofittable source technologies with retrofit options inside the same zone.
- `retrofit_potential::Float64`: (default: `0.0`) Amount of existing capacity for technology that can be retrofitted
- `retrofit_fraction::Float64`: (default: `0.0`) Fraction of existing capacity that is eligible for retrofits. Alternative to retrofit_potential
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
"""
mutable struct AggregateRetrofitPotential <: IS.SupplementalAttribute
    "Unique identifier to group retrofittable source technologies with retrofit options inside the same zone."
    retrofit_id::Int64
    "Amount of existing capacity for technology that can be retrofitted"
    retrofit_potential::Float64
    "Fraction of existing capacity that is eligible for retrofits. Alternative to retrofit_potential"
    retrofit_fraction::Float64
    "Optional dictionary to provide additional data"
    ext::Dict
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
end


function AggregateRetrofitPotential(; retrofit_id=0, retrofit_potential=0.0, retrofit_fraction=0.0, ext=Dict(), internal=InfrastructureSystemsInternal(), )
    AggregateRetrofitPotential(retrofit_id, retrofit_potential, retrofit_fraction, ext, internal, )
end

# Constructor for demo purposes; non-functional.
function AggregateRetrofitPotential(::Nothing)
    AggregateRetrofitPotential(;
        retrofit_id=InfrastructureSystemsInternal(),
        retrofit_potential=InfrastructureSystemsInternal(),
        retrofit_fraction=InfrastructureSystemsInternal(),
        ext=InfrastructureSystemsInternal(),
        internal=InfrastructureSystemsInternal(),
    )
end

"""Get [`AggregateRetrofitPotential`](@ref) `retrofit_id`."""
get_retrofit_id(value::AggregateRetrofitPotential) = value.retrofit_id
"""Get [`AggregateRetrofitPotential`](@ref) `retrofit_potential` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`get_retrofit_potential_unitful`](@ref)."""
get_retrofit_potential(value::AggregateRetrofitPotential, units) = InfrastructureSystems._strip_units(get_value(value, Val(:retrofit_potential), Val(:mw), units))
"""Get [`AggregateRetrofitPotential`](@ref) `retrofit_potential` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`get_retrofit_potential`](@ref)."""
get_retrofit_potential_unitful(value::AggregateRetrofitPotential, units) = get_value(value, Val(:retrofit_potential), Val(:mw), units)
InfrastructureSystems.display_units_arg(::typeof(get_retrofit_potential), ::Type{AggregateRetrofitPotential}) = InfrastructureSystems.NU
InfrastructureSystems.display_units_arg(::typeof(get_retrofit_potential_unitful), ::Type{AggregateRetrofitPotential}) = InfrastructureSystems.NU
"""Get [`AggregateRetrofitPotential`](@ref) `retrofit_fraction`."""
get_retrofit_fraction(value::AggregateRetrofitPotential) = value.retrofit_fraction
"""Get [`AggregateRetrofitPotential`](@ref) `ext`."""
get_ext(value::AggregateRetrofitPotential) = value.ext
"""Get [`AggregateRetrofitPotential`](@ref) `internal`."""
get_internal(value::AggregateRetrofitPotential) = value.internal

"""Set [`AggregateRetrofitPotential`](@ref) `retrofit_id`."""
set_retrofit_id!(value::AggregateRetrofitPotential, val) = value.retrofit_id = val
"""Set [`AggregateRetrofitPotential`](@ref) `retrofit_potential`."""
set_retrofit_potential!(value::AggregateRetrofitPotential, val, unit) = value.retrofit_potential = set_value(value, Val(:retrofit_potential), val, unit, Val(:mw))
"""Set [`AggregateRetrofitPotential`](@ref) `retrofit_fraction`."""
set_retrofit_fraction!(value::AggregateRetrofitPotential, val) = value.retrofit_fraction = val
"""Set [`AggregateRetrofitPotential`](@ref) `ext`."""
set_ext!(value::AggregateRetrofitPotential, val) = value.ext = val
"""Set [`AggregateRetrofitPotential`](@ref) `internal`."""
set_internal!(value::AggregateRetrofitPotential, val) = value.internal = val



function from_openapi(po::PI.AggregateRetrofitPotential, refs::OpenAPIRefs)
    return AggregateRetrofitPotential(;
        retrofit_id = po.retrofit_id,
        retrofit_potential = po.retrofit_potential,
        retrofit_fraction = po.retrofit_fraction,
    )
end

function to_openapi(value::AggregateRetrofitPotential, refs::OpenAPIRefs)
    return PI.AggregateRetrofitPotential(;
        id = get_id(value),
        retrofit_id = get_retrofit_id(value),
        retrofit_potential = get_retrofit_potential(value, IS.NU),
        retrofit_fraction = get_retrofit_fraction(value),
    )
end
