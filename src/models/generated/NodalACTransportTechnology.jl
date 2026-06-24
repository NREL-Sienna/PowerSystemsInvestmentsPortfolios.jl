#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct NodalACTransportTechnology{T <: PSY.Device} <: TransmissionTechnology
        name::String
        id::Int64
        available::Bool
        power_systems_type::String
        start_node::Node
        end_node::Node
        capacity_limits::MinMax
        unit_size::Float64
        capital_costs::PSY.ValueCurve
        resistance::Float64
        voltage::Float64
        reactance::Float64
        financial_data::TechnologyFinancialData
        ext::Dict
        internal::InfrastructureSystemsInternal
    end

Nodal representation of candidate AC transmission lines between two regions.

# Arguments
- `name::String`: Name
- `id::Int64`: Numerical Index for AC transport technologies
- `available::Bool`: Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `power_systems_type::String`: Corresponding type in PowerSystems.jl to be used in PCM modeling
- `start_node::Node`: Start node for transport technology
- `end_node::Node`: End node for transport technology
- `capacity_limits::MinMax`: (default: `(min=0, max=1e8)`) Allowable capacity for a transmission line (MW)
- `unit_size::Float64`: (default: `1.0`) Used for integer investment decisions. Represents the rating capacity of individual new lines (MW)
- `capital_costs::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Cost of adding new capacity to the nodal transmission line (USD/MW).
- `resistance::Float64`: (default: `1.0`) Technology resistance in Ohms
- `voltage::Float64`: (default: `230.0`) Voltage rating of transmission line (kV)
- `reactance::Float64`: (default: `1.0`) Series reactance for a line (ohms)
- `financial_data::TechnologyFinancialData`: Struct containing relevant financial information for a technology
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
"""
mutable struct NodalACTransportTechnology{T <: PSY.Device} <: TransmissionTechnology
    "Name"
    name::String
    "Numerical Index for AC transport technologies"
    id::Int64
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
    "Corresponding type in PowerSystems.jl to be used in PCM modeling"
    power_systems_type::String
    "Start node for transport technology"
    start_node::Node
    "End node for transport technology"
    end_node::Node
    "Allowable capacity for a transmission line (MW)"
    capacity_limits::MinMax
    "Used for integer investment decisions. Represents the rating capacity of individual new lines (MW)"
    unit_size::Float64
    "Cost of adding new capacity to the nodal transmission line (USD/MW)."
    capital_costs::PSY.ValueCurve
    "Technology resistance in Ohms"
    resistance::Float64
    "Voltage rating of transmission line (kV)"
    voltage::Float64
    "Series reactance for a line (ohms)"
    reactance::Float64
    "Struct containing relevant financial information for a technology"
    financial_data::TechnologyFinancialData
    "Optional dictionary to provide additional data"
    ext::Dict
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
end


function NodalACTransportTechnology{T}(; name, id, available, power_systems_type, start_node, end_node, capacity_limits=(min=0, max=1e8), unit_size=1.0, capital_costs=LinearCurve(0.0), resistance=1.0, voltage=230.0, reactance=1.0, financial_data, ext=Dict(), internal=InfrastructureSystemsInternal(), ) where T <: PSY.Device
    NodalACTransportTechnology{T}(name, id, available, power_systems_type, start_node, end_node, capacity_limits, unit_size, capital_costs, resistance, voltage, reactance, financial_data, ext, internal, )
end

"""Get [`NodalACTransportTechnology`](@ref) `name`."""
get_name(value::NodalACTransportTechnology) = value.name
"""Get [`NodalACTransportTechnology`](@ref) `id`."""
get_id(value::NodalACTransportTechnology) = value.id
"""Get [`NodalACTransportTechnology`](@ref) `available`."""
get_available(value::NodalACTransportTechnology) = value.available
"""Get [`NodalACTransportTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::NodalACTransportTechnology) = value.power_systems_type
"""Get [`NodalACTransportTechnology`](@ref) `start_node`."""
get_start_node(value::NodalACTransportTechnology) = value.start_node
"""Get [`NodalACTransportTechnology`](@ref) `end_node`."""
get_end_node(value::NodalACTransportTechnology) = value.end_node
"""Get [`NodalACTransportTechnology`](@ref) `capacity_limits`."""
get_capacity_limits(value::NodalACTransportTechnology) = value.capacity_limits
"""Get [`NodalACTransportTechnology`](@ref) `unit_size`."""
get_unit_size(value::NodalACTransportTechnology) = value.unit_size
"""Get [`NodalACTransportTechnology`](@ref) `capital_costs`."""
get_capital_costs(value::NodalACTransportTechnology) = value.capital_costs
"""Get [`NodalACTransportTechnology`](@ref) `resistance` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`get_resistance_unitful`](@ref)."""
get_resistance(value::NodalACTransportTechnology, units) = InfrastructureSystems._strip_units(get_value(value, Val(:resistance), Val(:ohm), units))
"""Get [`NodalACTransportTechnology`](@ref) `resistance` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`get_resistance`](@ref)."""
get_resistance_unitful(value::NodalACTransportTechnology, units) = get_value(value, Val(:resistance), Val(:ohm), units)
InfrastructureSystems.display_units_arg(::typeof(get_resistance), ::Type{NodalACTransportTechnology{T}}) where {T <: PSY.Device} = InfrastructureSystems.NU
InfrastructureSystems.display_units_arg(::typeof(get_resistance_unitful), ::Type{NodalACTransportTechnology{T}}) where {T <: PSY.Device} = InfrastructureSystems.NU
"""Get [`NodalACTransportTechnology`](@ref) `voltage` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`get_voltage_unitful`](@ref)."""
get_voltage(value::NodalACTransportTechnology, units) = InfrastructureSystems._strip_units(get_value(value, Val(:voltage), Val(:kv), units))
"""Get [`NodalACTransportTechnology`](@ref) `voltage` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`get_voltage`](@ref)."""
get_voltage_unitful(value::NodalACTransportTechnology, units) = get_value(value, Val(:voltage), Val(:kv), units)
InfrastructureSystems.display_units_arg(::typeof(get_voltage), ::Type{NodalACTransportTechnology{T}}) where {T <: PSY.Device} = InfrastructureSystems.NU
InfrastructureSystems.display_units_arg(::typeof(get_voltage_unitful), ::Type{NodalACTransportTechnology{T}}) where {T <: PSY.Device} = InfrastructureSystems.NU
"""Get [`NodalACTransportTechnology`](@ref) `reactance` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`get_reactance_unitful`](@ref)."""
get_reactance(value::NodalACTransportTechnology, units) = InfrastructureSystems._strip_units(get_value(value, Val(:reactance), Val(:ohm), units))
"""Get [`NodalACTransportTechnology`](@ref) `reactance` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`get_reactance`](@ref)."""
get_reactance_unitful(value::NodalACTransportTechnology, units) = get_value(value, Val(:reactance), Val(:ohm), units)
InfrastructureSystems.display_units_arg(::typeof(get_reactance), ::Type{NodalACTransportTechnology{T}}) where {T <: PSY.Device} = InfrastructureSystems.NU
InfrastructureSystems.display_units_arg(::typeof(get_reactance_unitful), ::Type{NodalACTransportTechnology{T}}) where {T <: PSY.Device} = InfrastructureSystems.NU
"""Get [`NodalACTransportTechnology`](@ref) `financial_data`."""
get_financial_data(value::NodalACTransportTechnology) = value.financial_data
"""Get [`NodalACTransportTechnology`](@ref) `ext`."""
get_ext(value::NodalACTransportTechnology) = value.ext
"""Get [`NodalACTransportTechnology`](@ref) `internal`."""
get_internal(value::NodalACTransportTechnology) = value.internal

"""Set [`NodalACTransportTechnology`](@ref) `name`."""
set_name!(value::NodalACTransportTechnology, val) = value.name = val
"""Set [`NodalACTransportTechnology`](@ref) `id`."""
set_id!(value::NodalACTransportTechnology, val) = value.id = val
"""Set [`NodalACTransportTechnology`](@ref) `available`."""
set_available!(value::NodalACTransportTechnology, val) = value.available = val
"""Set [`NodalACTransportTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::NodalACTransportTechnology, val) = value.power_systems_type = val
"""Set [`NodalACTransportTechnology`](@ref) `start_node`."""
set_start_node!(value::NodalACTransportTechnology, val) = value.start_node = val
"""Set [`NodalACTransportTechnology`](@ref) `end_node`."""
set_end_node!(value::NodalACTransportTechnology, val) = value.end_node = val
"""Set [`NodalACTransportTechnology`](@ref) `capacity_limits`."""
set_capacity_limits!(value::NodalACTransportTechnology, val) = value.capacity_limits = val
"""Set [`NodalACTransportTechnology`](@ref) `unit_size`."""
set_unit_size!(value::NodalACTransportTechnology, val) = value.unit_size = val
"""Set [`NodalACTransportTechnology`](@ref) `capital_costs`."""
set_capital_costs!(value::NodalACTransportTechnology, val) = value.capital_costs = val
"""Set [`NodalACTransportTechnology`](@ref) `resistance`."""
set_resistance!(value::NodalACTransportTechnology, val) = value.resistance = set_value(value, Val(:resistance), val, Val(:ohm))
"""Set [`NodalACTransportTechnology`](@ref) `voltage`."""
set_voltage!(value::NodalACTransportTechnology, val) = value.voltage = set_value(value, Val(:voltage), val, Val(:kv))
"""Set [`NodalACTransportTechnology`](@ref) `reactance`."""
set_reactance!(value::NodalACTransportTechnology, val) = value.reactance = set_value(value, Val(:reactance), val, Val(:ohm))
"""Set [`NodalACTransportTechnology`](@ref) `financial_data`."""
set_financial_data!(value::NodalACTransportTechnology, val) = value.financial_data = val
"""Set [`NodalACTransportTechnology`](@ref) `ext`."""
set_ext!(value::NodalACTransportTechnology, val) = value.ext = val
"""Set [`NodalACTransportTechnology`](@ref) `internal`."""
set_internal!(value::NodalACTransportTechnology, val) = value.internal = val

function serialize_openapi_struct(technology::NodalACTransportTechnology{T}, vals...) where T <: PSY.Device
    base_struct = APIServer.NodalACTransportTechnology(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:NodalACTransportTechnology}, vals::Dict)
    return IS.deserialize_struct(APIServer.NodalACTransportTechnology, vals)
end
