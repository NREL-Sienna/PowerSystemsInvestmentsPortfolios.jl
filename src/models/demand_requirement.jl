struct DemandRequirement{T <: PSY.StaticInjection}
    name::String
    available::Bool
    power_systems_type::Type{T}
    region::Union{PSY.ACBus, PSY.AggregationTopology}
    supplemental_attributes_container::IS.SupplementalAttributesContainer
    time_series_container::IS.TimeSeriesContainer
    internal::InfrastructureSystemsInternal
end
