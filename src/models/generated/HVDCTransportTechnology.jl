#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct HVDCTransportTechnology{T <: PSY.Device} <: Technology
        base_power::Float64
        capital_cost::PSY.ValueCurve
        start_region::Region
        available::Bool
        name::String
        id::Int64
        end_region::Region
        financial_data::TechnologyFinancialData
        power_systems_type::String
        angle_limit::Float64
        internal::InfrastructureSystemsInternal
        ext::Dict
        resistance::Float64
        voltage::Float64
        maximum_new_capacity::Float64
        base_year::Int
        existing_line_capacity::Float64
        line_loss::Float64
    end

An aggregated representation of candidate HVDC transmission lines between two regions.

# Arguments
- `base_power::Float64`: Base power
- `capital_cost::PSY.ValueCurve`: Cost of adding new capacity to the inter-regional transmission line.
- `start_region::Region`: Start region for transport technology
- `available::Bool`: identifies whether the technology is available
- `name::String`: Name
- `id::Int64`: Numerical Index for HVDC lines
- `end_region::Region`: End region for transport technology
- `financial_data::TechnologyFinancialData`: Struct containing relevant financial information for a technology
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `angle_limit::Float64`: (default: `0.0`) Votlage angle limit (radians)
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `resistance::Float64`: (default: `0.0`) Technology resistance in Ohms
- `voltage::Float64`: (default: `0.0`) Technology voltage in V
- `maximum_new_capacity::Float64`: Maximum capacity that can be added to transmission line (MW)
- `base_year::Int`: (default: `2020`) Reference year for technology data
- `existing_line_capacity::Float64`: Existing capacity of transport technology (MW)
- `line_loss::Float64`: Transmission loss for each transport technology (%)
"""
mutable struct HVDCTransportTechnology{T <: PSY.Device} <: Technology
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
    "Numerical Index for HVDC lines"
    id::Int64
    "End region for transport technology"
    end_region::Region
    "Struct containing relevant financial information for a technology"
    financial_data::TechnologyFinancialData
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
    "Technology voltage in V"
    voltage::Float64
    "Maximum capacity that can be added to transmission line (MW)"
    maximum_new_capacity::Float64
    "Reference year for technology data"
    base_year::Int
    "Existing capacity of transport technology (MW)"
    existing_line_capacity::Float64
    "Transmission loss for each transport technology (%)"
    line_loss::Float64
end


function HVDCTransportTechnology{T}(; base_power, capital_cost, start_region, available, name, id, end_region, financial_data, power_systems_type, angle_limit=0.0, internal=InfrastructureSystemsInternal(), ext=Dict(), resistance=0.0, voltage=0.0, maximum_new_capacity, base_year=2020, existing_line_capacity, line_loss, ) where T <: PSY.Device
    HVDCTransportTechnology{T}(base_power, capital_cost, start_region, available, name, id, end_region, financial_data, power_systems_type, angle_limit, internal, ext, resistance, voltage, maximum_new_capacity, base_year, existing_line_capacity, line_loss, )
end

"""Get [`HVDCTransportTechnology`](@ref) `base_power`."""
get_base_power(value::HVDCTransportTechnology) = value.base_power
"""Get [`HVDCTransportTechnology`](@ref) `capital_cost`."""
get_capital_cost(value::HVDCTransportTechnology) = value.capital_cost
"""Get [`HVDCTransportTechnology`](@ref) `start_region`."""
get_start_region(value::HVDCTransportTechnology) = value.start_region
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
"""Get [`HVDCTransportTechnology`](@ref) `maximum_new_capacity`."""
get_maximum_new_capacity(value::HVDCTransportTechnology) = value.maximum_new_capacity
"""Get [`HVDCTransportTechnology`](@ref) `base_year`."""
get_base_year(value::HVDCTransportTechnology) = value.base_year
"""Get [`HVDCTransportTechnology`](@ref) `existing_line_capacity`."""
get_existing_line_capacity(value::HVDCTransportTechnology) = value.existing_line_capacity
"""Get [`HVDCTransportTechnology`](@ref) `line_loss`."""
get_line_loss(value::HVDCTransportTechnology) = value.line_loss

"""Set [`HVDCTransportTechnology`](@ref) `base_power`."""
set_base_power!(value::HVDCTransportTechnology, val) = value.base_power = val
"""Set [`HVDCTransportTechnology`](@ref) `capital_cost`."""
set_capital_cost!(value::HVDCTransportTechnology, val) = value.capital_cost = val
"""Set [`HVDCTransportTechnology`](@ref) `start_region`."""
set_start_region!(value::HVDCTransportTechnology, val) = value.start_region = val
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
"""Set [`HVDCTransportTechnology`](@ref) `maximum_new_capacity`."""
set_maximum_new_capacity!(value::HVDCTransportTechnology, val) = value.maximum_new_capacity = val
"""Set [`HVDCTransportTechnology`](@ref) `base_year`."""
set_base_year!(value::HVDCTransportTechnology, val) = value.base_year = val
"""Set [`HVDCTransportTechnology`](@ref) `existing_line_capacity`."""
set_existing_line_capacity!(value::HVDCTransportTechnology, val) = value.existing_line_capacity = val
"""Set [`HVDCTransportTechnology`](@ref) `line_loss`."""
set_line_loss!(value::HVDCTransportTechnology, val) = value.line_loss = val

function serialize_openapi_struct(technology::HVDCTransportTechnology{T}, vals...) where T <: PSY.Device
    base_struct = APIServer.HVDCTransportTechnology(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:HVDCTransportTechnology}, vals::Dict)
    return IS.deserialize_struct(APIServer.HVDCTransportTechnology, vals)
end
