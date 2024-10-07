#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct AggregateRetrofitPotential <: IS.SupplementalAttribute
        retrofit_id::Int64
        retrofit_fraction::Float64
        internal::InfrastructureSystemsInternal
        retrofit_potential::Float64
        ext::Dict
    end



# Arguments
- `retrofit_id::Int64`: (default: `0`) Unique identifier to group retrofittable source technologies with retrofit options inside the same zone.
- `retrofit_fraction::Float64`: (default: `Dict()`) Fraction of existing capacity that is eligible for retrofits. Alternative to retrofit_potential
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `retrofit_potential::Float64`: (default: `0.0`) Amount of existing capacity for technology that can be retrofitted
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
"""
mutable struct AggregateRetrofitPotential <: IS.SupplementalAttribute
    "Unique identifier to group retrofittable source technologies with retrofit options inside the same zone."
    retrofit_id::Int64
    "Fraction of existing capacity that is eligible for retrofits. Alternative to retrofit_potential"
    retrofit_fraction::Float64
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Amount of existing capacity for technology that can be retrofitted"
    retrofit_potential::Float64
    "Option for providing additional data"
    ext::Dict
end


function AggregateRetrofitPotential(; retrofit_id=0, retrofit_fraction=Dict(), internal=InfrastructureSystemsInternal(), retrofit_potential=0.0, ext=Dict(), )
    AggregateRetrofitPotential(retrofit_id, retrofit_fraction, internal, retrofit_potential, ext, )
end

# Constructor for demo purposes; non-functional.
function AggregateRetrofitPotential(::Nothing)
    AggregateRetrofitPotential(;
        retrofit_id=Dict(),
        retrofit_fraction=Dict(),
        internal=Dict(),
        retrofit_potential=Dict(),
        ext=Dict(),
    )
end

"""Get [`AggregateRetrofitPotential`](@ref) `retrofit_id`."""
get_retrofit_id(value::AggregateRetrofitPotential) = value.retrofit_id
"""Get [`AggregateRetrofitPotential`](@ref) `retrofit_fraction`."""
get_retrofit_fraction(value::AggregateRetrofitPotential) = value.retrofit_fraction
"""Get [`AggregateRetrofitPotential`](@ref) `internal`."""
get_internal(value::AggregateRetrofitPotential) = value.internal
"""Get [`AggregateRetrofitPotential`](@ref) `retrofit_potential`."""
get_retrofit_potential(value::AggregateRetrofitPotential) = value.retrofit_potential
"""Get [`AggregateRetrofitPotential`](@ref) `ext`."""
get_ext(value::AggregateRetrofitPotential) = value.ext

"""Set [`AggregateRetrofitPotential`](@ref) `retrofit_id`."""
set_retrofit_id!(value::AggregateRetrofitPotential, val) = value.retrofit_id = val
"""Set [`AggregateRetrofitPotential`](@ref) `retrofit_fraction`."""
set_retrofit_fraction!(value::AggregateRetrofitPotential, val) = value.retrofit_fraction = val
"""Set [`AggregateRetrofitPotential`](@ref) `internal`."""
set_internal!(value::AggregateRetrofitPotential, val) = value.internal = val
"""Set [`AggregateRetrofitPotential`](@ref) `retrofit_potential`."""
set_retrofit_potential!(value::AggregateRetrofitPotential, val) = value.retrofit_potential = val
"""Set [`AggregateRetrofitPotential`](@ref) `ext`."""
set_ext!(value::AggregateRetrofitPotential, val) = value.ext = val

serialize(val::AggregateRetrofitPotential) = serialize_struct(val)
IS.deserialize(T::Type{<:AggregateRetrofitPotential}, val::Dict) = IS.deserialize_struct(T, val)
