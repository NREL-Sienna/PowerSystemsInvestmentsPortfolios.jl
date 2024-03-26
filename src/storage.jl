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
