#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct RetirementPotential <: IS.SupplementalAttribute
        id::Int64
        eligible_generators::Vector{String}
        planned_retirement_year::Dict{String, Int64}
        build_year::Dict{String, Int64}
        ext::Dict
        internal::InfrastructureSystemsInternal
    end

Supplemental attribute used to define what existing generators are eligible for retirement for a SupplyTechnology

# Arguments
- `id::Int64`: ID for individual component
- `eligible_generators::Vector{String}`: (default: `Vector()`) Names of individual generation units mapped to a technology that are eligible for retirement
- `planned_retirement_year::Dict{String, Int64}`: (default: `Dict{String, Int64}()`) Optional dictionary to indicate the year in which the forced/planned retirement will occur
- `build_year::Dict{String, Int64}`: (default: `Dict{String, Int64}()`) Optional dictionary to indicate the year in which existing generators in the base system were built
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
"""
mutable struct RetirementPotential <: IS.SupplementalAttribute
    "ID for individual component"
    id::Int64
    "Names of individual generation units mapped to a technology that are eligible for retirement"
    eligible_generators::Vector{String}
    "Optional dictionary to indicate the year in which the forced/planned retirement will occur"
    planned_retirement_year::Dict{String, Int64}
    "Optional dictionary to indicate the year in which existing generators in the base system were built"
    build_year::Dict{String, Int64}
    "Optional dictionary to provide additional data"
    ext::Dict
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
end


function RetirementPotential(; id, eligible_generators=Vector(), planned_retirement_year=Dict{String, Int64}(), build_year=Dict{String, Int64}(), ext=Dict(), internal=InfrastructureSystemsInternal(), )
    RetirementPotential(id, eligible_generators, planned_retirement_year, build_year, ext, internal, )
end

"""Get [`RetirementPotential`](@ref) `id`."""
get_id(value::RetirementPotential) = value.id
"""Get [`RetirementPotential`](@ref) `eligible_generators`."""
get_eligible_generators(value::RetirementPotential) = value.eligible_generators
"""Get [`RetirementPotential`](@ref) `planned_retirement_year`."""
get_planned_retirement_year(value::RetirementPotential) = value.planned_retirement_year
"""Get [`RetirementPotential`](@ref) `build_year`."""
get_build_year(value::RetirementPotential) = value.build_year
"""Get [`RetirementPotential`](@ref) `ext`."""
get_ext(value::RetirementPotential) = value.ext
"""Get [`RetirementPotential`](@ref) `internal`."""
get_internal(value::RetirementPotential) = value.internal

"""Set [`RetirementPotential`](@ref) `id`."""
set_id!(value::RetirementPotential, val) = value.id = val
"""Set [`RetirementPotential`](@ref) `eligible_generators`."""
set_eligible_generators!(value::RetirementPotential, val) = value.eligible_generators = val
"""Set [`RetirementPotential`](@ref) `planned_retirement_year`."""
set_planned_retirement_year!(value::RetirementPotential, val) = value.planned_retirement_year = val
"""Set [`RetirementPotential`](@ref) `build_year`."""
set_build_year!(value::RetirementPotential, val) = value.build_year = val
"""Set [`RetirementPotential`](@ref) `ext`."""
set_ext!(value::RetirementPotential, val) = value.ext = val
"""Set [`RetirementPotential`](@ref) `internal`."""
set_internal!(value::RetirementPotential, val) = value.internal = val



function from_openapi(po::PI.RetirementPotential, refs::OpenAPIRefs)
    return RetirementPotential(;
        id = po.id,
        eligible_generators = po.eligible_generators,
        planned_retirement_year = po.planned_retirement_year,
        build_year = po.build_year,
    )
end

function to_openapi(value::RetirementPotential, refs::OpenAPIRefs)
    return PI.RetirementPotential(;
        id = get_id(value),
        eligible_generators = get_eligible_generators(value),
        planned_retirement_year = get_planned_retirement_year(value),
        build_year = get_build_year(value),
    )
end
