#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct SupplyTechnology{T <: PSY.Generator} <: Technology
        name::String
        available::Bool
        fuel::PSY.ThermalFuels
        prime_mover::PSY.PrimeMovers
        capacity_factor::Float64
        capital_cost::Union{Nothing, IS.FunctionData}
        operational_cost::Union{Nothing, PSY.OperationalCost}
        ext::Dict{String, Any}
        supplemental_attributes_container::InfrastructureSystems.SupplementalAttributesContainer
        time_series_container::InfrastructureSystems.TimeSeriesContainer
        internal::InfrastructureSystemsInternal
    end

This struct represents a supply technology in a power system.

# Arguments
- `name::String`: The name of the supply technology.
- `available::Bool`: Indicates whether the technology is available or not in the simulation.
- `fuel::PSY.ThermalFuels`: The type of fuel used by the supply technology.
- `prime_mover::PSY.PrimeMovers`: The prime mover of the supply technology.
- `capacity_factor::Float64`: The capacity factor of the supply technology.
- `capital_cost::Union{Nothing, IS.FunctionData}`: The capital cost of the technology.
- `operational_cost::Union{Nothing, PSY.OperationalCost}`: The operational cost of the supply technology.
- `ext::Dict{String, Any}`
- `supplemental_attributes_container::InfrastructureSystems.SupplementalAttributesContainer`: Container for supplemental attributes.
- `time_series_container::InfrastructureSystems.TimeSeriesContainer`: internal time_series storage
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct SupplyTechnology{T <: PSY.Generator} <: Technology
    "The name of the supply technology."
    name::String
    "Indicates whether the technology is available or not in the simulation."
    available::Bool
    "The type of fuel used by the supply technology."
    fuel::PSY.ThermalFuels
    "The prime mover of the supply technology."
    prime_mover::PSY.PrimeMovers
    "The capacity factor of the supply technology."
    capacity_factor::Float64
    "The capital cost of the technology."
    capital_cost::Union{Nothing, IS.FunctionData}
    "The operational cost of the supply technology."
    operational_cost::Union{Nothing, PSY.OperationalCost}
    ext::Dict{String, Any}
    "Container for supplemental attributes."
    supplemental_attributes_container::InfrastructureSystems.SupplementalAttributesContainer
    "internal time_series storage"
    time_series_container::InfrastructureSystems.TimeSeriesContainer
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function SupplyTechnology{T}(name, available, fuel, prime_mover, capacity_factor, capital_cost, operational_cost, ext=Dict{String, Any}(), supplemental_attributes_container=InfrastructureSystems.SupplementalAttributesContainer(), time_series_container=InfrastructureSystems.TimeSeriesContainer(), ) where T <: PSY.Generator
    SupplyTechnology{T}(name, available, fuel, prime_mover, capacity_factor, capital_cost, operational_cost, ext, supplemental_attributes_container, time_series_container, InfrastructureSystemsInternal(), )
end

function SupplyTechnology{T}(; name, available, fuel, prime_mover, capacity_factor, capital_cost, operational_cost, ext=Dict{String, Any}(), supplemental_attributes_container=InfrastructureSystems.SupplementalAttributesContainer(), time_series_container=InfrastructureSystems.TimeSeriesContainer(), internal=InfrastructureSystemsInternal(), ) where T <: PSY.Generator
    SupplyTechnology{T}(name, available, fuel, prime_mover, capacity_factor, capital_cost, operational_cost, ext, supplemental_attributes_container, time_series_container, internal, )
end

"""Get [`SupplyTechnology`](@ref) `name`."""
get_name(value::SupplyTechnology) = value.name
"""Get [`SupplyTechnology`](@ref) `available`."""
get_available(value::SupplyTechnology) = value.available
"""Get [`SupplyTechnology`](@ref) `fuel`."""
get_fuel(value::SupplyTechnology) = value.fuel
"""Get [`SupplyTechnology`](@ref) `prime_mover`."""
get_prime_mover(value::SupplyTechnology) = value.prime_mover
"""Get [`SupplyTechnology`](@ref) `capacity_factor`."""
get_capacity_factor(value::SupplyTechnology) = value.capacity_factor
"""Get [`SupplyTechnology`](@ref) `capital_cost`."""
get_capital_cost(value::SupplyTechnology) = value.capital_cost
"""Get [`SupplyTechnology`](@ref) `operational_cost`."""
get_operational_cost(value::SupplyTechnology) = value.operational_cost
"""Get [`SupplyTechnology`](@ref) `ext`."""
get_ext(value::SupplyTechnology) = value.ext
"""Get [`SupplyTechnology`](@ref) `supplemental_attributes_container`."""
get_supplemental_attributes_container(value::SupplyTechnology) = value.supplemental_attributes_container
"""Get [`SupplyTechnology`](@ref) `time_series_container`."""
get_time_series_container(value::SupplyTechnology) = value.time_series_container
"""Get [`SupplyTechnology`](@ref) `internal`."""
get_internal(value::SupplyTechnology) = value.internal

"""Set [`SupplyTechnology`](@ref) `name`."""
set_name!(value::SupplyTechnology, val) = value.name = val
"""Set [`SupplyTechnology`](@ref) `available`."""
set_available!(value::SupplyTechnology, val) = value.available = val
"""Set [`SupplyTechnology`](@ref) `fuel`."""
set_fuel!(value::SupplyTechnology, val) = value.fuel = val
"""Set [`SupplyTechnology`](@ref) `prime_mover`."""
set_prime_mover!(value::SupplyTechnology, val) = value.prime_mover = val
"""Set [`SupplyTechnology`](@ref) `capacity_factor`."""
set_capacity_factor!(value::SupplyTechnology, val) = value.capacity_factor = val
"""Set [`SupplyTechnology`](@ref) `capital_cost`."""
set_capital_cost!(value::SupplyTechnology, val) = value.capital_cost = val
"""Set [`SupplyTechnology`](@ref) `operational_cost`."""
set_operational_cost!(value::SupplyTechnology, val) = value.operational_cost = val
"""Set [`SupplyTechnology`](@ref) `ext`."""
set_ext!(value::SupplyTechnology, val) = value.ext = val
"""Set [`SupplyTechnology`](@ref) `supplemental_attributes_container`."""
set_supplemental_attributes_container!(value::SupplyTechnology, val) = value.supplemental_attributes_container = val
"""Set [`SupplyTechnology`](@ref) `time_series_container`."""
set_time_series_container!(value::SupplyTechnology, val) = value.time_series_container = val
