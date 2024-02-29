"""
Required fields for a technology Type
- name
- available
- power_systems_type
- time_series_container
- internal
"""
abstract type Technology <: IS.InfrastructureSystemsComponent end

get_name(val::Technology) = val.name
get_available(val::Technology) = val.available
get_power_systems_type(val::Technology) = val.power_systems_type
get_internal(val::Technology) = val.internal
get_ext(val::Technology) = get_ext(get_internal(val))
get_name(val::Technology) = val.name
