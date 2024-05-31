struct TransportTechnology{T <: PSY.Device} <: Technology
    name::String
    available::Bool
    power_systems_type::Type{T}
    capital_cost::IS.FunctionData
    supplemental_attributes_container::IS.SupplementalAttributesContainer
    time_series_container::IS.TimeSeriesContainer
    internal::InfrastructureSystemsInternal
end
