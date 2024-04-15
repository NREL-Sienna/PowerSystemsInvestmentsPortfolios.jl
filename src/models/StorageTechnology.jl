#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct StorageTechnology{T <: PSY.Storage} <: Technology
        name::String
        available::Bool
        capital_cost::IS.FunctionData
        battery_chemistry::String
        prime_mover::PSY.PrimeMovers
        operational_cost::PSY.OperationalCost
        ext::Dict{String, Any}
        supplemental_attributes_container::InfrastructureSystems.SupplementalAttributesContainer
        time_series_container::InfrastructureSystems.TimeSeriesContainer
        internal::InfrastructureSystemsInternal
    end

This struct represents a storage technology in a power system.

# Arguments
- `name::String`: The name of the storage technology.
- `available::Bool`: Indicates whether the technology is available or not in the simulation.
- `capital_cost::IS.FunctionData`: The capital cost of the technology.
- `battery_chemistry::String`: The type of battery chemistry. Implement Chemistry Type Enums in PowerSystems.
- `prime_mover::PSY.PrimeMovers`: The prime mover of the storage technology.
- `operational_cost::PSY.OperationalCost`: The operational cost of the storage technology.
- `ext::Dict{String, Any}`
- `supplemental_attributes_container::InfrastructureSystems.SupplementalAttributesContainer`: Container for supplemental attributes.
- `time_series_container::InfrastructureSystems.TimeSeriesContainer`: internal time_series storage
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct StorageTechnology{T <: PSY.Storage} <: Technology
    "The name of the storage technology."
    name::String
    "Indicates whether the technology is available or not in the simulation."
    available::Bool
    "The capital cost of the technology."
    capital_cost::IS.FunctionData
    "The type of battery chemistry. Implement Chemistry Type Enums in PowerSystems."
    battery_chemistry::String
    "The prime mover of the storage technology."
    prime_mover::PSY.PrimeMovers
    "The operational cost of the storage technology."
    operational_cost::PSY.OperationalCost
    ext::Dict{String, Any}
    "Container for supplemental attributes."
    supplemental_attributes_container::InfrastructureSystems.SupplementalAttributesContainer
    "internal time_series storage"
    time_series_container::InfrastructureSystems.TimeSeriesContainer
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function StorageTechnology{T}(name, available, capital_cost, battery_chemistry, prime_mover, operational_cost, ext=Dict{String, Any}(), supplemental_attributes_container=InfrastructureSystems.SupplementalAttributesContainer(), time_series_container=InfrastructureSystems.TimeSeriesContainer(), ) where T <: PSY.Storage
    StorageTechnology{T}(name, available, capital_cost, battery_chemistry, prime_mover, operational_cost, ext, supplemental_attributes_container, time_series_container, InfrastructureSystemsInternal(), )
end

function StorageTechnology{T}(; name, available, capital_cost, battery_chemistry, prime_mover, operational_cost, ext=Dict{String, Any}(), supplemental_attributes_container=InfrastructureSystems.SupplementalAttributesContainer(), time_series_container=InfrastructureSystems.TimeSeriesContainer(), internal=InfrastructureSystemsInternal(), ) where T <: PSY.Storage
    StorageTechnology{T}(name, available, capital_cost, battery_chemistry, prime_mover, operational_cost, ext, supplemental_attributes_container, time_series_container, internal, )
end

"""Get [`StorageTechnology`](@ref) `name`."""
get_name(value::StorageTechnology) = value.name
"""Get [`StorageTechnology`](@ref) `available`."""
get_available(value::StorageTechnology) = value.available
"""Get [`StorageTechnology`](@ref) `capital_cost`."""
get_capital_cost(value::StorageTechnology) = value.capital_cost
"""Get [`StorageTechnology`](@ref) `battery_chemistry`."""
get_battery_chemistry(value::StorageTechnology) = value.battery_chemistry
"""Get [`StorageTechnology`](@ref) `prime_mover`."""
get_prime_mover(value::StorageTechnology) = value.prime_mover
"""Get [`StorageTechnology`](@ref) `operational_cost`."""
get_operational_cost(value::StorageTechnology) = value.operational_cost
"""Get [`StorageTechnology`](@ref) `ext`."""
get_ext(value::StorageTechnology) = value.ext
"""Get [`StorageTechnology`](@ref) `supplemental_attributes_container`."""
get_supplemental_attributes_container(value::StorageTechnology) = value.supplemental_attributes_container
"""Get [`StorageTechnology`](@ref) `time_series_container`."""
get_time_series_container(value::StorageTechnology) = value.time_series_container
"""Get [`StorageTechnology`](@ref) `internal`."""
get_internal(value::StorageTechnology) = value.internal

"""Set [`StorageTechnology`](@ref) `name`."""
set_name!(value::StorageTechnology, val) = value.name = val
"""Set [`StorageTechnology`](@ref) `available`."""
set_available!(value::StorageTechnology, val) = value.available = val
"""Set [`StorageTechnology`](@ref) `capital_cost`."""
set_capital_cost!(value::StorageTechnology, val) = value.capital_cost = val
"""Set [`StorageTechnology`](@ref) `battery_chemistry`."""
set_battery_chemistry!(value::StorageTechnology, val) = value.battery_chemistry = val
"""Set [`StorageTechnology`](@ref) `prime_mover`."""
set_prime_mover!(value::StorageTechnology, val) = value.prime_mover = val
"""Set [`StorageTechnology`](@ref) `operational_cost`."""
set_operational_cost!(value::StorageTechnology, val) = value.operational_cost = val
"""Set [`StorageTechnology`](@ref) `ext`."""
set_ext!(value::StorageTechnology, val) = value.ext = val
"""Set [`StorageTechnology`](@ref) `supplemental_attributes_container`."""
set_supplemental_attributes_container!(value::StorageTechnology, val) = value.supplemental_attributes_container = val
"""Set [`StorageTechnology`](@ref) `time_series_container`."""
set_time_series_container!(value::StorageTechnology, val) = value.time_series_container = val
