#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct ColocatedSupplyStorageTechnology{T <: PSY.Generator} <: ResourceTechnology
        base_power::Float64
        operation_costs_power::PSY.OperationalCost
        lifetime_storage::Int
        available::Bool
        operation_costs_solar::PSY.OperationalCost
        capacity_limits_wind::MinMax
        name::String
        capital_costs_power::PSY.ValueCurve
        capacity_power_limits::MinMax
        lifetime_wind::Int
        capacity_energy_limits::MinMax
        duration_limits::MinMax
        min_inverter_capacity::Float64
        id::Int64
        operation_costs_energy::PSY.OperationalCost
        capital_costs_energy::PSY.ValueCurve
        operation_costs_inverter::PSY.OperationalCost
        financial_data::TechnologyFinancialData
        inverter_efficiency::Float64
        power_systems_type::String
        capacity_limits_solar::MinMax
        internal::InfrastructureSystemsInternal
        operation_costs_wind::PSY.OperationalCost
        efficiency_storage::InOut
        ext::Dict
        region::Vector{RegionTopology}
        losses_storage::Float64
        inverter_supply_ratio::Float64
        capital_costs_wind::PSY.ValueCurve
        lifetime_solar::Int
        capital_costs_inverter::PSY.ValueCurve
        max_inverter_capacity::Float64
        capital_costs_solar::PSY.ValueCurve
    end

Supply Technology that supports a StorageTechnology co-located with wind and solar generation

# Arguments
- `base_power::Float64`: Base power
- `operation_costs_power::PSY.OperationalCost`: (default: `StorageCost()`) Fixed and variable O&M costs for a storage technology
- `lifetime_storage::Int`: (default: `100`) Maximum number of years a technology can be active once installed
- `available::Bool`: (default: `True`) Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `operation_costs_solar::PSY.OperationalCost`: (default: `ThermalGenerationCost()`) Fixed and variable O&M costs for a technology
- `capacity_limits_wind::MinMax`: (default: `(min=0, max=1e8)`) Maximum allowable installed capacity for a technology
- `name::String`: The technology name
- `capital_costs_power::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a storage technology's charge/discharge capacity.
- `capacity_power_limits::MinMax`: (default: `(min=0,max=1e8)`) allowable installed power capacity for a storage technology
- `lifetime_wind::Int`: (default: `100`) Maximum number of years a technology can be active once installed
- `capacity_energy_limits::MinMax`: (default: `(min=0,max=1e8)`) allowable installed energy capacity for a storage technology
- `duration_limits::MinMax`: (default: `(min=0,max=1000)`) Minimum required durattion for a storage technology
- `min_inverter_capacity::Float64`: (default: `1e8`) Minimum inverter capacity (MW)
- `id::Int64`: ID for individual generator
- `operation_costs_energy::PSY.OperationalCost`: (default: `StorageCost()`) Fixed and variable O&M costs for a storage technology
- `capital_costs_energy::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a storage technology's energy capacity.
- `operation_costs_inverter::PSY.OperationalCost`: Operational costs for using inverter in co-located systems
- `financial_data::TechnologyFinancialData`: Struct containing relevant financial information for a technology
- `inverter_efficiency::Float64`: Efficiency of AC to DC conversion of inverter
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `capacity_limits_solar::MinMax`: (default: `(min=0, max=1e8)`) Maximum allowable installed capacity for a technology
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `operation_costs_wind::PSY.OperationalCost`: (default: `ThermalGenerationCost()`) Fixed and variable O&M costs for a technology
- `efficiency_storage::InOut`: (default: `(in=1, out=1)`) Efficiency of charging storage
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `region::Vector{RegionTopology}`: (default: `Vector()`) Zone where tech operates in
- `losses_storage::Float64`: (default: `1.0`) Power loss (pct per hour)
- `inverter_supply_ratio::Float64`: Ratio of generation capacity to grid connection capacity
- `capital_costs_wind::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a technology.
- `lifetime_solar::Int`: (default: `100`) Maximum number of years a technology can be active once installed
- `capital_costs_inverter::PSY.ValueCurve`: Capitals costs for investing in inverter capacity
- `max_inverter_capacity::Float64`: (default: `1e8`) Limit on inverter capacity (MW)
- `capital_costs_solar::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a technology.
"""
mutable struct ColocatedSupplyStorageTechnology{T <: PSY.Generator} <: ResourceTechnology
    "Base power"
    base_power::Float64
    "Fixed and variable O&M costs for a storage technology"
    operation_costs_power::PSY.OperationalCost
    "Maximum number of years a technology can be active once installed"
    lifetime_storage::Int
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
    "Fixed and variable O&M costs for a technology"
    operation_costs_solar::PSY.OperationalCost
    "Maximum allowable installed capacity for a technology"
    capacity_limits_wind::MinMax
    "The technology name"
    name::String
    "Capital costs for investing in a storage technology's charge/discharge capacity."
    capital_costs_power::PSY.ValueCurve
    "allowable installed power capacity for a storage technology"
    capacity_power_limits::MinMax
    "Maximum number of years a technology can be active once installed"
    lifetime_wind::Int
    "allowable installed energy capacity for a storage technology"
    capacity_energy_limits::MinMax
    "Minimum required durattion for a storage technology"
    duration_limits::MinMax
    "Minimum inverter capacity (MW)"
    min_inverter_capacity::Float64
    "ID for individual generator"
    id::Int64
    "Fixed and variable O&M costs for a storage technology"
    operation_costs_energy::PSY.OperationalCost
    "Capital costs for investing in a storage technology's energy capacity."
    capital_costs_energy::PSY.ValueCurve
    "Operational costs for using inverter in co-located systems"
    operation_costs_inverter::PSY.OperationalCost
    "Struct containing relevant financial information for a technology"
    financial_data::TechnologyFinancialData
    "Efficiency of AC to DC conversion of inverter"
    inverter_efficiency::Float64
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Maximum allowable installed capacity for a technology"
    capacity_limits_solar::MinMax
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Fixed and variable O&M costs for a technology"
    operation_costs_wind::PSY.OperationalCost
    "Efficiency of charging storage"
    efficiency_storage::InOut
    "Option for providing additional data"
    ext::Dict
    "Zone where tech operates in"
    region::Vector{RegionTopology}
    "Power loss (pct per hour)"
    losses_storage::Float64
    "Ratio of generation capacity to grid connection capacity"
    inverter_supply_ratio::Float64
    "Capital costs for investing in a technology."
    capital_costs_wind::PSY.ValueCurve
    "Maximum number of years a technology can be active once installed"
    lifetime_solar::Int
    "Capitals costs for investing in inverter capacity"
    capital_costs_inverter::PSY.ValueCurve
    "Limit on inverter capacity (MW)"
    max_inverter_capacity::Float64
    "Capital costs for investing in a technology."
    capital_costs_solar::PSY.ValueCurve
end


function ColocatedSupplyStorageTechnology{T}(; base_power, operation_costs_power=StorageCost(), lifetime_storage=100, available=True, operation_costs_solar=ThermalGenerationCost(), capacity_limits_wind=(min=0, max=1e8), name, capital_costs_power=LinearCurve(0.0), capacity_power_limits=(min=0,max=1e8), lifetime_wind=100, capacity_energy_limits=(min=0,max=1e8), duration_limits=(min=0,max=1000), min_inverter_capacity=1e8, id, operation_costs_energy=StorageCost(), capital_costs_energy=LinearCurve(0.0), operation_costs_inverter, financial_data, inverter_efficiency, power_systems_type, capacity_limits_solar=(min=0, max=1e8), internal=InfrastructureSystemsInternal(), operation_costs_wind=ThermalGenerationCost(), efficiency_storage=(in=1, out=1), ext=Dict(), region=Vector(), losses_storage=1.0, inverter_supply_ratio, capital_costs_wind=LinearCurve(0.0), lifetime_solar=100, capital_costs_inverter, max_inverter_capacity=1e8, capital_costs_solar=LinearCurve(0.0), ) where T <: PSY.Generator
    ColocatedSupplyStorageTechnology{T}(base_power, operation_costs_power, lifetime_storage, available, operation_costs_solar, capacity_limits_wind, name, capital_costs_power, capacity_power_limits, lifetime_wind, capacity_energy_limits, duration_limits, min_inverter_capacity, id, operation_costs_energy, capital_costs_energy, operation_costs_inverter, financial_data, inverter_efficiency, power_systems_type, capacity_limits_solar, internal, operation_costs_wind, efficiency_storage, ext, region, losses_storage, inverter_supply_ratio, capital_costs_wind, lifetime_solar, capital_costs_inverter, max_inverter_capacity, capital_costs_solar, )
end

"""Get [`ColocatedSupplyStorageTechnology`](@ref) `base_power`."""
get_base_power(value::ColocatedSupplyStorageTechnology) = value.base_power
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_power`."""
get_operation_costs_power(value::ColocatedSupplyStorageTechnology) = value.operation_costs_power
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `lifetime_storage`."""
get_lifetime_storage(value::ColocatedSupplyStorageTechnology) = value.lifetime_storage
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `available`."""
get_available(value::ColocatedSupplyStorageTechnology) = value.available
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_solar`."""
get_operation_costs_solar(value::ColocatedSupplyStorageTechnology) = value.operation_costs_solar
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capacity_limits_wind`."""
get_capacity_limits_wind(value::ColocatedSupplyStorageTechnology) = value.capacity_limits_wind
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `name`."""
get_name(value::ColocatedSupplyStorageTechnology) = value.name
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_power`."""
get_capital_costs_power(value::ColocatedSupplyStorageTechnology) = value.capital_costs_power
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capacity_power_limits`."""
get_capacity_power_limits(value::ColocatedSupplyStorageTechnology) = value.capacity_power_limits
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `lifetime_wind`."""
get_lifetime_wind(value::ColocatedSupplyStorageTechnology) = value.lifetime_wind
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capacity_energy_limits`."""
get_capacity_energy_limits(value::ColocatedSupplyStorageTechnology) = value.capacity_energy_limits
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `duration_limits`."""
get_duration_limits(value::ColocatedSupplyStorageTechnology) = value.duration_limits
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `min_inverter_capacity`."""
get_min_inverter_capacity(value::ColocatedSupplyStorageTechnology) = value.min_inverter_capacity
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `id`."""
get_id(value::ColocatedSupplyStorageTechnology) = value.id
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_energy`."""
get_operation_costs_energy(value::ColocatedSupplyStorageTechnology) = value.operation_costs_energy
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_energy`."""
get_capital_costs_energy(value::ColocatedSupplyStorageTechnology) = value.capital_costs_energy
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_inverter`."""
get_operation_costs_inverter(value::ColocatedSupplyStorageTechnology) = value.operation_costs_inverter
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `financial_data`."""
get_financial_data(value::ColocatedSupplyStorageTechnology) = value.financial_data
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `inverter_efficiency`."""
get_inverter_efficiency(value::ColocatedSupplyStorageTechnology) = value.inverter_efficiency
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::ColocatedSupplyStorageTechnology) = value.power_systems_type
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capacity_limits_solar`."""
get_capacity_limits_solar(value::ColocatedSupplyStorageTechnology) = value.capacity_limits_solar
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `internal`."""
get_internal(value::ColocatedSupplyStorageTechnology) = value.internal
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_wind`."""
get_operation_costs_wind(value::ColocatedSupplyStorageTechnology) = value.operation_costs_wind
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `efficiency_storage`."""
get_efficiency_storage(value::ColocatedSupplyStorageTechnology) = value.efficiency_storage
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `ext`."""
get_ext(value::ColocatedSupplyStorageTechnology) = value.ext
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `region`."""
get_region(value::ColocatedSupplyStorageTechnology) = value.region
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `losses_storage`."""
get_losses_storage(value::ColocatedSupplyStorageTechnology) = value.losses_storage
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `inverter_supply_ratio`."""
get_inverter_supply_ratio(value::ColocatedSupplyStorageTechnology) = value.inverter_supply_ratio
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_wind`."""
get_capital_costs_wind(value::ColocatedSupplyStorageTechnology) = value.capital_costs_wind
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `lifetime_solar`."""
get_lifetime_solar(value::ColocatedSupplyStorageTechnology) = value.lifetime_solar
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_inverter`."""
get_capital_costs_inverter(value::ColocatedSupplyStorageTechnology) = value.capital_costs_inverter
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `max_inverter_capacity`."""
get_max_inverter_capacity(value::ColocatedSupplyStorageTechnology) = value.max_inverter_capacity
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_solar`."""
get_capital_costs_solar(value::ColocatedSupplyStorageTechnology) = value.capital_costs_solar

"""Set [`ColocatedSupplyStorageTechnology`](@ref) `base_power`."""
set_base_power!(value::ColocatedSupplyStorageTechnology, val) = value.base_power = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_power`."""
set_operation_costs_power!(value::ColocatedSupplyStorageTechnology, val) = value.operation_costs_power = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `lifetime_storage`."""
set_lifetime_storage!(value::ColocatedSupplyStorageTechnology, val) = value.lifetime_storage = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `available`."""
set_available!(value::ColocatedSupplyStorageTechnology, val) = value.available = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_solar`."""
set_operation_costs_solar!(value::ColocatedSupplyStorageTechnology, val) = value.operation_costs_solar = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capacity_limits_wind`."""
set_capacity_limits_wind!(value::ColocatedSupplyStorageTechnology, val) = value.capacity_limits_wind = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `name`."""
set_name!(value::ColocatedSupplyStorageTechnology, val) = value.name = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_power`."""
set_capital_costs_power!(value::ColocatedSupplyStorageTechnology, val) = value.capital_costs_power = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capacity_power_limits`."""
set_capacity_power_limits!(value::ColocatedSupplyStorageTechnology, val) = value.capacity_power_limits = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `lifetime_wind`."""
set_lifetime_wind!(value::ColocatedSupplyStorageTechnology, val) = value.lifetime_wind = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capacity_energy_limits`."""
set_capacity_energy_limits!(value::ColocatedSupplyStorageTechnology, val) = value.capacity_energy_limits = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `duration_limits`."""
set_duration_limits!(value::ColocatedSupplyStorageTechnology, val) = value.duration_limits = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `min_inverter_capacity`."""
set_min_inverter_capacity!(value::ColocatedSupplyStorageTechnology, val) = value.min_inverter_capacity = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `id`."""
set_id!(value::ColocatedSupplyStorageTechnology, val) = value.id = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_energy`."""
set_operation_costs_energy!(value::ColocatedSupplyStorageTechnology, val) = value.operation_costs_energy = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_energy`."""
set_capital_costs_energy!(value::ColocatedSupplyStorageTechnology, val) = value.capital_costs_energy = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_inverter`."""
set_operation_costs_inverter!(value::ColocatedSupplyStorageTechnology, val) = value.operation_costs_inverter = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `financial_data`."""
set_financial_data!(value::ColocatedSupplyStorageTechnology, val) = value.financial_data = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `inverter_efficiency`."""
set_inverter_efficiency!(value::ColocatedSupplyStorageTechnology, val) = value.inverter_efficiency = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::ColocatedSupplyStorageTechnology, val) = value.power_systems_type = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capacity_limits_solar`."""
set_capacity_limits_solar!(value::ColocatedSupplyStorageTechnology, val) = value.capacity_limits_solar = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `internal`."""
set_internal!(value::ColocatedSupplyStorageTechnology, val) = value.internal = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_wind`."""
set_operation_costs_wind!(value::ColocatedSupplyStorageTechnology, val) = value.operation_costs_wind = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `efficiency_storage`."""
set_efficiency_storage!(value::ColocatedSupplyStorageTechnology, val) = value.efficiency_storage = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `ext`."""
set_ext!(value::ColocatedSupplyStorageTechnology, val) = value.ext = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `region`."""
set_region!(value::ColocatedSupplyStorageTechnology, val) = value.region = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `losses_storage`."""
set_losses_storage!(value::ColocatedSupplyStorageTechnology, val) = value.losses_storage = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `inverter_supply_ratio`."""
set_inverter_supply_ratio!(value::ColocatedSupplyStorageTechnology, val) = value.inverter_supply_ratio = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_wind`."""
set_capital_costs_wind!(value::ColocatedSupplyStorageTechnology, val) = value.capital_costs_wind = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `lifetime_solar`."""
set_lifetime_solar!(value::ColocatedSupplyStorageTechnology, val) = value.lifetime_solar = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_inverter`."""
set_capital_costs_inverter!(value::ColocatedSupplyStorageTechnology, val) = value.capital_costs_inverter = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `max_inverter_capacity`."""
set_max_inverter_capacity!(value::ColocatedSupplyStorageTechnology, val) = value.max_inverter_capacity = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_solar`."""
set_capital_costs_solar!(value::ColocatedSupplyStorageTechnology, val) = value.capital_costs_solar = val

function serialize_openapi_struct(technology::ColocatedSupplyStorageTechnology{T}, vals...) where T <: PSY.Generator
    base_struct = APIServer.ColocatedSupplyStorageTechnology(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:ColocatedSupplyStorageTechnology}, vals::Dict)
    return IS.deserialize_struct(APIServer.ColocatedSupplyStorageTechnology, vals)
end
