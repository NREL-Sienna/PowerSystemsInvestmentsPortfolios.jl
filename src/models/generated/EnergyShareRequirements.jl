#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct EnergyShareRequirements <: Requirement
        name::String
        eligible_technologies::Vector{Technology}
        internal::InfrastructureSystemsInternal
        id::Int64
        ext::Dict
        generation_fraction::Float64
        available::Bool
        eligible_regions::Vector{Region}
    end



# Arguments
- `name::String`: The policy name
- `eligible_technologies::Vector{Technology}`: (default: `Vector{Technology}()`) List of SupplyTechnologies that will meet the energy share requirement.
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `id::Int64`: ID for individual policy
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `generation_fraction::Float64`: (default: `0.0`) Fraction of total demand across all eligible zones that needs to be met by qualifying resources.
- `available::Bool`: Availability
- `eligible_regions::Vector{Region}`: (default: `Vector{Region}()`) List of regions where the EnergyShareRequirement will be applied.
"""
mutable struct EnergyShareRequirements <: Requirement
    "The policy name"
    name::String
    "List of SupplyTechnologies that will meet the energy share requirement."
    eligible_technologies::Vector{Technology}
    "Internal field"
    internal::InfrastructureSystemsInternal
    "ID for individual policy"
    id::Int64
    "Option for providing additional data"
    ext::Dict
    "Fraction of total demand across all eligible zones that needs to be met by qualifying resources."
    generation_fraction::Float64
    "Availability"
    available::Bool
    "List of regions where the EnergyShareRequirement will be applied."
    eligible_regions::Vector{Region}
end


function EnergyShareRequirements(; name, eligible_technologies=Vector{Technology}(), internal=InfrastructureSystemsInternal(), id, ext=Dict(), generation_fraction=0.0, available, eligible_regions=Vector{Region}(), )
    EnergyShareRequirements(name, eligible_technologies, internal, id, ext, generation_fraction, available, eligible_regions, )
end

"""Get [`EnergyShareRequirements`](@ref) `name`."""
get_name(value::EnergyShareRequirements) = value.name
"""Get [`EnergyShareRequirements`](@ref) `eligible_technologies`."""
get_eligible_technologies(value::EnergyShareRequirements) = value.eligible_technologies
"""Get [`EnergyShareRequirements`](@ref) `internal`."""
get_internal(value::EnergyShareRequirements) = value.internal
"""Get [`EnergyShareRequirements`](@ref) `id`."""
get_id(value::EnergyShareRequirements) = value.id
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
"""Set [`EnergyShareRequirements`](@ref) `eligible_technologies`."""
set_eligible_technologies!(value::EnergyShareRequirements, val) = value.eligible_technologies = val
"""Set [`EnergyShareRequirements`](@ref) `internal`."""
set_internal!(value::EnergyShareRequirements, val) = value.internal = val
"""Set [`EnergyShareRequirements`](@ref) `id`."""
set_id!(value::EnergyShareRequirements, val) = value.id = val
"""Set [`EnergyShareRequirements`](@ref) `ext`."""
set_ext!(value::EnergyShareRequirements, val) = value.ext = val
"""Set [`EnergyShareRequirements`](@ref) `generation_fraction`."""
set_generation_fraction!(value::EnergyShareRequirements, val) = value.generation_fraction = val
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
