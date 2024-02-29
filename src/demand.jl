struct DemandTechnology{T <: PSY.StaticInjection} <: Technology
    name::String
    available::Bool
    power_systems_type::Type{T}
    capital_cost::Float64
    time_series_container::InfrastructureSystems.TimeSeriesContainer
    internal::InfrastructureSystemsInternal
end
