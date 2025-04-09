#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct HVDCTransportTechnology{T <: PSY.Device} <: TransmissionTechnology
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

An aggregated representation of candidate HVDC transmission lines between two regions.

# Arguments
- `base_power::Float64`: Base power
- `capital_cost::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Cost of adding new capacity to the nodal transmission line.
- `start_region::RegionTopology`: Start region for transport technology
- `build_year::Union{Nothing, Int}`: (default: `nothing`) Year in which the existing technology is built. Default to nothing for new technologies
- `available::Bool`: Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `name::String`: Name
- `id::Int64`: Numerical Index for HVDC lines
- `end_region::RegionTopology`: End region for transport technology
- `financial_data::TechnologyFinancialData`: Struct containing relevant financial information for a technology
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `length_km::Union{Nothing, Int}`: (default: `nothing`) Length of a transmission line in kilometers.
- `resistance::Float64`: (default: `0.0`) Technology resistance in Ohms
- `voltage::Float64`: (default: `0.0`) Technology voltage in V
- `unit_size::Float64`: (default: `1`) Used for integer investment decisions. Represents the rating capacity of individual new lines (MW)
- `existing_line_capacity::Float64`: (default: `0.0`) Existing capacity of transport technology (MW)
- `angle_limits::MinMax`: (default: `(min=0, max=6.28)`) Voltage angle limit (radians)
- `line_loss::Float64`: (default: `1.0`) Transmission loss for each transport technology (%)
- `capacity_limits::MinMax`: (default: `(min=0, max=1e8)`) Allowable capacity for a transmission line (MW)
"""
mutable struct HVDCTransportTechnology{T <: PSY.Device} <: TransmissionTechnology
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
    "Numerical Index for HVDC lines"
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
    "Technology resistance in Ohms"
    resistance::Float64
    "Technology voltage in V"
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


function HVDCTransportTechnology{T}(; base_power, capital_cost=LinearCurve(0.0), start_region, build_year=nothing, available, name, id, end_region, financial_data, power_systems_type, internal=InfrastructureSystemsInternal(), ext=Dict(), length_km=nothing, resistance=0.0, voltage=0.0, unit_size=1, existing_line_capacity=0.0, angle_limits=(min=0, max=6.28), line_loss=1.0, capacity_limits=(min=0, max=1e8), ) where T <: PSY.Device
    HVDCTransportTechnology{T}(base_power, capital_cost, start_region, build_year, available, name, id, end_region, financial_data, power_systems_type, internal, ext, length_km, resistance, voltage, unit_size, existing_line_capacity, angle_limits, line_loss, capacity_limits, )
end

"""Get [`HVDCTransportTechnology`](@ref) `base_power`."""
get_base_power(value::HVDCTransportTechnology) = value.base_power
"""Get [`HVDCTransportTechnology`](@ref) `capital_cost`."""
get_capital_cost(value::HVDCTransportTechnology) = value.capital_cost
"""Get [`HVDCTransportTechnology`](@ref) `start_region`."""
get_start_region(value::HVDCTransportTechnology) = value.start_region
"""Get [`HVDCTransportTechnology`](@ref) `build_year`."""
get_build_year(value::HVDCTransportTechnology) = value.build_year
"""Get [`HVDCTransportTechnology`](@ref) `available`."""
get_available(value::HVDCTransportTechnology) = value.available
"""Get [`HVDCTransportTechnology`](@ref) `name`."""
get_name(value::HVDCTransportTechnology) = value.name
"""Get [`HVDCTransportTechnology`](@ref) `id`."""
get_id(value::HVDCTransportTechnology) = value.id
"""Get [`HVDCTransportTechnology`](@ref) `end_region`."""
get_end_region(value::HVDCTransportTechnology) = value.end_region
"""Get [`HVDCTransportTechnology`](@ref) `financial_data`."""
get_financial_data(value::HVDCTransportTechnology) = value.financial_data
"""Get [`HVDCTransportTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::HVDCTransportTechnology) = value.power_systems_type
"""Get [`HVDCTransportTechnology`](@ref) `internal`."""
get_internal(value::HVDCTransportTechnology) = value.internal
"""Get [`HVDCTransportTechnology`](@ref) `ext`."""
get_ext(value::HVDCTransportTechnology) = value.ext
"""Get [`HVDCTransportTechnology`](@ref) `length_km`."""
get_length_km(value::HVDCTransportTechnology) = value.length_km
"""Get [`HVDCTransportTechnology`](@ref) `resistance`."""
get_resistance(value::HVDCTransportTechnology) = value.resistance
"""Get [`HVDCTransportTechnology`](@ref) `voltage`."""
get_voltage(value::HVDCTransportTechnology) = value.voltage
"""Get [`HVDCTransportTechnology`](@ref) `unit_size`."""
get_unit_size(value::HVDCTransportTechnology) = value.unit_size
"""Get [`HVDCTransportTechnology`](@ref) `existing_line_capacity`."""
get_existing_line_capacity(value::HVDCTransportTechnology) = value.existing_line_capacity
"""Get [`HVDCTransportTechnology`](@ref) `angle_limits`."""
get_angle_limits(value::HVDCTransportTechnology) = value.angle_limits
"""Get [`HVDCTransportTechnology`](@ref) `line_loss`."""
get_line_loss(value::HVDCTransportTechnology) = value.line_loss
"""Get [`HVDCTransportTechnology`](@ref) `capacity_limits`."""
get_capacity_limits(value::HVDCTransportTechnology) = value.capacity_limits

"""Set [`HVDCTransportTechnology`](@ref) `base_power`."""
set_base_power!(value::HVDCTransportTechnology, val) = value.base_power = val
"""Set [`HVDCTransportTechnology`](@ref) `capital_cost`."""
set_capital_cost!(value::HVDCTransportTechnology, val) = value.capital_cost = val
"""Set [`HVDCTransportTechnology`](@ref) `start_region`."""
set_start_region!(value::HVDCTransportTechnology, val) = value.start_region = val
"""Set [`HVDCTransportTechnology`](@ref) `build_year`."""
set_build_year!(value::HVDCTransportTechnology, val) = value.build_year = val
"""Set [`HVDCTransportTechnology`](@ref) `available`."""
set_available!(value::HVDCTransportTechnology, val) = value.available = val
"""Set [`HVDCTransportTechnology`](@ref) `name`."""
set_name!(value::HVDCTransportTechnology, val) = value.name = val
"""Set [`HVDCTransportTechnology`](@ref) `id`."""
set_id!(value::HVDCTransportTechnology, val) = value.id = val
"""Set [`HVDCTransportTechnology`](@ref) `end_region`."""
set_end_region!(value::HVDCTransportTechnology, val) = value.end_region = val
"""Set [`HVDCTransportTechnology`](@ref) `financial_data`."""
set_financial_data!(value::HVDCTransportTechnology, val) = value.financial_data = val
"""Set [`HVDCTransportTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::HVDCTransportTechnology, val) = value.power_systems_type = val
"""Set [`HVDCTransportTechnology`](@ref) `internal`."""
set_internal!(value::HVDCTransportTechnology, val) = value.internal = val
"""Set [`HVDCTransportTechnology`](@ref) `ext`."""
set_ext!(value::HVDCTransportTechnology, val) = value.ext = val
"""Set [`HVDCTransportTechnology`](@ref) `length_km`."""
set_length_km!(value::HVDCTransportTechnology, val) = value.length_km = val
"""Set [`HVDCTransportTechnology`](@ref) `resistance`."""
set_resistance!(value::HVDCTransportTechnology, val) = value.resistance = val
"""Set [`HVDCTransportTechnology`](@ref) `voltage`."""
set_voltage!(value::HVDCTransportTechnology, val) = value.voltage = val
"""Set [`HVDCTransportTechnology`](@ref) `unit_size`."""
set_unit_size!(value::HVDCTransportTechnology, val) = value.unit_size = val
"""Set [`HVDCTransportTechnology`](@ref) `existing_line_capacity`."""
set_existing_line_capacity!(value::HVDCTransportTechnology, val) = value.existing_line_capacity = val
"""Set [`HVDCTransportTechnology`](@ref) `angle_limits`."""
set_angle_limits!(value::HVDCTransportTechnology, val) = value.angle_limits = val
"""Set [`HVDCTransportTechnology`](@ref) `line_loss`."""
set_line_loss!(value::HVDCTransportTechnology, val) = value.line_loss = val
"""Set [`HVDCTransportTechnology`](@ref) `capacity_limits`."""
set_capacity_limits!(value::HVDCTransportTechnology, val) = value.capacity_limits = val

function serialize_openapi_struct(technology::HVDCTransportTechnology{T}, vals...) where T <: PSY.Device
    base_struct = APIServer.HVDCTransportTechnology(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:HVDCTransportTechnology}, vals::Dict)
    return IS.deserialize_struct(APIServer.HVDCTransportTechnology, vals)
end
