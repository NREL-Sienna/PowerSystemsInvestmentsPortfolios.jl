#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct CarbonCaps <: Requirement
        name::String
        available::Bool
        id::Int64
        max_tons_mwh::Float64
        target_year::Int64
        max_mtons::Float64
        ext::Dict
        internal::InfrastructureSystemsInternal
    end

Defines limits to the amount of carbon produced. Can be defined either by the total amount of carbon produced (tons CO2) or by the carbon intensity of the portfolio (tons CO2 per MWh of electricity)

# Arguments
- `name::String`: The requirement name
- `available::Bool`: Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `id::Int64`: ID for individual policy
- `max_tons_mwh::Float64`: (default: `1e-6`) Emission limit in terms of rate. Units: Mt/MWh.
- `target_year::Int64`: (default: `2050`) Year in which carbon cap will be applied
- `max_mtons::Float64`: (default: `1e8`) Emission limit in absolute values (million tonnes). Units: Mt.
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
"""
mutable struct CarbonCaps <: Requirement
    "The requirement name"
    name::String
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
    "ID for individual policy"
    id::Int64
    "Emission limit in terms of rate. Units: Mt/MWh."
    max_tons_mwh::Float64
    "Year in which carbon cap will be applied"
    target_year::Int64
    "Emission limit in absolute values (million tonnes). Units: Mt."
    max_mtons::Float64
    "Optional dictionary to provide additional data"
    ext::Dict
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
end


function CarbonCaps(; name, available, id, max_tons_mwh=1e-6, target_year=2050, max_mtons=1e8, ext=Dict(), internal=InfrastructureSystemsInternal(), )
    CarbonCaps(name, available, id, max_tons_mwh, target_year, max_mtons, ext, internal, )
end

"""Get [`CarbonCaps`](@ref) `name`."""
get_name(value::CarbonCaps) = value.name
"""Get [`CarbonCaps`](@ref) `available`."""
get_available(value::CarbonCaps) = value.available
"""Get [`CarbonCaps`](@ref) `id`."""
get_id(value::CarbonCaps) = value.id
"""Get [`CarbonCaps`](@ref) `max_tons_mwh` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`get_max_tons_mwh_unitful`](@ref)."""
get_max_tons_mwh(value::CarbonCaps, units) = InfrastructureSystems._strip_units(get_value(value, Val(:max_tons_mwh), Val(:mt_per_mwh), units))
"""Get [`CarbonCaps`](@ref) `max_tons_mwh` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`get_max_tons_mwh`](@ref)."""
get_max_tons_mwh_unitful(value::CarbonCaps, units) = get_value(value, Val(:max_tons_mwh), Val(:mt_per_mwh), units)
InfrastructureSystems.display_units_arg(::typeof(get_max_tons_mwh), ::Type{CarbonCaps}) = InfrastructureSystems.NU
InfrastructureSystems.display_units_arg(::typeof(get_max_tons_mwh_unitful), ::Type{CarbonCaps}) = InfrastructureSystems.NU
"""Get [`CarbonCaps`](@ref) `target_year`."""
get_target_year(value::CarbonCaps) = value.target_year
"""Get [`CarbonCaps`](@ref) `max_mtons` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`get_max_mtons_unitful`](@ref)."""
get_max_mtons(value::CarbonCaps, units) = InfrastructureSystems._strip_units(get_value(value, Val(:max_mtons), Val(:mt), units))
"""Get [`CarbonCaps`](@ref) `max_mtons` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`get_max_mtons`](@ref)."""
get_max_mtons_unitful(value::CarbonCaps, units) = get_value(value, Val(:max_mtons), Val(:mt), units)
InfrastructureSystems.display_units_arg(::typeof(get_max_mtons), ::Type{CarbonCaps}) = InfrastructureSystems.NU
InfrastructureSystems.display_units_arg(::typeof(get_max_mtons_unitful), ::Type{CarbonCaps}) = InfrastructureSystems.NU
"""Get [`CarbonCaps`](@ref) `ext`."""
get_ext(value::CarbonCaps) = value.ext
"""Get [`CarbonCaps`](@ref) `internal`."""
get_internal(value::CarbonCaps) = value.internal

"""Set [`CarbonCaps`](@ref) `name`."""
set_name!(value::CarbonCaps, val) = value.name = val
"""Set [`CarbonCaps`](@ref) `available`."""
set_available!(value::CarbonCaps, val) = value.available = val
"""Set [`CarbonCaps`](@ref) `id`."""
set_id!(value::CarbonCaps, val) = value.id = val
"""Set [`CarbonCaps`](@ref) `max_tons_mwh`."""
set_max_tons_mwh!(value::CarbonCaps, val, unit) = value.max_tons_mwh = set_value(value, Val(:max_tons_mwh), val, unit, Val(:mt_per_mwh))
"""Set [`CarbonCaps`](@ref) `target_year`."""
set_target_year!(value::CarbonCaps, val) = value.target_year = val
"""Set [`CarbonCaps`](@ref) `max_mtons`."""
set_max_mtons!(value::CarbonCaps, val, unit) = value.max_mtons = set_value(value, Val(:max_mtons), val, unit, Val(:mt))
"""Set [`CarbonCaps`](@ref) `ext`."""
set_ext!(value::CarbonCaps, val) = value.ext = val
"""Set [`CarbonCaps`](@ref) `internal`."""
set_internal!(value::CarbonCaps, val) = value.internal = val




function from_openapi(::Type{ CarbonCaps }, po, refs::OpenAPIRefs)
    return CarbonCaps(;
        name = po.name,
        available = po.available,
        id = po.id,
        max_tons_mwh = po.max_tons_mwh,
        target_year = po.target_year,
        max_mtons = po.max_mtons,
    )
end

function to_openapi(value::CarbonCaps, refs::OpenAPIRefs)
    return PI.CarbonCaps(;
        name = get_name(value),
        available = get_available(value),
        id = get_id(value),
        max_tons_mwh = get_max_tons_mwh(value, IS.NU),
        target_year = get_target_year(value),
        max_mtons = get_max_mtons(value, IS.NU),
    )
end
