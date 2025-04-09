#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct EnergyShareRequirements <: Requirement
        name::String
        target_year::Int64
        internal::InfrastructureSystemsInternal
        id::Int64
        generation_fraction_requirement::Float64
        ext::Dict
        eligible_resources::Vector{Technology}
        available::Bool
        eligible_regions::Vector{RegionTopology}
    end

Policy requirement that the total generation of `eligible_technologies` must be greater than or equal to a pre-determined fraction of the total demand in eligible zones, such that `sum(P)_eligible_technologies >= total_fraction * sum(D)_eligible_regions`

# Arguments
- `name::String`: The policy name
- `target_year::Int64`: (default: `2050`) Year in which carbon cap will be applied
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `id::Int64`: ID for individual policy
- `generation_fraction_requirement::Float64`: (default: `0.0`) Fraction of total demand across all eligible zones that needs to be met by qualifying resources.
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `eligible_resources::Vector{Technology}`: (default: `Vector{Technology}()`) List of SupplyTechnologies that will meet the energy share requirement.
- `available::Bool`: Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `eligible_regions::Vector{RegionTopology}`: (default: `Vector{RegionTopology}()`) List of regions where the EnergyShareRequirement will be applied.
"""
mutable struct EnergyShareRequirements <: Requirement
    "The policy name"
    name::String
    "Year in which carbon cap will be applied"
    target_year::Int64
    "Internal field"
    internal::InfrastructureSystemsInternal
    "ID for individual policy"
    id::Int64
    "Fraction of total demand across all eligible zones that needs to be met by qualifying resources."
    generation_fraction_requirement::Float64
    "Option for providing additional data"
    ext::Dict
    "List of SupplyTechnologies that will meet the energy share requirement."
    eligible_resources::Vector{Technology}
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
    "List of regions where the EnergyShareRequirement will be applied."
    eligible_regions::Vector{RegionTopology}
end


function EnergyShareRequirements(; name, target_year=2050, internal=InfrastructureSystemsInternal(), id, generation_fraction_requirement=0.0, ext=Dict(), eligible_resources=Vector{Technology}(), available, eligible_regions=Vector{RegionTopology}(), )
    EnergyShareRequirements(name, target_year, internal, id, generation_fraction_requirement, ext, eligible_resources, available, eligible_regions, )
end

"""Get [`EnergyShareRequirements`](@ref) `name`."""
get_name(value::EnergyShareRequirements) = value.name
"""Get [`EnergyShareRequirements`](@ref) `target_year`."""
get_target_year(value::EnergyShareRequirements) = value.target_year
"""Get [`EnergyShareRequirements`](@ref) `internal`."""
get_internal(value::EnergyShareRequirements) = value.internal
"""Get [`EnergyShareRequirements`](@ref) `id`."""
get_id(value::EnergyShareRequirements) = value.id
"""Get [`EnergyShareRequirements`](@ref) `generation_fraction_requirement`."""
get_generation_fraction_requirement(value::EnergyShareRequirements) = value.generation_fraction_requirement
"""Get [`EnergyShareRequirements`](@ref) `ext`."""
get_ext(value::EnergyShareRequirements) = value.ext
"""Get [`EnergyShareRequirements`](@ref) `eligible_resources`."""
get_eligible_resources(value::EnergyShareRequirements) = value.eligible_resources
"""Get [`EnergyShareRequirements`](@ref) `available`."""
get_available(value::EnergyShareRequirements) = value.available
"""Get [`EnergyShareRequirements`](@ref) `eligible_regions`."""
get_eligible_regions(value::EnergyShareRequirements) = value.eligible_regions

"""Set [`EnergyShareRequirements`](@ref) `name`."""
set_name!(value::EnergyShareRequirements, val) = value.name = val
"""Set [`EnergyShareRequirements`](@ref) `target_year`."""
set_target_year!(value::EnergyShareRequirements, val) = value.target_year = val
"""Set [`EnergyShareRequirements`](@ref) `internal`."""
set_internal!(value::EnergyShareRequirements, val) = value.internal = val
"""Set [`EnergyShareRequirements`](@ref) `id`."""
set_id!(value::EnergyShareRequirements, val) = value.id = val
"""Set [`EnergyShareRequirements`](@ref) `generation_fraction_requirement`."""
set_generation_fraction_requirement!(value::EnergyShareRequirements, val) = value.generation_fraction_requirement = val
"""Set [`EnergyShareRequirements`](@ref) `ext`."""
set_ext!(value::EnergyShareRequirements, val) = value.ext = val
"""Set [`EnergyShareRequirements`](@ref) `eligible_resources`."""
set_eligible_resources!(value::EnergyShareRequirements, val) = value.eligible_resources = val
"""Set [`EnergyShareRequirements`](@ref) `available`."""
set_available!(value::EnergyShareRequirements, val) = value.available = val
"""Set [`EnergyShareRequirements`](@ref) `eligible_regions`."""
set_eligible_regions!(value::EnergyShareRequirements, val) = value.eligible_regions = val

function serialize_openapi_struct(technology::EnergyShareRequirements, vals...)
    base_struct = APIServer.EnergyShareRequirements(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:EnergyShareRequirements}, vals::Dict)
    return IS.deserialize_struct(APIServer.EnergyShareRequirements, vals)
end
