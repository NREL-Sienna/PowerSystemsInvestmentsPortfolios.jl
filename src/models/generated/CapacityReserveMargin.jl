#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct CapacityReserveMargin <: Requirement
        name::String
        available::Bool
        id::Int64
        eligible_regions::Vector{RegionTopology}
        eligible_technologies::Vector{Technology}
        target_year::Int64
        capacity_reserve_fraction::Float64
        ext::Dict
        internal::InfrastructureSystemsInternal
    end

Policy requirement to enforce a minimum capacity reserve margin, such that (total_capacity - peak_demand)/peak_demand >= capacity_reserve_fraction

# Arguments
- `name::String`: The requirement name
- `available::Bool`: Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `id::Int64`: ID for individual policy
- `eligible_regions::Vector{RegionTopology}`: (default: `Vector{RegionTopology}()`) List of regions where this reserve margin is enforced
- `eligible_technologies::Vector{Technology}`: (default: `Vector{Technology}()`) List of technologies that can contribute to the capacity reserve margin requirement
- `target_year::Int64`: (default: `2050`) Year in which capacity reserve margin will be applied
- `capacity_reserve_fraction::Float64`: (default: `0.0`) Capacity reserve requirements, represented as a fraction of peak demand in a region
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
"""
mutable struct CapacityReserveMargin <: Requirement
    "The requirement name"
    name::String
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
    "ID for individual policy"
    id::Int64
    "List of regions where this reserve margin is enforced"
    eligible_regions::Vector{RegionTopology}
    "List of technologies that can contribute to the capacity reserve margin requirement"
    eligible_technologies::Vector{Technology}
    "Year in which capacity reserve margin will be applied"
    target_year::Int64
    "Capacity reserve requirements, represented as a fraction of peak demand in a region"
    capacity_reserve_fraction::Float64
    "Optional dictionary to provide additional data"
    ext::Dict
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
end


function CapacityReserveMargin(; name, available, id, eligible_regions=Vector{RegionTopology}(), eligible_technologies=Vector{Technology}(), target_year=2050, capacity_reserve_fraction=0.0, ext=Dict(), internal=InfrastructureSystemsInternal(), )
    CapacityReserveMargin(name, available, id, eligible_regions, eligible_technologies, target_year, capacity_reserve_fraction, ext, internal, )
end

"""Get [`CapacityReserveMargin`](@ref) `name`."""
get_name(value::CapacityReserveMargin) = value.name
"""Get [`CapacityReserveMargin`](@ref) `available`."""
get_available(value::CapacityReserveMargin) = value.available
"""Get [`CapacityReserveMargin`](@ref) `id`."""
get_id(value::CapacityReserveMargin) = value.id
"""Get [`CapacityReserveMargin`](@ref) `eligible_regions`."""
get_eligible_regions(value::CapacityReserveMargin) = value.eligible_regions
"""Get [`CapacityReserveMargin`](@ref) `eligible_technologies`."""
get_eligible_technologies(value::CapacityReserveMargin) = value.eligible_technologies
"""Get [`CapacityReserveMargin`](@ref) `target_year`."""
get_target_year(value::CapacityReserveMargin) = value.target_year
"""Get [`CapacityReserveMargin`](@ref) `capacity_reserve_fraction`."""
get_capacity_reserve_fraction(value::CapacityReserveMargin) = value.capacity_reserve_fraction
"""Get [`CapacityReserveMargin`](@ref) `ext`."""
get_ext(value::CapacityReserveMargin) = value.ext
"""Get [`CapacityReserveMargin`](@ref) `internal`."""
get_internal(value::CapacityReserveMargin) = value.internal

"""Set [`CapacityReserveMargin`](@ref) `name`."""
set_name!(value::CapacityReserveMargin, val) = value.name = val
"""Set [`CapacityReserveMargin`](@ref) `available`."""
set_available!(value::CapacityReserveMargin, val) = value.available = val
"""Set [`CapacityReserveMargin`](@ref) `id`."""
set_id!(value::CapacityReserveMargin, val) = value.id = val
"""Set [`CapacityReserveMargin`](@ref) `eligible_regions`."""
set_eligible_regions!(value::CapacityReserveMargin, val) = value.eligible_regions = val
"""Set [`CapacityReserveMargin`](@ref) `eligible_technologies`."""
set_eligible_technologies!(value::CapacityReserveMargin, val) = value.eligible_technologies = val
"""Set [`CapacityReserveMargin`](@ref) `target_year`."""
set_target_year!(value::CapacityReserveMargin, val) = value.target_year = val
"""Set [`CapacityReserveMargin`](@ref) `capacity_reserve_fraction`."""
set_capacity_reserve_fraction!(value::CapacityReserveMargin, val) = value.capacity_reserve_fraction = val
"""Set [`CapacityReserveMargin`](@ref) `ext`."""
set_ext!(value::CapacityReserveMargin, val) = value.ext = val
"""Set [`CapacityReserveMargin`](@ref) `internal`."""
set_internal!(value::CapacityReserveMargin, val) = value.internal = val

function serialize_openapi_struct(technology::CapacityReserveMargin, vals...)
    base_struct = APIServer.CapacityReserveMargin(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:CapacityReserveMargin}, vals::Dict)
    return IS.deserialize_struct(APIServer.CapacityReserveMargin, vals)
end
