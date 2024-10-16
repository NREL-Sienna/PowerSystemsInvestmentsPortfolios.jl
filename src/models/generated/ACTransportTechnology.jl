#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct ACTransportTechnology{T <: PSY.Device} <: Technology
        capital_cost::PSY.ValueCurve
        start_region::Int64
        available::Bool
        name::String
        capital_recovery_factor::Int64
        end_region::Int64
        power_systems_type::String
        angle_limit::Float64
        internal::InfrastructureSystemsInternal
        ext::Dict
        resistance::Float64
        voltage::Float64
        network_id::Int64
        maximum_new_capacity::Float64
        existing_line_capacity::Float64
        wacc::Float64
        line_loss::Float64
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
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `resistance::Float64`: (default: `0.0`) Technology resistance in Ohms
- `voltage::Float64`: (default: `0.0`) Technology resistance in Ohms
- `network_id::Int64`: Numerical Index
- `maximum_new_capacity::Float64`: Maximum capacity that can be added to transmission line (MW)
- `existing_line_capacity::Float64`: Existing capacity of transport technology (MW)
- `wacc::Float64`: (default: `0`) Weighted average cost of capital
- `line_loss::Float64`: Transmission loss for each transport technology (%)
"""
mutable struct ACTransportTechnology{T <: PSY.Device} <: Technology
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
    "Existing capacity of transport technology (MW)"
    existing_line_capacity::Float64
    "Weighted average cost of capital"
    wacc::Float64
    "Transmission loss for each transport technology (%)"
    line_loss::Float64
end


function ACTransportTechnology{T}(; capital_cost, start_region, available, name, capital_recovery_factor=0, end_region, power_systems_type, angle_limit=0.0, internal=InfrastructureSystemsInternal(), ext=Dict(), resistance=0.0, voltage=0.0, network_id, maximum_new_capacity, existing_line_capacity, wacc=0, line_loss, ) where T <: PSY.Device
    ACTransportTechnology{T}(capital_cost, start_region, available, name, capital_recovery_factor, end_region, power_systems_type, angle_limit, internal, ext, resistance, voltage, network_id, maximum_new_capacity, existing_line_capacity, wacc, line_loss, )
end

"""Get [`ACTransportTechnology`](@ref) `capital_cost`."""
get_capital_cost(value::ACTransportTechnology) = value.capital_cost
"""Get [`ACTransportTechnology`](@ref) `start_region`."""
get_start_region(value::ACTransportTechnology) = value.start_region
"""Get [`ACTransportTechnology`](@ref) `available`."""
get_available(value::ACTransportTechnology) = value.available
"""Get [`ACTransportTechnology`](@ref) `name`."""
get_name(value::ACTransportTechnology) = value.name
"""Get [`ACTransportTechnology`](@ref) `capital_recovery_factor`."""
get_capital_recovery_factor(value::ACTransportTechnology) = value.capital_recovery_factor
"""Get [`ACTransportTechnology`](@ref) `end_region`."""
get_end_region(value::ACTransportTechnology) = value.end_region
"""Get [`ACTransportTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::ACTransportTechnology) = value.power_systems_type
"""Get [`ACTransportTechnology`](@ref) `angle_limit`."""
get_angle_limit(value::ACTransportTechnology) = value.angle_limit
"""Get [`ACTransportTechnology`](@ref) `internal`."""
get_internal(value::ACTransportTechnology) = value.internal
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
"""Get [`ACTransportTechnology`](@ref) `existing_line_capacity`."""
get_existing_line_capacity(value::ACTransportTechnology) = value.existing_line_capacity
"""Get [`ACTransportTechnology`](@ref) `wacc`."""
get_wacc(value::ACTransportTechnology) = value.wacc
"""Get [`ACTransportTechnology`](@ref) `line_loss`."""
get_line_loss(value::ACTransportTechnology) = value.line_loss

"""Set [`ACTransportTechnology`](@ref) `capital_cost`."""
set_capital_cost!(value::ACTransportTechnology, val) = value.capital_cost = val
"""Set [`ACTransportTechnology`](@ref) `start_region`."""
set_start_region!(value::ACTransportTechnology, val) = value.start_region = val
"""Set [`ACTransportTechnology`](@ref) `available`."""
set_available!(value::ACTransportTechnology, val) = value.available = val
"""Set [`ACTransportTechnology`](@ref) `name`."""
set_name!(value::ACTransportTechnology, val) = value.name = val
"""Set [`ACTransportTechnology`](@ref) `capital_recovery_factor`."""
set_capital_recovery_factor!(value::ACTransportTechnology, val) = value.capital_recovery_factor = val
"""Set [`ACTransportTechnology`](@ref) `end_region`."""
set_end_region!(value::ACTransportTechnology, val) = value.end_region = val
"""Set [`ACTransportTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::ACTransportTechnology, val) = value.power_systems_type = val
"""Set [`ACTransportTechnology`](@ref) `angle_limit`."""
set_angle_limit!(value::ACTransportTechnology, val) = value.angle_limit = val
"""Set [`ACTransportTechnology`](@ref) `internal`."""
set_internal!(value::ACTransportTechnology, val) = value.internal = val
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
"""Set [`ACTransportTechnology`](@ref) `existing_line_capacity`."""
set_existing_line_capacity!(value::ACTransportTechnology, val) = value.existing_line_capacity = val
"""Set [`ACTransportTechnology`](@ref) `wacc`."""
set_wacc!(value::ACTransportTechnology, val) = value.wacc = val
"""Set [`ACTransportTechnology`](@ref) `line_loss`."""
set_line_loss!(value::ACTransportTechnology, val) = value.line_loss = val
