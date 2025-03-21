#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandSideTechnology{T <: PSY.StaticInjection} <: Technology
        price_per_unit::PSY.ValueCurve
        variable_cost_per_mwh::PSY.ValueCurve
        available::Bool
        name::String
        curtailment_cost::PSY.ValueCurve
        id::Int64
        technology_efficiency::Float64
        max_demand_advance::Float64
        demand_energy_efficiency::Float64
        max_demand_curtailment::Float64
        max_demand_delay::Float64
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        ext::Dict
        region::Union{Nothing, Vector{Region}}
        min_power::Float64
    end



# Arguments
- `price_per_unit::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Price or value per unit of output. Ex: USD per ton of hydrogen for electrolyzers
- `variable_cost_per_mwh::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Variable operations and maintenance costs associated with flexible demand deferral
- `available::Bool`: identifies whether the technology is available
- `name::String`: The technology name
- `curtailment_cost::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Energy cost of curtailed output, USD per Mwh
- `id::Int64`: ID for demand side technology
- `technology_efficiency::Float64`: (default: `0.0`) MWh of electricity per unit of output. Ex: MWh per ton of hydrogen for electrolyzers
- `max_demand_advance::Float64`: (default: `0.0`) Maximum number of hours that demand can be scheduled in advance of the original schedule (hours).
- `demand_energy_efficiency::Float64`: (default: `0.0`) Energy efficiency associated with time shifting demand. Represents energy losses due to time shifting
- `max_demand_curtailment::Float64`: (default: `0.0`) Maximum fraction of demand that can be curtailed
- `max_demand_delay::Float64`: (default: `0.0`) Maximum number of hours that demand can be deferred or delayed (hours).
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `region::Union{Nothing, Vector{Region}}`: (default: `Vector()`) Region
- `min_power::Float64`: (default: `0.0`) Minimum operation of demandside unit as a fraction of total capacity
"""
mutable struct DemandSideTechnology{T <: PSY.StaticInjection} <: Technology
    "Price or value per unit of output. Ex: USD per ton of hydrogen for electrolyzers"
    price_per_unit::PSY.ValueCurve
    "Variable operations and maintenance costs associated with flexible demand deferral"
    variable_cost_per_mwh::PSY.ValueCurve
    "identifies whether the technology is available"
    available::Bool
    "The technology name"
    name::String
    "Energy cost of curtailed output, USD per Mwh"
    curtailment_cost::PSY.ValueCurve
    "ID for demand side technology"
    id::Int64
    "MWh of electricity per unit of output. Ex: MWh per ton of hydrogen for electrolyzers"
    technology_efficiency::Float64
    "Maximum number of hours that demand can be scheduled in advance of the original schedule (hours)."
    max_demand_advance::Float64
    "Energy efficiency associated with time shifting demand. Represents energy losses due to time shifting"
    demand_energy_efficiency::Float64
    "Maximum fraction of demand that can be curtailed"
    max_demand_curtailment::Float64
    "Maximum number of hours that demand can be deferred or delayed (hours)."
    max_demand_delay::Float64
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Region"
    region::Union{Nothing, Vector{Region}}
    "Minimum operation of demandside unit as a fraction of total capacity"
    min_power::Float64
end


function DemandSideTechnology{T}(; price_per_unit=LinearCurve(0.0), variable_cost_per_mwh=LinearCurve(0.0), available, name, curtailment_cost=LinearCurve(0.0), id, technology_efficiency=0.0, max_demand_advance=0.0, demand_energy_efficiency=0.0, max_demand_curtailment=0.0, max_demand_delay=0.0, power_systems_type, internal=InfrastructureSystemsInternal(), ext=Dict(), region=Vector(), min_power=0.0, ) where T <: PSY.StaticInjection
    DemandSideTechnology{T}(price_per_unit, variable_cost_per_mwh, available, name, curtailment_cost, id, technology_efficiency, max_demand_advance, demand_energy_efficiency, max_demand_curtailment, max_demand_delay, power_systems_type, internal, ext, region, min_power, )
end

"""Get [`DemandSideTechnology`](@ref) `price_per_unit`."""
get_price_per_unit(value::DemandSideTechnology) = value.price_per_unit
"""Get [`DemandSideTechnology`](@ref) `variable_cost_per_mwh`."""
get_variable_cost_per_mwh(value::DemandSideTechnology) = value.variable_cost_per_mwh
"""Get [`DemandSideTechnology`](@ref) `available`."""
get_available(value::DemandSideTechnology) = value.available
"""Get [`DemandSideTechnology`](@ref) `name`."""
get_name(value::DemandSideTechnology) = value.name
"""Get [`DemandSideTechnology`](@ref) `curtailment_cost`."""
get_curtailment_cost(value::DemandSideTechnology) = value.curtailment_cost
"""Get [`DemandSideTechnology`](@ref) `id`."""
get_id(value::DemandSideTechnology) = value.id
"""Get [`DemandSideTechnology`](@ref) `technology_efficiency`."""
get_technology_efficiency(value::DemandSideTechnology) = value.technology_efficiency
"""Get [`DemandSideTechnology`](@ref) `max_demand_advance`."""
get_max_demand_advance(value::DemandSideTechnology) = value.max_demand_advance
"""Get [`DemandSideTechnology`](@ref) `demand_energy_efficiency`."""
get_demand_energy_efficiency(value::DemandSideTechnology) = value.demand_energy_efficiency
"""Get [`DemandSideTechnology`](@ref) `max_demand_curtailment`."""
get_max_demand_curtailment(value::DemandSideTechnology) = value.max_demand_curtailment
"""Get [`DemandSideTechnology`](@ref) `max_demand_delay`."""
get_max_demand_delay(value::DemandSideTechnology) = value.max_demand_delay
"""Get [`DemandSideTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::DemandSideTechnology) = value.power_systems_type
"""Get [`DemandSideTechnology`](@ref) `internal`."""
get_internal(value::DemandSideTechnology) = value.internal
"""Get [`DemandSideTechnology`](@ref) `ext`."""
get_ext(value::DemandSideTechnology) = value.ext
"""Get [`DemandSideTechnology`](@ref) `region`."""
get_region(value::DemandSideTechnology) = value.region
"""Get [`DemandSideTechnology`](@ref) `min_power`."""
get_min_power(value::DemandSideTechnology) = value.min_power

"""Set [`DemandSideTechnology`](@ref) `price_per_unit`."""
set_price_per_unit!(value::DemandSideTechnology, val) = value.price_per_unit = val
"""Set [`DemandSideTechnology`](@ref) `variable_cost_per_mwh`."""
set_variable_cost_per_mwh!(value::DemandSideTechnology, val) = value.variable_cost_per_mwh = val
"""Set [`DemandSideTechnology`](@ref) `available`."""
set_available!(value::DemandSideTechnology, val) = value.available = val
"""Set [`DemandSideTechnology`](@ref) `name`."""
set_name!(value::DemandSideTechnology, val) = value.name = val
"""Set [`DemandSideTechnology`](@ref) `curtailment_cost`."""
set_curtailment_cost!(value::DemandSideTechnology, val) = value.curtailment_cost = val
"""Set [`DemandSideTechnology`](@ref) `id`."""
set_id!(value::DemandSideTechnology, val) = value.id = val
"""Set [`DemandSideTechnology`](@ref) `technology_efficiency`."""
set_technology_efficiency!(value::DemandSideTechnology, val) = value.technology_efficiency = val
"""Set [`DemandSideTechnology`](@ref) `max_demand_advance`."""
set_max_demand_advance!(value::DemandSideTechnology, val) = value.max_demand_advance = val
"""Set [`DemandSideTechnology`](@ref) `demand_energy_efficiency`."""
set_demand_energy_efficiency!(value::DemandSideTechnology, val) = value.demand_energy_efficiency = val
"""Set [`DemandSideTechnology`](@ref) `max_demand_curtailment`."""
set_max_demand_curtailment!(value::DemandSideTechnology, val) = value.max_demand_curtailment = val
"""Set [`DemandSideTechnology`](@ref) `max_demand_delay`."""
set_max_demand_delay!(value::DemandSideTechnology, val) = value.max_demand_delay = val
"""Set [`DemandSideTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::DemandSideTechnology, val) = value.power_systems_type = val
"""Set [`DemandSideTechnology`](@ref) `internal`."""
set_internal!(value::DemandSideTechnology, val) = value.internal = val
"""Set [`DemandSideTechnology`](@ref) `ext`."""
set_ext!(value::DemandSideTechnology, val) = value.ext = val
"""Set [`DemandSideTechnology`](@ref) `region`."""
set_region!(value::DemandSideTechnology, val) = value.region = val
"""Set [`DemandSideTechnology`](@ref) `min_power`."""
set_min_power!(value::DemandSideTechnology, val) = value.min_power = val

function serialize_openapi_struct(technology::DemandSideTechnology{T}, vals...) where T <: PSY.StaticInjection
    base_struct = APIServer.DemandSideTechnology(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:DemandSideTechnology}, vals::Dict)
    return IS.deserialize_struct(APIServer.DemandSideTechnology, vals)
end
