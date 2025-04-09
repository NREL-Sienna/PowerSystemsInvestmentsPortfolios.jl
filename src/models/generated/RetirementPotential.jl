#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct RetirementPotential <: IS.SupplementalAttribute
        planned_retirement_year::Dict{String, Int64}
        eligible_generators::Vector{String}
        internal::InfrastructureSystemsInternal
        year::Dict{String, Int64}
        ext::Dict
    end

Supplemental attribute used to define what existing generators are eligible for retirement for a SupplyTechnology

# Arguments
- `planned_retirement_year::Dict{String, Int64}`: (default: `Dict{String, Int64}()`) Optional dictionary to indicate the year in which the forced/planned retirement will occur
- `eligible_generators::Vector{String}`: (default: `Vector()`) Names of individual generation units mapped to a technology that are eligible for retirement
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `year::Dict{String, Int64}`: (default: `Dict{String, Int64}()`) Optional dictionary to indicate the year in which existing generators in the base system were built
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
"""
mutable struct RetirementPotential <: IS.SupplementalAttribute
    "Optional dictionary to indicate the year in which the forced/planned retirement will occur"
    planned_retirement_year::Dict{String, Int64}
    "Names of individual generation units mapped to a technology that are eligible for retirement"
    eligible_generators::Vector{String}
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Optional dictionary to indicate the year in which existing generators in the base system were built"
    year::Dict{String, Int64}
    "Option for providing additional data"
    ext::Dict
end


function RetirementPotential(; planned_retirement_year=Dict{String, Int64}(), eligible_generators=Vector(), internal=InfrastructureSystemsInternal(), year=Dict{String, Int64}(), ext=Dict(), )
    RetirementPotential(planned_retirement_year, eligible_generators, internal, year, ext, )
end

# Constructor for demo purposes; non-functional.
function RetirementPotential(::Nothing)
    RetirementPotential(;
        planned_retirement_year=Dict(),
        eligible_generators=Dict(),
        internal=Dict(),
        year=Dict(),
        ext=Dict(),
    )
end

"""Get [`RetirementPotential`](@ref) `planned_retirement_year`."""
get_planned_retirement_year(value::RetirementPotential) = value.planned_retirement_year
"""Get [`RetirementPotential`](@ref) `eligible_generators`."""
get_eligible_generators(value::RetirementPotential) = value.eligible_generators
"""Get [`RetirementPotential`](@ref) `internal`."""
get_internal(value::RetirementPotential) = value.internal
"""Get [`RetirementPotential`](@ref) `year`."""
get_year(value::RetirementPotential) = value.year
"""Get [`RetirementPotential`](@ref) `ext`."""
get_ext(value::RetirementPotential) = value.ext

"""Set [`RetirementPotential`](@ref) `planned_retirement_year`."""
set_planned_retirement_year!(value::RetirementPotential, val) = value.planned_retirement_year = val
"""Set [`RetirementPotential`](@ref) `eligible_generators`."""
set_eligible_generators!(value::RetirementPotential, val) = value.eligible_generators = val
"""Set [`RetirementPotential`](@ref) `internal`."""
set_internal!(value::RetirementPotential, val) = value.internal = val
"""Set [`RetirementPotential`](@ref) `year`."""
set_year!(value::RetirementPotential, val) = value.year = val
"""Set [`RetirementPotential`](@ref) `ext`."""
set_ext!(value::RetirementPotential, val) = value.ext = val

function serialize_openapi_struct(technology::RetirementPotential, vals...)
    base_struct = APIServer.RetirementPotential(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:RetirementPotential}, vals::Dict)
    return IS.deserialize_struct(APIServer.RetirementPotential, vals)
end
