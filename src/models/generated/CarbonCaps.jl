#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct CarbonCaps <: Requirement
        name::String
        power_systems_type::String
        pricecap::Float64
        eligible_zones::Vector{Region}
        internal::InfrastructureSystemsInternal
        co_2_max_tons_mwh::Float64
        ext::Dict
        co_2_max_mtons::Float64
        available::Bool
    end



# Arguments
- `name::String`: The technology name
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `pricecap::Float64`: (default: `1e8`) pricecap value for carbon caps
- `eligible_zones::Vector{Region}`: (default: `Vector{Region}()`) List of regions that contribute to the carbon cap constraint.
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `co_2_max_tons_mwh::Float64`: (default: `1`) Emission limit in terms of rate (tCO@/MWh)
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `co_2_max_mtons::Float64`: (default: `Vector{Int64}()`) Emission limit in absolute values, in Million of tons
- `available::Bool`: Availability
"""
mutable struct CarbonCaps <: Requirement
    "The technology name"
    name::String
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "pricecap value for carbon caps"
    pricecap::Float64
    "List of regions that contribute to the carbon cap constraint."
    eligible_zones::Vector{Region}
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Emission limit in terms of rate (tCO@/MWh)"
    co_2_max_tons_mwh::Float64
    "Option for providing additional data"
    ext::Dict
    "Emission limit in absolute values, in Million of tons"
    co_2_max_mtons::Float64
    "Availability"
    available::Bool
end


function CarbonCaps(; name, power_systems_type, pricecap=1e8, eligible_zones=Vector{Region}(), internal=InfrastructureSystemsInternal(), co_2_max_tons_mwh=1, ext=Dict(), co_2_max_mtons=Vector{Int64}(), available, )
    CarbonCaps(name, power_systems_type, pricecap, eligible_zones, internal, co_2_max_tons_mwh, ext, co_2_max_mtons, available, )
end

"""Get [`CarbonCaps`](@ref) `name`."""
get_name(value::CarbonCaps) = value.name
"""Get [`CarbonCaps`](@ref) `power_systems_type`."""
get_power_systems_type(value::CarbonCaps) = value.power_systems_type
"""Get [`CarbonCaps`](@ref) `pricecap`."""
get_pricecap(value::CarbonCaps) = value.pricecap
"""Get [`CarbonCaps`](@ref) `eligible_zones`."""
get_eligible_zones(value::CarbonCaps) = value.eligible_zones
"""Get [`CarbonCaps`](@ref) `internal`."""
get_internal(value::CarbonCaps) = value.internal
"""Get [`CarbonCaps`](@ref) `co_2_max_tons_mwh`."""
get_co_2_max_tons_mwh(value::CarbonCaps) = value.co_2_max_tons_mwh
"""Get [`CarbonCaps`](@ref) `ext`."""
get_ext(value::CarbonCaps) = value.ext
"""Get [`CarbonCaps`](@ref) `co_2_max_mtons`."""
get_co_2_max_mtons(value::CarbonCaps) = value.co_2_max_mtons
"""Get [`CarbonCaps`](@ref) `available`."""
get_available(value::CarbonCaps) = value.available

"""Set [`CarbonCaps`](@ref) `name`."""
set_name!(value::CarbonCaps, val) = value.name = val
"""Set [`CarbonCaps`](@ref) `power_systems_type`."""
set_power_systems_type!(value::CarbonCaps, val) = value.power_systems_type = val
"""Set [`CarbonCaps`](@ref) `pricecap`."""
set_pricecap!(value::CarbonCaps, val) = value.pricecap = val
"""Set [`CarbonCaps`](@ref) `eligible_zones`."""
set_eligible_zones!(value::CarbonCaps, val) = value.eligible_zones = val
"""Set [`CarbonCaps`](@ref) `internal`."""
set_internal!(value::CarbonCaps, val) = value.internal = val
"""Set [`CarbonCaps`](@ref) `co_2_max_tons_mwh`."""
set_co_2_max_tons_mwh!(value::CarbonCaps, val) = value.co_2_max_tons_mwh = val
"""Set [`CarbonCaps`](@ref) `ext`."""
set_ext!(value::CarbonCaps, val) = value.ext = val
"""Set [`CarbonCaps`](@ref) `co_2_max_mtons`."""
set_co_2_max_mtons!(value::CarbonCaps, val) = value.co_2_max_mtons = val
"""Set [`CarbonCaps`](@ref) `available`."""
set_available!(value::CarbonCaps, val) = value.available = val

function serialize_openapi_struct(technology::CarbonCaps, vals...)
    base_struct = APIServer.CarbonCaps(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:CarbonCaps}, vals::Dict)
    return IS.deserialize_struct(APIServer.CarbonCaps, vals)
end
