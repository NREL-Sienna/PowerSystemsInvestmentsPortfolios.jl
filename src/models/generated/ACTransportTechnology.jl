#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct ACTransportTechnology{T <: PSY.Device} <: TransmissionTechnology
        base_power::Float64
        capital_cost::PSY.ValueCurve
        start_region::RegionTopology
        build_year::Union{Nothing, Int}
        available::Bool
        name::String
        id::Int64
        end_region::RegionTopology
        financial_data::TechnologyFinancialData
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        ext::Dict
        length_km::Union{Nothing, Int}
        resistance::Float64
        voltage::Float64
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
- `start_region::RegionTopology`: Start region for transport technology
- `build_year::Union{Nothing, Int}`: (default: `nothing`) Year in which the existing technology is built. Default to nothing for new technologies
- `available::Bool`: Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `name::String`: Name
- `id::Int64`: Numerical Index for AC transport technologies
- `end_region::RegionTopology`: End region for transport technology
- `financial_data::TechnologyFinancialData`: Struct containing relevant financial information for a technology
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `length_km::Union{Nothing, Int}`: (default: `nothing`) Length of a transmission line in kilometers.
- `resistance::Float64`: (default: `0.0`) Line resistance in Ohms
- `voltage::Float64`: (default: `0.0`) Rated line voltage in Volts
- `unit_size::Float64`: (default: `1`) Used for integer investment decisions. Represents the rating capacity of individual new lines (MW)
- `existing_line_capacity::Float64`: (default: `0.0`) Existing capacity of transport technology (MW)
- `angle_limits::MinMax`: (default: `(min=0, max=6.28)`) Voltage angle limit (radians)
- `line_loss::Float64`: (default: `1.0`) Transmission loss for each transport technology (%)
- `capacity_limits::MinMax`: (default: `(min=0, max=1e8)`) Allowable capacity for a transmission line (MW)
"""
mutable struct ACTransportTechnology{T <: PSY.Device} <: TransmissionTechnology
    "Base power"
    base_power::Float64
    "Cost of adding new capacity to the nodal transmission line."
    capital_cost::PSY.ValueCurve
    "Start region for transport technology"
    start_region::RegionTopology
    "Year in which the existing technology is built. Default to nothing for new technologies"
    build_year::Union{Nothing, Int}
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
    "Name"
    name::String
    "Numerical Index for AC transport technologies"
    id::Int64
    "End region for transport technology"
    end_region::RegionTopology
    "Struct containing relevant financial information for a technology"
    financial_data::TechnologyFinancialData
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Length of a transmission line in kilometers."
    length_km::Union{Nothing, Int}
    "Line resistance in Ohms"
    resistance::Float64
    "Rated line voltage in Volts"
    voltage::Float64
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


function ACTransportTechnology{T}(; base_power, capital_cost=LinearCurve(0.0), start_region, build_year=nothing, available, name, id, end_region, financial_data, power_systems_type, internal=InfrastructureSystemsInternal(), ext=Dict(), length_km=nothing, resistance=0.0, voltage=0.0, unit_size=1, existing_line_capacity=0.0, angle_limits=(min=0, max=6.28), line_loss=1.0, capacity_limits=(min=0, max=1e8), ) where T <: PSY.Device
    ACTransportTechnology{T}(base_power, capital_cost, start_region, build_year, available, name, id, end_region, financial_data, power_systems_type, internal, ext, length_km, resistance, voltage, unit_size, existing_line_capacity, angle_limits, line_loss, capacity_limits, )
end

"""Get [`ACTransportTechnology`](@ref) `base_power`."""
get_base_power(value::ACTransportTechnology) = value.base_power
"""Get [`ACTransportTechnology`](@ref) `capital_cost`."""
get_capital_cost(value::ACTransportTechnology) = value.capital_cost
"""Get [`ACTransportTechnology`](@ref) `start_region`."""
get_start_region(value::ACTransportTechnology) = value.start_region
"""Get [`ACTransportTechnology`](@ref) `build_year`."""
get_build_year(value::ACTransportTechnology) = value.build_year
"""Get [`ACTransportTechnology`](@ref) `available`."""
get_available(value::ACTransportTechnology) = value.available
"""Get [`ACTransportTechnology`](@ref) `name`."""
get_name(value::ACTransportTechnology) = value.name
"""Get [`ACTransportTechnology`](@ref) `id`."""
get_id(value::ACTransportTechnology) = value.id
"""Get [`ACTransportTechnology`](@ref) `end_region`."""
get_end_region(value::ACTransportTechnology) = value.end_region
"""Get [`ACTransportTechnology`](@ref) `financial_data`."""
get_financial_data(value::ACTransportTechnology) = value.financial_data
"""Get [`ACTransportTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::ACTransportTechnology) = value.power_systems_type
"""Get [`ACTransportTechnology`](@ref) `internal`."""
get_internal(value::ACTransportTechnology) = value.internal
"""Get [`ACTransportTechnology`](@ref) `ext`."""
get_ext(value::ACTransportTechnology) = value.ext
"""Get [`ACTransportTechnology`](@ref) `length_km`."""
get_length_km(value::ACTransportTechnology) = value.length_km
"""Get [`ACTransportTechnology`](@ref) `resistance`."""
get_resistance(value::ACTransportTechnology) = value.resistance
"""Get [`ACTransportTechnology`](@ref) `voltage`."""
get_voltage(value::ACTransportTechnology) = value.voltage
"""Get [`ACTransportTechnology`](@ref) `unit_size`."""
get_unit_size(value::ACTransportTechnology) = value.unit_size
"""Get [`ACTransportTechnology`](@ref) `existing_line_capacity`."""
get_existing_line_capacity(value::ACTransportTechnology) = value.existing_line_capacity
"""Get [`ACTransportTechnology`](@ref) `angle_limits`."""
get_angle_limits(value::ACTransportTechnology) = value.angle_limits
"""Get [`ACTransportTechnology`](@ref) `line_loss`."""
get_line_loss(value::ACTransportTechnology) = value.line_loss
"""Get [`ACTransportTechnology`](@ref) `capacity_limits`."""
get_capacity_limits(value::ACTransportTechnology) = value.capacity_limits

"""Set [`ACTransportTechnology`](@ref) `base_power`."""
set_base_power!(value::ACTransportTechnology, val) = value.base_power = val
"""Set [`ACTransportTechnology`](@ref) `capital_cost`."""
set_capital_cost!(value::ACTransportTechnology, val) = value.capital_cost = val
"""Set [`ACTransportTechnology`](@ref) `start_region`."""
set_start_region!(value::ACTransportTechnology, val) = value.start_region = val
"""Set [`ACTransportTechnology`](@ref) `build_year`."""
set_build_year!(value::ACTransportTechnology, val) = value.build_year = val
"""Set [`ACTransportTechnology`](@ref) `available`."""
set_available!(value::ACTransportTechnology, val) = value.available = val
"""Set [`ACTransportTechnology`](@ref) `name`."""
set_name!(value::ACTransportTechnology, val) = value.name = val
"""Set [`ACTransportTechnology`](@ref) `id`."""
set_id!(value::ACTransportTechnology, val) = value.id = val
"""Set [`ACTransportTechnology`](@ref) `end_region`."""
set_end_region!(value::ACTransportTechnology, val) = value.end_region = val
"""Set [`ACTransportTechnology`](@ref) `financial_data`."""
set_financial_data!(value::ACTransportTechnology, val) = value.financial_data = val
"""Set [`ACTransportTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::ACTransportTechnology, val) = value.power_systems_type = val
"""Set [`ACTransportTechnology`](@ref) `internal`."""
set_internal!(value::ACTransportTechnology, val) = value.internal = val
"""Set [`ACTransportTechnology`](@ref) `ext`."""
set_ext!(value::ACTransportTechnology, val) = value.ext = val
"""Set [`ACTransportTechnology`](@ref) `length_km`."""
set_length_km!(value::ACTransportTechnology, val) = value.length_km = val
"""Set [`ACTransportTechnology`](@ref) `resistance`."""
set_resistance!(value::ACTransportTechnology, val) = value.resistance = val
"""Set [`ACTransportTechnology`](@ref) `voltage`."""
set_voltage!(value::ACTransportTechnology, val) = value.voltage = val
"""Set [`ACTransportTechnology`](@ref) `unit_size`."""
set_unit_size!(value::ACTransportTechnology, val) = value.unit_size = val
"""Set [`ACTransportTechnology`](@ref) `existing_line_capacity`."""
set_existing_line_capacity!(value::ACTransportTechnology, val) = value.existing_line_capacity = val
"""Set [`ACTransportTechnology`](@ref) `angle_limits`."""
set_angle_limits!(value::ACTransportTechnology, val) = value.angle_limits = val
"""Set [`ACTransportTechnology`](@ref) `line_loss`."""
set_line_loss!(value::ACTransportTechnology, val) = value.line_loss = val
"""Set [`ACTransportTechnology`](@ref) `capacity_limits`."""
set_capacity_limits!(value::ACTransportTechnology, val) = value.capacity_limits = val

function serialize_openapi_struct(technology::ACTransportTechnology{T}, vals...) where T <: PSY.Device
    base_struct = APIServer.ACTransportTechnology(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:ACTransportTechnology}, vals::Dict)
    return IS.deserialize_struct(APIServer.ACTransportTechnology, vals)
end
