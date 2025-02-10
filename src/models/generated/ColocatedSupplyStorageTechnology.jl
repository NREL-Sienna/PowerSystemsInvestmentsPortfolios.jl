#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct ColocatedSupplyStorageTechnology{T <: PSY.Generator} <: Technology
        base_power::Float64
        capital_costs_supply::PSY.ValueCurve
        max_capacity_storage_power::Float64
        prime_mover_type::PrimeMovers
        min_capacity_supply::Float64
        capital_costs_storage_energy::PSY.ValueCurve
        supply_financial_data::TechnologyFinancialData
        lifetime::Int
        available::Bool
        name::String
        id::Int64
        min_capacity_storage_power::Float64
        min_capacity_storage_energy::Float64
        max_capacity_storage_energy::Float64
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        operation_costs_storage::PSY.OperationalCost
        unit_size_storage_energy::Float64
        ext::Dict
        balancing_topology::String
        region::Union{Nothing, Region, Vector{Region}}
        max_capacity_supply::Float64
        operation_costs_supply::PSY.OperationalCost
        capital_costs_storage_power::PSY.ValueCurve
        unit_size_supply::Float64
        unit_size_storage_power::Float64
        base_year::Int
        storage_financial_data::TechnologyFinancialData
    end



# Arguments
- `base_power::Float64`: Base power
- `capital_costs_supply::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a supply technology.
- `max_capacity_storage_power::Float64`: (default: `1e8`) Maximum allowable installed capacity for the StorageTechnology charge/discharge
- `prime_mover_type::PrimeMovers`: (default: `PrimeMovers.OT`) Prime mover for generator
- `min_capacity_supply::Float64`: (default: `0.0`) Minimum required capacity for the SupplyTechnology
- `capital_costs_storage_energy::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in energy storage capacity.
- `supply_financial_data::TechnologyFinancialData`: Struct containing relevant financial information for the SupplyTechnology
- `lifetime::Int`: (default: `100`) Maximum number of years a technology can be active once installed
- `available::Bool`: (default: `True`) identifies whether the technology is available
- `name::String`: The technology name
- `id::Int64`: ID for individual technology
- `min_capacity_storage_power::Float64`: (default: `0.0`) Minimum required capacity for storage charge/discharge
- `min_capacity_storage_energy::Float64`: (default: `0.0`) Minimum required capacity for a energy storage
- `max_capacity_storage_energy::Float64`: (default: `1e8`) Maximum allowable installed capacity for energy storage
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `operation_costs_storage::PSY.OperationalCost`: (default: `StorageCost()`) Fixed and variable O&M costs for a storage technology
- `unit_size_storage_energy::Float64`: (default: `0.0`) Used for discrete investment decisions. Size of each unit being built for storage energy capacity (MWh)
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `balancing_topology::String`: Set of balancing nodes
- `region::Union{Nothing, Region, Vector{Region}}`: (default: `nothing`) Zone where tech operates in
- `max_capacity_supply::Float64`: (default: `1e8`) Maximum allowable installed capacity for the SupplyTechnology
- `operation_costs_supply::PSY.OperationalCost`: (default: `ThermalGenerationCost()`) Fixed and variable O&M costs for a supply technology
- `capital_costs_storage_power::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in storage charge/discharge capacity.
- `unit_size_supply::Float64`: (default: `0.0`) Used for discrete investment decisions. Size of each unit being built for SupplyTechnology (MW)
- `unit_size_storage_power::Float64`: (default: `0.0`) Used for discrete investment decisions. Size of each unit being built for storage charge/discharge (MW)
- `base_year::Int`: (default: `2020`) Reference year for technology data
- `storage_financial_data::TechnologyFinancialData`: Struct containing relevant financial information for the StorageTechnology
"""
mutable struct ColocatedSupplyStorageTechnology{T <: PSY.Generator} <: Technology
    "Base power"
    base_power::Float64
    "Capital costs for investing in a supply technology."
    capital_costs_supply::PSY.ValueCurve
    "Maximum allowable installed capacity for the StorageTechnology charge/discharge"
    max_capacity_storage_power::Float64
    "Prime mover for generator"
    prime_mover_type::PrimeMovers
    "Minimum required capacity for the SupplyTechnology"
    min_capacity_supply::Float64
    "Capital costs for investing in energy storage capacity."
    capital_costs_storage_energy::PSY.ValueCurve
    "Struct containing relevant financial information for the SupplyTechnology"
    supply_financial_data::TechnologyFinancialData
    "Maximum number of years a technology can be active once installed"
    lifetime::Int
    "identifies whether the technology is available"
    available::Bool
    "The technology name"
    name::String
    "ID for individual technology"
    id::Int64
    "Minimum required capacity for storage charge/discharge"
    min_capacity_storage_power::Float64
    "Minimum required capacity for a energy storage"
    min_capacity_storage_energy::Float64
    "Maximum allowable installed capacity for energy storage"
    max_capacity_storage_energy::Float64
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Fixed and variable O&M costs for a storage technology"
    operation_costs_storage::PSY.OperationalCost
    "Used for discrete investment decisions. Size of each unit being built for storage energy capacity (MWh)"
    unit_size_storage_energy::Float64
    "Option for providing additional data"
    ext::Dict
    "Set of balancing nodes"
    balancing_topology::String
    "Zone where tech operates in"
    region::Union{Nothing, Region, Vector{Region}}
    "Maximum allowable installed capacity for the SupplyTechnology"
    max_capacity_supply::Float64
    "Fixed and variable O&M costs for a supply technology"
    operation_costs_supply::PSY.OperationalCost
    "Capital costs for investing in storage charge/discharge capacity."
    capital_costs_storage_power::PSY.ValueCurve
    "Used for discrete investment decisions. Size of each unit being built for SupplyTechnology (MW)"
    unit_size_supply::Float64
    "Used for discrete investment decisions. Size of each unit being built for storage charge/discharge (MW)"
    unit_size_storage_power::Float64
    "Reference year for technology data"
    base_year::Int
    "Struct containing relevant financial information for the StorageTechnology"
    storage_financial_data::TechnologyFinancialData
end


function ColocatedSupplyStorageTechnology{T}(; base_power, capital_costs_supply=LinearCurve(0.0), max_capacity_storage_power=1e8, prime_mover_type=PrimeMovers.OT, min_capacity_supply=0.0, capital_costs_storage_energy=LinearCurve(0.0), supply_financial_data, lifetime=100, available=True, name, id, min_capacity_storage_power=0.0, min_capacity_storage_energy=0.0, max_capacity_storage_energy=1e8, power_systems_type, internal=InfrastructureSystemsInternal(), operation_costs_storage=StorageCost(), unit_size_storage_energy=0.0, ext=Dict(), balancing_topology, region=nothing, max_capacity_supply=1e8, operation_costs_supply=ThermalGenerationCost(), capital_costs_storage_power=LinearCurve(0.0), unit_size_supply=0.0, unit_size_storage_power=0.0, base_year=2020, storage_financial_data, ) where T <: PSY.Generator
    ColocatedSupplyStorageTechnology{T}(base_power, capital_costs_supply, max_capacity_storage_power, prime_mover_type, min_capacity_supply, capital_costs_storage_energy, supply_financial_data, lifetime, available, name, id, min_capacity_storage_power, min_capacity_storage_energy, max_capacity_storage_energy, power_systems_type, internal, operation_costs_storage, unit_size_storage_energy, ext, balancing_topology, region, max_capacity_supply, operation_costs_supply, capital_costs_storage_power, unit_size_supply, unit_size_storage_power, base_year, storage_financial_data, )
end

"""Get [`ColocatedSupplyStorageTechnology`](@ref) `base_power`."""
get_base_power(value::ColocatedSupplyStorageTechnology) = value.base_power
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_supply`."""
get_capital_costs_supply(value::ColocatedSupplyStorageTechnology) = value.capital_costs_supply
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `max_capacity_storage_power`."""
get_max_capacity_storage_power(value::ColocatedSupplyStorageTechnology) = value.max_capacity_storage_power
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `prime_mover_type`."""
get_prime_mover_type(value::ColocatedSupplyStorageTechnology) = value.prime_mover_type
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `min_capacity_supply`."""
get_min_capacity_supply(value::ColocatedSupplyStorageTechnology) = value.min_capacity_supply
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_storage_energy`."""
get_capital_costs_storage_energy(value::ColocatedSupplyStorageTechnology) = value.capital_costs_storage_energy
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `supply_financial_data`."""
get_supply_financial_data(value::ColocatedSupplyStorageTechnology) = value.supply_financial_data
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `lifetime`."""
get_lifetime(value::ColocatedSupplyStorageTechnology) = value.lifetime
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `available`."""
get_available(value::ColocatedSupplyStorageTechnology) = value.available
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `name`."""
get_name(value::ColocatedSupplyStorageTechnology) = value.name
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `id`."""
get_id(value::ColocatedSupplyStorageTechnology) = value.id
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `min_capacity_storage_power`."""
get_min_capacity_storage_power(value::ColocatedSupplyStorageTechnology) = value.min_capacity_storage_power
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `min_capacity_storage_energy`."""
get_min_capacity_storage_energy(value::ColocatedSupplyStorageTechnology) = value.min_capacity_storage_energy
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `max_capacity_storage_energy`."""
get_max_capacity_storage_energy(value::ColocatedSupplyStorageTechnology) = value.max_capacity_storage_energy
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::ColocatedSupplyStorageTechnology) = value.power_systems_type
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `internal`."""
get_internal(value::ColocatedSupplyStorageTechnology) = value.internal
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_storage`."""
get_operation_costs_storage(value::ColocatedSupplyStorageTechnology) = value.operation_costs_storage
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `unit_size_storage_energy`."""
get_unit_size_storage_energy(value::ColocatedSupplyStorageTechnology) = value.unit_size_storage_energy
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `ext`."""
get_ext(value::ColocatedSupplyStorageTechnology) = value.ext
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `balancing_topology`."""
get_balancing_topology(value::ColocatedSupplyStorageTechnology) = value.balancing_topology
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `region`."""
get_region(value::ColocatedSupplyStorageTechnology) = value.region
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `max_capacity_supply`."""
get_max_capacity_supply(value::ColocatedSupplyStorageTechnology) = value.max_capacity_supply
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_supply`."""
get_operation_costs_supply(value::ColocatedSupplyStorageTechnology) = value.operation_costs_supply
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_storage_power`."""
get_capital_costs_storage_power(value::ColocatedSupplyStorageTechnology) = value.capital_costs_storage_power
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `unit_size_supply`."""
get_unit_size_supply(value::ColocatedSupplyStorageTechnology) = value.unit_size_supply
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `unit_size_storage_power`."""
get_unit_size_storage_power(value::ColocatedSupplyStorageTechnology) = value.unit_size_storage_power
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `base_year`."""
get_base_year(value::ColocatedSupplyStorageTechnology) = value.base_year
"""Get [`ColocatedSupplyStorageTechnology`](@ref) `storage_financial_data`."""
get_storage_financial_data(value::ColocatedSupplyStorageTechnology) = value.storage_financial_data

"""Set [`ColocatedSupplyStorageTechnology`](@ref) `base_power`."""
set_base_power!(value::ColocatedSupplyStorageTechnology, val) = value.base_power = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_supply`."""
set_capital_costs_supply!(value::ColocatedSupplyStorageTechnology, val) = value.capital_costs_supply = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `max_capacity_storage_power`."""
set_max_capacity_storage_power!(value::ColocatedSupplyStorageTechnology, val) = value.max_capacity_storage_power = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `prime_mover_type`."""
set_prime_mover_type!(value::ColocatedSupplyStorageTechnology, val) = value.prime_mover_type = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `min_capacity_supply`."""
set_min_capacity_supply!(value::ColocatedSupplyStorageTechnology, val) = value.min_capacity_supply = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_storage_energy`."""
set_capital_costs_storage_energy!(value::ColocatedSupplyStorageTechnology, val) = value.capital_costs_storage_energy = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `supply_financial_data`."""
set_supply_financial_data!(value::ColocatedSupplyStorageTechnology, val) = value.supply_financial_data = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `lifetime`."""
set_lifetime!(value::ColocatedSupplyStorageTechnology, val) = value.lifetime = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `available`."""
set_available!(value::ColocatedSupplyStorageTechnology, val) = value.available = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `name`."""
set_name!(value::ColocatedSupplyStorageTechnology, val) = value.name = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `id`."""
set_id!(value::ColocatedSupplyStorageTechnology, val) = value.id = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `min_capacity_storage_power`."""
set_min_capacity_storage_power!(value::ColocatedSupplyStorageTechnology, val) = value.min_capacity_storage_power = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `min_capacity_storage_energy`."""
set_min_capacity_storage_energy!(value::ColocatedSupplyStorageTechnology, val) = value.min_capacity_storage_energy = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `max_capacity_storage_energy`."""
set_max_capacity_storage_energy!(value::ColocatedSupplyStorageTechnology, val) = value.max_capacity_storage_energy = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::ColocatedSupplyStorageTechnology, val) = value.power_systems_type = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `internal`."""
set_internal!(value::ColocatedSupplyStorageTechnology, val) = value.internal = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_storage`."""
set_operation_costs_storage!(value::ColocatedSupplyStorageTechnology, val) = value.operation_costs_storage = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `unit_size_storage_energy`."""
set_unit_size_storage_energy!(value::ColocatedSupplyStorageTechnology, val) = value.unit_size_storage_energy = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `ext`."""
set_ext!(value::ColocatedSupplyStorageTechnology, val) = value.ext = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `balancing_topology`."""
set_balancing_topology!(value::ColocatedSupplyStorageTechnology, val) = value.balancing_topology = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `region`."""
set_region!(value::ColocatedSupplyStorageTechnology, val) = value.region = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `max_capacity_supply`."""
set_max_capacity_supply!(value::ColocatedSupplyStorageTechnology, val) = value.max_capacity_supply = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `operation_costs_supply`."""
set_operation_costs_supply!(value::ColocatedSupplyStorageTechnology, val) = value.operation_costs_supply = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `capital_costs_storage_power`."""
set_capital_costs_storage_power!(value::ColocatedSupplyStorageTechnology, val) = value.capital_costs_storage_power = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `unit_size_supply`."""
set_unit_size_supply!(value::ColocatedSupplyStorageTechnology, val) = value.unit_size_supply = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `unit_size_storage_power`."""
set_unit_size_storage_power!(value::ColocatedSupplyStorageTechnology, val) = value.unit_size_storage_power = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `base_year`."""
set_base_year!(value::ColocatedSupplyStorageTechnology, val) = value.base_year = val
"""Set [`ColocatedSupplyStorageTechnology`](@ref) `storage_financial_data`."""
set_storage_financial_data!(value::ColocatedSupplyStorageTechnology, val) = value.storage_financial_data = val
