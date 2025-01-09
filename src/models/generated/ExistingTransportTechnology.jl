#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct ExistingTransportTechnology{T <: PSY.Device} <: Technology
        base_power::Float64
        capital_cost::PSY.ValueCurve
        start_region::Region
        available::Bool
        name::String
        end_region::Region
        power_systems_type::String
        susceptance::Float64
        internal::InfrastructureSystemsInternal
        ext::Dict
        resistance::Float64
        voltage::Float64
        network_id::Int64
        maximum_new_capacity::Float64
        base_year::Int
        existing_line_capacity::Float64
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
- `susceptance::Float64`: (default: `0.0`) Technology susceptance
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `resistance::Float64`: (default: `0.0`) Technology resistance in Ohms
- `voltage::Float64`: (default: `0.0`) Technology voltage in Volts
- `network_id::Int64`: Numerical Index
- `maximum_new_capacity::Float64`: Maximum capacity that can be added to transmission line (MW)
- `base_year::Int`: (default: `2020`) Reference year for technology data
- `existing_line_capacity::Float64`: Existing capacity of transport technology (MW)
- `line_loss::Float64`: Transmission loss for each transport technology (%)
- `capital_recovery_period::Int64`: (default: `30`) Capital recovery period (in years) used for determining overnight capital costs from annualized investment costs for network transmission line expansion.
"""
mutable struct ExistingTransportTechnology{T <: PSY.Device} <: Technology
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
    "Technology susceptance"
    susceptance::Float64
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Technology resistance in Ohms"
    resistance::Float64
    "Technology voltage in Volts"
    voltage::Float64
    "Numerical Index"
    network_id::Int64
    "Maximum capacity that can be added to transmission line (MW)"
    maximum_new_capacity::Float64
    "Reference year for technology data"
    base_year::Int
    "Existing capacity of transport technology (MW)"
    existing_line_capacity::Float64
    "Transmission loss for each transport technology (%)"
    line_loss::Float64
    "Capital recovery period (in years) used for determining overnight capital costs from annualized investment costs for network transmission line expansion."
    capital_recovery_period::Int64
end


function ExistingTransportTechnology{T}(; base_power, capital_cost, start_region, available, name, end_region, power_systems_type, susceptance=0.0, internal=InfrastructureSystemsInternal(), ext=Dict(), resistance=0.0, voltage=0.0, network_id, maximum_new_capacity, base_year=2020, existing_line_capacity, line_loss, capital_recovery_period=30, ) where T <: PSY.Device
    ExistingTransportTechnology{T}(base_power, capital_cost, start_region, available, name, end_region, power_systems_type, susceptance, internal, ext, resistance, voltage, network_id, maximum_new_capacity, base_year, existing_line_capacity, line_loss, capital_recovery_period, )
end

"""Get [`ExistingTransportTechnology`](@ref) `base_power`."""
get_base_power(value::ExistingTransportTechnology) = value.base_power
"""Get [`ExistingTransportTechnology`](@ref) `capital_cost`."""
get_capital_cost(value::ExistingTransportTechnology) = value.capital_cost
"""Get [`ExistingTransportTechnology`](@ref) `start_region`."""
get_start_region(value::ExistingTransportTechnology) = value.start_region
"""Get [`ExistingTransportTechnology`](@ref) `available`."""
get_available(value::ExistingTransportTechnology) = value.available
"""Get [`ExistingTransportTechnology`](@ref) `name`."""
get_name(value::ExistingTransportTechnology) = value.name
"""Get [`ExistingTransportTechnology`](@ref) `end_region`."""
get_end_region(value::ExistingTransportTechnology) = value.end_region
"""Get [`ExistingTransportTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::ExistingTransportTechnology) = value.power_systems_type
"""Get [`ExistingTransportTechnology`](@ref) `susceptance`."""
get_susceptance(value::ExistingTransportTechnology) = value.susceptance
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
"""Get [`ExistingTransportTechnology`](@ref) `base_year`."""
get_base_year(value::ExistingTransportTechnology) = value.base_year
"""Get [`ExistingTransportTechnology`](@ref) `existing_line_capacity`."""
get_existing_line_capacity(value::ExistingTransportTechnology) = value.existing_line_capacity
"""Get [`ExistingTransportTechnology`](@ref) `line_loss`."""
get_line_loss(value::ExistingTransportTechnology) = value.line_loss
"""Get [`ExistingTransportTechnology`](@ref) `capital_recovery_period`."""
get_capital_recovery_period(value::ExistingTransportTechnology) = value.capital_recovery_period

"""Set [`ExistingTransportTechnology`](@ref) `base_power`."""
set_base_power!(value::ExistingTransportTechnology, val) = value.base_power = val
"""Set [`ExistingTransportTechnology`](@ref) `capital_cost`."""
set_capital_cost!(value::ExistingTransportTechnology, val) = value.capital_cost = val
"""Set [`ExistingTransportTechnology`](@ref) `start_region`."""
set_start_region!(value::ExistingTransportTechnology, val) = value.start_region = val
"""Set [`ExistingTransportTechnology`](@ref) `available`."""
set_available!(value::ExistingTransportTechnology, val) = value.available = val
"""Set [`ExistingTransportTechnology`](@ref) `name`."""
set_name!(value::ExistingTransportTechnology, val) = value.name = val
"""Set [`ExistingTransportTechnology`](@ref) `end_region`."""
set_end_region!(value::ExistingTransportTechnology, val) = value.end_region = val
"""Set [`ExistingTransportTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::ExistingTransportTechnology, val) = value.power_systems_type = val
"""Set [`ExistingTransportTechnology`](@ref) `susceptance`."""
set_susceptance!(value::ExistingTransportTechnology, val) = value.susceptance = val
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
"""Set [`ExistingTransportTechnology`](@ref) `base_year`."""
set_base_year!(value::ExistingTransportTechnology, val) = value.base_year = val
"""Set [`ExistingTransportTechnology`](@ref) `existing_line_capacity`."""
set_existing_line_capacity!(value::ExistingTransportTechnology, val) = value.existing_line_capacity = val
"""Set [`ExistingTransportTechnology`](@ref) `line_loss`."""
set_line_loss!(value::ExistingTransportTechnology, val) = value.line_loss = val
"""Set [`ExistingTransportTechnology`](@ref) `capital_recovery_period`."""
set_capital_recovery_period!(value::ExistingTransportTechnology, val) = value.capital_recovery_period = val
