struct StorageTechnology{T <: PSY.Storage} <: Technology
    name::String
    power_systems_type::Type{T}
    capital_cost::Float64
    battery_chemistry::String # Implement Chemistry Type Enums in PowerSystems
    prime_mover::PSY.Primer_mover
    capital_cost::Float64
    operational_cost::PSY.OperationalCost
    ext::Dict{String, Any}
    time_series_container::InfrastructureSystems.TimeSeriesContainer
    internal::InfrastructureSystemsInternal
end
