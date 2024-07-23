#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct TransportTechnology{T <: PSY.Device} <: Technology
        capital_cost::PSY.ValueCurve
        start_region::String
        available::Bool
        capital_recovery_factor::Int64
        end_region::String
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        network_lines::Int64
        ext::Dict
        resistance::Float64
        derate_cap_res::Float64
        voltage::Float64
        existing_flow_capacity::Float64
        maximum_new_capacity::Float64
        line_loss::Float64
        cap_res_excl::Int64
    end



# Arguments
- `capital_cost::PSY.ValueCurve`: Cost of adding new capacity to the inter-regional transmission line.
- `start_region::String`: Start region for transport technology
- `available::Bool`: identifies whether the technology is available
- `capital_recovery_factor::Int64`: (default: `0`) Capital recovery period (in years) used for determining overnight capital costs from annualized investment costs for network transmission line expansion.
- `end_region::String`: End region for transport technology
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `network_lines::Int64`: Numerical Index
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `resistance::Float64`: (default: `0.0`) Technology resistance in Ohms
- `derate_cap_res::Float64`: (default: `0.0`) value represents the derating of the firm transmission capacity for the capacity reserve margin constraint.
- `voltage::Float64`: (default: `0.0`) Technology resistance in Ohms
- `existing_flow_capacity::Float64`: Existing capacity of transport technology (MW)
- `maximum_new_capacity::Float64`: Maximum capacity that can be added to transmission line (MW)
- `line_loss::Float64`: Transmission loss for each transport technology (%)
- `cap_res_excl::Int64`: (default: `0`) (-1,1,0)
"""
mutable struct TransportTechnology{T <: PSY.Device} <: Technology
    "Cost of adding new capacity to the inter-regional transmission line."
    capital_cost::PSY.ValueCurve
    "Start region for transport technology"
    start_region::String
    "identifies whether the technology is available"
    available::Bool
    "Capital recovery period (in years) used for determining overnight capital costs from annualized investment costs for network transmission line expansion."
    capital_recovery_factor::Int64
    "End region for transport technology"
    end_region::String
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Numerical Index"
    network_lines::Int64
    "Option for providing additional data"
    ext::Dict
    "Technology resistance in Ohms"
    resistance::Float64
    "value represents the derating of the firm transmission capacity for the capacity reserve margin constraint."
    derate_cap_res::Float64
    "Technology resistance in Ohms"
    voltage::Float64
    "Existing capacity of transport technology (MW)"
    existing_flow_capacity::Float64
    "Maximum capacity that can be added to transmission line (MW)"
    maximum_new_capacity::Float64
    "Transmission loss for each transport technology (%)"
    line_loss::Float64
    "(-1,1,0)"
    cap_res_excl::Int64
end


function TransportTechnology{T}(; capital_cost, start_region, available, capital_recovery_factor=0, end_region, power_systems_type, internal=InfrastructureSystemsInternal(), network_lines, ext=Dict(), resistance=0.0, derate_cap_res=0.0, voltage=0.0, existing_flow_capacity, maximum_new_capacity, line_loss, cap_res_excl=0, ) where T <: PSY.Device
    TransportTechnology{T}(capital_cost, start_region, available, capital_recovery_factor, end_region, power_systems_type, internal, network_lines, ext, resistance, derate_cap_res, voltage, existing_flow_capacity, maximum_new_capacity, line_loss, cap_res_excl, )
end

"""Get [`TransportTechnology`](@ref) `capital_cost`."""
get_capital_cost(value::TransportTechnology) = value.capital_cost
"""Get [`TransportTechnology`](@ref) `start_region`."""
get_start_region(value::TransportTechnology) = value.start_region
"""Get [`TransportTechnology`](@ref) `available`."""
get_available(value::TransportTechnology) = value.available
"""Get [`TransportTechnology`](@ref) `capital_recovery_factor`."""
get_capital_recovery_factor(value::TransportTechnology) = value.capital_recovery_factor
"""Get [`TransportTechnology`](@ref) `end_region`."""
get_end_region(value::TransportTechnology) = value.end_region
"""Get [`TransportTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::TransportTechnology) = value.power_systems_type
"""Get [`TransportTechnology`](@ref) `internal`."""
get_internal(value::TransportTechnology) = value.internal
"""Get [`TransportTechnology`](@ref) `network_lines`."""
get_network_lines(value::TransportTechnology) = value.network_lines
"""Get [`TransportTechnology`](@ref) `ext`."""
get_ext(value::TransportTechnology) = value.ext
"""Get [`TransportTechnology`](@ref) `resistance`."""
get_resistance(value::TransportTechnology) = value.resistance
"""Get [`TransportTechnology`](@ref) `derate_cap_res`."""
get_derate_cap_res(value::TransportTechnology) = value.derate_cap_res
"""Get [`TransportTechnology`](@ref) `voltage`."""
get_voltage(value::TransportTechnology) = value.voltage
"""Get [`TransportTechnology`](@ref) `existing_flow_capacity`."""
get_existing_flow_capacity(value::TransportTechnology) = value.existing_flow_capacity
"""Get [`TransportTechnology`](@ref) `maximum_new_capacity`."""
get_maximum_new_capacity(value::TransportTechnology) = value.maximum_new_capacity
"""Get [`TransportTechnology`](@ref) `line_loss`."""
get_line_loss(value::TransportTechnology) = value.line_loss
"""Get [`TransportTechnology`](@ref) `cap_res_excl`."""
get_cap_res_excl(value::TransportTechnology) = value.cap_res_excl

"""Set [`TransportTechnology`](@ref) `capital_cost`."""
set_capital_cost!(value::TransportTechnology, val) = value.capital_cost = val
"""Set [`TransportTechnology`](@ref) `start_region`."""
set_start_region!(value::TransportTechnology, val) = value.start_region = val
"""Set [`TransportTechnology`](@ref) `available`."""
set_available!(value::TransportTechnology, val) = value.available = val
"""Set [`TransportTechnology`](@ref) `capital_recovery_factor`."""
set_capital_recovery_factor!(value::TransportTechnology, val) = value.capital_recovery_factor = val
"""Set [`TransportTechnology`](@ref) `end_region`."""
set_end_region!(value::TransportTechnology, val) = value.end_region = val
"""Set [`TransportTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::TransportTechnology, val) = value.power_systems_type = val
"""Set [`TransportTechnology`](@ref) `internal`."""
set_internal!(value::TransportTechnology, val) = value.internal = val
"""Set [`TransportTechnology`](@ref) `network_lines`."""
set_network_lines!(value::TransportTechnology, val) = value.network_lines = val
"""Set [`TransportTechnology`](@ref) `ext`."""
set_ext!(value::TransportTechnology, val) = value.ext = val
"""Set [`TransportTechnology`](@ref) `resistance`."""
set_resistance!(value::TransportTechnology, val) = value.resistance = val
"""Set [`TransportTechnology`](@ref) `derate_cap_res`."""
set_derate_cap_res!(value::TransportTechnology, val) = value.derate_cap_res = val
"""Set [`TransportTechnology`](@ref) `voltage`."""
set_voltage!(value::TransportTechnology, val) = value.voltage = val
"""Set [`TransportTechnology`](@ref) `existing_flow_capacity`."""
set_existing_flow_capacity!(value::TransportTechnology, val) = value.existing_flow_capacity = val
"""Set [`TransportTechnology`](@ref) `maximum_new_capacity`."""
set_maximum_new_capacity!(value::TransportTechnology, val) = value.maximum_new_capacity = val
"""Set [`TransportTechnology`](@ref) `line_loss`."""
set_line_loss!(value::TransportTechnology, val) = value.line_loss = val
"""Set [`TransportTechnology`](@ref) `cap_res_excl`."""
set_cap_res_excl!(value::TransportTechnology, val) = value.cap_res_excl = val
