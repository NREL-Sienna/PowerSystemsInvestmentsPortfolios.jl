#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct EnergyShareRequirements <: Requirements
        name::String
        internal::InfrastructureSystemsInternal
        ext::Dict
        generation_fraction::Float64
        available::Bool
        eligible_regions::Vector{Region}
    end



# Arguments
- `name::String`: The technology name
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `generation_fraction::Float64`: (default: `0.0`) Fraction of total demand across all eligible zones that needs to be met by qualifying resources.
- `available::Bool`: Availability
- `eligible_regions::Vector{Region}`: (default: `Vector{Region}()`) List of regions where the EnergyShareRequirement will be applied.
"""
mutable struct EnergyShareRequirements <: Requirements
    "The technology name"
    name::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Fraction of total demand across all eligible zones that needs to be met by qualifying resources."
    generation_fraction::Float64
    "Availability"
    available::Bool
    "List of regions where the EnergyShareRequirement will be applied."
    eligible_regions::Vector{Region}
end


function EnergyShareRequirements(; name, internal=InfrastructureSystemsInternal(), ext=Dict(), generation_fraction=0.0, available, eligible_regions=Vector{Region}(), )
    EnergyShareRequirements(name, internal, ext, generation_fraction, available, eligible_regions, )
end

"""Get [`EnergyShareRequirements`](@ref) `name`."""
get_name(value::EnergyShareRequirements) = value.name
"""Get [`EnergyShareRequirements`](@ref) `internal`."""
get_internal(value::EnergyShareRequirements) = value.internal
"""Get [`EnergyShareRequirements`](@ref) `ext`."""
get_ext(value::EnergyShareRequirements) = value.ext
"""Get [`EnergyShareRequirements`](@ref) `generation_fraction`."""
get_generation_fraction(value::EnergyShareRequirements) = value.generation_fraction
"""Get [`EnergyShareRequirements`](@ref) `available`."""
get_available(value::EnergyShareRequirements) = value.available
"""Get [`EnergyShareRequirements`](@ref) `eligible_regions`."""
get_eligible_regions(value::EnergyShareRequirements) = value.eligible_regions

"""Set [`EnergyShareRequirements`](@ref) `name`."""
set_name!(value::EnergyShareRequirements, val) = value.name = val
"""Set [`EnergyShareRequirements`](@ref) `internal`."""
set_internal!(value::EnergyShareRequirements, val) = value.internal = val
"""Set [`EnergyShareRequirements`](@ref) `ext`."""
set_ext!(value::EnergyShareRequirements, val) = value.ext = val
"""Set [`EnergyShareRequirements`](@ref) `generation_fraction`."""
set_generation_fraction!(value::EnergyShareRequirements, val) = value.generation_fraction = val
"""Set [`EnergyShareRequirements`](@ref) `available`."""
set_available!(value::EnergyShareRequirements, val) = value.available = val
"""Set [`EnergyShareRequirements`](@ref) `eligible_regions`."""
set_eligible_regions!(value::EnergyShareRequirements, val) = value.eligible_regions = val
