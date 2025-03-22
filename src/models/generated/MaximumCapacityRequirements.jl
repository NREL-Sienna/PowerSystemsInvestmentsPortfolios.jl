#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct MaximumCapacityRequirements <: Requirement
        name::String
        max_capacity_mw::Float64
        target_year::Int64
        internal::InfrastructureSystemsInternal
        ext::Dict
        eligible_resources::Vector{Technology}
        available::Bool
    end



# Arguments
- `name::String`: The technology name
- `max_capacity_mw::Float64`: (default: `0.0`) Maximum total capacity across all eligible resources
- `target_year::Int64`: (default: `2050`) Year in which carbon cap will be applied
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `eligible_resources::Vector{Technology}`: (default: `Vector{Technology}()`) List of technologies that contribute to the carbon cap constraint.
- `available::Bool`: Availability
"""
mutable struct MaximumCapacityRequirements <: Requirement
    "The technology name"
    name::String
    "Maximum total capacity across all eligible resources"
    max_capacity_mw::Float64
    "Year in which carbon cap will be applied"
    target_year::Int64
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "List of technologies that contribute to the carbon cap constraint."
    eligible_resources::Vector{Technology}
    "Availability"
    available::Bool
end


function MaximumCapacityRequirements(; name, max_capacity_mw=0.0, target_year=2050, internal=InfrastructureSystemsInternal(), ext=Dict(), eligible_resources=Vector{Technology}(), available, )
    MaximumCapacityRequirements(name, max_capacity_mw, target_year, internal, ext, eligible_resources, available, )
end

"""Get [`MaximumCapacityRequirements`](@ref) `name`."""
get_name(value::MaximumCapacityRequirements) = value.name
"""Get [`MaximumCapacityRequirements`](@ref) `max_capacity_mw`."""
get_max_capacity_mw(value::MaximumCapacityRequirements) = value.max_capacity_mw
"""Get [`MaximumCapacityRequirements`](@ref) `target_year`."""
get_target_year(value::MaximumCapacityRequirements) = value.target_year
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
"""Set [`MaximumCapacityRequirements`](@ref) `target_year`."""
set_target_year!(value::MaximumCapacityRequirements, val) = value.target_year = val
"""Set [`MaximumCapacityRequirements`](@ref) `internal`."""
set_internal!(value::MaximumCapacityRequirements, val) = value.internal = val
"""Set [`MaximumCapacityRequirements`](@ref) `ext`."""
set_ext!(value::MaximumCapacityRequirements, val) = value.ext = val
"""Set [`MaximumCapacityRequirements`](@ref) `eligible_resources`."""
set_eligible_resources!(value::MaximumCapacityRequirements, val) = value.eligible_resources = val
"""Set [`MaximumCapacityRequirements`](@ref) `available`."""
set_available!(value::MaximumCapacityRequirements, val) = value.available = val

function serialize_openapi_struct(technology::MaximumCapacityRequirements, vals...)
    base_struct = APIServer.MaximumCapacityRequirements(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:MaximumCapacityRequirements}, vals::Dict)
    return IS.deserialize_struct(APIServer.MaximumCapacityRequirements, vals)
end
