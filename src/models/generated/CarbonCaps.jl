#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct CarbonCaps <: Requirements
        name::String
        internal::InfrastructureSystemsInternal
        eligible_zones::Vector{Int64}
        co_2_max_tons_mwh::Float64
        ext::Dict
        co_2_max_mtons::Float64
        slack::Float64
        available::Bool
    end



# Arguments
- `name::String`: The technology name
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `eligible_zones::Vector{Int64}`: (default: `Vector{Int64}()`) List of zones that contribute to the carbon cap constraint.
- `co_2_max_tons_mwh::Float64`: (default: `1`) Emission limit in terms of rate (tCO@/MWh)
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `co_2_max_mtons::Float64`: (default: `Vector{Int64}()`) Emission limit in absolute values, in Million of tons
- `slack::Float64`: Slack value for carbon caps
- `available::Bool`: Availability
"""
mutable struct CarbonCaps <: Requirements
    "The technology name"
    name::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "List of zones that contribute to the carbon cap constraint."
    eligible_zones::Vector{Int64}
    "Emission limit in terms of rate (tCO@/MWh)"
    co_2_max_tons_mwh::Float64
    "Option for providing additional data"
    ext::Dict
    "Emission limit in absolute values, in Million of tons"
    co_2_max_mtons::Float64
    "Slack value for carbon caps"
    slack::Float64
    "Availability"
    available::Bool
end


function CarbonCaps(; name, internal=InfrastructureSystemsInternal(), eligible_zones=Vector{Int64}(), co_2_max_tons_mwh=1, ext=Dict(), co_2_max_mtons=Vector{Int64}(), slack, available, )
    CarbonCaps(name, internal, eligible_zones, co_2_max_tons_mwh, ext, co_2_max_mtons, slack, available, )
end

"""Get [`CarbonCaps`](@ref) `name`."""
get_name(value::CarbonCaps) = value.name
"""Get [`CarbonCaps`](@ref) `internal`."""
get_internal(value::CarbonCaps) = value.internal
"""Get [`CarbonCaps`](@ref) `eligible_zones`."""
get_eligible_zones(value::CarbonCaps) = value.eligible_zones
"""Get [`CarbonCaps`](@ref) `co_2_max_tons_mwh`."""
get_co_2_max_tons_mwh(value::CarbonCaps) = value.co_2_max_tons_mwh
"""Get [`CarbonCaps`](@ref) `ext`."""
get_ext(value::CarbonCaps) = value.ext
"""Get [`CarbonCaps`](@ref) `co_2_max_mtons`."""
get_co_2_max_mtons(value::CarbonCaps) = value.co_2_max_mtons
"""Get [`CarbonCaps`](@ref) `slack`."""
get_slack(value::CarbonCaps) = value.slack
"""Get [`CarbonCaps`](@ref) `available`."""
get_available(value::CarbonCaps) = value.available

"""Set [`CarbonCaps`](@ref) `name`."""
set_name!(value::CarbonCaps, val) = value.name = val
"""Set [`CarbonCaps`](@ref) `internal`."""
set_internal!(value::CarbonCaps, val) = value.internal = val
"""Set [`CarbonCaps`](@ref) `eligible_zones`."""
set_eligible_zones!(value::CarbonCaps, val) = value.eligible_zones = val
"""Set [`CarbonCaps`](@ref) `co_2_max_tons_mwh`."""
set_co_2_max_tons_mwh!(value::CarbonCaps, val) = value.co_2_max_tons_mwh = val
"""Set [`CarbonCaps`](@ref) `ext`."""
set_ext!(value::CarbonCaps, val) = value.ext = val
"""Set [`CarbonCaps`](@ref) `co_2_max_mtons`."""
set_co_2_max_mtons!(value::CarbonCaps, val) = value.co_2_max_mtons = val
"""Set [`CarbonCaps`](@ref) `slack`."""
set_slack!(value::CarbonCaps, val) = value.slack = val
"""Set [`CarbonCaps`](@ref) `available`."""
set_available!(value::CarbonCaps, val) = value.available = val
