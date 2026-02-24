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

abstract type ResourceTechnology <: Technology end
abstract type TransmissionTechnology <: Technology end
abstract type DemandTechnology <: Technology end

get_name(val::Technology) = val.name
get_available(val::Technology) = val.available
get_power_systems_type(val::Technology) = val.power_systems_type
get_internal(val::Technology) = val.internal
get_ext(val::Technology) = get_ext(get_internal(val))
get_time_series_container(val::Technology) = val.time_series_container
get_supplemental_attributes_container(val::Technology) =
    val.supplemental_attributes_container
supports_time_series(::Technology) = true
supports_requirements(::Technology) = true

"""
Return true if the requirement is attached to the Technology.
"""
function has_requirement(technology::Technology, requirement::Requirement)
    for _requirement in get_requirements(technology)
        if IS.get_uuid(_requirement) == IS.get_uuid(requirement)
            return true
        end
    end

    return false
end
