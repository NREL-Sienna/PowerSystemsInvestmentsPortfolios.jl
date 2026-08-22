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
get_id(val::Technology) = IS.get_id(val)
set_id!(val::Technology, id) = IS.set_id!(val, id)
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
Return true if a specific requirement is attached to the Technology.
"""
function has_requirement(technology::Technology, requirement::Requirement)
    if !supports_requirements(technology)
        return false
    end
    for _requirement in get_requirements(technology)
        if get_id(_requirement) == get_id(requirement)
            return true
        end
    end

    return false
end

"""
Return true if a technology has any requirements of type T attached to it.
"""
function has_requirement(technology::Technology, ::Type{T}) where {T <: Requirement}
    if !supports_requirements(technology)
        return false
    end
    for _requirement in get_requirements(technology)
        if isa(_requirement, T)
            return true
        end
    end

    return false
end
