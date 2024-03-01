struct StorageTechnology{T <: PSY.Storage} <: Technology
    name::String
    available::Bool
    power_systems_type::Type{T}
    capital_cost::Float64
    battery_chemistry::String # Implement Chemistry Type Enums in PowerSystems
    prime_mover::PSY.Primer_mover
    capital_cost::Float64
    operational_cost::PSY.OperationalCost
    ext::Dict{String, Any}
    supplemental_attributes_container::IS.SupplementalAttributesContainer
    time_series_container::IS.TimeSeriesContainer
    internal::InfrastructureSystemsInternal
end
