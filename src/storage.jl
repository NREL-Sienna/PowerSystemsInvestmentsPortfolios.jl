struct StorageTechnology{T <: PSY.Storage} <: Technology
    name::String
    available::Bool
    power_systems_type::Type{T}
    capital_cost::IS.FunctionData
    battery_chemistry::String # Implement Chemistry Type Enums in PowerSystems
    prime_mover::PSY.PrimeMovers
    operational_cost::PSY.OperationalCost
    supplemental_attributes_container::IS.SupplementalAttributesContainer
    time_series_container::IS.TimeSeriesContainer
    internal::InfrastructureSystemsInternal
end

get_name(technology::StorageTechnology) = technology.name
get_available(technology::StorageTechnology) = technology.available
get_power_systems_type(technology::StorageTechnology) = technology.power_systems_type
get_capital_cost(technology::StorageTechnology) = technology.capital_cost
get_battery_chemistry(technology::StorageTechnology) = technology.battery_chemistry
get_operational_cost(technology::StorageTechnology) = technology.operational_cost

set_name!(technology::StorageTechnology, v::AbstractString) = technology.name = v
set_available!(technology::StorageTechnology, v::Bool) = technology.available = v
set_power_systems_type!(technology::StorageTechnology, v::Type) = technology.power_systems_type = v
set_capital_cost!(technology::StorageTechnology, v::IS.FunctionData) = technology.capital_cost = v
set_battery_chemistry!(technology::StorageTechnology, v::String) = technology.battery_chemistry = v
set_operational_cost!(technology::StorageTechnology, v::PSY.OperationalCost) = technology.operational_cost = v