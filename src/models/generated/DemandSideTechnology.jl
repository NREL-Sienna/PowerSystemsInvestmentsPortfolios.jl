#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandSideTechnology{T <: PSY.StaticInjection} <: DemandTechnology
        name::String
        id::Int64
        available::Bool
        power_systems_type::String
        region::Vector{RegionTopology}
        technology_efficiency::Float64
        price_per_unit::PSY.ValueCurve
        min_power::Float64
        peak_demand_mw::Float64
        curtailment_cost::PSY.ValueCurve
        max_demand_curtailment::Float64
        max_demand_delay::Float64
        max_demand_advance::Float64
        demand_energy_efficiency::Float64
        shift_variable_cost::PSY.ValueCurve
        ext::Dict
        internal::InfrastructureSystemsInternal
    end

Represents demand side technologies such as electric vehicles or hydrogen electrolyzers.

# Arguments
- `name::String`: The technology name
- `id::Int64`: ID for demand side technology
- `available::Bool`: Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `power_systems_type::String`: Corresponding type in PowerSystems.jl to be used in PCM modeling
- `region::Vector{RegionTopology}`: (default: `Vector()`) Location where technology is operated
- `technology_efficiency::Float64`: (default: `0.0`) MWh of electricity per unit of output. Ex: MWh per ton of hydrogen for electrolyzers
- `price_per_unit::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Price or value per unit of output. Ex: USD per ton of hydrogen for electrolyzers
- `min_power::Float64`: (default: `0.0`) Minimum operation of demandside unit as a fraction of peak demand
- `peak_demand_mw::Float64`: (default: `0.0`) Peak demand value in MW
- `curtailment_cost::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Energy cost of curtailed demand, USD per Mwh
- `max_demand_curtailment::Float64`: (default: `0.0`) Maximum fraction of demand that can be curtailed
- `max_demand_delay::Float64`: (default: `0.0`) Maximum number of hours that demand can be deferred or delayed (hours).
- `max_demand_advance::Float64`: (default: `0.0`) Maximum number of hours that demand can be scheduled in advance of the original schedule (hours).
- `demand_energy_efficiency::Float64`: (default: `0.0`) Energy efficiency associated with time shifting demand. Represents energy losses due to time shifting
- `shift_variable_cost::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Variable operation and maintenance costs associated with flexible demand deferral/advancement
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
"""
mutable struct DemandSideTechnology{T <: PSY.StaticInjection} <: DemandTechnology
    "The technology name"
    name::String
    "ID for demand side technology"
    id::Int64
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
    "Corresponding type in PowerSystems.jl to be used in PCM modeling"
    power_systems_type::String
    "Location where technology is operated"
    region::Vector{RegionTopology}
    "MWh of electricity per unit of output. Ex: MWh per ton of hydrogen for electrolyzers"
    technology_efficiency::Float64
    "Price or value per unit of output. Ex: USD per ton of hydrogen for electrolyzers"
    price_per_unit::PSY.ValueCurve
    "Minimum operation of demandside unit as a fraction of peak demand"
    min_power::Float64
    "Peak demand value in MW"
    peak_demand_mw::Float64
    "Energy cost of curtailed demand, USD per Mwh"
    curtailment_cost::PSY.ValueCurve
    "Maximum fraction of demand that can be curtailed"
    max_demand_curtailment::Float64
    "Maximum number of hours that demand can be deferred or delayed (hours)."
    max_demand_delay::Float64
    "Maximum number of hours that demand can be scheduled in advance of the original schedule (hours)."
    max_demand_advance::Float64
    "Energy efficiency associated with time shifting demand. Represents energy losses due to time shifting"
    demand_energy_efficiency::Float64
    "Variable operation and maintenance costs associated with flexible demand deferral/advancement"
    shift_variable_cost::PSY.ValueCurve
    "Optional dictionary to provide additional data"
    ext::Dict
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
end


function DemandSideTechnology{T}(; name, id, available, power_systems_type, region=Vector(), technology_efficiency=0.0, price_per_unit=LinearCurve(0.0), min_power=0.0, peak_demand_mw=0.0, curtailment_cost=LinearCurve(0.0), max_demand_curtailment=0.0, max_demand_delay=0.0, max_demand_advance=0.0, demand_energy_efficiency=0.0, shift_variable_cost=LinearCurve(0.0), ext=Dict(), internal=InfrastructureSystemsInternal(), ) where T <: PSY.StaticInjection
    DemandSideTechnology{T}(name, id, available, power_systems_type, region, technology_efficiency, price_per_unit, min_power, peak_demand_mw, curtailment_cost, max_demand_curtailment, max_demand_delay, max_demand_advance, demand_energy_efficiency, shift_variable_cost, ext, internal, )
end

"""Get [`DemandSideTechnology`](@ref) `name`."""
get_name(value::DemandSideTechnology) = value.name
"""Get [`DemandSideTechnology`](@ref) `id`."""
get_id(value::DemandSideTechnology) = value.id
"""Get [`DemandSideTechnology`](@ref) `available`."""
get_available(value::DemandSideTechnology) = value.available
"""Get [`DemandSideTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::DemandSideTechnology) = value.power_systems_type
"""Get [`DemandSideTechnology`](@ref) `region`."""
get_region(value::DemandSideTechnology) = value.region
"""Get [`DemandSideTechnology`](@ref) `technology_efficiency`."""
get_technology_efficiency(value::DemandSideTechnology) = value.technology_efficiency
"""Get [`DemandSideTechnology`](@ref) `price_per_unit`."""
get_price_per_unit(value::DemandSideTechnology) = value.price_per_unit
"""Get [`DemandSideTechnology`](@ref) `min_power`."""
get_min_power(value::DemandSideTechnology) = value.min_power
"""Get [`DemandSideTechnology`](@ref) `peak_demand_mw` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`get_peak_demand_mw_unitful`](@ref)."""
get_peak_demand_mw(value::DemandSideTechnology, units) = InfrastructureSystems._strip_units(get_value(value, Val(:peak_demand_mw), Val(:mw), units))
"""Get [`DemandSideTechnology`](@ref) `peak_demand_mw` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`get_peak_demand_mw`](@ref)."""
get_peak_demand_mw_unitful(value::DemandSideTechnology, units) = get_value(value, Val(:peak_demand_mw), Val(:mw), units)
InfrastructureSystems.display_units_arg(::typeof(get_peak_demand_mw), ::Type{DemandSideTechnology{T}}) where {T <: PSY.StaticInjection} = InfrastructureSystems.NU
InfrastructureSystems.display_units_arg(::typeof(get_peak_demand_mw_unitful), ::Type{DemandSideTechnology{T}}) where {T <: PSY.StaticInjection} = InfrastructureSystems.NU
"""Get [`DemandSideTechnology`](@ref) `curtailment_cost`."""
get_curtailment_cost(value::DemandSideTechnology) = value.curtailment_cost
"""Get [`DemandSideTechnology`](@ref) `max_demand_curtailment`."""
get_max_demand_curtailment(value::DemandSideTechnology) = value.max_demand_curtailment
"""Get [`DemandSideTechnology`](@ref) `max_demand_delay` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`get_max_demand_delay_unitful`](@ref)."""
get_max_demand_delay(value::DemandSideTechnology, units) = InfrastructureSystems._strip_units(get_value(value, Val(:max_demand_delay), Val(:hr), units))
"""Get [`DemandSideTechnology`](@ref) `max_demand_delay` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`get_max_demand_delay`](@ref)."""
get_max_demand_delay_unitful(value::DemandSideTechnology, units) = get_value(value, Val(:max_demand_delay), Val(:hr), units)
InfrastructureSystems.display_units_arg(::typeof(get_max_demand_delay), ::Type{DemandSideTechnology{T}}) where {T <: PSY.StaticInjection} = InfrastructureSystems.NU
InfrastructureSystems.display_units_arg(::typeof(get_max_demand_delay_unitful), ::Type{DemandSideTechnology{T}}) where {T <: PSY.StaticInjection} = InfrastructureSystems.NU
"""Get [`DemandSideTechnology`](@ref) `max_demand_advance` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`get_max_demand_advance_unitful`](@ref)."""
get_max_demand_advance(value::DemandSideTechnology, units) = InfrastructureSystems._strip_units(get_value(value, Val(:max_demand_advance), Val(:hr), units))
"""Get [`DemandSideTechnology`](@ref) `max_demand_advance` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`get_max_demand_advance`](@ref)."""
get_max_demand_advance_unitful(value::DemandSideTechnology, units) = get_value(value, Val(:max_demand_advance), Val(:hr), units)
InfrastructureSystems.display_units_arg(::typeof(get_max_demand_advance), ::Type{DemandSideTechnology{T}}) where {T <: PSY.StaticInjection} = InfrastructureSystems.NU
InfrastructureSystems.display_units_arg(::typeof(get_max_demand_advance_unitful), ::Type{DemandSideTechnology{T}}) where {T <: PSY.StaticInjection} = InfrastructureSystems.NU
"""Get [`DemandSideTechnology`](@ref) `demand_energy_efficiency`."""
get_demand_energy_efficiency(value::DemandSideTechnology) = value.demand_energy_efficiency
"""Get [`DemandSideTechnology`](@ref) `shift_variable_cost`."""
get_shift_variable_cost(value::DemandSideTechnology) = value.shift_variable_cost
"""Get [`DemandSideTechnology`](@ref) `ext`."""
get_ext(value::DemandSideTechnology) = value.ext
"""Get [`DemandSideTechnology`](@ref) `internal`."""
get_internal(value::DemandSideTechnology) = value.internal

"""Set [`DemandSideTechnology`](@ref) `name`."""
set_name!(value::DemandSideTechnology, val) = value.name = val
"""Set [`DemandSideTechnology`](@ref) `id`."""
set_id!(value::DemandSideTechnology, val) = value.id = val
"""Set [`DemandSideTechnology`](@ref) `available`."""
set_available!(value::DemandSideTechnology, val) = value.available = val
"""Set [`DemandSideTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::DemandSideTechnology, val) = value.power_systems_type = val
"""Set [`DemandSideTechnology`](@ref) `region`."""
set_region!(value::DemandSideTechnology, val) = value.region = val
"""Set [`DemandSideTechnology`](@ref) `technology_efficiency`."""
set_technology_efficiency!(value::DemandSideTechnology, val) = value.technology_efficiency = val
"""Set [`DemandSideTechnology`](@ref) `price_per_unit`."""
set_price_per_unit!(value::DemandSideTechnology, val) = value.price_per_unit = val
"""Set [`DemandSideTechnology`](@ref) `min_power`."""
set_min_power!(value::DemandSideTechnology, val) = value.min_power = val
"""Set [`DemandSideTechnology`](@ref) `peak_demand_mw`."""
set_peak_demand_mw!(value::DemandSideTechnology, val) = value.peak_demand_mw = set_value(value, Val(:peak_demand_mw), val, Val(:mw))
"""Set [`DemandSideTechnology`](@ref) `curtailment_cost`."""
set_curtailment_cost!(value::DemandSideTechnology, val) = value.curtailment_cost = val
"""Set [`DemandSideTechnology`](@ref) `max_demand_curtailment`."""
set_max_demand_curtailment!(value::DemandSideTechnology, val) = value.max_demand_curtailment = val
"""Set [`DemandSideTechnology`](@ref) `max_demand_delay`."""
set_max_demand_delay!(value::DemandSideTechnology, val) = value.max_demand_delay = set_value(value, Val(:max_demand_delay), val, Val(:hr))
"""Set [`DemandSideTechnology`](@ref) `max_demand_advance`."""
set_max_demand_advance!(value::DemandSideTechnology, val) = value.max_demand_advance = set_value(value, Val(:max_demand_advance), val, Val(:hr))
"""Set [`DemandSideTechnology`](@ref) `demand_energy_efficiency`."""
set_demand_energy_efficiency!(value::DemandSideTechnology, val) = value.demand_energy_efficiency = val
"""Set [`DemandSideTechnology`](@ref) `shift_variable_cost`."""
set_shift_variable_cost!(value::DemandSideTechnology, val) = value.shift_variable_cost = val
"""Set [`DemandSideTechnology`](@ref) `ext`."""
set_ext!(value::DemandSideTechnology, val) = value.ext = val
"""Set [`DemandSideTechnology`](@ref) `internal`."""
set_internal!(value::DemandSideTechnology, val) = value.internal = val

function serialize_openapi_struct(technology::DemandSideTechnology{T}, vals...) where T <: PSY.StaticInjection
    base_struct = APIServer.DemandSideTechnology(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:DemandSideTechnology}, vals::Dict)
    return IS.deserialize_struct(APIServer.DemandSideTechnology, vals)
end
