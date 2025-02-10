#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct MinimumCapacityRequirements <: Requirements
        name::String
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        min_capacity_mw::Float64
        ext::Dict
        eligible_resources::Vector{Technology}
        available::Bool
    end



# Arguments
- `name::String`: The technology name
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `min_capacity_mw::Float64`: (default: `0.0`) Minimum total capacity across all eligible resources
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `eligible_resources::Vector{Technology}`: (default: `Vector{Technology}()`) List of technologies that contribute to the carbon cap constraint.
- `available::Bool`: Availability
"""
mutable struct MinimumCapacityRequirements <: Requirements
    "The technology name"
    name::String
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Minimum total capacity across all eligible resources"
    min_capacity_mw::Float64
    "Option for providing additional data"
    ext::Dict
    "List of technologies that contribute to the carbon cap constraint."
    eligible_resources::Vector{Technology}
    "Availability"
    available::Bool
end


function MinimumCapacityRequirements(; name, power_systems_type, internal=InfrastructureSystemsInternal(), min_capacity_mw=0.0, ext=Dict(), eligible_resources=Vector{Technology}(), available, )
    MinimumCapacityRequirements(name, power_systems_type, internal, min_capacity_mw, ext, eligible_resources, available, )
end

"""Get [`MinimumCapacityRequirements`](@ref) `name`."""
get_name(value::MinimumCapacityRequirements) = value.name
"""Get [`MinimumCapacityRequirements`](@ref) `power_systems_type`."""
get_power_systems_type(value::MinimumCapacityRequirements) = value.power_systems_type
"""Get [`MinimumCapacityRequirements`](@ref) `internal`."""
get_internal(value::MinimumCapacityRequirements) = value.internal
"""Get [`MinimumCapacityRequirements`](@ref) `min_capacity_mw`."""
get_min_capacity_mw(value::MinimumCapacityRequirements) = value.min_capacity_mw
"""Get [`MinimumCapacityRequirements`](@ref) `ext`."""
get_ext(value::MinimumCapacityRequirements) = value.ext
"""Get [`MinimumCapacityRequirements`](@ref) `eligible_resources`."""
get_eligible_resources(value::MinimumCapacityRequirements) = value.eligible_resources
"""Get [`MinimumCapacityRequirements`](@ref) `available`."""
get_available(value::MinimumCapacityRequirements) = value.available

"""Set [`MinimumCapacityRequirements`](@ref) `name`."""
set_name!(value::MinimumCapacityRequirements, val) = value.name = val
"""Set [`MinimumCapacityRequirements`](@ref) `power_systems_type`."""
set_power_systems_type!(value::MinimumCapacityRequirements, val) = value.power_systems_type = val
"""Set [`MinimumCapacityRequirements`](@ref) `internal`."""
set_internal!(value::MinimumCapacityRequirements, val) = value.internal = val
"""Set [`MinimumCapacityRequirements`](@ref) `min_capacity_mw`."""
set_min_capacity_mw!(value::MinimumCapacityRequirements, val) = value.min_capacity_mw = val
"""Set [`MinimumCapacityRequirements`](@ref) `ext`."""
set_ext!(value::MinimumCapacityRequirements, val) = value.ext = val
"""Set [`MinimumCapacityRequirements`](@ref) `eligible_resources`."""
set_eligible_resources!(value::MinimumCapacityRequirements, val) = value.eligible_resources = val
"""Set [`MinimumCapacityRequirements`](@ref) `available`."""
set_available!(value::MinimumCapacityRequirements, val) = value.available = val
