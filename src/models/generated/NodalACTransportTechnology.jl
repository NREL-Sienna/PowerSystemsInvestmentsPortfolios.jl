#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct NodalACTransportTechnology{T <: PSY.Device} <: TransmissionTechnology
        capital_costs::PSY.ValueCurve
        available::Bool
        name::String
        end_node::Node
        id::Int64
        financial_data::TechnologyFinancialData
        start_node::Node
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        ext::Dict
        reactance::Float64
        resistance::Float64
        voltage::Float64
        unit_size::Float64
        capacity_limits::MinMax
    end

Nodal representation of candidate AC transmission lines between two regions.

# Arguments
- `capital_costs::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Cost of adding new capacity to the nodal transmission line.
- `available::Bool`: Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `name::String`: Name
- `end_node::Node`: End node for transport technology
- `id::Int64`: Numerical Index for AC transport technologies
- `financial_data::TechnologyFinancialData`: Struct containing relevant financial information for a technology
- `start_node::Node`: Start node for transport technology
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `reactance::Float64`: Series reactance for a line (ohms)
- `resistance::Float64`: (default: `0.0`) Technology resistance in Ohms
- `voltage::Float64`: (default: `0.0`) Technology voltage in Volts
- `unit_size::Float64`: (default: `1`) Used for integer investment decisions. Represents the rating capacity of individual new lines (MW)
- `capacity_limits::MinMax`: (default: `(min=0, max=1e8)`) Allowable capacity for a transmission line (MW)
"""
mutable struct NodalACTransportTechnology{T <: PSY.Device} <: TransmissionTechnology
    "Cost of adding new capacity to the nodal transmission line."
    capital_costs::PSY.ValueCurve
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
    "Name"
    name::String
    "End node for transport technology"
    end_node::Node
    "Numerical Index for AC transport technologies"
    id::Int64
    "Struct containing relevant financial information for a technology"
    financial_data::TechnologyFinancialData
    "Start node for transport technology"
    start_node::Node
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Series reactance for a line (ohms)"
    reactance::Float64
    "Technology resistance in Ohms"
    resistance::Float64
    "Technology voltage in Volts"
    voltage::Float64
    "Used for integer investment decisions. Represents the rating capacity of individual new lines (MW)"
    unit_size::Float64
    "Allowable capacity for a transmission line (MW)"
    capacity_limits::MinMax
end


function NodalACTransportTechnology{T}(; capital_costs=LinearCurve(0.0), available, name, end_node, id, financial_data, start_node, power_systems_type, internal=InfrastructureSystemsInternal(), ext=Dict(), reactance, resistance=0.0, voltage=0.0, unit_size=1, capacity_limits=(min=0, max=1e8), ) where T <: PSY.Device
    NodalACTransportTechnology{T}(capital_costs, available, name, end_node, id, financial_data, start_node, power_systems_type, internal, ext, reactance, resistance, voltage, unit_size, capacity_limits, )
end

"""Get [`NodalACTransportTechnology`](@ref) `capital_costs`."""
get_capital_costs(value::NodalACTransportTechnology) = value.capital_costs
"""Get [`NodalACTransportTechnology`](@ref) `available`."""
get_available(value::NodalACTransportTechnology) = value.available
"""Get [`NodalACTransportTechnology`](@ref) `name`."""
get_name(value::NodalACTransportTechnology) = value.name
"""Get [`NodalACTransportTechnology`](@ref) `end_node`."""
get_end_node(value::NodalACTransportTechnology) = value.end_node
"""Get [`NodalACTransportTechnology`](@ref) `id`."""
get_id(value::NodalACTransportTechnology) = value.id
"""Get [`NodalACTransportTechnology`](@ref) `financial_data`."""
get_financial_data(value::NodalACTransportTechnology) = value.financial_data
"""Get [`NodalACTransportTechnology`](@ref) `start_node`."""
get_start_node(value::NodalACTransportTechnology) = value.start_node
"""Get [`NodalACTransportTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::NodalACTransportTechnology) = value.power_systems_type
"""Get [`NodalACTransportTechnology`](@ref) `internal`."""
get_internal(value::NodalACTransportTechnology) = value.internal
"""Get [`NodalACTransportTechnology`](@ref) `ext`."""
get_ext(value::NodalACTransportTechnology) = value.ext
"""Get [`NodalACTransportTechnology`](@ref) `reactance`."""
get_reactance(value::NodalACTransportTechnology) = value.reactance
"""Get [`NodalACTransportTechnology`](@ref) `resistance`."""
get_resistance(value::NodalACTransportTechnology) = value.resistance
"""Get [`NodalACTransportTechnology`](@ref) `voltage`."""
get_voltage(value::NodalACTransportTechnology) = value.voltage
"""Get [`NodalACTransportTechnology`](@ref) `unit_size`."""
get_unit_size(value::NodalACTransportTechnology) = value.unit_size
"""Get [`NodalACTransportTechnology`](@ref) `capacity_limits`."""
get_capacity_limits(value::NodalACTransportTechnology) = value.capacity_limits

"""Set [`NodalACTransportTechnology`](@ref) `capital_costs`."""
set_capital_costs!(value::NodalACTransportTechnology, val) = value.capital_costs = val
"""Set [`NodalACTransportTechnology`](@ref) `available`."""
set_available!(value::NodalACTransportTechnology, val) = value.available = val
"""Set [`NodalACTransportTechnology`](@ref) `name`."""
set_name!(value::NodalACTransportTechnology, val) = value.name = val
"""Set [`NodalACTransportTechnology`](@ref) `end_node`."""
set_end_node!(value::NodalACTransportTechnology, val) = value.end_node = val
"""Set [`NodalACTransportTechnology`](@ref) `id`."""
set_id!(value::NodalACTransportTechnology, val) = value.id = val
"""Set [`NodalACTransportTechnology`](@ref) `financial_data`."""
set_financial_data!(value::NodalACTransportTechnology, val) = value.financial_data = val
"""Set [`NodalACTransportTechnology`](@ref) `start_node`."""
set_start_node!(value::NodalACTransportTechnology, val) = value.start_node = val
"""Set [`NodalACTransportTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::NodalACTransportTechnology, val) = value.power_systems_type = val
"""Set [`NodalACTransportTechnology`](@ref) `internal`."""
set_internal!(value::NodalACTransportTechnology, val) = value.internal = val
"""Set [`NodalACTransportTechnology`](@ref) `ext`."""
set_ext!(value::NodalACTransportTechnology, val) = value.ext = val
"""Set [`NodalACTransportTechnology`](@ref) `reactance`."""
set_reactance!(value::NodalACTransportTechnology, val) = value.reactance = val
"""Set [`NodalACTransportTechnology`](@ref) `resistance`."""
set_resistance!(value::NodalACTransportTechnology, val) = value.resistance = val
"""Set [`NodalACTransportTechnology`](@ref) `voltage`."""
set_voltage!(value::NodalACTransportTechnology, val) = value.voltage = val
"""Set [`NodalACTransportTechnology`](@ref) `unit_size`."""
set_unit_size!(value::NodalACTransportTechnology, val) = value.unit_size = val
"""Set [`NodalACTransportTechnology`](@ref) `capacity_limits`."""
set_capacity_limits!(value::NodalACTransportTechnology, val) = value.capacity_limits = val

function serialize_openapi_struct(technology::NodalACTransportTechnology{T}, vals...) where T <: PSY.Device
    base_struct = APIServer.NodalACTransportTechnology(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:NodalACTransportTechnology}, vals::Dict)
    return IS.deserialize_struct(APIServer.NodalACTransportTechnology, vals)
end
