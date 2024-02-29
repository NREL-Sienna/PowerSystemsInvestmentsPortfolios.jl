struct SupplyTechnology{T <: PSY.Device} <: IS.Component
    name::String
    power_systems_type::Type{T}
    fuel::PSY.ThermalFuels
    prime_mover::PSY.Primer_mover
    capacity_factor::Float64
    capital_cost::Float64
    operational_cost::PSY.OperationalCost
    ext::Dict{String, Any}
    time_series_container::InfrastructureSystems.TimeSeriesContainer
    internal::InfrastructureSystemsInternal
end
