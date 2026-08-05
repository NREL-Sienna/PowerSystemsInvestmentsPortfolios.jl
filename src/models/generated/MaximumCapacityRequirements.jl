#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct MaximumCapacityRequirements <: Requirement
        name::String
        available::Bool
        id::Int64
        max_capacity_mw::Float64
        target_year::Int64
        ext::Dict
        internal::InfrastructureSystemsInternal
    end

Policy requirement that the total capacity of all technologies in `eligible_resources` in the target year is less than the specified limit in MW

# Arguments
- `name::String`: The technology name
- `available::Bool`: Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `id::Int64`: ID for individual policy
- `max_capacity_mw::Float64`: (default: `0.0`) Maximum total capacity across all eligible resources (MW)
- `target_year::Int64`: (default: `2050`) Year in which the capacity requirement will be applied
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
"""
mutable struct MaximumCapacityRequirements <: Requirement
    "The technology name"
    name::String
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
    "ID for individual policy"
    id::Int64
    "Maximum total capacity across all eligible resources (MW)"
    max_capacity_mw::Float64
    "Year in which the capacity requirement will be applied"
    target_year::Int64
    "Optional dictionary to provide additional data"
    ext::Dict
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
end


function MaximumCapacityRequirements(; name, available, id, max_capacity_mw=0.0, target_year=2050, ext=Dict(), internal=InfrastructureSystemsInternal(), )
    MaximumCapacityRequirements(name, available, id, max_capacity_mw, target_year, ext, internal, )
end

"""Get [`MaximumCapacityRequirements`](@ref) `name`."""
get_name(value::MaximumCapacityRequirements) = value.name
"""Get [`MaximumCapacityRequirements`](@ref) `available`."""
get_available(value::MaximumCapacityRequirements) = value.available
"""Get [`MaximumCapacityRequirements`](@ref) `id`."""
get_id(value::MaximumCapacityRequirements) = value.id
"""Get [`MaximumCapacityRequirements`](@ref) `max_capacity_mw`."""
get_max_capacity_mw(value::MaximumCapacityRequirements) = value.max_capacity_mw
"""Get [`MaximumCapacityRequirements`](@ref) `target_year`."""
get_target_year(value::MaximumCapacityRequirements) = value.target_year
"""Get [`MaximumCapacityRequirements`](@ref) `ext`."""
get_ext(value::MaximumCapacityRequirements) = value.ext
"""Get [`MaximumCapacityRequirements`](@ref) `internal`."""
get_internal(value::MaximumCapacityRequirements) = value.internal

"""Set [`MaximumCapacityRequirements`](@ref) `name`."""
set_name!(value::MaximumCapacityRequirements, val) = value.name = val
"""Set [`MaximumCapacityRequirements`](@ref) `available`."""
set_available!(value::MaximumCapacityRequirements, val) = value.available = val
"""Set [`MaximumCapacityRequirements`](@ref) `id`."""
set_id!(value::MaximumCapacityRequirements, val) = value.id = val
"""Set [`MaximumCapacityRequirements`](@ref) `max_capacity_mw`."""
set_max_capacity_mw!(value::MaximumCapacityRequirements, val) = value.max_capacity_mw = val
"""Set [`MaximumCapacityRequirements`](@ref) `target_year`."""
set_target_year!(value::MaximumCapacityRequirements, val) = value.target_year = val
"""Set [`MaximumCapacityRequirements`](@ref) `ext`."""
set_ext!(value::MaximumCapacityRequirements, val) = value.ext = val
"""Set [`MaximumCapacityRequirements`](@ref) `internal`."""
set_internal!(value::MaximumCapacityRequirements, val) = value.internal = val



function serialize_openapi_struct(technology::MaximumCapacityRequirements, vals...)
    base_struct = APIServer.MaximumCapacityRequirements(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:MaximumCapacityRequirements}, vals::Dict)
    return IS.deserialize_struct(APIServer.MaximumCapacityRequirements, vals)
end
