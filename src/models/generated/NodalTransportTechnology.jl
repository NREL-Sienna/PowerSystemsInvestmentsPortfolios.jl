#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct NodalTransportTechnology{T <: PSY.Device} <: Technology
        base_power::Float64
        capital_cost::PSY.ValueCurve
        available::Bool
        name::String
        end_node::Node
        id::Int64
        financial_data::TechnologyFinancialData
        start_node::Node
        power_systems_type::String
        susceptance::Float64
        internal::InfrastructureSystemsInternal
        ext::Dict
        resistance::Float64
        voltage::Float64
        base_year::Int
        unit_size::Float64
        existing_line_capacity::Float64
        angle_limits::MinMax
        line_loss::Float64
        capacity_limits::MinMax
    end

An aggregated representation of candidate AC transmission lines between two regions.

# Arguments
- `base_power::Float64`: Base power
- `capital_cost::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Cost of adding new capacity to the nodal transmission line.
- `available::Bool`: Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `name::String`: Name
- `end_node::Node`: End node for transport technology
- `id::Int64`: Numerical Index for AC transport technologies
- `financial_data::TechnologyFinancialData`: Struct containing relevant financial information for a technology
- `start_node::Node`: Start node for transport technology
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `susceptance::Float64`: Series susceptance for a line, defined as the reciprocal of the series reactance
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `resistance::Float64`: (default: `0.0`) Technology resistance in Ohms
- `voltage::Float64`: (default: `0.0`) Technology voltage in Volts
- `base_year::Int`: (default: `2020`) Reference year for technology data
- `unit_size::Float64`: (default: `1`) Used for integer investment decisions. Represents the rating capacity of individual new lines (MW)
- `existing_line_capacity::Float64`: (default: `0.0`) Existing capacity of transport technology (MW)
- `angle_limits::MinMax`: (default: `(min=0, max=6.28)`) Voltage angle limit (radians)
- `line_loss::Float64`: Transmission loss for each transport technology (%)
- `capacity_limits::MinMax`: (default: `(min=0, max=1e8)`) Allowable capacity for a transmission line (MW)
"""
mutable struct NodalTransportTechnology{T <: PSY.Device} <: Technology
    "Base power"
    base_power::Float64
    "Cost of adding new capacity to the nodal transmission line."
    capital_cost::PSY.ValueCurve
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
    "Series susceptance for a line, defined as the reciprocal of the series reactance"
    susceptance::Float64
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Technology resistance in Ohms"
    resistance::Float64
    "Technology voltage in Volts"
    voltage::Float64
    "Reference year for technology data"
    base_year::Int
    "Used for integer investment decisions. Represents the rating capacity of individual new lines (MW)"
    unit_size::Float64
    "Existing capacity of transport technology (MW)"
    existing_line_capacity::Float64
    "Voltage angle limit (radians)"
    angle_limits::MinMax
    "Transmission loss for each transport technology (%)"
    line_loss::Float64
    "Allowable capacity for a transmission line (MW)"
    capacity_limits::MinMax
end


function NodalTransportTechnology{T}(; base_power, capital_cost=LinearCurve(0.0), available, name, end_node, id, financial_data, start_node, power_systems_type, susceptance, internal=InfrastructureSystemsInternal(), ext=Dict(), resistance=0.0, voltage=0.0, base_year=2020, unit_size=1, existing_line_capacity=0.0, angle_limits=(min=0, max=6.28), line_loss, capacity_limits=(min=0, max=1e8), ) where T <: PSY.Device
    NodalTransportTechnology{T}(base_power, capital_cost, available, name, end_node, id, financial_data, start_node, power_systems_type, susceptance, internal, ext, resistance, voltage, base_year, unit_size, existing_line_capacity, angle_limits, line_loss, capacity_limits, )
end

"""Get [`NodalTransportTechnology`](@ref) `base_power`."""
get_base_power(value::NodalTransportTechnology) = value.base_power
"""Get [`NodalTransportTechnology`](@ref) `capital_cost`."""
get_capital_cost(value::NodalTransportTechnology) = value.capital_cost
"""Get [`NodalTransportTechnology`](@ref) `available`."""
get_available(value::NodalTransportTechnology) = value.available
"""Get [`NodalTransportTechnology`](@ref) `name`."""
get_name(value::NodalTransportTechnology) = value.name
"""Get [`NodalTransportTechnology`](@ref) `end_node`."""
get_end_node(value::NodalTransportTechnology) = value.end_node
"""Get [`NodalTransportTechnology`](@ref) `id`."""
get_id(value::NodalTransportTechnology) = value.id
"""Get [`NodalTransportTechnology`](@ref) `financial_data`."""
get_financial_data(value::NodalTransportTechnology) = value.financial_data
"""Get [`NodalTransportTechnology`](@ref) `start_node`."""
get_start_node(value::NodalTransportTechnology) = value.start_node
"""Get [`NodalTransportTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::NodalTransportTechnology) = value.power_systems_type
"""Get [`NodalTransportTechnology`](@ref) `susceptance`."""
get_susceptance(value::NodalTransportTechnology) = value.susceptance
"""Get [`NodalTransportTechnology`](@ref) `internal`."""
get_internal(value::NodalTransportTechnology) = value.internal
"""Get [`NodalTransportTechnology`](@ref) `ext`."""
get_ext(value::NodalTransportTechnology) = value.ext
"""Get [`NodalTransportTechnology`](@ref) `resistance`."""
get_resistance(value::NodalTransportTechnology) = value.resistance
"""Get [`NodalTransportTechnology`](@ref) `voltage`."""
get_voltage(value::NodalTransportTechnology) = value.voltage
"""Get [`NodalTransportTechnology`](@ref) `base_year`."""
get_base_year(value::NodalTransportTechnology) = value.base_year
"""Get [`NodalTransportTechnology`](@ref) `unit_size`."""
get_unit_size(value::NodalTransportTechnology) = value.unit_size
"""Get [`NodalTransportTechnology`](@ref) `existing_line_capacity`."""
get_existing_line_capacity(value::NodalTransportTechnology) = value.existing_line_capacity
"""Get [`NodalTransportTechnology`](@ref) `angle_limits`."""
get_angle_limits(value::NodalTransportTechnology) = value.angle_limits
"""Get [`NodalTransportTechnology`](@ref) `line_loss`."""
get_line_loss(value::NodalTransportTechnology) = value.line_loss
"""Get [`NodalTransportTechnology`](@ref) `capacity_limits`."""
get_capacity_limits(value::NodalTransportTechnology) = value.capacity_limits

"""Set [`NodalTransportTechnology`](@ref) `base_power`."""
set_base_power!(value::NodalTransportTechnology, val) = value.base_power = val
"""Set [`NodalTransportTechnology`](@ref) `capital_cost`."""
set_capital_cost!(value::NodalTransportTechnology, val) = value.capital_cost = val
"""Set [`NodalTransportTechnology`](@ref) `available`."""
set_available!(value::NodalTransportTechnology, val) = value.available = val
"""Set [`NodalTransportTechnology`](@ref) `name`."""
set_name!(value::NodalTransportTechnology, val) = value.name = val
"""Set [`NodalTransportTechnology`](@ref) `end_node`."""
set_end_node!(value::NodalTransportTechnology, val) = value.end_node = val
"""Set [`NodalTransportTechnology`](@ref) `id`."""
set_id!(value::NodalTransportTechnology, val) = value.id = val
"""Set [`NodalTransportTechnology`](@ref) `financial_data`."""
set_financial_data!(value::NodalTransportTechnology, val) = value.financial_data = val
"""Set [`NodalTransportTechnology`](@ref) `start_node`."""
set_start_node!(value::NodalTransportTechnology, val) = value.start_node = val
"""Set [`NodalTransportTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::NodalTransportTechnology, val) = value.power_systems_type = val
"""Set [`NodalTransportTechnology`](@ref) `susceptance`."""
set_susceptance!(value::NodalTransportTechnology, val) = value.susceptance = val
"""Set [`NodalTransportTechnology`](@ref) `internal`."""
set_internal!(value::NodalTransportTechnology, val) = value.internal = val
"""Set [`NodalTransportTechnology`](@ref) `ext`."""
set_ext!(value::NodalTransportTechnology, val) = value.ext = val
"""Set [`NodalTransportTechnology`](@ref) `resistance`."""
set_resistance!(value::NodalTransportTechnology, val) = value.resistance = val
"""Set [`NodalTransportTechnology`](@ref) `voltage`."""
set_voltage!(value::NodalTransportTechnology, val) = value.voltage = val
"""Set [`NodalTransportTechnology`](@ref) `base_year`."""
set_base_year!(value::NodalTransportTechnology, val) = value.base_year = val
"""Set [`NodalTransportTechnology`](@ref) `unit_size`."""
set_unit_size!(value::NodalTransportTechnology, val) = value.unit_size = val
"""Set [`NodalTransportTechnology`](@ref) `existing_line_capacity`."""
set_existing_line_capacity!(value::NodalTransportTechnology, val) = value.existing_line_capacity = val
"""Set [`NodalTransportTechnology`](@ref) `angle_limits`."""
set_angle_limits!(value::NodalTransportTechnology, val) = value.angle_limits = val
"""Set [`NodalTransportTechnology`](@ref) `line_loss`."""
set_line_loss!(value::NodalTransportTechnology, val) = value.line_loss = val
"""Set [`NodalTransportTechnology`](@ref) `capacity_limits`."""
set_capacity_limits!(value::NodalTransportTechnology, val) = value.capacity_limits = val

function serialize_openapi_struct(technology::NodalTransportTechnology{T}, vals...) where T <: PSY.Device
    base_struct = APIServer.NodalTransportTechnology(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:NodalTransportTechnology}, vals::Dict)
    return IS.deserialize_struct(APIServer.NodalTransportTechnology, vals)
end
