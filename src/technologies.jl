"""
abstract type to represent technolgies available for investment.

Required fields for a technology Type

  - name
  - available
  - power_systems_type
  - time_series_container
  - supplemental_attributes_container
  - internal
"""
abstract type Technology <: IS.InfrastructureSystemsComponent end

get_name(val::Technology) = val.name
get_available(val::Technology) = val.available
get_power_systems_type(val::Technology) = val.power_systems_type
get_internal(val::Technology) = val.internal
get_ext(val::Technology) = get_ext(get_internal(val))
get_time_series_container(val::Technology) = val.time_series_container
get_supplemental_attributes_container(val::Technology) =
    val.supplemental_attributes_container

set_name!(val::Technology, v::AbstractString) = val.name = v
set_available!(val::Technology, v::Bool) = val.available = v
# set_power_systems_type!(...)
set_internal!(val::Technology, v::IS.InfrastructureSystemsInternal) = val.internal = v
set_ext!(val::Technology, v::Dict{String, Any}) = val.ext = v
# set_time_series_container!(...)
# set_supplemental_attributes_container(...)

"""
Getting a time series by key
"""
function get_time_series_by_key(
    key::TimeSeriesKey,
    component::Technology;
    start_time::Union{Nothing, Dates.DateTime} = nothing,
    len::Union{Nothing, Int} = nothing,
    count::Union{Nothing, Int} = nothing,
)
    return IS.get_time_series_by_key(
        key,
        component,
        start_time=start_time,
        len=len,
        count=count,
    )
end

"""
Returns an iterator of TimeSeriesData instances attached to the component.
"""
function get_time_series_multiple(
    component::Technology,
    filter_func = nothing;
    type = nothing,
    start_time = nothing,
    name = nothing,
)
    return IS.get_time_series_multiple(
        component,
        filter_func;
        type=type,
        start_time=start_time,
        name=name,
    )
end

"""
Returns an iterator of TimeSeriesData instances attached to the component.
"""
function get_time_series_multiple(
    ::Type{TimeSeriesMetadata},
    component::Technology,
)
    return IS.get_time_series_multiple(component, TimeSeriesMetadata)
end

"""
Returns the TimeSeriesData instance with the metadata that's attached to the component.
"""
function get_time_series_with_metadata_multiple(
    component::Technology,
    filter_func = nothing;
    type = nothing,
    start_time = nothing,
    name = nothing,
)
    return IS.get_time_series_with_metadata_multiple(
        component,
        filter_func;
        type=type,
        start_time=start_time,
        name=name,
    )
end

"""
Transform all instances of SingleTimeSeries to DeterministicSingleTimeSeries. Do nothing
if the component does not contain any instances.

All required checks must have been completed by the caller.

Return true if a transformation occurs.
"""
function transform_single_time_series_internal!(
    component::Technology,
    ::Type{T},
    params::TimeSeriesParameters,
) where {T <: DeterministicSingleTimeSeries}
    return IS.transform_single_time_series_internal!(component, T, params)
end

"""
Method to get the time series transformed parameters
"""
function get_single_time_series_transformed_parameters(
    component::Technology,
    ::Type{T},
    horizon::Int,
    interval::Dates.Period,
) where {T <: Forecast}
    return IS.get_single_time_series_transformed_parameters(component, T, horizon, interval)
end

"""
Get method for transformed parameters from metadata instead
"""
function _get_single_time_series_transformed_parameters(
    ts_metadata::SingleTimeSeriesMetadata,
    ::Type{T},
    horizon::Int,
    interval::Dates.Period,
) where {T <: Forecast}
    return IS._get_single_time_series_transformed_parameters(ts_metadata, T, horizon, interval)
end