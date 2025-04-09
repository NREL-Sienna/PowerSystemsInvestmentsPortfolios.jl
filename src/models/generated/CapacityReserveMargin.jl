#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct CapacityReserveMargin <: Requirement
        name::String
        eligible_technologies::Vector{Technology}
        target_year::Int64
        internal::InfrastructureSystemsInternal
        id::Int64
        capacity_reserve_fraction::Float64
        ext::Dict
        available::Bool
        eligible_regions::Vector{RegionTopology}
    end

Policy requirement to enforce a minimum capacity reserve margin, such that (total_capacity - peak_demand)/peak_demand >= capacity_reserve_fraction

# Arguments
- `name::String`: The requirement name
- `eligible_technologies::Vector{Technology}`: (default: `Vector{Technology}()`) List of technologies that can contribute to the capacity reserve margin requirement
- `target_year::Int64`: (default: `2050`) Year in which carbon cap will be applied
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `id::Int64`: ID for individual policy
- `capacity_reserve_fraction::Float64`: (default: `0.0`) Capacity reserve requirements, represented as a fraction of peak demand in region
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `available::Bool`: Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `eligible_regions::Vector{RegionTopology}`: (default: `Vector{RegionTopology}()`) List of regions where this reserve margin is enforced
"""
mutable struct CapacityReserveMargin <: Requirement
    "The requirement name"
    name::String
    "List of technologies that can contribute to the capacity reserve margin requirement"
    eligible_technologies::Vector{Technology}
    "Year in which carbon cap will be applied"
    target_year::Int64
    "Internal field"
    internal::InfrastructureSystemsInternal
    "ID for individual policy"
    id::Int64
    "Capacity reserve requirements, represented as a fraction of peak demand in region"
    capacity_reserve_fraction::Float64
    "Option for providing additional data"
    ext::Dict
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
    "List of regions where this reserve margin is enforced"
    eligible_regions::Vector{RegionTopology}
end


function CapacityReserveMargin(; name, eligible_technologies=Vector{Technology}(), target_year=2050, internal=InfrastructureSystemsInternal(), id, capacity_reserve_fraction=0.0, ext=Dict(), available, eligible_regions=Vector{RegionTopology}(), )
    CapacityReserveMargin(name, eligible_technologies, target_year, internal, id, capacity_reserve_fraction, ext, available, eligible_regions, )
end

"""Get [`CapacityReserveMargin`](@ref) `name`."""
get_name(value::CapacityReserveMargin) = value.name
"""Get [`CapacityReserveMargin`](@ref) `eligible_technologies`."""
get_eligible_technologies(value::CapacityReserveMargin) = value.eligible_technologies
"""Get [`CapacityReserveMargin`](@ref) `target_year`."""
get_target_year(value::CapacityReserveMargin) = value.target_year
"""Get [`CapacityReserveMargin`](@ref) `internal`."""
get_internal(value::CapacityReserveMargin) = value.internal
"""Get [`CapacityReserveMargin`](@ref) `id`."""
get_id(value::CapacityReserveMargin) = value.id
"""Get [`CapacityReserveMargin`](@ref) `capacity_reserve_fraction`."""
get_capacity_reserve_fraction(value::CapacityReserveMargin) = value.capacity_reserve_fraction
"""Get [`CapacityReserveMargin`](@ref) `ext`."""
get_ext(value::CapacityReserveMargin) = value.ext
"""Get [`CapacityReserveMargin`](@ref) `available`."""
get_available(value::CapacityReserveMargin) = value.available
"""Get [`CapacityReserveMargin`](@ref) `eligible_regions`."""
get_eligible_regions(value::CapacityReserveMargin) = value.eligible_regions

"""Set [`CapacityReserveMargin`](@ref) `name`."""
set_name!(value::CapacityReserveMargin, val) = value.name = val
"""Set [`CapacityReserveMargin`](@ref) `eligible_technologies`."""
set_eligible_technologies!(value::CapacityReserveMargin, val) = value.eligible_technologies = val
"""Set [`CapacityReserveMargin`](@ref) `target_year`."""
set_target_year!(value::CapacityReserveMargin, val) = value.target_year = val
"""Set [`CapacityReserveMargin`](@ref) `internal`."""
set_internal!(value::CapacityReserveMargin, val) = value.internal = val
"""Set [`CapacityReserveMargin`](@ref) `id`."""
set_id!(value::CapacityReserveMargin, val) = value.id = val
"""Set [`CapacityReserveMargin`](@ref) `capacity_reserve_fraction`."""
set_capacity_reserve_fraction!(value::CapacityReserveMargin, val) = value.capacity_reserve_fraction = val
"""Set [`CapacityReserveMargin`](@ref) `ext`."""
set_ext!(value::CapacityReserveMargin, val) = value.ext = val
"""Set [`CapacityReserveMargin`](@ref) `available`."""
set_available!(value::CapacityReserveMargin, val) = value.available = val
"""Set [`CapacityReserveMargin`](@ref) `eligible_regions`."""
set_eligible_regions!(value::CapacityReserveMargin, val) = value.eligible_regions = val

function serialize_openapi_struct(technology::CapacityReserveMargin, vals...)
    base_struct = APIServer.CapacityReserveMargin(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:CapacityReserveMargin}, vals::Dict)
    return IS.deserialize_struct(APIServer.CapacityReserveMargin, vals)
end
