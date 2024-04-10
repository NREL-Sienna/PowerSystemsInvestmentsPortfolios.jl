#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandRequirement{T <: PSY.StaticInjection} <: PSY.StaticInjection
        name::String
        available::Bool
        power_systems_type::Type{T}
        region::Union{PSY.ACBus, PSY.AggregationTopology}
        supplemental_attributes_container::InfrastructureSystems.SupplementalAttributesContainer
        time_series_container::InfrastructureSystems.TimeSeriesContainer
        internal::InfrastructureSystemsInternal
    end

This struct represents the demand requirement for a power system.

# Arguments
- `name::String`: The name of the load demand requirement.
- `available::Bool`: Indicates whether the load demand is available or not in the simulation.
- `power_systems_type::Type{T}`: The type of PowerSystems Component this build option translates to.
- `region::Union{PSY.ACBus, PSY.AggregationTopology}`: The region of the demand requirement.
- `supplemental_attributes_container::InfrastructureSystems.SupplementalAttributesContainer`: Container for supplemental attributes.
- `time_series_container::InfrastructureSystems.TimeSeriesContainer`: internal time_series storage
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct DemandRequirement{T <: PSY.StaticInjection} <: PSY.StaticInjection
    "The name of the load demand requirement."
    name::String
    "Indicates whether the load demand is available or not in the simulation."
    available::Bool
    "The type of PowerSystems Component this build option translates to."
    power_systems_type::Type{T}
    "The region of the demand requirement."
    region::Union{PSY.ACBus, PSY.AggregationTopology}
    "Container for supplemental attributes."
    supplemental_attributes_container::InfrastructureSystems.SupplementalAttributesContainer
    "internal time_series storage"
    time_series_container::InfrastructureSystems.TimeSeriesContainer
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function DemandRequirement{T}(name, available, power_systems_type, region, supplemental_attributes_container=InfrastructureSystems.SupplementalAttributesContainer(), time_series_container=InfrastructureSystems.TimeSeriesContainer(), ) where T <: PSY.StaticInjection
    DemandRequirement{T}(name, available, power_systems_type, region, supplemental_attributes_container, time_series_container, InfrastructureSystemsInternal(), )
end

function DemandRequirement{T}(; name, available, power_systems_type, region, supplemental_attributes_container=InfrastructureSystems.SupplementalAttributesContainer(), time_series_container=InfrastructureSystems.TimeSeriesContainer(), internal=InfrastructureSystemsInternal(), ) where T <: PSY.StaticInjection
    DemandRequirement{T}(name, available, power_systems_type, region, supplemental_attributes_container, time_series_container, internal, )
end

"""Get [`DemandRequirement`](@ref) `name`."""
get_name(value::DemandRequirement) = value.name
"""Get [`DemandRequirement`](@ref) `available`."""
get_available(value::DemandRequirement) = value.available
"""Get [`DemandRequirement`](@ref) `power_systems_type`."""
get_power_systems_type(value::DemandRequirement) = value.power_systems_type
"""Get [`DemandRequirement`](@ref) `region`."""
get_region(value::DemandRequirement) = value.region
"""Get [`DemandRequirement`](@ref) `supplemental_attributes_container`."""
get_supplemental_attributes_container(value::DemandRequirement) = value.supplemental_attributes_container
"""Get [`DemandRequirement`](@ref) `time_series_container`."""
get_time_series_container(value::DemandRequirement) = value.time_series_container
"""Get [`DemandRequirement`](@ref) `internal`."""
get_internal(value::DemandRequirement) = value.internal

"""Set [`DemandRequirement`](@ref) `name`."""
set_name!(value::DemandRequirement, val) = value.name = val
"""Set [`DemandRequirement`](@ref) `available`."""
set_available!(value::DemandRequirement, val) = value.available = val
"""Set [`DemandRequirement`](@ref) `power_systems_type`."""
set_power_systems_type!(value::DemandRequirement, val) = value.power_systems_type = val
"""Set [`DemandRequirement`](@ref) `region`."""
set_region!(value::DemandRequirement, val) = value.region = val
"""Set [`DemandRequirement`](@ref) `supplemental_attributes_container`."""
set_supplemental_attributes_container!(value::DemandRequirement, val) = value.supplemental_attributes_container = val
"""Set [`DemandRequirement`](@ref) `time_series_container`."""
set_time_series_container!(value::DemandRequirement, val) = value.time_series_container = val
