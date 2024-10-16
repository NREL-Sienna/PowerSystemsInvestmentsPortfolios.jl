#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct ExistingTransportTechnology{T <: PSY.Device} <: Technology
        capital_cost::PSY.ValueCurve
        start_region::Region
        available::Bool
        name::String
        capital_recovery_factor::Int64
        end_region::Region
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
- `start_region::Region`: Start region for transport technology
- `available::Bool`: identifies whether the technology is available
- `name::String`: Name
- `capital_recovery_factor::Int64`: (default: `0`) Capital recovery period (in years) used for determining overnight capital costs from annualized investment costs for network transmission line expansion.
- `end_region::Region`: End region for transport technology
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
mutable struct ExistingTransportTechnology{T <: PSY.Device} <: Technology
    "Cost of adding new capacity to the inter-regional transmission line."
    capital_cost::PSY.ValueCurve
    "Start region for transport technology"
    start_region::Region
    "identifies whether the technology is available"
    available::Bool
    "Name"
    name::String
    "Capital recovery period (in years) used for determining overnight capital costs from annualized investment costs for network transmission line expansion."
    capital_recovery_factor::Int64
    "End region for transport technology"
    end_region::Region
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


function ExistingTransportTechnology{T}(; capital_cost, start_region, available, name, capital_recovery_factor=0, end_region, power_systems_type, angle_limit=0.0, internal=InfrastructureSystemsInternal(), ext=Dict(), resistance=0.0, voltage=0.0, network_id, maximum_new_capacity, existing_line_capacity, wacc=0, line_loss, ) where T <: PSY.Device
    ExistingTransportTechnology{T}(capital_cost, start_region, available, name, capital_recovery_factor, end_region, power_systems_type, angle_limit, internal, ext, resistance, voltage, network_id, maximum_new_capacity, existing_line_capacity, wacc, line_loss, )
end

"""Get [`ExistingTransportTechnology`](@ref) `capital_cost`."""
get_capital_cost(value::ExistingTransportTechnology) = value.capital_cost
"""Get [`ExistingTransportTechnology`](@ref) `start_region`."""
get_start_region(value::ExistingTransportTechnology) = value.start_region
"""Get [`ExistingTransportTechnology`](@ref) `available`."""
get_available(value::ExistingTransportTechnology) = value.available
"""Get [`ExistingTransportTechnology`](@ref) `name`."""
get_name(value::ExistingTransportTechnology) = value.name
"""Get [`ExistingTransportTechnology`](@ref) `capital_recovery_factor`."""
get_capital_recovery_factor(value::ExistingTransportTechnology) = value.capital_recovery_factor
"""Get [`ExistingTransportTechnology`](@ref) `end_region`."""
get_end_region(value::ExistingTransportTechnology) = value.end_region
"""Get [`ExistingTransportTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::ExistingTransportTechnology) = value.power_systems_type
"""Get [`ExistingTransportTechnology`](@ref) `angle_limit`."""
get_angle_limit(value::ExistingTransportTechnology) = value.angle_limit
"""Get [`ExistingTransportTechnology`](@ref) `internal`."""
get_internal(value::ExistingTransportTechnology) = value.internal
"""Get [`ExistingTransportTechnology`](@ref) `ext`."""
get_ext(value::ExistingTransportTechnology) = value.ext
"""Get [`ExistingTransportTechnology`](@ref) `resistance`."""
get_resistance(value::ExistingTransportTechnology) = value.resistance
"""Get [`ExistingTransportTechnology`](@ref) `voltage`."""
get_voltage(value::ExistingTransportTechnology) = value.voltage
"""Get [`ExistingTransportTechnology`](@ref) `network_id`."""
get_network_id(value::ExistingTransportTechnology) = value.network_id
"""Get [`ExistingTransportTechnology`](@ref) `maximum_new_capacity`."""
get_maximum_new_capacity(value::ExistingTransportTechnology) = value.maximum_new_capacity
"""Get [`ExistingTransportTechnology`](@ref) `existing_line_capacity`."""
get_existing_line_capacity(value::ExistingTransportTechnology) = value.existing_line_capacity
"""Get [`ExistingTransportTechnology`](@ref) `wacc`."""
get_wacc(value::ExistingTransportTechnology) = value.wacc
"""Get [`ExistingTransportTechnology`](@ref) `line_loss`."""
get_line_loss(value::ExistingTransportTechnology) = value.line_loss

"""Set [`ExistingTransportTechnology`](@ref) `capital_cost`."""
set_capital_cost!(value::ExistingTransportTechnology, val) = value.capital_cost = val
"""Set [`ExistingTransportTechnology`](@ref) `start_region`."""
set_start_region!(value::ExistingTransportTechnology, val) = value.start_region = val
"""Set [`ExistingTransportTechnology`](@ref) `available`."""
set_available!(value::ExistingTransportTechnology, val) = value.available = val
"""Set [`ExistingTransportTechnology`](@ref) `name`."""
set_name!(value::ExistingTransportTechnology, val) = value.name = val
"""Set [`ExistingTransportTechnology`](@ref) `capital_recovery_factor`."""
set_capital_recovery_factor!(value::ExistingTransportTechnology, val) = value.capital_recovery_factor = val
"""Set [`ExistingTransportTechnology`](@ref) `end_region`."""
set_end_region!(value::ExistingTransportTechnology, val) = value.end_region = val
"""Set [`ExistingTransportTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::ExistingTransportTechnology, val) = value.power_systems_type = val
"""Set [`ExistingTransportTechnology`](@ref) `angle_limit`."""
set_angle_limit!(value::ExistingTransportTechnology, val) = value.angle_limit = val
"""Set [`ExistingTransportTechnology`](@ref) `internal`."""
set_internal!(value::ExistingTransportTechnology, val) = value.internal = val
"""Set [`ExistingTransportTechnology`](@ref) `ext`."""
set_ext!(value::ExistingTransportTechnology, val) = value.ext = val
"""Set [`ExistingTransportTechnology`](@ref) `resistance`."""
set_resistance!(value::ExistingTransportTechnology, val) = value.resistance = val
"""Set [`ExistingTransportTechnology`](@ref) `voltage`."""
set_voltage!(value::ExistingTransportTechnology, val) = value.voltage = val
"""Set [`ExistingTransportTechnology`](@ref) `network_id`."""
set_network_id!(value::ExistingTransportTechnology, val) = value.network_id = val
"""Set [`ExistingTransportTechnology`](@ref) `maximum_new_capacity`."""
set_maximum_new_capacity!(value::ExistingTransportTechnology, val) = value.maximum_new_capacity = val
"""Set [`ExistingTransportTechnology`](@ref) `existing_line_capacity`."""
set_existing_line_capacity!(value::ExistingTransportTechnology, val) = value.existing_line_capacity = val
"""Set [`ExistingTransportTechnology`](@ref) `wacc`."""
set_wacc!(value::ExistingTransportTechnology, val) = value.wacc = val
"""Set [`ExistingTransportTechnology`](@ref) `line_loss`."""
set_line_loss!(value::ExistingTransportTechnology, val) = value.line_loss = val
