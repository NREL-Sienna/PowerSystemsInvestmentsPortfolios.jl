#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandSideTechnology{T <: PSY.StaticInjection} <: Technology
        name::String
        available::Bool
        power_systems_type::Type{T}
        capital_cost::IS.FunctionData
        supplemental_attributes_container::InfrastructureSystems.SupplementalAttributesContainer
        time_series_container::InfrastructureSystems.TimeSeriesContainer
        internal::InfrastructureSystemsInternal
    end

This struct represents a demand side technology in a power system.

# Arguments
- `name::String`: The name of the demand side technology.
- `available::Bool`: Indicates whether the technology is available or not in the simulation.
- `power_systems_type::Type{T}`: The type of PowerSystems Component this build option translates to.
- `capital_cost::IS.FunctionData`: The capital cost of the technology.
- `supplemental_attributes_container::InfrastructureSystems.SupplementalAttributesContainer`: Container for supplemental attributes.
- `time_series_container::InfrastructureSystems.TimeSeriesContainer`: internal time_series storage
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct DemandSideTechnology{T <: PSY.StaticInjection} <: Technology
    "The name of the demand side technology."
    name::String
    "Indicates whether the technology is available or not in the simulation."
    available::Bool
    "The type of PowerSystems Component this build option translates to."
    power_systems_type::Type{T}
    "The capital cost of the technology."
    capital_cost::IS.FunctionData
    "Container for supplemental attributes."
    supplemental_attributes_container::InfrastructureSystems.SupplementalAttributesContainer
    "internal time_series storage"
    time_series_container::InfrastructureSystems.TimeSeriesContainer
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function DemandSideTechnology{T}(name, available, power_systems_type, capital_cost, supplemental_attributes_container=InfrastructureSystems.SupplementalAttributesContainer(), time_series_container=InfrastructureSystems.TimeSeriesContainer(), ) where T <: PSY.StaticInjection
    DemandSideTechnology{T}(name, available, power_systems_type, capital_cost, supplemental_attributes_container, time_series_container, InfrastructureSystemsInternal(), )
end

function DemandSideTechnology{T}(; name, available, power_systems_type, capital_cost, supplemental_attributes_container=InfrastructureSystems.SupplementalAttributesContainer(), time_series_container=InfrastructureSystems.TimeSeriesContainer(), internal=InfrastructureSystemsInternal(), ) where T <: PSY.StaticInjection
    DemandSideTechnology{T}(name, available, power_systems_type, capital_cost, supplemental_attributes_container, time_series_container, internal, )
end

"""Get [`DemandSideTechnology`](@ref) `name`."""
get_name(value::DemandSideTechnology) = value.name
"""Get [`DemandSideTechnology`](@ref) `available`."""
get_available(value::DemandSideTechnology) = value.available
"""Get [`DemandSideTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::DemandSideTechnology) = value.power_systems_type
"""Get [`DemandSideTechnology`](@ref) `capital_cost`."""
get_capital_cost(value::DemandSideTechnology) = value.capital_cost
"""Get [`DemandSideTechnology`](@ref) `supplemental_attributes_container`."""
get_supplemental_attributes_container(value::DemandSideTechnology) = value.supplemental_attributes_container
"""Get [`DemandSideTechnology`](@ref) `time_series_container`."""
get_time_series_container(value::DemandSideTechnology) = value.time_series_container
"""Get [`DemandSideTechnology`](@ref) `internal`."""
get_internal(value::DemandSideTechnology) = value.internal

"""Set [`DemandSideTechnology`](@ref) `name`."""
set_name!(value::DemandSideTechnology, val) = value.name = val
"""Set [`DemandSideTechnology`](@ref) `available`."""
set_available!(value::DemandSideTechnology, val) = value.available = val
"""Set [`DemandSideTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::DemandSideTechnology, val) = value.power_systems_type = val
"""Set [`DemandSideTechnology`](@ref) `capital_cost`."""
set_capital_cost!(value::DemandSideTechnology, val) = value.capital_cost = val
"""Set [`DemandSideTechnology`](@ref) `supplemental_attributes_container`."""
set_supplemental_attributes_container!(value::DemandSideTechnology, val) = value.supplemental_attributes_container = val
"""Set [`DemandSideTechnology`](@ref) `time_series_container`."""
set_time_series_container!(value::DemandSideTechnology, val) = value.time_series_container = val
