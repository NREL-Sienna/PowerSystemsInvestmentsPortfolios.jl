#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct RetrofitPotential <: IS.SupplementalAttribute
        internal::InfrastructureSystemsInternal
        retrofit_potential::Vector{PSY.Generator}
        ext::Dict
    end



# Arguments
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `retrofit_potential::Vector{PSY.Generator}`: (default: `Vector()`) Individual generation units mapped to this technology that can be retrofitted
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
"""
mutable struct RetrofitPotential <: IS.SupplementalAttribute
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Individual generation units mapped to this technology that can be retrofitted"
    retrofit_potential::Vector{PSY.Generator}
    "Option for providing additional data"
    ext::Dict
end


function RetrofitPotential(; internal=InfrastructureSystemsInternal(), retrofit_potential=Vector(), ext=Dict(), )
    RetrofitPotential(internal, retrofit_potential, ext, )
end

# Constructor for demo purposes; non-functional.
function RetrofitPotential(::Nothing)
    RetrofitPotential(;
        internal=Dict(),
        retrofit_potential=Dict(),
        ext=Dict(),
    )
end

"""Get [`RetrofitPotential`](@ref) `internal`."""
get_internal(value::RetrofitPotential) = value.internal
"""Get [`RetrofitPotential`](@ref) `retrofit_potential`."""
get_retrofit_potential(value::RetrofitPotential) = value.retrofit_potential
"""Get [`RetrofitPotential`](@ref) `ext`."""
get_ext(value::RetrofitPotential) = value.ext

"""Set [`RetrofitPotential`](@ref) `internal`."""
set_internal!(value::RetrofitPotential, val) = value.internal = val
"""Set [`RetrofitPotential`](@ref) `retrofit_potential`."""
set_retrofit_potential!(value::RetrofitPotential, val) = value.retrofit_potential = val
"""Set [`RetrofitPotential`](@ref) `ext`."""
set_ext!(value::RetrofitPotential, val) = value.ext = val

IS.serialize(val::RetrofitPotential) = IS.serialize_struct(val)
IS.deserialize(T::Type{<:RetrofitPotential}, val::Dict) = IS.deserialize_struct(T, val)
