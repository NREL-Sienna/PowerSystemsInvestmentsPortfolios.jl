#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct HVDCTransportTechnology{T <: PSY.Device} <: Technology
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
mutable struct HVDCTransportTechnology{T <: PSY.Device} <: Technology
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


function HVDCTransportTechnology{T}(; capital_cost, start_region, available, name, capital_recovery_factor=0, end_region, power_systems_type, angle_limit=0.0, internal=InfrastructureSystemsInternal(), ext=Dict(), resistance=0.0, voltage=0.0, network_id, maximum_new_capacity, existing_line_capacity, wacc=0, line_loss, ) where T <: PSY.Device
    HVDCTransportTechnology{T}(capital_cost, start_region, available, name, capital_recovery_factor, end_region, power_systems_type, angle_limit, internal, ext, resistance, voltage, network_id, maximum_new_capacity, existing_line_capacity, wacc, line_loss, )
end

"""Get [`HVDCTransportTechnology`](@ref) `capital_cost`."""
get_capital_cost(value::HVDCTransportTechnology) = value.capital_cost
"""Get [`HVDCTransportTechnology`](@ref) `start_region`."""
get_start_region(value::HVDCTransportTechnology) = value.start_region
"""Get [`HVDCTransportTechnology`](@ref) `available`."""
get_available(value::HVDCTransportTechnology) = value.available
"""Get [`HVDCTransportTechnology`](@ref) `name`."""
get_name(value::HVDCTransportTechnology) = value.name
"""Get [`HVDCTransportTechnology`](@ref) `capital_recovery_factor`."""
get_capital_recovery_factor(value::HVDCTransportTechnology) = value.capital_recovery_factor
"""Get [`HVDCTransportTechnology`](@ref) `end_region`."""
get_end_region(value::HVDCTransportTechnology) = value.end_region
"""Get [`HVDCTransportTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::HVDCTransportTechnology) = value.power_systems_type
"""Get [`HVDCTransportTechnology`](@ref) `angle_limit`."""
get_angle_limit(value::HVDCTransportTechnology) = value.angle_limit
"""Get [`HVDCTransportTechnology`](@ref) `internal`."""
get_internal(value::HVDCTransportTechnology) = value.internal
"""Get [`HVDCTransportTechnology`](@ref) `ext`."""
get_ext(value::HVDCTransportTechnology) = value.ext
"""Get [`HVDCTransportTechnology`](@ref) `resistance`."""
get_resistance(value::HVDCTransportTechnology) = value.resistance
"""Get [`HVDCTransportTechnology`](@ref) `voltage`."""
get_voltage(value::HVDCTransportTechnology) = value.voltage
"""Get [`HVDCTransportTechnology`](@ref) `network_id`."""
get_network_id(value::HVDCTransportTechnology) = value.network_id
"""Get [`HVDCTransportTechnology`](@ref) `maximum_new_capacity`."""
get_maximum_new_capacity(value::HVDCTransportTechnology) = value.maximum_new_capacity
"""Get [`HVDCTransportTechnology`](@ref) `existing_line_capacity`."""
get_existing_line_capacity(value::HVDCTransportTechnology) = value.existing_line_capacity
"""Get [`HVDCTransportTechnology`](@ref) `wacc`."""
get_wacc(value::HVDCTransportTechnology) = value.wacc
"""Get [`HVDCTransportTechnology`](@ref) `line_loss`."""
get_line_loss(value::HVDCTransportTechnology) = value.line_loss

"""Set [`HVDCTransportTechnology`](@ref) `capital_cost`."""
set_capital_cost!(value::HVDCTransportTechnology, val) = value.capital_cost = val
"""Set [`HVDCTransportTechnology`](@ref) `start_region`."""
set_start_region!(value::HVDCTransportTechnology, val) = value.start_region = val
"""Set [`HVDCTransportTechnology`](@ref) `available`."""
set_available!(value::HVDCTransportTechnology, val) = value.available = val
"""Set [`HVDCTransportTechnology`](@ref) `name`."""
set_name!(value::HVDCTransportTechnology, val) = value.name = val
"""Set [`HVDCTransportTechnology`](@ref) `capital_recovery_factor`."""
set_capital_recovery_factor!(value::HVDCTransportTechnology, val) = value.capital_recovery_factor = val
"""Set [`HVDCTransportTechnology`](@ref) `end_region`."""
set_end_region!(value::HVDCTransportTechnology, val) = value.end_region = val
"""Set [`HVDCTransportTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::HVDCTransportTechnology, val) = value.power_systems_type = val
"""Set [`HVDCTransportTechnology`](@ref) `angle_limit`."""
set_angle_limit!(value::HVDCTransportTechnology, val) = value.angle_limit = val
"""Set [`HVDCTransportTechnology`](@ref) `internal`."""
set_internal!(value::HVDCTransportTechnology, val) = value.internal = val
"""Set [`HVDCTransportTechnology`](@ref) `ext`."""
set_ext!(value::HVDCTransportTechnology, val) = value.ext = val
"""Set [`HVDCTransportTechnology`](@ref) `resistance`."""
set_resistance!(value::HVDCTransportTechnology, val) = value.resistance = val
"""Set [`HVDCTransportTechnology`](@ref) `voltage`."""
set_voltage!(value::HVDCTransportTechnology, val) = value.voltage = val
"""Set [`HVDCTransportTechnology`](@ref) `network_id`."""
set_network_id!(value::HVDCTransportTechnology, val) = value.network_id = val
"""Set [`HVDCTransportTechnology`](@ref) `maximum_new_capacity`."""
set_maximum_new_capacity!(value::HVDCTransportTechnology, val) = value.maximum_new_capacity = val
"""Set [`HVDCTransportTechnology`](@ref) `existing_line_capacity`."""
set_existing_line_capacity!(value::HVDCTransportTechnology, val) = value.existing_line_capacity = val
"""Set [`HVDCTransportTechnology`](@ref) `wacc`."""
set_wacc!(value::HVDCTransportTechnology, val) = value.wacc = val
"""Set [`HVDCTransportTechnology`](@ref) `line_loss`."""
set_line_loss!(value::HVDCTransportTechnology, val) = value.line_loss = val
