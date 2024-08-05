#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct MinimumCapacityRequirements <: Requirements
        name::String
        internal::InfrastructureSystemsInternal
        ext::Dict
        min_mw::Float64
        eligible_resources::Vector{String}
        available::Bool
    end



# Arguments
- `name::String`: The technology name
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `min_mw::Float64`: (default: `0`) Minimum total capacity across all eligible resources
- `eligible_resources::Vector{String}`: (default: `Vector{String}()`) List of resources that contribute to the carbon cap constraint.
- `available::Bool`: Availability
"""
mutable struct MinimumCapacityRequirements <: Requirements
    "The technology name"
    name::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Minimum total capacity across all eligible resources"
    min_mw::Float64
    "List of resources that contribute to the carbon cap constraint."
    eligible_resources::Vector{String}
    "Availability"
    available::Bool
end


function MinimumCapacityRequirements(; name, internal=InfrastructureSystemsInternal(), ext=Dict(), min_mw=0, eligible_resources=Vector{String}(), available, )
    MinimumCapacityRequirements(name, internal, ext, min_mw, eligible_resources, available, )
end

"""Get [`MinimumCapacityRequirements`](@ref) `name`."""
get_name(value::MinimumCapacityRequirements) = value.name
"""Get [`MinimumCapacityRequirements`](@ref) `internal`."""
get_internal(value::MinimumCapacityRequirements) = value.internal
"""Get [`MinimumCapacityRequirements`](@ref) `ext`."""
get_ext(value::MinimumCapacityRequirements) = value.ext
"""Get [`MinimumCapacityRequirements`](@ref) `min_mw`."""
get_min_mw(value::MinimumCapacityRequirements) = value.min_mw
"""Get [`MinimumCapacityRequirements`](@ref) `eligible_resources`."""
get_eligible_resources(value::MinimumCapacityRequirements) = value.eligible_resources
"""Get [`MinimumCapacityRequirements`](@ref) `available`."""
get_available(value::MinimumCapacityRequirements) = value.available

"""Set [`MinimumCapacityRequirements`](@ref) `name`."""
set_name!(value::MinimumCapacityRequirements, val) = value.name = val
"""Set [`MinimumCapacityRequirements`](@ref) `internal`."""
set_internal!(value::MinimumCapacityRequirements, val) = value.internal = val
"""Set [`MinimumCapacityRequirements`](@ref) `ext`."""
set_ext!(value::MinimumCapacityRequirements, val) = value.ext = val
"""Set [`MinimumCapacityRequirements`](@ref) `min_mw`."""
set_min_mw!(value::MinimumCapacityRequirements, val) = value.min_mw = val
"""Set [`MinimumCapacityRequirements`](@ref) `eligible_resources`."""
set_eligible_resources!(value::MinimumCapacityRequirements, val) = value.eligible_resources = val
"""Set [`MinimumCapacityRequirements`](@ref) `available`."""
set_available!(value::MinimumCapacityRequirements, val) = value.available = val