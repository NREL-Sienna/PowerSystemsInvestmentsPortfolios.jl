struct TransportTechnology{T <: PSY.Device} <: IS.Component
    name::String
    power_systems_type::Type{T}
    capital_cost::Float64
    ext::Dict{String, Any}
    time_series_container::InfrastructureSystems.TimeSeriesContainer
    internal::InfrastructureSystemsInternal
end
