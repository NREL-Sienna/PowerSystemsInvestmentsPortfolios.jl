"""
abstract type to represent spatial aggregations for the CEM.

Required fields for a RegionTopology Type

  - name
  - id
  - time_series_container
  - supplemental_attributes_container
  - internal
"""
abstract type RegionTopology <: IS.InfrastructureSystemsComponent end

get_name(val::RegionTopology) = val.name
get_id(val::RegionTopology) = val.id
get_internal(val::RegionTopology) = val.internal
get_ext(val::RegionTopology) = get_ext(get_internal(val))
get_time_series_container(val::RegionTopology) = val.time_series_container
get_supplemental_attributes_container(val::RegionTopology) = val.supplemental_attributes_container
supports_time_series(::RegionTopology) = true
