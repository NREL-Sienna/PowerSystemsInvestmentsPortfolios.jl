struct SupplyTechnology{T <: PSY.Generator} <: Technology
    name::String
    available::Bool
    power_systems_type::Type{T}
    fuel::PSY.ThermalFuels
    prime_mover::PSY.PrimeMovers
    capacity_factor::Float64
    capital_cost::IS.FunctionData
    operational_cost::PSY.OperationalCost
    supplemental_attributes_container::IS.SupplementalAttributesContainer
    time_series_container::IS.TimeSeriesContainer
    internal::InfrastructureSystemsInternal
end
