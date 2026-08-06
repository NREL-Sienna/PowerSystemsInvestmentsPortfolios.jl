#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct RetrofitPotential <: IS.SupplementalAttribute
        eligible_generators::Vector{String}
        ext::Dict
        internal::InfrastructureSystemsInternal
    end

Supplemental attribute used to define what existing generators are eligible for retrofit for a SupplyTechnology

# Arguments
- `eligible_generators::Vector{String}`: (default: `Vector()`) Names of individual generation units mapped to this technology that can be retrofitted
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
"""
mutable struct RetrofitPotential <: IS.SupplementalAttribute
    "Names of individual generation units mapped to this technology that can be retrofitted"
    eligible_generators::Vector{String}
    "Optional dictionary to provide additional data"
    ext::Dict
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
end


function RetrofitPotential(; eligible_generators=Vector(), ext=Dict(), internal=InfrastructureSystemsInternal(), )
    RetrofitPotential(eligible_generators, ext, internal, )
end

# Constructor for demo purposes; non-functional.
function RetrofitPotential(::Nothing)
    RetrofitPotential(;
        eligible_generators=InfrastructureSystemsInternal(),
        ext=InfrastructureSystemsInternal(),
        internal=InfrastructureSystemsInternal(),
    )
end

"""Get [`RetrofitPotential`](@ref) `eligible_generators`."""
get_eligible_generators(value::RetrofitPotential) = value.eligible_generators
"""Get [`RetrofitPotential`](@ref) `ext`."""
get_ext(value::RetrofitPotential) = value.ext
"""Get [`RetrofitPotential`](@ref) `internal`."""
get_internal(value::RetrofitPotential) = value.internal

"""Set [`RetrofitPotential`](@ref) `eligible_generators`."""
set_eligible_generators!(value::RetrofitPotential, val) = value.eligible_generators = val
"""Set [`RetrofitPotential`](@ref) `ext`."""
set_ext!(value::RetrofitPotential, val) = value.ext = val
"""Set [`RetrofitPotential`](@ref) `internal`."""
set_internal!(value::RetrofitPotential, val) = value.internal = val



function serialize_openapi_struct(technology::RetrofitPotential, vals...)
    base_struct = APIServer.RetrofitPotential(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:RetrofitPotential}, vals::Dict)
    return IS.deserialize_struct(APIServer.RetrofitPotential, vals)
end
