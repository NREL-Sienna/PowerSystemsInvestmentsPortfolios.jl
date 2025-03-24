#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct MinimumCapacityRequirements <: Requirement
        name::String
        target_year::Int64
        internal::InfrastructureSystemsInternal
        id::Int64
        min_capacity_mw::Float64
        ext::Dict
        eligible_resources::Vector{Technology}
        available::Bool
    end

Policy requirement that the total capacity of all technologies in `eligible_technologies` in the target year is greater than or equal to the specific minimum in MW

# Arguments
- `name::String`: The requirement name
- `target_year::Int64`: (default: `2050`) Year in which carbon cap will be applied
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `id::Int64`: ID for individual policy
- `min_capacity_mw::Float64`: (default: `0.0`) Minimum total capacity across all eligible resources
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `eligible_resources::Vector{Technology}`: (default: `Vector{Technology}()`) List of resources that contribute to the carbon cap constraint.
- `available::Bool`: Availability
"""

mutable struct MinimumCapacityRequirements <: Requirement
    "The requirement name"
    name::String
    "Year in which carbon cap will be applied"
    target_year::Int64
    "Internal field"
    internal::InfrastructureSystemsInternal
    "ID for individual policy"
    id::Int64
    "Minimum total capacity across all eligible resources"
    min_capacity_mw::Float64
    "Option for providing additional data"
    ext::Dict
    "List of resources that contribute to the carbon cap constraint."
    eligible_resources::Vector{Technology}
    "Availability"
    available::Bool
end


function MinimumCapacityRequirements(; name, target_year=2050, internal=InfrastructureSystemsInternal(), id, min_capacity_mw=0.0, ext=Dict(), eligible_resources=Vector{Technology}(), available, )
    MinimumCapacityRequirements(name, target_year, internal, id, min_capacity_mw, ext, eligible_resources, available, )
end

"""Get [`MinimumCapacityRequirements`](@ref) `name`."""
get_name(value::MinimumCapacityRequirements) = value.name
"""Get [`MinimumCapacityRequirements`](@ref) `target_year`."""
get_target_year(value::MinimumCapacityRequirements) = value.target_year
"""Get [`MinimumCapacityRequirements`](@ref) `internal`."""
get_internal(value::MinimumCapacityRequirements) = value.internal
"""Get [`MinimumCapacityRequirements`](@ref) `id`."""
get_id(value::MinimumCapacityRequirements) = value.id
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
"""Set [`MinimumCapacityRequirements`](@ref) `target_year`."""
set_target_year!(value::MinimumCapacityRequirements, val) = value.target_year = val
"""Set [`MinimumCapacityRequirements`](@ref) `internal`."""
set_internal!(value::MinimumCapacityRequirements, val) = value.internal = val
"""Set [`MinimumCapacityRequirements`](@ref) `id`."""
set_id!(value::MinimumCapacityRequirements, val) = value.id = val
"""Set [`MinimumCapacityRequirements`](@ref) `min_capacity_mw`."""
set_min_capacity_mw!(value::MinimumCapacityRequirements, val) = value.min_capacity_mw = val
"""Set [`MinimumCapacityRequirements`](@ref) `ext`."""
set_ext!(value::MinimumCapacityRequirements, val) = value.ext = val
"""Set [`MinimumCapacityRequirements`](@ref) `eligible_resources`."""
set_eligible_resources!(value::MinimumCapacityRequirements, val) = value.eligible_resources = val
"""Set [`MinimumCapacityRequirements`](@ref) `available`."""
set_available!(value::MinimumCapacityRequirements, val) = value.available = val

function serialize_openapi_struct(technology::MinimumCapacityRequirements, vals...)
    base_struct = APIServer.MinimumCapacityRequirements(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:MinimumCapacityRequirements}, vals::Dict)
    return IS.deserialize_struct(APIServer.MinimumCapacityRequirements, vals)
end

function serialize_openapi_struct(technology::MinimumCapacityRequirements, vals...)
    base_struct = APIServer.MinimumCapacityRequirements(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:MinimumCapacityRequirements}, vals::Dict)
    return IS.deserialize_struct(APIServer.MinimumCapacityRequirements, vals)
end
