#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct ACTransportTechnology{T <: PSY.Device} <: Technology
        base_power::Float64
        capital_cost::PSY.ValueCurve
        start_region::Region
        available::Bool
        name::String
        end_region::Region
        power_systems_type::String
        angle_limit::Float64
        internal::InfrastructureSystemsInternal
        interest_rate::Float64
        ext::Dict
        resistance::Float64
        voltage::Float64
        network_id::Int64
        maximum_new_capacity::Float64
        base_year::Int
        existing_line_capacity::Float64
        wacc::Float64
        line_loss::Float64
        capital_recovery_period::Int64
    end



# Arguments
- `base_power::Float64`: Base power
- `capital_cost::PSY.ValueCurve`: Cost of adding new capacity to the inter-regional transmission line.
- `start_region::Region`: Start region for transport technology
- `available::Bool`: identifies whether the technology is available
- `name::String`: Name
- `end_region::Region`: End region for transport technology
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `angle_limit::Float64`: (default: `0.0`) Votlage angle limit (radians)
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `interest_rate::Float64`: (default: `0.07`) Interest rate for technology
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `resistance::Float64`: (default: `0.0`) Technology resistance in Ohms
- `voltage::Float64`: (default: `0.0`) Technology resistance in Ohms
- `network_id::Int64`: Numerical Index
- `maximum_new_capacity::Float64`: Maximum capacity that can be added to transmission line (MW)
- `base_year::Int`: (default: `2020`) Reference year for technology data
- `existing_line_capacity::Float64`: Existing capacity of transport technology (MW)
- `wacc::Float64`: (default: `0`) Weighted average cost of capital
- `line_loss::Float64`: Transmission loss for each transport technology (%)
- `capital_recovery_period::Int64`: (default: `30`) Capital recovery period (in years) used for determining overnight capital costs from annualized investment costs for network transmission line expansion.
"""
mutable struct ACTransportTechnology{T <: PSY.Device} <: Technology
    "Base power"
    base_power::Float64
    "Cost of adding new capacity to the inter-regional transmission line."
    capital_cost::PSY.ValueCurve
    "Start region for transport technology"
    start_region::Region
    "identifies whether the technology is available"
    available::Bool
    "Name"
    name::String
    "End region for transport technology"
    end_region::Region
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Votlage angle limit (radians)"
    angle_limit::Float64
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Interest rate for technology"
    interest_rate::Float64
    "Option for providing additional data"
    ext::Dict
    "Technology resistance in Ohms"
    resistance::Float64
    "Technology resistance in Ohms"
    voltage::Float64
    "Numerical Index"
    network_id::Int64
    "Maximum capacity that can be added to transmission line (MW)"
    maximum_new_capacity::Float64
    "Reference year for technology data"
    base_year::Int
    "Existing capacity of transport technology (MW)"
    existing_line_capacity::Float64
    "Weighted average cost of capital"
    wacc::Float64
    "Transmission loss for each transport technology (%)"
    line_loss::Float64
    "Capital recovery period (in years) used for determining overnight capital costs from annualized investment costs for network transmission line expansion."
    capital_recovery_period::Int64
end


function ACTransportTechnology{T}(; base_power, capital_cost, start_region, available, name, end_region, power_systems_type, angle_limit=0.0, internal=InfrastructureSystemsInternal(), interest_rate=0.07, ext=Dict(), resistance=0.0, voltage=0.0, network_id, maximum_new_capacity, base_year=2020, existing_line_capacity, wacc=0, line_loss, capital_recovery_period=30, ) where T <: PSY.Device
    ACTransportTechnology{T}(base_power, capital_cost, start_region, available, name, end_region, power_systems_type, angle_limit, internal, interest_rate, ext, resistance, voltage, network_id, maximum_new_capacity, base_year, existing_line_capacity, wacc, line_loss, capital_recovery_period, )
end

"""Get [`ACTransportTechnology`](@ref) `base_power`."""
get_base_power(value::ACTransportTechnology) = value.base_power
"""Get [`ACTransportTechnology`](@ref) `capital_cost`."""
get_capital_cost(value::ACTransportTechnology) = value.capital_cost
"""Get [`ACTransportTechnology`](@ref) `start_region`."""
get_start_region(value::ACTransportTechnology) = value.start_region
"""Get [`ACTransportTechnology`](@ref) `available`."""
get_available(value::ACTransportTechnology) = value.available
"""Get [`ACTransportTechnology`](@ref) `name`."""
get_name(value::ACTransportTechnology) = value.name
"""Get [`ACTransportTechnology`](@ref) `end_region`."""
get_end_region(value::ACTransportTechnology) = value.end_region
"""Get [`ACTransportTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::ACTransportTechnology) = value.power_systems_type
"""Get [`ACTransportTechnology`](@ref) `angle_limit`."""
get_angle_limit(value::ACTransportTechnology) = value.angle_limit
"""Get [`ACTransportTechnology`](@ref) `internal`."""
get_internal(value::ACTransportTechnology) = value.internal
"""Get [`ACTransportTechnology`](@ref) `interest_rate`."""
get_interest_rate(value::ACTransportTechnology) = value.interest_rate
"""Get [`ACTransportTechnology`](@ref) `ext`."""
get_ext(value::ACTransportTechnology) = value.ext
"""Get [`ACTransportTechnology`](@ref) `resistance`."""
get_resistance(value::ACTransportTechnology) = value.resistance
"""Get [`ACTransportTechnology`](@ref) `voltage`."""
get_voltage(value::ACTransportTechnology) = value.voltage
"""Get [`ACTransportTechnology`](@ref) `network_id`."""
get_network_id(value::ACTransportTechnology) = value.network_id
"""Get [`ACTransportTechnology`](@ref) `maximum_new_capacity`."""
get_maximum_new_capacity(value::ACTransportTechnology) = value.maximum_new_capacity
"""Get [`ACTransportTechnology`](@ref) `base_year`."""
get_base_year(value::ACTransportTechnology) = value.base_year
"""Get [`ACTransportTechnology`](@ref) `existing_line_capacity`."""
get_existing_line_capacity(value::ACTransportTechnology) = value.existing_line_capacity
"""Get [`ACTransportTechnology`](@ref) `wacc`."""
get_wacc(value::ACTransportTechnology) = value.wacc
"""Get [`ACTransportTechnology`](@ref) `line_loss`."""
get_line_loss(value::ACTransportTechnology) = value.line_loss
"""Get [`ACTransportTechnology`](@ref) `capital_recovery_period`."""
get_capital_recovery_period(value::ACTransportTechnology) = value.capital_recovery_period

"""Set [`ACTransportTechnology`](@ref) `base_power`."""
set_base_power!(value::ACTransportTechnology, val) = value.base_power = val
"""Set [`ACTransportTechnology`](@ref) `capital_cost`."""
set_capital_cost!(value::ACTransportTechnology, val) = value.capital_cost = val
"""Set [`ACTransportTechnology`](@ref) `start_region`."""
set_start_region!(value::ACTransportTechnology, val) = value.start_region = val
"""Set [`ACTransportTechnology`](@ref) `available`."""
set_available!(value::ACTransportTechnology, val) = value.available = val
"""Set [`ACTransportTechnology`](@ref) `name`."""
set_name!(value::ACTransportTechnology, val) = value.name = val
"""Set [`ACTransportTechnology`](@ref) `end_region`."""
set_end_region!(value::ACTransportTechnology, val) = value.end_region = val
"""Set [`ACTransportTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::ACTransportTechnology, val) = value.power_systems_type = val
"""Set [`ACTransportTechnology`](@ref) `angle_limit`."""
set_angle_limit!(value::ACTransportTechnology, val) = value.angle_limit = val
"""Set [`ACTransportTechnology`](@ref) `internal`."""
set_internal!(value::ACTransportTechnology, val) = value.internal = val
"""Set [`ACTransportTechnology`](@ref) `interest_rate`."""
set_interest_rate!(value::ACTransportTechnology, val) = value.interest_rate = val
"""Set [`ACTransportTechnology`](@ref) `ext`."""
set_ext!(value::ACTransportTechnology, val) = value.ext = val
"""Set [`ACTransportTechnology`](@ref) `resistance`."""
set_resistance!(value::ACTransportTechnology, val) = value.resistance = val
"""Set [`ACTransportTechnology`](@ref) `voltage`."""
set_voltage!(value::ACTransportTechnology, val) = value.voltage = val
"""Set [`ACTransportTechnology`](@ref) `network_id`."""
set_network_id!(value::ACTransportTechnology, val) = value.network_id = val
"""Set [`ACTransportTechnology`](@ref) `maximum_new_capacity`."""
set_maximum_new_capacity!(value::ACTransportTechnology, val) = value.maximum_new_capacity = val
"""Set [`ACTransportTechnology`](@ref) `base_year`."""
set_base_year!(value::ACTransportTechnology, val) = value.base_year = val
"""Set [`ACTransportTechnology`](@ref) `existing_line_capacity`."""
set_existing_line_capacity!(value::ACTransportTechnology, val) = value.existing_line_capacity = val
"""Set [`ACTransportTechnology`](@ref) `wacc`."""
set_wacc!(value::ACTransportTechnology, val) = value.wacc = val
"""Set [`ACTransportTechnology`](@ref) `line_loss`."""
set_line_loss!(value::ACTransportTechnology, val) = value.line_loss = val
"""Set [`ACTransportTechnology`](@ref) `capital_recovery_period`."""
set_capital_recovery_period!(value::ACTransportTechnology, val) = value.capital_recovery_period = val
