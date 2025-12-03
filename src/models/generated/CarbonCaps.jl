#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct CarbonCaps <: Requirement
        name::String
        max_tons_mwh::Float64
        target_year::Int64
        internal::InfrastructureSystemsInternal
        id::Int64
        max_mtons::Float64
        ext::Dict
        available::Bool
        eligible_regions::Vector{RegionTopology}
    end

Defines limits to the amount of carbon produced. Can be defined either by the total amount of carbon produced (tons CO2) or by the carbon intensity of the portfolio (tons CO2 per MWh of electricity)

# Arguments
- `name::String`: The requirement name
- `max_tons_mwh::Float64`: (default: `1.0`) Emission limit in terms of rate (tCO2/MWh)
- `target_year::Int64`: (default: `2050`) Year in which carbon cap will be applied
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
- `id::Int64`: ID for individual policy
- `max_mtons::Float64`: (default: `1e8`) Emission limit in absolute values (million tCO2)
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `available::Bool`: Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `eligible_regions::Vector{RegionTopology}`: (default: `Vector{RegionTopology}()`) List of regions that contribute to the carbon cap constraint.
"""
mutable struct CarbonCaps <: Requirement
    "The requirement name"
    name::String
    "Emission limit in terms of rate (tCO2/MWh)"
    max_tons_mwh::Float64
    "Year in which carbon cap will be applied"
    target_year::Int64
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
    "ID for individual policy"
    id::Int64
    "Emission limit in absolute values (million tCO2)"
    max_mtons::Float64
    "Optional dictionary to provide additional data"
    ext::Dict
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
    "List of regions that contribute to the carbon cap constraint."
    eligible_regions::Vector{RegionTopology}
end


function CarbonCaps(; name, max_tons_mwh=1.0, target_year=2050, internal=InfrastructureSystemsInternal(), id, max_mtons=1e8, ext=Dict(), available, eligible_regions=Vector{RegionTopology}(), )
    CarbonCaps(name, max_tons_mwh, target_year, internal, id, max_mtons, ext, available, eligible_regions, )
end

"""Get [`CarbonCaps`](@ref) `name`."""
get_name(value::CarbonCaps) = value.name
"""Get [`CarbonCaps`](@ref) `max_tons_mwh`."""
get_max_tons_mwh(value::CarbonCaps) = value.max_tons_mwh
"""Get [`CarbonCaps`](@ref) `target_year`."""
get_target_year(value::CarbonCaps) = value.target_year
"""Get [`CarbonCaps`](@ref) `internal`."""
get_internal(value::CarbonCaps) = value.internal
"""Get [`CarbonCaps`](@ref) `id`."""
get_id(value::CarbonCaps) = value.id
"""Get [`CarbonCaps`](@ref) `max_mtons`."""
get_max_mtons(value::CarbonCaps) = value.max_mtons
"""Get [`CarbonCaps`](@ref) `ext`."""
get_ext(value::CarbonCaps) = value.ext
"""Get [`CarbonCaps`](@ref) `available`."""
get_available(value::CarbonCaps) = value.available
"""Get [`CarbonCaps`](@ref) `eligible_regions`."""
get_eligible_regions(value::CarbonCaps) = value.eligible_regions

"""Set [`CarbonCaps`](@ref) `name`."""
set_name!(value::CarbonCaps, val) = value.name = val
"""Set [`CarbonCaps`](@ref) `max_tons_mwh`."""
set_max_tons_mwh!(value::CarbonCaps, val) = value.max_tons_mwh = val
"""Set [`CarbonCaps`](@ref) `target_year`."""
set_target_year!(value::CarbonCaps, val) = value.target_year = val
"""Set [`CarbonCaps`](@ref) `internal`."""
set_internal!(value::CarbonCaps, val) = value.internal = val
"""Set [`CarbonCaps`](@ref) `id`."""
set_id!(value::CarbonCaps, val) = value.id = val
"""Set [`CarbonCaps`](@ref) `max_mtons`."""
set_max_mtons!(value::CarbonCaps, val) = value.max_mtons = val
"""Set [`CarbonCaps`](@ref) `ext`."""
set_ext!(value::CarbonCaps, val) = value.ext = val
"""Set [`CarbonCaps`](@ref) `available`."""
set_available!(value::CarbonCaps, val) = value.available = val
"""Set [`CarbonCaps`](@ref) `eligible_regions`."""
set_eligible_regions!(value::CarbonCaps, val) = value.eligible_regions = val

function serialize_openapi_struct(technology::CarbonCaps, vals...)
    base_struct = APIServer.CarbonCaps(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:CarbonCaps}, vals::Dict)
    return IS.deserialize_struct(APIServer.CarbonCaps, vals)
end
