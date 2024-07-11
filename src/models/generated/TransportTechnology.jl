#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct TransportTechnology{T <: PSY.Device} <: Technology
        start_region::String
        available::Bool
        name::String
        end_region::String
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        ext::Dict
        resistance::Float64
        voltage::Float64
        existing_flow_capacity::Float64
        maximum_new_capacity::Float64
        line_loss::Float64
    end



# Arguments
- `start_region::String`: Start region for transport technology
- `available::Bool`: identifies whether the technology is available
- `name::String`: The technology name
- `end_region::String`: End region for transport technology
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `resistance::Float64`: Technology resistance in Ohms
- `voltage::Float64`: Technology resistance in Ohms
- `existing_flow_capacity::Float64`: Existing capacity of transport technology (MW)
- `maximum_new_capacity::Float64`: Maximum capacity that can be added to transmission line (MW)
- `line_loss::Float64`: Transmission loss for each transport technology (%)
"""
mutable struct TransportTechnology{T <: PSY.Device} <: Technology
    "Start region for transport technology"
    start_region::String
    "identifies whether the technology is available"
    available::Bool
    "The technology name"
    name::String
    "End region for transport technology"
    end_region::String
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Technology resistance in Ohms"
    resistance::Float64
    "Technology resistance in Ohms"
    voltage::Float64
    "Existing capacity of transport technology (MW)"
    existing_flow_capacity::Float64
    "Maximum capacity that can be added to transmission line (MW)"
    maximum_new_capacity::Float64
    "Transmission loss for each transport technology (%)"
    line_loss::Float64
end


function TransportTechnology{T}(; start_region, available, name, end_region, power_systems_type, internal=InfrastructureSystemsInternal(), ext=Dict(), resistance, voltage, existing_flow_capacity, maximum_new_capacity, line_loss, ) where T <: PSY.Device
    TransportTechnology{T}(start_region, available, name, end_region, power_systems_type, internal, ext, resistance, voltage, existing_flow_capacity, maximum_new_capacity, line_loss, )
end

"""Get [`TransportTechnology`](@ref) `start_region`."""
get_start_region(value::TransportTechnology) = value.start_region
"""Get [`TransportTechnology`](@ref) `available`."""
get_available(value::TransportTechnology) = value.available
"""Get [`TransportTechnology`](@ref) `name`."""
get_name(value::TransportTechnology) = value.name
"""Get [`TransportTechnology`](@ref) `end_region`."""
get_end_region(value::TransportTechnology) = value.end_region
"""Get [`TransportTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::TransportTechnology) = value.power_systems_type
"""Get [`TransportTechnology`](@ref) `internal`."""
get_internal(value::TransportTechnology) = value.internal
"""Get [`TransportTechnology`](@ref) `ext`."""
get_ext(value::TransportTechnology) = value.ext
"""Get [`TransportTechnology`](@ref) `resistance`."""
get_resistance(value::TransportTechnology) = value.resistance
"""Get [`TransportTechnology`](@ref) `voltage`."""
get_voltage(value::TransportTechnology) = value.voltage
"""Get [`TransportTechnology`](@ref) `existing_flow_capacity`."""
get_existing_flow_capacity(value::TransportTechnology) = value.existing_flow_capacity
"""Get [`TransportTechnology`](@ref) `maximum_new_capacity`."""
get_maximum_new_capacity(value::TransportTechnology) = value.maximum_new_capacity
"""Get [`TransportTechnology`](@ref) `line_loss`."""
get_line_loss(value::TransportTechnology) = value.line_loss

"""Set [`TransportTechnology`](@ref) `start_region`."""
set_start_region!(value::TransportTechnology, val) = value.start_region = val
"""Set [`TransportTechnology`](@ref) `available`."""
set_available!(value::TransportTechnology, val) = value.available = val
"""Set [`TransportTechnology`](@ref) `name`."""
set_name!(value::TransportTechnology, val) = value.name = val
"""Set [`TransportTechnology`](@ref) `end_region`."""
set_end_region!(value::TransportTechnology, val) = value.end_region = val
"""Set [`TransportTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::TransportTechnology, val) = value.power_systems_type = val
"""Set [`TransportTechnology`](@ref) `internal`."""
set_internal!(value::TransportTechnology, val) = value.internal = val
"""Set [`TransportTechnology`](@ref) `ext`."""
set_ext!(value::TransportTechnology, val) = value.ext = val
"""Set [`TransportTechnology`](@ref) `resistance`."""
set_resistance!(value::TransportTechnology, val) = value.resistance = val
"""Set [`TransportTechnology`](@ref) `voltage`."""
set_voltage!(value::TransportTechnology, val) = value.voltage = val
"""Set [`TransportTechnology`](@ref) `existing_flow_capacity`."""
set_existing_flow_capacity!(value::TransportTechnology, val) = value.existing_flow_capacity = val
"""Set [`TransportTechnology`](@ref) `maximum_new_capacity`."""
set_maximum_new_capacity!(value::TransportTechnology, val) = value.maximum_new_capacity = val
"""Set [`TransportTechnology`](@ref) `line_loss`."""
set_line_loss!(value::TransportTechnology, val) = value.line_loss = val
