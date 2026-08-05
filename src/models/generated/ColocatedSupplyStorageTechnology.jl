#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct ColocatedSupplyStorageTechnology{T <: PSY.Generator} <: ResourceTechnology
        name::String
        power_systems_type::String
        region::Vector{RegionTopology}
        id::Int64
        available::Bool
        capital_costs_solar::PSY.ValueCurve
        operation_costs_solar::PSY.OperationalCost
        capacity_limits_solar::MinMax
        lifetime_solar::Int
        capital_costs_wind::PSY.ValueCurve
        operation_costs_wind::PSY.OperationalCost
        capacity_limits_wind::MinMax
        lifetime_wind::Int
        capital_costs_energy::PSY.ValueCurve
        capital_costs_power::PSY.ValueCurve
        operation_costs_energy::PSY.OperationalCost
        operation_costs_power::PSY.OperationalCost
        capacity_power_limits::MinMax
        capacity_energy_limits::MinMax
        duration_limits::MinMax
        efficiency_storage::InOut
        losses_storage::Float64
        lifetime_storage::Int
        financial_data::TechnologyFinancialData
        max_inverter_capacity::Float64
        min_inverter_capacity::Float64
        capital_costs_inverter::PSY.ValueCurve
        operation_costs_inverter::PSY.OperationalCost
        inverter_efficiency::Float64
        inverter_supply_ratio::Float64
        ext::Dict
        internal::InfrastructureSystemsInternal
    end

Supply Technology that supports a StorageTechnology co-located with wind and solar generation

# Arguments
- `name::String`: The technology name
- `power_systems_type::String`: Corresponding type in PowerSystems.jl to be used in PCM modeling
- `region::Vector{RegionTopology}`: (default: `Vector()`) Zone where tech operates in
- `id::Int64`: ID for individual generator
- `available::Bool`: (default: `True`) Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `capital_costs_solar::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a technology. (USD/MW)
- `operation_costs_solar::PSY.OperationalCost`: (default: `ThermalGenerationCost()`) Fixed and variable O&M costs for a technology
- `capacity_limits_solar::MinMax`: (default: `(min=0, max=1e8)`) Maximum allowable installed capacity for a technology (MW)
- `lifetime_solar::Int`: (default: `100`) Maximum number of years a technology can be active once installed (years)
- `capital_costs_wind::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a technology. (USD/MW)
- `operation_costs_wind::PSY.OperationalCost`: (default: `ThermalGenerationCost()`) Fixed and variable O&M costs for a technology
- `capacity_limits_wind::MinMax`: (default: `(min=0, max=1e8)`) Maximum allowable installed capacity for a technology (MW)
- `lifetime_wind::Int`: (default: `100`) Maximum number of years a technology can be active once installed (years)
- `capital_costs_energy::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a storage technology's energy capacity. (USD/MWh)
- `capital_costs_power::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a storage technology's charge/discharge capacity. (USD/MW)
- `operation_costs_energy::PSY.OperationalCost`: (default: `StorageCost()`) Fixed and variable O&M costs for a storage technology
- `operation_costs_power::PSY.OperationalCost`: (default: `StorageCost()`) Fixed and variable O&M costs for a storage technology
- `capacity_power_limits::MinMax`: (default: `(min=0,max=1e8)`) allowable installed power capacity for a storage technology (MW)
- `capacity_energy_limits::MinMax`: (default: `(min=0,max=1e8)`) allowable installed energy capacity for a storage technology (MWh)
- `duration_limits::MinMax`: (default: `(min=0,max=1000)`) Minimum required durattion for a storage technology (hours)
- `efficiency_storage::InOut`: (default: `(in=1, out=1)`) Efficiency of charging storage (fraction of total charge (in) and discharge (out) capacity
- `losses_storage::Float64`: (default: `0.0`) Power loss (fraction of stored energy per hour)
- `lifetime_storage::Int`: (default: `100`) Maximum number of years a technology can be active once installed (years)
- `financial_data::TechnologyFinancialData`: Struct containing relevant financial information for a technology
- `max_inverter_capacity::Float64`: (default: `1e8`) Limit on inverter capacity (MW)
- `min_inverter_capacity::Float64`: (default: `1e8`) Minimum inverter capacity (MW)
- `capital_costs_inverter::PSY.ValueCurve`: Capitals costs for investing in inverter capacity (USD/MW)
- `operation_costs_inverter::PSY.OperationalCost`: Operational costs for using inverter in co-located systems
- `inverter_efficiency::Float64`: Efficiency of AC to DC conversion of inverter
- `inverter_supply_ratio::Float64`: Ratio of generation capacity to grid connection capacity
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
"""
mutable struct ColocatedSupplyStorageTechnology{T <: PSY.Generator} <: ResourceTechnology
    "The technology name"
    name::String
    "Corresponding type in PowerSystems.jl to be used in PCM modeling"
    power_systems_type::String
    "Zone where tech operates in"
    region::Vector{RegionTopology}
    "ID for individual generator"
    id::Int64
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
    "Capital costs for investing in a technology. (USD/MW)"
    capital_costs_solar::PSY.ValueCurve
    "Fixed and variable O&M costs for a technology"
    operation_costs_solar::PSY.OperationalCost
    "Maximum allowable installed capacity for a technology (MW)"
    capacity_limits_solar::MinMax
    "Maximum number of years a technology can be active once installed (years)"
    lifetime_solar::Int
    "Capital costs for investing in a technology. (USD/MW)"
    capital_costs_wind::PSY.ValueCurve
    "Fixed and variable O&M costs for a technology"
    operation_costs_wind::PSY.OperationalCost
    "Maximum allowable installed capacity for a technology (MW)"
    capacity_limits_wind::MinMax
    "Maximum number of years a technology can be active once installed (years)"
    lifetime_wind::Int
    "Capital costs for investing in a storage technology's energy capacity. (USD/MWh)"
    capital_costs_energy::PSY.ValueCurve
    "Capital costs for investing in a storage technology's charge/discharge capacity. (USD/MW)"
    capital_costs_power::PSY.ValueCurve
    "Fixed and variable O&M costs for a storage technology"
    operation_costs_energy::PSY.OperationalCost
    "Fixed and variable O&M costs for a storage technology"
    operation_costs_power::PSY.OperationalCost
    "allowable installed power capacity for a storage technology (MW)"
    capacity_power_limits::MinMax
    "allowable installed energy capacity for a storage technology (MWh)"
    capacity_energy_limits::MinMax
    "Minimum required durattion for a storage technology (hours)"
    duration_limits::MinMax
    "Efficiency of charging storage (fraction of total charge (in) and discharge (out) capacity"
    efficiency_storage::InOut
    "Power loss (fraction of stored energy per hour)"
    losses_storage::Float64
    "Maximum number of years a technology can be active once installed (years)"
    lifetime_storage::Int
    "Struct containing relevant financial information for a technology"
    financial_data::TechnologyFinancialData
    "Limit on inverter capacity (MW)"
    max_inverter_capacity::Float64
    "Minimum inverter capacity (MW)"
    min_inverter_capacity::Float64
    "Capitals costs for investing in inverter capacity (USD/MW)"
    capital_costs_inverter::PSY.ValueCurve
    "Operational costs for using inverter in co-located systems"
    operation_costs_inverter::PSY.OperationalCost
    "Efficiency of AC to DC conversion of inverter"
    inverter_efficiency::Float64
    "Ratio of generation capacity to grid connection capacity"
    inverter_supply_ratio::Float64
    "Optional dictionary to provide additional data"
    ext::Dict
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
end


function ColocatedSupplyStorageTechnology{T}(; name, power_systems_type, region=Vector(), id, available=True, capital_costs_solar=LinearCurve(0.0), operation_costs_solar=ThermalGenerationCost(), capacity_limits_solar=(min=0, max=1e8), lifetime_solar=100, capital_costs_wind=LinearCurve(0.0), operation_costs_wind=ThermalGenerationCost(), capacity_limits_wind=(min=0, max=1e8), lifetime_wind=100, capital_costs_energy=LinearCurve(0.0), capital_costs_power=LinearCurve(0.0), operation_costs_energy=StorageCost(), operation_costs_power=StorageCost(), capacity_power_limits=(min=0,max=1e8), capacity_energy_limits=(min=0,max=1e8), duration_limits=(min=0,max=1000), efficiency_storage=(in=1, out=1), losses_storage=0.0, lifetime_storage=100, financial_data, max_inverter_capacity=1e8, min_inverter_capacity=1e8, capital_costs_inverter, operation_costs_inverter, inverter_efficiency, inverter_supply_ratio, ext=Dict(), internal=InfrastructureSystemsInternal(), ) where T <: PSY.Generator
    ColocatedSupplyStorageTechnology{T}(name, power_systems_type, region, id, available, capital_costs_solar, operation_costs_solar, capacity_limits_solar, lifetime_solar, capital_costs_wind, operation_costs_wind, capacity_limits_wind, lifetime_wind, capital_costs_energy, capital_costs_power, operation_costs_energy, operation_costs_power, capacity_power_limits, capacity_energy_limits, duration_limits, efficiency_storage, losses_storage, lifetime_storage, financial_data, max_inverter_capacity, min_inverter_capacity, capital_costs_inverter, operation_costs_inverter, inverter_efficiency, inverter_supply_ratio, ext, internal, )
end

"""Get [`ColocatedSupplyStorageTechnology`](@ref) `name`."""
get_name(value::ColocatedSupplyStorageTechnology) = value.name
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::ColocatedSupplyStorageTechnology) = value.power_systems_type
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `region`."""
get_region(value::ColocatedSupplyStorageTechnology) = value.region
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `id`."""
get_id(value::ColocatedSupplyStorageTechnology) = value.id
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `available`."""
get_available(value::ColocatedSupplyStorageTechnology) = value.available
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_solar`."""
get_capital_costs_solar(value::ColocatedSupplyStorageTechnology) = value.capital_costs_solar
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_solar`."""
get_operation_costs_solar(value::ColocatedSupplyStorageTechnology) = value.operation_costs_solar
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capacity_limits_solar`."""
get_capacity_limits_solar(value::ColocatedSupplyStorageTechnology) = value.capacity_limits_solar
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `lifetime_solar`."""
get_lifetime_solar(value::ColocatedSupplyStorageTechnology) = value.lifetime_solar
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_wind`."""
get_capital_costs_wind(value::ColocatedSupplyStorageTechnology) = value.capital_costs_wind
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_wind`."""
get_operation_costs_wind(value::ColocatedSupplyStorageTechnology) = value.operation_costs_wind
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capacity_limits_wind`."""
get_capacity_limits_wind(value::ColocatedSupplyStorageTechnology) = value.capacity_limits_wind
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `lifetime_wind`."""
get_lifetime_wind(value::ColocatedSupplyStorageTechnology) = value.lifetime_wind
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_energy`."""
get_capital_costs_energy(value::ColocatedSupplyStorageTechnology) = value.capital_costs_energy
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_power`."""
get_capital_costs_power(value::ColocatedSupplyStorageTechnology) = value.capital_costs_power
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_energy`."""
get_operation_costs_energy(value::ColocatedSupplyStorageTechnology) = value.operation_costs_energy
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_power`."""
get_operation_costs_power(value::ColocatedSupplyStorageTechnology) = value.operation_costs_power
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capacity_power_limits`."""
get_capacity_power_limits(value::ColocatedSupplyStorageTechnology) = value.capacity_power_limits
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capacity_energy_limits`."""
get_capacity_energy_limits(value::ColocatedSupplyStorageTechnology) = value.capacity_energy_limits
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `duration_limits`."""
get_duration_limits(value::ColocatedSupplyStorageTechnology) = value.duration_limits
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `efficiency_storage`."""
get_efficiency_storage(value::ColocatedSupplyStorageTechnology) = value.efficiency_storage
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `losses_storage`."""
get_losses_storage(value::ColocatedSupplyStorageTechnology) = value.losses_storage
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `lifetime_storage`."""
get_lifetime_storage(value::ColocatedSupplyStorageTechnology) = value.lifetime_storage
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `financial_data`."""
get_financial_data(value::ColocatedSupplyStorageTechnology) = value.financial_data
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `max_inverter_capacity`."""
get_max_inverter_capacity(value::ColocatedSupplyStorageTechnology) = value.max_inverter_capacity
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `min_inverter_capacity`."""
get_min_inverter_capacity(value::ColocatedSupplyStorageTechnology) = value.min_inverter_capacity
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_inverter`."""
get_capital_costs_inverter(value::ColocatedSupplyStorageTechnology) = value.capital_costs_inverter
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_inverter`."""
get_operation_costs_inverter(value::ColocatedSupplyStorageTechnology) = value.operation_costs_inverter
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `inverter_efficiency`."""
get_inverter_efficiency(value::ColocatedSupplyStorageTechnology) = value.inverter_efficiency
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `inverter_supply_ratio`."""
get_inverter_supply_ratio(value::ColocatedSupplyStorageTechnology) = value.inverter_supply_ratio
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `ext`."""
get_ext(value::ColocatedSupplyStorageTechnology) = value.ext
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `internal`."""
get_internal(value::ColocatedSupplyStorageTechnology) = value.internal

"""Set [`ColocatedSupplyStorageTechnology`](@ref) `name`."""
set_name!(value::ColocatedSupplyStorageTechnology, val) = value.name = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::ColocatedSupplyStorageTechnology, val) = value.power_systems_type = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `region`."""
set_region!(value::ColocatedSupplyStorageTechnology, val) = value.region = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `id`."""
set_id!(value::ColocatedSupplyStorageTechnology, val) = value.id = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `available`."""
set_available!(value::ColocatedSupplyStorageTechnology, val) = value.available = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_solar`."""
set_capital_costs_solar!(value::ColocatedSupplyStorageTechnology, val) = value.capital_costs_solar = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_solar`."""
set_operation_costs_solar!(value::ColocatedSupplyStorageTechnology, val) = value.operation_costs_solar = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capacity_limits_solar`."""
set_capacity_limits_solar!(value::ColocatedSupplyStorageTechnology, val) = value.capacity_limits_solar = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `lifetime_solar`."""
set_lifetime_solar!(value::ColocatedSupplyStorageTechnology, val) = value.lifetime_solar = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_wind`."""
set_capital_costs_wind!(value::ColocatedSupplyStorageTechnology, val) = value.capital_costs_wind = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_wind`."""
set_operation_costs_wind!(value::ColocatedSupplyStorageTechnology, val) = value.operation_costs_wind = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capacity_limits_wind`."""
set_capacity_limits_wind!(value::ColocatedSupplyStorageTechnology, val) = value.capacity_limits_wind = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `lifetime_wind`."""
set_lifetime_wind!(value::ColocatedSupplyStorageTechnology, val) = value.lifetime_wind = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_energy`."""
set_capital_costs_energy!(value::ColocatedSupplyStorageTechnology, val) = value.capital_costs_energy = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_power`."""
set_capital_costs_power!(value::ColocatedSupplyStorageTechnology, val) = value.capital_costs_power = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_energy`."""
set_operation_costs_energy!(value::ColocatedSupplyStorageTechnology, val) = value.operation_costs_energy = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_power`."""
set_operation_costs_power!(value::ColocatedSupplyStorageTechnology, val) = value.operation_costs_power = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capacity_power_limits`."""
set_capacity_power_limits!(value::ColocatedSupplyStorageTechnology, val) = value.capacity_power_limits = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capacity_energy_limits`."""
set_capacity_energy_limits!(value::ColocatedSupplyStorageTechnology, val) = value.capacity_energy_limits = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `duration_limits`."""
set_duration_limits!(value::ColocatedSupplyStorageTechnology, val) = value.duration_limits = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `efficiency_storage`."""
set_efficiency_storage!(value::ColocatedSupplyStorageTechnology, val) = value.efficiency_storage = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `losses_storage`."""
set_losses_storage!(value::ColocatedSupplyStorageTechnology, val) = value.losses_storage = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `lifetime_storage`."""
set_lifetime_storage!(value::ColocatedSupplyStorageTechnology, val) = value.lifetime_storage = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `financial_data`."""
set_financial_data!(value::ColocatedSupplyStorageTechnology, val) = value.financial_data = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `max_inverter_capacity`."""
set_max_inverter_capacity!(value::ColocatedSupplyStorageTechnology, val) = value.max_inverter_capacity = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `min_inverter_capacity`."""
set_min_inverter_capacity!(value::ColocatedSupplyStorageTechnology, val) = value.min_inverter_capacity = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_inverter`."""
set_capital_costs_inverter!(value::ColocatedSupplyStorageTechnology, val) = value.capital_costs_inverter = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_inverter`."""
set_operation_costs_inverter!(value::ColocatedSupplyStorageTechnology, val) = value.operation_costs_inverter = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `inverter_efficiency`."""
set_inverter_efficiency!(value::ColocatedSupplyStorageTechnology, val) = value.inverter_efficiency = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `inverter_supply_ratio`."""
set_inverter_supply_ratio!(value::ColocatedSupplyStorageTechnology, val) = value.inverter_supply_ratio = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `ext`."""
set_ext!(value::ColocatedSupplyStorageTechnology, val) = value.ext = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `internal`."""
set_internal!(value::ColocatedSupplyStorageTechnology, val) = value.internal = val


function serialize_openapi_struct(technology::ColocatedSupplyStorageTechnology{T}, vals...) where T <: PSY.Generator
    base_struct = APIServer.ColocatedSupplyStorageTechnology(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:ColocatedSupplyStorageTechnology}, vals::Dict)
    return IS.deserialize_struct(APIServer.ColocatedSupplyStorageTechnology, vals)
end
