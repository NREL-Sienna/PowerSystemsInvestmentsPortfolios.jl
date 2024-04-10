#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct TransportTechnology{T <: PSY.Device} <: Technology
        name::String
        available::Bool
        power_systems_type::Type{T}
        capital_cost::IS.FunctionData
        supplemental_attributes_container::InfrastructureSystems.SupplementalAttributesContainer
        time_series_container::InfrastructureSystems.TimeSeriesContainer
        internal::InfrastructureSystemsInternal
    end

This struct represents a transport technology in a power system.

# Arguments
- `name::String`: The name of the transport technology.
- `available::Bool`: Indicates whether the technology is available or not in the simulation.
- `power_systems_type::Type{T}`: The type of PowerSystems Component this build option translates to.
- `capital_cost::IS.FunctionData`: The capital cost of the technology.
- `supplemental_attributes_container::InfrastructureSystems.SupplementalAttributesContainer`: Container for supplemental attributes.
- `time_series_container::InfrastructureSystems.TimeSeriesContainer`: internal time_series storage
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct TransportTechnology{T <: PSY.Device} <: Technology
    "The name of the transport technology."
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

function TransportTechnology{T}(name, available, power_systems_type, capital_cost, supplemental_attributes_container=InfrastructureSystems.SupplementalAttributesContainer(), time_series_container=InfrastructureSystems.TimeSeriesContainer(), ) where T <: PSY.Device
    TransportTechnology{T}(name, available, power_systems_type, capital_cost, supplemental_attributes_container, time_series_container, InfrastructureSystemsInternal(), )
end

function TransportTechnology{T}(; name, available, power_systems_type, capital_cost, supplemental_attributes_container=InfrastructureSystems.SupplementalAttributesContainer(), time_series_container=InfrastructureSystems.TimeSeriesContainer(), internal=InfrastructureSystemsInternal(), ) where T <: PSY.Device
    TransportTechnology{T}(name, available, power_systems_type, capital_cost, supplemental_attributes_container, time_series_container, internal, )
end

"""Get [`TransportTechnology`](@ref) `name`."""
get_name(value::TransportTechnology) = value.name
"""Get [`TransportTechnology`](@ref) `available`."""
get_available(value::TransportTechnology) = value.available
"""Get [`TransportTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::TransportTechnology) = value.power_systems_type
"""Get [`TransportTechnology`](@ref) `capital_cost`."""
get_capital_cost(value::TransportTechnology) = value.capital_cost
"""Get [`TransportTechnology`](@ref) `supplemental_attributes_container`."""
get_supplemental_attributes_container(value::TransportTechnology) = value.supplemental_attributes_container
"""Get [`TransportTechnology`](@ref) `time_series_container`."""
get_time_series_container(value::TransportTechnology) = value.time_series_container
"""Get [`TransportTechnology`](@ref) `internal`."""
get_internal(value::TransportTechnology) = value.internal

"""Set [`TransportTechnology`](@ref) `name`."""
set_name!(value::TransportTechnology, val) = value.name = val
"""Set [`TransportTechnology`](@ref) `available`."""
set_available!(value::TransportTechnology, val) = value.available = val
"""Set [`TransportTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::TransportTechnology, val) = value.power_systems_type = val
"""Set [`TransportTechnology`](@ref) `capital_cost`."""
set_capital_cost!(value::TransportTechnology, val) = value.capital_cost = val
"""Set [`TransportTechnology`](@ref) `supplemental_attributes_container`."""
set_supplemental_attributes_container!(value::TransportTechnology, val) = value.supplemental_attributes_container = val
"""Set [`TransportTechnology`](@ref) `time_series_container`."""
set_time_series_container!(value::TransportTechnology, val) = value.time_series_container = val
