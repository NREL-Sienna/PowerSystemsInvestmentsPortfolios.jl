#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct CarbonCaps <: Requirements
        name::String
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        max_tons_per_mwh::Float64
        max_tons::Float64
        ext::Dict
        available::Bool
        eligible_regions::Vector{Region}
    end



# Arguments
- `name::String`: The technology name
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `max_tons_per_mwh::Float64`: (default: `1.0`) Emission limit in terms of rate (tCO2/MWh)
- `max_tons::Float64`: (default: `1e8`) Emission limit in absolute values, in Million of tons
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `available::Bool`: Availability
- `eligible_regions::Vector{Region}`: (default: `Vector{Region}()`) List of regions that contribute to the carbon cap constraint.
"""
mutable struct CarbonCaps <: Requirements
    "The technology name"
    name::String
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Emission limit in terms of rate (tCO2/MWh)"
    max_tons_per_mwh::Float64
    "Emission limit in absolute values, in Million of tons"
    max_tons::Float64
    "Option for providing additional data"
    ext::Dict
    "Availability"
    available::Bool
    "List of regions that contribute to the carbon cap constraint."
    eligible_regions::Vector{Region}
end


function CarbonCaps(; name, power_systems_type, internal=InfrastructureSystemsInternal(), max_tons_per_mwh=1.0, max_tons=1e8, ext=Dict(), available, eligible_regions=Vector{Region}(), )
    CarbonCaps(name, power_systems_type, internal, max_tons_per_mwh, max_tons, ext, available, eligible_regions, )
end

"""Get [`CarbonCaps`](@ref) `name`."""
get_name(value::CarbonCaps) = value.name
"""Get [`CarbonCaps`](@ref) `power_systems_type`."""
get_power_systems_type(value::CarbonCaps) = value.power_systems_type
"""Get [`CarbonCaps`](@ref) `internal`."""
get_internal(value::CarbonCaps) = value.internal
"""Get [`CarbonCaps`](@ref) `max_tons_per_mwh`."""
get_max_tons_per_mwh(value::CarbonCaps) = value.max_tons_per_mwh
"""Get [`CarbonCaps`](@ref) `max_tons`."""
get_max_tons(value::CarbonCaps) = value.max_tons
"""Get [`CarbonCaps`](@ref) `ext`."""
get_ext(value::CarbonCaps) = value.ext
"""Get [`CarbonCaps`](@ref) `available`."""
get_available(value::CarbonCaps) = value.available
"""Get [`CarbonCaps`](@ref) `eligible_regions`."""
get_eligible_regions(value::CarbonCaps) = value.eligible_regions

"""Set [`CarbonCaps`](@ref) `name`."""
set_name!(value::CarbonCaps, val) = value.name = val
"""Set [`CarbonCaps`](@ref) `power_systems_type`."""
set_power_systems_type!(value::CarbonCaps, val) = value.power_systems_type = val
"""Set [`CarbonCaps`](@ref) `internal`."""
set_internal!(value::CarbonCaps, val) = value.internal = val
"""Set [`CarbonCaps`](@ref) `max_tons_per_mwh`."""
set_max_tons_per_mwh!(value::CarbonCaps, val) = value.max_tons_per_mwh = val
"""Set [`CarbonCaps`](@ref) `max_tons`."""
set_max_tons!(value::CarbonCaps, val) = value.max_tons = val
"""Set [`CarbonCaps`](@ref) `ext`."""
set_ext!(value::CarbonCaps, val) = value.ext = val
"""Set [`CarbonCaps`](@ref) `available`."""
set_available!(value::CarbonCaps, val) = value.available = val
"""Set [`CarbonCaps`](@ref) `eligible_regions`."""
set_eligible_regions!(value::CarbonCaps, val) = value.eligible_regions = val
