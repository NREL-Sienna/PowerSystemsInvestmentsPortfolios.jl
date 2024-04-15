#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandSideTechnology{T <: PSY.StaticInjection} <: Technology
        name::String
        available::Bool
        capital_cost::IS.FunctionData
        ext::Dict{String, Any}
        supplemental_attributes_container::InfrastructureSystems.SupplementalAttributesContainer
        time_series_container::InfrastructureSystems.TimeSeriesContainer
        internal::InfrastructureSystemsInternal
    end

This struct represents a demand side technology in a power system.

# Arguments
- `name::String`: The name of the demand side technology.
- `available::Bool`: Indicates whether the technology is available or not in the simulation.
- `capital_cost::IS.FunctionData`: The capital cost of the technology.
- `ext::Dict{String, Any}`
- `supplemental_attributes_container::InfrastructureSystems.SupplementalAttributesContainer`: Container for supplemental attributes.
- `time_series_container::InfrastructureSystems.TimeSeriesContainer`: internal time_series storage
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct DemandSideTechnology{T <: PSY.StaticInjection} <: Technology
    "The name of the demand side technology."
    name::String
    "Indicates whether the technology is available or not in the simulation."
    available::Bool
    "The capital cost of the technology."
    capital_cost::IS.FunctionData
    ext::Dict{String, Any}
    "Container for supplemental attributes."
    supplemental_attributes_container::InfrastructureSystems.SupplementalAttributesContainer
    "internal time_series storage"
    time_series_container::InfrastructureSystems.TimeSeriesContainer
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function DemandSideTechnology{T}(name, available, capital_cost, ext=Dict{String, Any}(), supplemental_attributes_container=InfrastructureSystems.SupplementalAttributesContainer(), time_series_container=InfrastructureSystems.TimeSeriesContainer(), ) where T <: PSY.StaticInjection
    DemandSideTechnology{T}(name, available, capital_cost, ext, supplemental_attributes_container, time_series_container, InfrastructureSystemsInternal(), )
end

function DemandSideTechnology{T}(; name, available, capital_cost, ext=Dict{String, Any}(), supplemental_attributes_container=InfrastructureSystems.SupplementalAttributesContainer(), time_series_container=InfrastructureSystems.TimeSeriesContainer(), internal=InfrastructureSystemsInternal(), ) where T <: PSY.StaticInjection
    DemandSideTechnology{T}(name, available, capital_cost, ext, supplemental_attributes_container, time_series_container, internal, )
end

"""Get [`DemandSideTechnology`](@ref) `name`."""
get_name(value::DemandSideTechnology) = value.name
"""Get [`DemandSideTechnology`](@ref) `available`."""
get_available(value::DemandSideTechnology) = value.available
"""Get [`DemandSideTechnology`](@ref) `capital_cost`."""
get_capital_cost(value::DemandSideTechnology) = value.capital_cost
"""Get [`DemandSideTechnology`](@ref) `ext`."""
get_ext(value::DemandSideTechnology) = value.ext
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
"""Set [`DemandSideTechnology`](@ref) `capital_cost`."""
set_capital_cost!(value::DemandSideTechnology, val) = value.capital_cost = val
"""Set [`DemandSideTechnology`](@ref) `ext`."""
set_ext!(value::DemandSideTechnology, val) = value.ext = val
"""Set [`DemandSideTechnology`](@ref) `supplemental_attributes_container`."""
set_supplemental_attributes_container!(value::DemandSideTechnology, val) = value.supplemental_attributes_container = val
"""Set [`DemandSideTechnology`](@ref) `time_series_container`."""
set_time_series_container!(value::DemandSideTechnology, val) = value.time_series_container = val
