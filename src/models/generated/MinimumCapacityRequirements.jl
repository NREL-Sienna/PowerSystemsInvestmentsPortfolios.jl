#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct MinimumCapacityRequirements <: Requirements
        name::String
        power_systems_type::String
        pricecap::Float64
        internal::InfrastructureSystemsInternal
        ext::Dict
        min_mw::Float64
        eligible_resources::Vector{String}
        available::Bool
    end



# Arguments
- `name::String`: The technology name
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `pricecap::Float64`: (default: `1e8`) price threshold for policy constraint, USD/MW
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `min_mw::Float64`: (default: `0.0`) Minimum total capacity across all eligible resources
- `eligible_resources::Vector{String}`: (default: `Vector{String}()`) List of resources that contribute to the carbon cap constraint.
- `available::Bool`: Availability
"""
mutable struct MinimumCapacityRequirements <: Requirements
    "The technology name"
    name::String
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "price threshold for policy constraint, USD/MW"
    pricecap::Float64
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


function MinimumCapacityRequirements(; name, power_systems_type, pricecap=1e8, internal=InfrastructureSystemsInternal(), ext=Dict(), min_mw=0.0, eligible_resources=Vector{String}(), available, )
    MinimumCapacityRequirements(name, power_systems_type, pricecap, internal, ext, min_mw, eligible_resources, available, )
end

"""Get [`MinimumCapacityRequirements`](@ref) `name`."""
get_name(value::MinimumCapacityRequirements) = value.name
"""Get [`MinimumCapacityRequirements`](@ref) `power_systems_type`."""
get_power_systems_type(value::MinimumCapacityRequirements) = value.power_systems_type
"""Get [`MinimumCapacityRequirements`](@ref) `pricecap`."""
get_pricecap(value::MinimumCapacityRequirements) = value.pricecap
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
"""Set [`MinimumCapacityRequirements`](@ref) `power_systems_type`."""
set_power_systems_type!(value::MinimumCapacityRequirements, val) = value.power_systems_type = val
"""Set [`MinimumCapacityRequirements`](@ref) `pricecap`."""
set_pricecap!(value::MinimumCapacityRequirements, val) = value.pricecap = val
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

function serialize_openapi_struct(technology::MinimumCapacityRequirements, vals...)
    base_struct = APIServer.MinimumCapacityRequirements(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:MinimumCapacityRequirements}, vals::Dict)
    return IS.deserialize_struct(APIServer.MinimumCapacityRequirements, vals)
end
