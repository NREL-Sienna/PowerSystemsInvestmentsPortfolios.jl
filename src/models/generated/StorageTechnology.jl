#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct StorageTechnology{T <: PSY.Storage} <: Technology
        base_power::Float64
        prime_mover_type::PrimeMovers
        lifetime::Int
        available::Bool
        name::String
        storage_tech::StorageTech
        capital_costs_power::PSY.ValueCurve
        capacity_power_limits::MinMax
        capacity_energy_limits::MinMax
        operations_costs_power::PSY.OperationalCost
        unit_size_power::Float64
        id::Int64
        duration_limits::MinMax
        capital_costs_energy::PSY.ValueCurve
        losses::Float64
        financial_data::TechnologyFinancialData
        existing_capacity_power::Float64
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        ext::Dict
        balancing_topology::String
        region::Vector{Region}
        unit_size_energy::Float64
        base_year::Int
        existing_capacity_energy::Float64
        efficiency::InOut
        operations_costs_energy::PSY.OperationalCost
    end



# Arguments
- `base_power::Float64`: Base power
- `prime_mover_type::PrimeMovers`: (default: `PrimeMovers.OT`) Prime mover for generator
- `lifetime::Int`: (default: `100`) Maximum number of years a technology can be active once installed
- `available::Bool`: identifies whether the technology is available
- `name::String`: The technology name
- `storage_tech::StorageTech`: Storage Technology Type
- `capital_costs_power::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a technology.
- `capacity_power_limits::MinMax`: (default: `(min=0,max=1e8)`) allowable installed power capacity for a storage technology
- `capacity_energy_limits::MinMax`: (default: `(min=0,max=1e8)`) allowable installed energy capacity for a storage technology
- `operations_costs_power::PSY.OperationalCost`: (default: `StorageCost()`) Fixed and variable O&M costs for a technology
- `unit_size_power::Float64`: (default: `0.0`) Used for discrete investment decisions. Size of each unit being built (MW)
- `id::Int64`: ID for individual storage technology
- `duration_limits::MinMax`: (default: `(min=0,max=1000)`) Minimum required durection for a storage technology
- `capital_costs_energy::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a technology.
- `losses::Float64`: (default: `1.0`) Power loss (pct per hour)
- `financial_data::TechnologyFinancialData`: Struct containing relevant financial information for a technology
- `existing_capacity_power::Float64`: (default: `0.0`) Pre-existing power capacity for a technology (MW)
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `balancing_topology::String`: Set of balancing nodes
- `region::Vector{Region}`: (default: `Vector()`) Region
- `unit_size_energy::Float64`: (default: `0.0`) Used for discrete investment decisions. Size of each unit being built (MW)
- `base_year::Int`: (default: `2020`) Reference year for technology data
- `existing_capacity_energy::Float64`: (default: `0.0`) Pre-existing energy capacity for a technology (MWh)
- `efficiency::InOut`: (default: `(in=1, out=1)`) Efficiency of charging storage
- `operations_costs_energy::PSY.OperationalCost`: (default: `StorageCost()`) Fixed and variable O&M costs for a technology
"""
mutable struct StorageTechnology{T <: PSY.Storage} <: Technology
    "Base power"
    base_power::Float64
    "Prime mover for generator"
    prime_mover_type::PrimeMovers
    "Maximum number of years a technology can be active once installed"
    lifetime::Int
    "identifies whether the technology is available"
    available::Bool
    "The technology name"
    name::String
    "Storage Technology Type"
    storage_tech::StorageTech
    "Capital costs for investing in a technology."
    capital_costs_power::PSY.ValueCurve
    "allowable installed power capacity for a storage technology"
    capacity_power_limits::MinMax
    "allowable installed energy capacity for a storage technology"
    capacity_energy_limits::MinMax
    "Fixed and variable O&M costs for a technology"
    operations_costs_power::PSY.OperationalCost
    "Used for discrete investment decisions. Size of each unit being built (MW)"
    unit_size_power::Float64
    "ID for individual storage technology"
    id::Int64
    "Minimum required durection for a storage technology"
    duration_limits::MinMax
    "Capital costs for investing in a technology."
    capital_costs_energy::PSY.ValueCurve
    "Power loss (pct per hour)"
    losses::Float64
    "Struct containing relevant financial information for a technology"
    financial_data::TechnologyFinancialData
    "Pre-existing power capacity for a technology (MW)"
    existing_capacity_power::Float64
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Set of balancing nodes"
    balancing_topology::String
    "Region"
    region::Vector{Region}
    "Used for discrete investment decisions. Size of each unit being built (MW)"
    unit_size_energy::Float64
    "Reference year for technology data"
    base_year::Int
    "Pre-existing energy capacity for a technology (MWh)"
    existing_capacity_energy::Float64
    "Efficiency of charging storage"
    efficiency::InOut
    "Fixed and variable O&M costs for a technology"
    operations_costs_energy::PSY.OperationalCost
end


function StorageTechnology{T}(; base_power, prime_mover_type=PrimeMovers.OT, lifetime=100, available, name, storage_tech, capital_costs_power=LinearCurve(0.0), capacity_power_limits=(min=0,max=1e8), capacity_energy_limits=(min=0,max=1e8), operations_costs_power=StorageCost(), unit_size_power=0.0, id, duration_limits=(min=0,max=1000), capital_costs_energy=LinearCurve(0.0), losses=1.0, financial_data, existing_capacity_power=0.0, power_systems_type, internal=InfrastructureSystemsInternal(), ext=Dict(), balancing_topology, region=Vector(), unit_size_energy=0.0, base_year=2020, existing_capacity_energy=0.0, efficiency=(in=1, out=1), operations_costs_energy=StorageCost(), ) where T <: PSY.Storage
    StorageTechnology{T}(base_power, prime_mover_type, lifetime, available, name, storage_tech, capital_costs_power, capacity_power_limits, capacity_energy_limits, operations_costs_power, unit_size_power, id, duration_limits, capital_costs_energy, losses, financial_data, existing_capacity_power, power_systems_type, internal, ext, balancing_topology, region, unit_size_energy, base_year, existing_capacity_energy, efficiency, operations_costs_energy, )
end

"""Get [`StorageTechnology`](@ref) `base_power`."""
get_base_power(value::StorageTechnology) = value.base_power
"""Get [`StorageTechnology`](@ref) `prime_mover_type`."""
get_prime_mover_type(value::StorageTechnology) = value.prime_mover_type
"""Get [`StorageTechnology`](@ref) `lifetime`."""
get_lifetime(value::StorageTechnology) = value.lifetime
"""Get [`StorageTechnology`](@ref) `available`."""
get_available(value::StorageTechnology) = value.available
"""Get [`StorageTechnology`](@ref) `name`."""
get_name(value::StorageTechnology) = value.name
"""Get [`StorageTechnology`](@ref) `storage_tech`."""
get_storage_tech(value::StorageTechnology) = value.storage_tech
"""Get [`StorageTechnology`](@ref) `capital_costs_power`."""
get_capital_costs_power(value::StorageTechnology) = value.capital_costs_power
"""Get [`StorageTechnology`](@ref) `capacity_power_limits`."""
get_capacity_power_limits(value::StorageTechnology) = value.capacity_power_limits
"""Get [`StorageTechnology`](@ref) `capacity_energy_limits`."""
get_capacity_energy_limits(value::StorageTechnology) = value.capacity_energy_limits
"""Get [`StorageTechnology`](@ref) `operations_costs_power`."""
get_operations_costs_power(value::StorageTechnology) = value.operations_costs_power
"""Get [`StorageTechnology`](@ref) `unit_size_power`."""
get_unit_size_power(value::StorageTechnology) = value.unit_size_power
"""Get [`StorageTechnology`](@ref) `id`."""
get_id(value::StorageTechnology) = value.id
"""Get [`StorageTechnology`](@ref) `duration_limits`."""
get_duration_limits(value::StorageTechnology) = value.duration_limits
"""Get [`StorageTechnology`](@ref) `capital_costs_energy`."""
get_capital_costs_energy(value::StorageTechnology) = value.capital_costs_energy
"""Get [`StorageTechnology`](@ref) `losses`."""
get_losses(value::StorageTechnology) = value.losses
"""Get [`StorageTechnology`](@ref) `financial_data`."""
get_financial_data(value::StorageTechnology) = value.financial_data
"""Get [`StorageTechnology`](@ref) `existing_capacity_power`."""
get_existing_capacity_power(value::StorageTechnology) = value.existing_capacity_power
"""Get [`StorageTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::StorageTechnology) = value.power_systems_type
"""Get [`StorageTechnology`](@ref) `internal`."""
get_internal(value::StorageTechnology) = value.internal
"""Get [`StorageTechnology`](@ref) `ext`."""
get_ext(value::StorageTechnology) = value.ext
"""Get [`StorageTechnology`](@ref) `balancing_topology`."""
get_balancing_topology(value::StorageTechnology) = value.balancing_topology
"""Get [`StorageTechnology`](@ref) `region`."""
get_region(value::StorageTechnology) = value.region
"""Get [`StorageTechnology`](@ref) `unit_size_energy`."""
get_unit_size_energy(value::StorageTechnology) = value.unit_size_energy
"""Get [`StorageTechnology`](@ref) `base_year`."""
get_base_year(value::StorageTechnology) = value.base_year
"""Get [`StorageTechnology`](@ref) `existing_capacity_energy`."""
get_existing_capacity_energy(value::StorageTechnology) = value.existing_capacity_energy
"""Get [`StorageTechnology`](@ref) `efficiency`."""
get_efficiency(value::StorageTechnology) = value.efficiency
"""Get [`StorageTechnology`](@ref) `operations_costs_energy`."""
get_operations_costs_energy(value::StorageTechnology) = value.operations_costs_energy

"""Set [`StorageTechnology`](@ref) `base_power`."""
set_base_power!(value::StorageTechnology, val) = value.base_power = val
"""Set [`StorageTechnology`](@ref) `prime_mover_type`."""
set_prime_mover_type!(value::StorageTechnology, val) = value.prime_mover_type = val
"""Set [`StorageTechnology`](@ref) `lifetime`."""
set_lifetime!(value::StorageTechnology, val) = value.lifetime = val
"""Set [`StorageTechnology`](@ref) `available`."""
set_available!(value::StorageTechnology, val) = value.available = val
"""Set [`StorageTechnology`](@ref) `name`."""
set_name!(value::StorageTechnology, val) = value.name = val
"""Set [`StorageTechnology`](@ref) `storage_tech`."""
set_storage_tech!(value::StorageTechnology, val) = value.storage_tech = val
"""Set [`StorageTechnology`](@ref) `capital_costs_power`."""
set_capital_costs_power!(value::StorageTechnology, val) = value.capital_costs_power = val
"""Set [`StorageTechnology`](@ref) `capacity_power_limits`."""
set_capacity_power_limits!(value::StorageTechnology, val) = value.capacity_power_limits = val
"""Set [`StorageTechnology`](@ref) `capacity_energy_limits`."""
set_capacity_energy_limits!(value::StorageTechnology, val) = value.capacity_energy_limits = val
"""Set [`StorageTechnology`](@ref) `operations_costs_power`."""
set_operations_costs_power!(value::StorageTechnology, val) = value.operations_costs_power = val
"""Set [`StorageTechnology`](@ref) `unit_size_power`."""
set_unit_size_power!(value::StorageTechnology, val) = value.unit_size_power = val
"""Set [`StorageTechnology`](@ref) `id`."""
set_id!(value::StorageTechnology, val) = value.id = val
"""Set [`StorageTechnology`](@ref) `duration_limits`."""
set_duration_limits!(value::StorageTechnology, val) = value.duration_limits = val
"""Set [`StorageTechnology`](@ref) `capital_costs_energy`."""
set_capital_costs_energy!(value::StorageTechnology, val) = value.capital_costs_energy = val
"""Set [`StorageTechnology`](@ref) `losses`."""
set_losses!(value::StorageTechnology, val) = value.losses = val
"""Set [`StorageTechnology`](@ref) `financial_data`."""
set_financial_data!(value::StorageTechnology, val) = value.financial_data = val
"""Set [`StorageTechnology`](@ref) `existing_capacity_power`."""
set_existing_capacity_power!(value::StorageTechnology, val) = value.existing_capacity_power = val
"""Set [`StorageTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::StorageTechnology, val) = value.power_systems_type = val
"""Set [`StorageTechnology`](@ref) `internal`."""
set_internal!(value::StorageTechnology, val) = value.internal = val
"""Set [`StorageTechnology`](@ref) `ext`."""
set_ext!(value::StorageTechnology, val) = value.ext = val
"""Set [`StorageTechnology`](@ref) `balancing_topology`."""
set_balancing_topology!(value::StorageTechnology, val) = value.balancing_topology = val
"""Set [`StorageTechnology`](@ref) `region`."""
set_region!(value::StorageTechnology, val) = value.region = val
"""Set [`StorageTechnology`](@ref) `unit_size_energy`."""
set_unit_size_energy!(value::StorageTechnology, val) = value.unit_size_energy = val
"""Set [`StorageTechnology`](@ref) `base_year`."""
set_base_year!(value::StorageTechnology, val) = value.base_year = val
"""Set [`StorageTechnology`](@ref) `existing_capacity_energy`."""
set_existing_capacity_energy!(value::StorageTechnology, val) = value.existing_capacity_energy = val
"""Set [`StorageTechnology`](@ref) `efficiency`."""
set_efficiency!(value::StorageTechnology, val) = value.efficiency = val
"""Set [`StorageTechnology`](@ref) `operations_costs_energy`."""
set_operations_costs_energy!(value::StorageTechnology, val) = value.operations_costs_energy = val

function serialize_openapi_struct(technology::StorageTechnology{T}, vals...) where T <: PSY.Storage
    base_struct = APIServer.StorageTechnology(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:StorageTechnology}, vals::Dict)
    return IS.deserialize_struct(APIServer.StorageTechnology, vals)
end
