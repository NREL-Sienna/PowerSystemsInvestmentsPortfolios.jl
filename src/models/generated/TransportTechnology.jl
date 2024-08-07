#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct TransportTechnology{T <: PSY.Device} <: Technology
        capital_cost::PSY.ValueCurve
        start_region::Int64
        available::Bool
        name::String
        capital_recovery_factor::Int64
        end_region::Int64
        power_systems_type::String
        angle_limit::Float64
        internal::InfrastructureSystemsInternal
        network_lines::Int64
        ext::Dict
        resistance::Float64
        voltage::Float64
        maximum_new_capacity::Float64
        existing_line_capacity::Float64
        wacc::Float64
        line_loss::Float64
        maximum_flow::Float64
    end



# Arguments
- `capital_cost::PSY.ValueCurve`: Cost of adding new capacity to the inter-regional transmission line.
- `start_region::Int64`: Start region for transport technology
- `available::Bool`: identifies whether the technology is available
- `name::String`: Name
- `capital_recovery_factor::Int64`: (default: `0`) Capital recovery period (in years) used for determining overnight capital costs from annualized investment costs for network transmission line expansion.
- `end_region::Int64`: End region for transport technology
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `angle_limit::Float64`: (default: `0.0`) Votlage angle limit (radians)
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `network_lines::Int64`: Numerical Index
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `resistance::Float64`: (default: `0.0`) Technology resistance in Ohms
- `voltage::Float64`: (default: `0.0`) Technology resistance in Ohms
- `maximum_new_capacity::Float64`: Maximum capacity that can be added to transmission line (MW)
- `existing_line_capacity::Float64`: Existing capacity of transport technology (MW)
- `wacc::Float64`: (default: `0`) Weighted average cost of capital
- `line_loss::Float64`: Transmission loss for each transport technology (%)
- `maximum_flow::Float64`: Maximum line flow (MW)
"""
mutable struct TransportTechnology{T <: PSY.Device} <: Technology
    "Cost of adding new capacity to the inter-regional transmission line."
    capital_cost::PSY.ValueCurve
    "Start region for transport technology"
    start_region::Int64
    "identifies whether the technology is available"
    available::Bool
    "Name"
    name::String
    "Capital recovery period (in years) used for determining overnight capital costs from annualized investment costs for network transmission line expansion."
    capital_recovery_factor::Int64
    "End region for transport technology"
    end_region::Int64
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Votlage angle limit (radians)"
    angle_limit::Float64
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Numerical Index"
    network_lines::Int64
    "Option for providing additional data"
    ext::Dict
    "Technology resistance in Ohms"
    resistance::Float64
    "Technology resistance in Ohms"
    voltage::Float64
    "Maximum capacity that can be added to transmission line (MW)"
    maximum_new_capacity::Float64
    "Existing capacity of transport technology (MW)"
    existing_line_capacity::Float64
    "Weighted average cost of capital"
    wacc::Float64
    "Transmission loss for each transport technology (%)"
    line_loss::Float64
    "Maximum line flow (MW)"
    maximum_flow::Float64
end


function TransportTechnology{T}(; capital_cost, start_region, available, name, capital_recovery_factor=0, end_region, power_systems_type, angle_limit=0.0, internal=InfrastructureSystemsInternal(), network_lines, ext=Dict(), resistance=0.0, voltage=0.0, maximum_new_capacity, existing_line_capacity, wacc=0, line_loss, maximum_flow, ) where T <: PSY.Device
    TransportTechnology{T}(capital_cost, start_region, available, name, capital_recovery_factor, end_region, power_systems_type, angle_limit, internal, network_lines, ext, resistance, voltage, maximum_new_capacity, existing_line_capacity, wacc, line_loss, maximum_flow, )
end

"""Get [`TransportTechnology`](@ref) `capital_cost`."""
get_capital_cost(value::TransportTechnology) = value.capital_cost
"""Get [`TransportTechnology`](@ref) `start_region`."""
get_start_region(value::TransportTechnology) = value.start_region
"""Get [`TransportTechnology`](@ref) `available`."""
get_available(value::TransportTechnology) = value.available
"""Get [`TransportTechnology`](@ref) `name`."""
get_name(value::TransportTechnology) = value.name
"""Get [`TransportTechnology`](@ref) `capital_recovery_factor`."""
get_capital_recovery_factor(value::TransportTechnology) = value.capital_recovery_factor
"""Get [`TransportTechnology`](@ref) `end_region`."""
get_end_region(value::TransportTechnology) = value.end_region
"""Get [`TransportTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::TransportTechnology) = value.power_systems_type
"""Get [`TransportTechnology`](@ref) `angle_limit`."""
get_angle_limit(value::TransportTechnology) = value.angle_limit
"""Get [`TransportTechnology`](@ref) `internal`."""
get_internal(value::TransportTechnology) = value.internal
"""Get [`TransportTechnology`](@ref) `network_lines`."""
get_network_lines(value::TransportTechnology) = value.network_lines
"""Get [`TransportTechnology`](@ref) `ext`."""
get_ext(value::TransportTechnology) = value.ext
"""Get [`TransportTechnology`](@ref) `resistance`."""
get_resistance(value::TransportTechnology) = value.resistance
"""Get [`TransportTechnology`](@ref) `voltage`."""
get_voltage(value::TransportTechnology) = value.voltage
"""Get [`TransportTechnology`](@ref) `maximum_new_capacity`."""
get_maximum_new_capacity(value::TransportTechnology) = value.maximum_new_capacity
"""Get [`TransportTechnology`](@ref) `existing_line_capacity`."""
get_existing_line_capacity(value::TransportTechnology) = value.existing_line_capacity
"""Get [`TransportTechnology`](@ref) `wacc`."""
get_wacc(value::TransportTechnology) = value.wacc
"""Get [`TransportTechnology`](@ref) `line_loss`."""
get_line_loss(value::TransportTechnology) = value.line_loss
"""Get [`TransportTechnology`](@ref) `maximum_flow`."""
get_maximum_flow(value::TransportTechnology) = value.maximum_flow

"""Set [`TransportTechnology`](@ref) `capital_cost`."""
set_capital_cost!(value::TransportTechnology, val) = value.capital_cost = val
"""Set [`TransportTechnology`](@ref) `start_region`."""
set_start_region!(value::TransportTechnology, val) = value.start_region = val
"""Set [`TransportTechnology`](@ref) `available`."""
set_available!(value::TransportTechnology, val) = value.available = val
"""Set [`TransportTechnology`](@ref) `name`."""
set_name!(value::TransportTechnology, val) = value.name = val
"""Set [`TransportTechnology`](@ref) `capital_recovery_factor`."""
set_capital_recovery_factor!(value::TransportTechnology, val) = value.capital_recovery_factor = val
"""Set [`TransportTechnology`](@ref) `end_region`."""
set_end_region!(value::TransportTechnology, val) = value.end_region = val
"""Set [`TransportTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::TransportTechnology, val) = value.power_systems_type = val
"""Set [`TransportTechnology`](@ref) `angle_limit`."""
set_angle_limit!(value::TransportTechnology, val) = value.angle_limit = val
"""Set [`TransportTechnology`](@ref) `internal`."""
set_internal!(value::TransportTechnology, val) = value.internal = val
"""Set [`TransportTechnology`](@ref) `network_lines`."""
set_network_lines!(value::TransportTechnology, val) = value.network_lines = val
"""Set [`TransportTechnology`](@ref) `ext`."""
set_ext!(value::TransportTechnology, val) = value.ext = val
"""Set [`TransportTechnology`](@ref) `resistance`."""
set_resistance!(value::TransportTechnology, val) = value.resistance = val
"""Set [`TransportTechnology`](@ref) `voltage`."""
set_voltage!(value::TransportTechnology, val) = value.voltage = val
"""Set [`TransportTechnology`](@ref) `maximum_new_capacity`."""
set_maximum_new_capacity!(value::TransportTechnology, val) = value.maximum_new_capacity = val
"""Set [`TransportTechnology`](@ref) `existing_line_capacity`."""
set_existing_line_capacity!(value::TransportTechnology, val) = value.existing_line_capacity = val
"""Set [`TransportTechnology`](@ref) `wacc`."""
set_wacc!(value::TransportTechnology, val) = value.wacc = val
"""Set [`TransportTechnology`](@ref) `line_loss`."""
set_line_loss!(value::TransportTechnology, val) = value.line_loss = val
"""Set [`TransportTechnology`](@ref) `maximum_flow`."""
set_maximum_flow!(value::TransportTechnology, val) = value.maximum_flow = val
