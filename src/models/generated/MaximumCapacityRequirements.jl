#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct MaximumCapacityRequirements <: Requirements
        name::String
        max_capacity_mw::Float64
        internal::InfrastructureSystemsInternal
        ext::Dict
        eligible_resources::Vector{Technology}
        available::Bool
    end



# Arguments
- `name::String`: The technology name
- `max_capacity_mw::Float64`: (default: `0.0`) Maximum total capacity across all eligible resources
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `eligible_resources::Vector{Technology}`: (default: `Vector{Technology}()`) List of technologies that contribute to the carbon cap constraint.
- `available::Bool`: Availability
"""
mutable struct MaximumCapacityRequirements <: Requirements
    "The technology name"
    name::String
    "Maximum total capacity across all eligible resources"
    max_capacity_mw::Float64
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "List of technologies that contribute to the carbon cap constraint."
    eligible_resources::Vector{Technology}
    "Availability"
    available::Bool
end


function MaximumCapacityRequirements(; name, max_capacity_mw=0.0, internal=InfrastructureSystemsInternal(), ext=Dict(), eligible_resources=Vector{Technology}(), available, )
    MaximumCapacityRequirements(name, max_capacity_mw, internal, ext, eligible_resources, available, )
end

"""Get [`MaximumCapacityRequirements`](@ref) `name`."""
get_name(value::MaximumCapacityRequirements) = value.name
"""Get [`MaximumCapacityRequirements`](@ref) `max_capacity_mw`."""
get_max_capacity_mw(value::MaximumCapacityRequirements) = value.max_capacity_mw
"""Get [`MaximumCapacityRequirements`](@ref) `internal`."""
get_internal(value::MaximumCapacityRequirements) = value.internal
"""Get [`MaximumCapacityRequirements`](@ref) `ext`."""
get_ext(value::MaximumCapacityRequirements) = value.ext
"""Get [`MaximumCapacityRequirements`](@ref) `eligible_resources`."""
get_eligible_resources(value::MaximumCapacityRequirements) = value.eligible_resources
"""Get [`MaximumCapacityRequirements`](@ref) `available`."""
get_available(value::MaximumCapacityRequirements) = value.available

"""Set [`MaximumCapacityRequirements`](@ref) `name`."""
set_name!(value::MaximumCapacityRequirements, val) = value.name = val
"""Set [`MaximumCapacityRequirements`](@ref) `max_capacity_mw`."""
set_max_capacity_mw!(value::MaximumCapacityRequirements, val) = value.max_capacity_mw = val
"""Set [`MaximumCapacityRequirements`](@ref) `internal`."""
set_internal!(value::MaximumCapacityRequirements, val) = value.internal = val
"""Set [`MaximumCapacityRequirements`](@ref) `ext`."""
set_ext!(value::MaximumCapacityRequirements, val) = value.ext = val
"""Set [`MaximumCapacityRequirements`](@ref) `eligible_resources`."""
set_eligible_resources!(value::MaximumCapacityRequirements, val) = value.eligible_resources = val
"""Set [`MaximumCapacityRequirements`](@ref) `available`."""
set_available!(value::MaximumCapacityRequirements, val) = value.available = val
