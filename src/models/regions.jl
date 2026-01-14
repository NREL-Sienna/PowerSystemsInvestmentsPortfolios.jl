"""
    RegionTopology

Abstract type to represent spatial aggregations for investment portfolio modeling.

All subtypes must implement the following fields:

  - `name::String`: Unique identifier for the region
  - `id::Int`: Numeric identifier
  - `time_series_container`: Container for time series data
  - `supplemental_attributes_container`: Container for supplemental attributes
  - `internal`: Internal infrastructure systems data

Examples of concrete types include `Zone` and `Node`.
"""
abstract type RegionTopology <: IS.InfrastructureSystemsComponent end

get_name(val::RegionTopology) = val.name
get_id(val::RegionTopology) = val.id
get_internal(val::RegionTopology) = val.internal
get_ext(val::RegionTopology) = get_ext(get_internal(val))
get_time_series_container(val::RegionTopology) = val.time_series_container
get_supplemental_attributes_container(val::RegionTopology) =
    val.supplemental_attributes_container
supports_time_series(::RegionTopology) = true
