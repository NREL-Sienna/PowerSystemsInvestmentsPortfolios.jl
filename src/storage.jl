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

"""
Clearing the time series for a storage device
"""
function clear_time_series_storage!(component::StorageTechnology)
    return IS.clear_time_series_storage!(component)
end


"""
Setting the time series for a storage device
"""
function set_time_series_storage!(
    component::StorageTechnology,
    storage::Union{Nothing, TimeSeriesStorage},
)
    return IS.set_time_series_storage!(component, storage)
end

"""
Getting the time series for a storage device
"""
function _get_time_series_storage(component::StorageTechnology)
    return IS._get_time_series_storage(component)
end