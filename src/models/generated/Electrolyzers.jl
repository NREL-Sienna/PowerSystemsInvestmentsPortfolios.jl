#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct Electrolyzers{T <: PSY.StaticInjection} <: Technology
        available::Bool
        name::String
        ramp_down::Float64
        hydrogen_mwh_per_tonne::PSY.ValueCurve
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        hydrogen_price_per_tonne::Float64
        ext::Dict
        electrolyzer_min_kt::Float64
        min_power::Float64
        ramp_up::Float64
    end



# Arguments
- `available::Bool`: identifies whether the technology is available
- `name::String`: The technology name
- `ramp_down::Float64`: Maximum decrease in power output from between two periods (typically hours), reported as a fraction of nameplate capacity.
- `hydrogen_mwh_per_tonne::PSY.ValueCurve`: Electrolyzer efficiency in megawatt-hours (MWh) of electricity per metric tonne of hydrogen produced (MWh/t)
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `hydrogen_price_per_tonne::Float64`: Price (or value) of hydrogen per metric tonne (/t)
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `electrolyzer_min_kt::Float64`: Minimum annual quantity of hydrogen that must be produced by electrolyzer in kilotonnes (kt)
- `min_power::Float64`: The minimum generation level for a unit as a fraction of total capacity.
- `ramp_up::Float64`: Maximum increase in power output from between two periods (typically hours), reported as a fraction of nameplate capacity.
"""
mutable struct Electrolyzers{T <: PSY.StaticInjection} <: Technology
    "identifies whether the technology is available"
    available::Bool
    "The technology name"
    name::String
    "Maximum decrease in power output from between two periods (typically hours), reported as a fraction of nameplate capacity."
    ramp_down::Float64
    "Electrolyzer efficiency in megawatt-hours (MWh) of electricity per metric tonne of hydrogen produced (MWh/t)"
    hydrogen_mwh_per_tonne::PSY.ValueCurve
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Price (or value) of hydrogen per metric tonne (/t)"
    hydrogen_price_per_tonne::Float64
    "Option for providing additional data"
    ext::Dict
    "Minimum annual quantity of hydrogen that must be produced by electrolyzer in kilotonnes (kt)"
    electrolyzer_min_kt::Float64
    "The minimum generation level for a unit as a fraction of total capacity."
    min_power::Float64
    "Maximum increase in power output from between two periods (typically hours), reported as a fraction of nameplate capacity."
    ramp_up::Float64
end


function Electrolyzers{T}(; available, name, ramp_down, hydrogen_mwh_per_tonne, power_systems_type, internal=InfrastructureSystemsInternal(), hydrogen_price_per_tonne, ext=Dict(), electrolyzer_min_kt, min_power, ramp_up, ) where T <: PSY.StaticInjection
    Electrolyzers{T}(available, name, ramp_down, hydrogen_mwh_per_tonne, power_systems_type, internal, hydrogen_price_per_tonne, ext, electrolyzer_min_kt, min_power, ramp_up, )
end

"""Get [`Electrolyzers`](@ref) `available`."""
get_available(value::Electrolyzers) = value.available
"""Get [`Electrolyzers`](@ref) `name`."""
get_name(value::Electrolyzers) = value.name
"""Get [`Electrolyzers`](@ref) `ramp_down`."""
get_ramp_down(value::Electrolyzers) = value.ramp_down
"""Get [`Electrolyzers`](@ref) `hydrogen_mwh_per_tonne`."""
get_hydrogen_mwh_per_tonne(value::Electrolyzers) = value.hydrogen_mwh_per_tonne
"""Get [`Electrolyzers`](@ref) `power_systems_type`."""
get_power_systems_type(value::Electrolyzers) = value.power_systems_type
"""Get [`Electrolyzers`](@ref) `internal`."""
get_internal(value::Electrolyzers) = value.internal
"""Get [`Electrolyzers`](@ref) `hydrogen_price_per_tonne`."""
get_hydrogen_price_per_tonne(value::Electrolyzers) = value.hydrogen_price_per_tonne
"""Get [`Electrolyzers`](@ref) `ext`."""
get_ext(value::Electrolyzers) = value.ext
"""Get [`Electrolyzers`](@ref) `electrolyzer_min_kt`."""
get_electrolyzer_min_kt(value::Electrolyzers) = value.electrolyzer_min_kt
"""Get [`Electrolyzers`](@ref) `min_power`."""
get_min_power(value::Electrolyzers) = value.min_power
"""Get [`Electrolyzers`](@ref) `ramp_up`."""
get_ramp_up(value::Electrolyzers) = value.ramp_up

"""Set [`Electrolyzers`](@ref) `available`."""
set_available!(value::Electrolyzers, val) = value.available = val
"""Set [`Electrolyzers`](@ref) `name`."""
set_name!(value::Electrolyzers, val) = value.name = val
"""Set [`Electrolyzers`](@ref) `ramp_down`."""
set_ramp_down!(value::Electrolyzers, val) = value.ramp_down = val
"""Set [`Electrolyzers`](@ref) `hydrogen_mwh_per_tonne`."""
set_hydrogen_mwh_per_tonne!(value::Electrolyzers, val) = value.hydrogen_mwh_per_tonne = val
"""Set [`Electrolyzers`](@ref) `power_systems_type`."""
set_power_systems_type!(value::Electrolyzers, val) = value.power_systems_type = val
"""Set [`Electrolyzers`](@ref) `internal`."""
set_internal!(value::Electrolyzers, val) = value.internal = val
"""Set [`Electrolyzers`](@ref) `hydrogen_price_per_tonne`."""
set_hydrogen_price_per_tonne!(value::Electrolyzers, val) = value.hydrogen_price_per_tonne = val
"""Set [`Electrolyzers`](@ref) `ext`."""
set_ext!(value::Electrolyzers, val) = value.ext = val
"""Set [`Electrolyzers`](@ref) `electrolyzer_min_kt`."""
set_electrolyzer_min_kt!(value::Electrolyzers, val) = value.electrolyzer_min_kt = val
"""Set [`Electrolyzers`](@ref) `min_power`."""
set_min_power!(value::Electrolyzers, val) = value.min_power = val
"""Set [`Electrolyzers`](@ref) `ramp_up`."""
set_ramp_up!(value::Electrolyzers, val) = value.ramp_up = val
