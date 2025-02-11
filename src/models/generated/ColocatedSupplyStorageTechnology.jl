#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct ColocatedSupplyStorageTechnology{T <: PSY.Generator} <: Technology
        name::String
        operation_costs_inverter::PSY.OperationalCost
        minimum_inverter_capacity::Float64
        supply_technology::SupplyTechnology{RenewableDispatch}
        inverter_efficiency::Float64
        internal::InfrastructureSystemsInternal
        ext::Dict
        maximum_inverter_capacity::Float64
        inverter_supply_ratio::Float64
        capital_costs_inverter::PSY.ValueCurve
        storage_technology::StorageTechnology{EnergyReservoirStorage}
    end



# Arguments
- `name::String`: Technology name
- `operation_costs_inverter::PSY.OperationalCost`: Operational costs for using inverter in co-located systems
- `minimum_inverter_capacity::Float64`: (default: `1e8`) Minimum inverter capacity (MW)
- `supply_technology::SupplyTechnology{RenewableDispatch}`: Renewable generation technology
- `inverter_efficiency::Float64`: Efficiency of AC to DC conversion of inverter
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `maximum_inverter_capacity::Float64`: (default: `1e8`) Limit on inverter capacity (MW)
- `inverter_supply_ratio::Float64`: Ratio of generation capacity to grid connection capacity
- `capital_costs_inverter::PSY.ValueCurve`: Capitals costs for investing in inverter capacity
- `storage_technology::StorageTechnology{EnergyReservoirStorage}`: Storage technology
"""
mutable struct ColocatedSupplyStorageTechnology{T <: PSY.Generator} <: Technology
    "Technology name"
    name::String
    "Operational costs for using inverter in co-located systems"
    operation_costs_inverter::PSY.OperationalCost
    "Minimum inverter capacity (MW)"
    minimum_inverter_capacity::Float64
    "Renewable generation technology"
    supply_technology::SupplyTechnology{RenewableDispatch}
    "Efficiency of AC to DC conversion of inverter"
    inverter_efficiency::Float64
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Limit on inverter capacity (MW)"
    maximum_inverter_capacity::Float64
    "Ratio of generation capacity to grid connection capacity"
    inverter_supply_ratio::Float64
    "Capitals costs for investing in inverter capacity"
    capital_costs_inverter::PSY.ValueCurve
    "Storage technology"
    storage_technology::StorageTechnology{EnergyReservoirStorage}
end


function ColocatedSupplyStorageTechnology{T}(; name, operation_costs_inverter, minimum_inverter_capacity=1e8, supply_technology, inverter_efficiency, internal=InfrastructureSystemsInternal(), ext=Dict(), maximum_inverter_capacity=1e8, inverter_supply_ratio, capital_costs_inverter, storage_technology, ) where T <: PSY.Generator
    ColocatedSupplyStorageTechnology{T}(name, operation_costs_inverter, minimum_inverter_capacity, supply_technology, inverter_efficiency, internal, ext, maximum_inverter_capacity, inverter_supply_ratio, capital_costs_inverter, storage_technology, )
end

"""Get [`ColocatedSupplyStorageTechnology`](@ref) `name`."""
get_name(value::ColocatedSupplyStorageTechnology) = value.name
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_inverter`."""
get_operation_costs_inverter(value::ColocatedSupplyStorageTechnology) = value.operation_costs_inverter
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `minimum_inverter_capacity`."""
get_minimum_inverter_capacity(value::ColocatedSupplyStorageTechnology) = value.minimum_inverter_capacity
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `supply_technology`."""
get_supply_technology(value::ColocatedSupplyStorageTechnology) = value.supply_technology
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `inverter_efficiency`."""
get_inverter_efficiency(value::ColocatedSupplyStorageTechnology) = value.inverter_efficiency
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `internal`."""
get_internal(value::ColocatedSupplyStorageTechnology) = value.internal
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `ext`."""
get_ext(value::ColocatedSupplyStorageTechnology) = value.ext
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `maximum_inverter_capacity`."""
get_maximum_inverter_capacity(value::ColocatedSupplyStorageTechnology) = value.maximum_inverter_capacity
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `inverter_supply_ratio`."""
get_inverter_supply_ratio(value::ColocatedSupplyStorageTechnology) = value.inverter_supply_ratio
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_inverter`."""
get_capital_costs_inverter(value::ColocatedSupplyStorageTechnology) = value.capital_costs_inverter
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `storage_technology`."""
get_storage_technology(value::ColocatedSupplyStorageTechnology) = value.storage_technology

"""Set [`ColocatedSupplyStorageTechnology`](@ref) `name`."""
set_name!(value::ColocatedSupplyStorageTechnology, val) = value.name = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_inverter`."""
set_operation_costs_inverter!(value::ColocatedSupplyStorageTechnology, val) = value.operation_costs_inverter = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `minimum_inverter_capacity`."""
set_minimum_inverter_capacity!(value::ColocatedSupplyStorageTechnology, val) = value.minimum_inverter_capacity = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `supply_technology`."""
set_supply_technology!(value::ColocatedSupplyStorageTechnology, val) = value.supply_technology = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `inverter_efficiency`."""
set_inverter_efficiency!(value::ColocatedSupplyStorageTechnology, val) = value.inverter_efficiency = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `internal`."""
set_internal!(value::ColocatedSupplyStorageTechnology, val) = value.internal = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `ext`."""
set_ext!(value::ColocatedSupplyStorageTechnology, val) = value.ext = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `maximum_inverter_capacity`."""
set_maximum_inverter_capacity!(value::ColocatedSupplyStorageTechnology, val) = value.maximum_inverter_capacity = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `inverter_supply_ratio`."""
set_inverter_supply_ratio!(value::ColocatedSupplyStorageTechnology, val) = value.inverter_supply_ratio = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_inverter`."""
set_capital_costs_inverter!(value::ColocatedSupplyStorageTechnology, val) = value.capital_costs_inverter = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `storage_technology`."""
set_storage_technology!(value::ColocatedSupplyStorageTechnology, val) = value.storage_technology = val
