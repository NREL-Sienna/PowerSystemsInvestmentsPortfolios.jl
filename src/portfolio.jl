struct Portfolio <: IS.InfrastructureSystemsType
    aggregation::Type{<: Union{PSY.ACBus, PSY.AggregationTopology}}
    discount_rate::Float64
    data::IS.SystemData
    time_series_container::InfrastructureSystems.TimeSeriesContainer
end
