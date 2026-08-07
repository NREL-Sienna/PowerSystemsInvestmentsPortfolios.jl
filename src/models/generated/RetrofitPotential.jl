#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct RetrofitPotential <: IS.SupplementalAttribute
        id::Int64
        eligible_generators::Vector{String}
        ext::Dict
        internal::InfrastructureSystemsInternal
    end

Supplemental attribute used to define what existing generators are eligible for retrofit for a SupplyTechnology

# Arguments
- `id::Int64`: ID for individual component
- `eligible_generators::Vector{String}`: (default: `Vector()`) Names of individual generation units mapped to this technology that can be retrofitted
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
"""
mutable struct RetrofitPotential <: IS.SupplementalAttribute
    "ID for individual component"
    id::Int64
    "Names of individual generation units mapped to this technology that can be retrofitted"
    eligible_generators::Vector{String}
    "Optional dictionary to provide additional data"
    ext::Dict
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
end


function RetrofitPotential(; id, eligible_generators=Vector(), ext=Dict(), internal=InfrastructureSystemsInternal(), )
    RetrofitPotential(id, eligible_generators, ext, internal, )
end

"""Get [`RetrofitPotential`](@ref) `id`."""
get_id(value::RetrofitPotential) = value.id
"""Get [`RetrofitPotential`](@ref) `eligible_generators`."""
get_eligible_generators(value::RetrofitPotential) = value.eligible_generators
"""Get [`RetrofitPotential`](@ref) `ext`."""
get_ext(value::RetrofitPotential) = value.ext
"""Get [`RetrofitPotential`](@ref) `internal`."""
get_internal(value::RetrofitPotential) = value.internal

"""Set [`RetrofitPotential`](@ref) `id`."""
set_id!(value::RetrofitPotential, val) = value.id = val
"""Set [`RetrofitPotential`](@ref) `eligible_generators`."""
set_eligible_generators!(value::RetrofitPotential, val) = value.eligible_generators = val
"""Set [`RetrofitPotential`](@ref) `ext`."""
set_ext!(value::RetrofitPotential, val) = value.ext = val
"""Set [`RetrofitPotential`](@ref) `internal`."""
set_internal!(value::RetrofitPotential, val) = value.internal = val




function from_openapi(::Type{ RetrofitPotential }, po, refs::OpenAPIRefs)
    return RetrofitPotential(;
        id = po.id,
        eligible_generators = po.eligible_generators,
    )
end

function to_openapi(value::RetrofitPotential, refs::OpenAPIRefs)
    return PI.RetrofitPotential(;
        id = get_id(value),
        eligible_generators = get_eligible_generators(value),
    )
end
