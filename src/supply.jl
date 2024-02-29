struct SupplyTechnology{T <: PSY.Generator} <: Technology
    name::String
    available::Bool
    power_systems_type::Type{T}
    fuel::PSY.ThermalFuels
    prime_mover::PSY.Primer_mover
    capacity_factor::Float64
    capital_cost::Float64
    operational_cost::PSY.OperationalCost
    time_series_container::InfrastructureSystems.TimeSeriesContainer
    internal::InfrastructureSystemsInternal
end
