#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct RetrofitPotential <: IS.SupplementalAttribute
        eligible_generators::Vector{String}
        retrofit_fraction::Float64
        internal::InfrastructureSystemsInternal
        ext::Dict
        retrofit_cost::PSY.ValueCurve
    end

Supplemental attribute used to define what existing generators are eligible for retrofit for a SupplyTechnology

# Arguments
- `eligible_generators::Vector{String}`: (default: `Vector()`) Names of individual generation units mapped to this technology that can be retrofitted
- `retrofit_fraction::Float64`: (default: `1.0`) Fraction of existing capacity that is eligible for retrofits.
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `retrofit_cost::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Cost of retrofitting an existing generator to a new technology. (USD/MW)
"""
mutable struct RetrofitPotential <: IS.SupplementalAttribute
    "Names of individual generation units mapped to this technology that can be retrofitted"
    eligible_generators::Vector{String}
    "Fraction of existing capacity that is eligible for retrofits."
    retrofit_fraction::Float64
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
    "Optional dictionary to provide additional data"
    ext::Dict
    "Cost of retrofitting an existing generator to a new technology. (USD/MW)"
    retrofit_cost::PSY.ValueCurve
end


function RetrofitPotential(; eligible_generators=Vector(), retrofit_fraction=1.0, internal=InfrastructureSystemsInternal(), ext=Dict(), retrofit_cost=LinearCurve(0.0), )
    RetrofitPotential(eligible_generators, retrofit_fraction, internal, ext, retrofit_cost, )
end

# Constructor for demo purposes; non-functional.
function RetrofitPotential(::Nothing)
    RetrofitPotential(;
        eligible_generators=LinearCurve(0.0),
        retrofit_fraction=LinearCurve(0.0),
        internal=LinearCurve(0.0),
        ext=LinearCurve(0.0),
        retrofit_cost=LinearCurve(0.0),
    )
end

"""Get [`RetrofitPotential`](@ref) `eligible_generators`."""
get_eligible_generators(value::RetrofitPotential) = value.eligible_generators
"""Get [`RetrofitPotential`](@ref) `retrofit_fraction`."""
get_retrofit_fraction(value::RetrofitPotential) = value.retrofit_fraction
"""Get [`RetrofitPotential`](@ref) `internal`."""
get_internal(value::RetrofitPotential) = value.internal
"""Get [`RetrofitPotential`](@ref) `ext`."""
get_ext(value::RetrofitPotential) = value.ext
"""Get [`RetrofitPotential`](@ref) `retrofit_cost`."""
get_retrofit_cost(value::RetrofitPotential) = value.retrofit_cost

"""Set [`RetrofitPotential`](@ref) `eligible_generators`."""
set_eligible_generators!(value::RetrofitPotential, val) = value.eligible_generators = val
"""Set [`RetrofitPotential`](@ref) `retrofit_fraction`."""
set_retrofit_fraction!(value::RetrofitPotential, val) = value.retrofit_fraction = val
"""Set [`RetrofitPotential`](@ref) `internal`."""
set_internal!(value::RetrofitPotential, val) = value.internal = val
"""Set [`RetrofitPotential`](@ref) `ext`."""
set_ext!(value::RetrofitPotential, val) = value.ext = val
"""Set [`RetrofitPotential`](@ref) `retrofit_cost`."""
set_retrofit_cost!(value::RetrofitPotential, val) = value.retrofit_cost = val

function serialize_openapi_struct(technology::RetrofitPotential, vals...)
    base_struct = APIServer.RetrofitPotential(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:RetrofitPotential}, vals::Dict)
    return IS.deserialize_struct(APIServer.RetrofitPotential, vals)
end
