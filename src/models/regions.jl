"""
abstract type to represent regions for the CEM.

Required fields for a Region Type

  - name
  - id
  - time_series_container
  - supplemental_attributes_container
  - internal
"""
abstract type Region <: IS.InfrastructureSystemsComponent end

get_name(val::Region) = val.name
get_id(val::Region) = val.id
get_internal(val::Region) = val.internal
get_ext(val::Region) = get_ext(get_internal(val))
get_time_series_container(val::Region) = val.time_series_container
get_supplemental_attributes_container(val::Region) =
    val.supplemental_attributes_container
supports_time_series(::Region) = true
