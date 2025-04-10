#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct StorageTechnology{T <: PSY.Storage} <: ResourceTechnology
        base_power::Float64
        prime_mover_type::PrimeMovers
        lifetime::Int
        available::Bool
        min_discharge_fraction::Float64
        capacity_limits_charge::Union{Nothing, MinMax}
        name::String
        storage_tech::StorageTech
        duration_limits::MinMax
        id::Int64
        losses::Float64
        capital_costs_energy::PSY.ValueCurve
        financial_data::TechnologyFinancialData
        operation_costs::PSY.OperationalCost
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        ext::Dict
        region::Vector{RegionTopology}
        capacity_limits_energy::MinMax
        unit_size_energy::Float64
        unit_size_charge::Union{Nothing, Float64}
        efficiency::InOut
        unit_size_discharge::Float64
        capacity_limits_discharge::MinMax
        capital_costs_charge::Union{Nothing, PSY.ValueCurve}
        capital_costs_discharge::PSY.ValueCurve
    end

Candidate storage technology in a region.

# Arguments
- `base_power::Float64`: Base power
- `prime_mover_type::PrimeMovers`: (default: `PrimeMovers.OT`) Prime mover for generator
- `lifetime::Int`: (default: `100`) Maximum number of years a technology can be active once installed
- `available::Bool`: Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `min_discharge_fraction::Float64`: (default: `0.0`) Minimum discharge as a fraction of total discharge capacity
- `capacity_limits_charge::Union{Nothing, MinMax}`: (default: `nothing`) allowable installed power capacity for a storage technology
- `name::String`: The technology name
- `storage_tech::StorageTech`: Storage Technology Type
- `duration_limits::MinMax`: (default: `(min=0,max=1000.0)`) Minimum and maximum duration limits (energy to discharge capacity ratio) for a storage technology
- `id::Int64`: ID for individual storage technology
- `losses::Float64`: (default: `0.00`) Self-discharge of storage (fraction of energy stored per hour)
- `capital_costs_energy::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a technology.
- `financial_data::TechnologyFinancialData`: Struct containing relevant financial information for a technology
- `operation_costs::PSY.OperationalCost`: (default: `StorageCost()`) Fixed and variable O&M costs for a technology
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `region::Vector{RegionTopology}`: (default: `Vector()`) Location where technology is operated
- `capacity_limits_energy::MinMax`: (default: `(min=0,max=1e8)`) allowable installed energy capacity for a storage technology
- `unit_size_energy::Float64`: (default: `0.0`) Used for discrete investment decisions. Size of each unit being built (MW)
- `unit_size_charge::Union{Nothing, Float64}`: (default: `nothing`) Used for discrete investment decisions. Unit size of charging capacity (MW)
- `efficiency::InOut`: (default: `(in=1, out=1)`) Efficiency of charging storage
- `unit_size_discharge::Float64`: (default: `0.0`) Used for discrete investment decisions. Size of each unit of discharging capacity being built (MW)
- `capacity_limits_discharge::MinMax`: (default: `(min=0,max=1e8)`) allowable installed power capacity for a storage technology
- `capital_costs_charge::Union{Nothing, PSY.ValueCurve}`: (default: `nothing`) Capital costs for investing in a technology.
- `capital_costs_discharge::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a technology.
"""
mutable struct StorageTechnology{T <: PSY.Storage} <: ResourceTechnology
    "Base power"
    base_power::Float64
    "Prime mover for generator"
    prime_mover_type::PrimeMovers
    "Maximum number of years a technology can be active once installed"
    lifetime::Int
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
    "Minimum discharge as a fraction of total discharge capacity"
    min_discharge_fraction::Float64
    "allowable installed power capacity for a storage technology"
    capacity_limits_charge::Union{Nothing, MinMax}
    "The technology name"
    name::String
    "Storage Technology Type"
    storage_tech::StorageTech
    "Minimum and maximum duration limits (energy to discharge capacity ratio) for a storage technology"
    duration_limits::MinMax
    "ID for individual storage technology"
    id::Int64
    "Self-discharge of storage (fraction of energy stored per hour)"
    losses::Float64
    "Capital costs for investing in a technology."
    capital_costs_energy::PSY.ValueCurve
    "Struct containing relevant financial information for a technology"
    financial_data::TechnologyFinancialData
    "Fixed and variable O&M costs for a technology"
    operation_costs::PSY.OperationalCost
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Location where technology is operated"
    region::Vector{RegionTopology}
    "allowable installed energy capacity for a storage technology"
    capacity_limits_energy::MinMax
    "Used for discrete investment decisions. Size of each unit being built (MW)"
    unit_size_energy::Float64
    "Used for discrete investment decisions. Unit size of charging capacity (MW)"
    unit_size_charge::Union{Nothing, Float64}
    "Efficiency of charging storage"
    efficiency::InOut
    "Used for discrete investment decisions. Size of each unit of discharging capacity being built (MW)"
    unit_size_discharge::Float64
    "allowable installed power capacity for a storage technology"
    capacity_limits_discharge::MinMax
    "Capital costs for investing in a technology."
    capital_costs_charge::Union{Nothing, PSY.ValueCurve}
    "Capital costs for investing in a technology."
    capital_costs_discharge::PSY.ValueCurve
end


function StorageTechnology{T}(; base_power, prime_mover_type=PrimeMovers.OT, lifetime=100, available, min_discharge_fraction=0.0, capacity_limits_charge=nothing, name, storage_tech, duration_limits=(min=0,max=1000.0), id, losses=0.00, capital_costs_energy=LinearCurve(0.0), financial_data, operation_costs=StorageCost(), power_systems_type, internal=InfrastructureSystemsInternal(), ext=Dict(), region=Vector(), capacity_limits_energy=(min=0,max=1e8), unit_size_energy=0.0, unit_size_charge=nothing, efficiency=(in=1, out=1), unit_size_discharge=0.0, capacity_limits_discharge=(min=0,max=1e8), capital_costs_charge=nothing, capital_costs_discharge=LinearCurve(0.0), ) where T <: PSY.Storage
    StorageTechnology{T}(base_power, prime_mover_type, lifetime, available, min_discharge_fraction, capacity_limits_charge, name, storage_tech, duration_limits, id, losses, capital_costs_energy, financial_data, operation_costs, power_systems_type, internal, ext, region, capacity_limits_energy, unit_size_energy, unit_size_charge, efficiency, unit_size_discharge, capacity_limits_discharge, capital_costs_charge, capital_costs_discharge, )
end

"""Get [`StorageTechnology`](@ref) `base_power`."""
get_base_power(value::StorageTechnology) = value.base_power
"""Get [`StorageTechnology`](@ref) `prime_mover_type`."""
get_prime_mover_type(value::StorageTechnology) = value.prime_mover_type
"""Get [`StorageTechnology`](@ref) `lifetime`."""
get_lifetime(value::StorageTechnology) = value.lifetime
"""Get [`StorageTechnology`](@ref) `available`."""
get_available(value::StorageTechnology) = value.available
"""Get [`StorageTechnology`](@ref) `min_discharge_fraction`."""
get_min_discharge_fraction(value::StorageTechnology) = value.min_discharge_fraction
"""Get [`StorageTechnology`](@ref) `capacity_limits_charge`."""
get_capacity_limits_charge(value::StorageTechnology) = value.capacity_limits_charge
"""Get [`StorageTechnology`](@ref) `name`."""
get_name(value::StorageTechnology) = value.name
"""Get [`StorageTechnology`](@ref) `storage_tech`."""
get_storage_tech(value::StorageTechnology) = value.storage_tech
"""Get [`StorageTechnology`](@ref) `duration_limits`."""
get_duration_limits(value::StorageTechnology) = value.duration_limits
"""Get [`StorageTechnology`](@ref) `id`."""
get_id(value::StorageTechnology) = value.id
"""Get [`StorageTechnology`](@ref) `losses`."""
get_losses(value::StorageTechnology) = value.losses
"""Get [`StorageTechnology`](@ref) `capital_costs_energy`."""
get_capital_costs_energy(value::StorageTechnology) = value.capital_costs_energy
"""Get [`StorageTechnology`](@ref) `financial_data`."""
get_financial_data(value::StorageTechnology) = value.financial_data
"""Get [`StorageTechnology`](@ref) `operation_costs`."""
get_operation_costs(value::StorageTechnology) = value.operation_costs
"""Get [`StorageTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::StorageTechnology) = value.power_systems_type
"""Get [`StorageTechnology`](@ref) `internal`."""
get_internal(value::StorageTechnology) = value.internal
"""Get [`StorageTechnology`](@ref) `ext`."""
get_ext(value::StorageTechnology) = value.ext
"""Get [`StorageTechnology`](@ref) `region`."""
get_region(value::StorageTechnology) = value.region
"""Get [`StorageTechnology`](@ref) `capacity_limits_energy`."""
get_capacity_limits_energy(value::StorageTechnology) = value.capacity_limits_energy
"""Get [`StorageTechnology`](@ref) `unit_size_energy`."""
get_unit_size_energy(value::StorageTechnology) = value.unit_size_energy
"""Get [`StorageTechnology`](@ref) `unit_size_charge`."""
get_unit_size_charge(value::StorageTechnology) = value.unit_size_charge
"""Get [`StorageTechnology`](@ref) `efficiency`."""
get_efficiency(value::StorageTechnology) = value.efficiency
"""Get [`StorageTechnology`](@ref) `unit_size_discharge`."""
get_unit_size_discharge(value::StorageTechnology) = value.unit_size_discharge
"""Get [`StorageTechnology`](@ref) `capacity_limits_discharge`."""
get_capacity_limits_discharge(value::StorageTechnology) = value.capacity_limits_discharge
"""Get [`StorageTechnology`](@ref) `capital_costs_charge`."""
get_capital_costs_charge(value::StorageTechnology) = value.capital_costs_charge
"""Get [`StorageTechnology`](@ref) `capital_costs_discharge`."""
get_capital_costs_discharge(value::StorageTechnology) = value.capital_costs_discharge

"""Set [`StorageTechnology`](@ref) `base_power`."""
set_base_power!(value::StorageTechnology, val) = value.base_power = val
"""Set [`StorageTechnology`](@ref) `prime_mover_type`."""
set_prime_mover_type!(value::StorageTechnology, val) = value.prime_mover_type = val
"""Set [`StorageTechnology`](@ref) `lifetime`."""
set_lifetime!(value::StorageTechnology, val) = value.lifetime = val
"""Set [`StorageTechnology`](@ref) `available`."""
set_available!(value::StorageTechnology, val) = value.available = val
"""Set [`StorageTechnology`](@ref) `min_discharge_fraction`."""
set_min_discharge_fraction!(value::StorageTechnology, val) = value.min_discharge_fraction = val
"""Set [`StorageTechnology`](@ref) `capacity_limits_charge`."""
set_capacity_limits_charge!(value::StorageTechnology, val) = value.capacity_limits_charge = val
"""Set [`StorageTechnology`](@ref) `name`."""
set_name!(value::StorageTechnology, val) = value.name = val
"""Set [`StorageTechnology`](@ref) `storage_tech`."""
set_storage_tech!(value::StorageTechnology, val) = value.storage_tech = val
"""Set [`StorageTechnology`](@ref) `duration_limits`."""
set_duration_limits!(value::StorageTechnology, val) = value.duration_limits = val
"""Set [`StorageTechnology`](@ref) `id`."""
set_id!(value::StorageTechnology, val) = value.id = val
"""Set [`StorageTechnology`](@ref) `losses`."""
set_losses!(value::StorageTechnology, val) = value.losses = val
"""Set [`StorageTechnology`](@ref) `capital_costs_energy`."""
set_capital_costs_energy!(value::StorageTechnology, val) = value.capital_costs_energy = val
"""Set [`StorageTechnology`](@ref) `financial_data`."""
set_financial_data!(value::StorageTechnology, val) = value.financial_data = val
"""Set [`StorageTechnology`](@ref) `operation_costs`."""
set_operation_costs!(value::StorageTechnology, val) = value.operation_costs = val
"""Set [`StorageTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::StorageTechnology, val) = value.power_systems_type = val
"""Set [`StorageTechnology`](@ref) `internal`."""
set_internal!(value::StorageTechnology, val) = value.internal = val
"""Set [`StorageTechnology`](@ref) `ext`."""
set_ext!(value::StorageTechnology, val) = value.ext = val
"""Set [`StorageTechnology`](@ref) `region`."""
set_region!(value::StorageTechnology, val) = value.region = val
"""Set [`StorageTechnology`](@ref) `capacity_limits_energy`."""
set_capacity_limits_energy!(value::StorageTechnology, val) = value.capacity_limits_energy = val
"""Set [`StorageTechnology`](@ref) `unit_size_energy`."""
set_unit_size_energy!(value::StorageTechnology, val) = value.unit_size_energy = val
"""Set [`StorageTechnology`](@ref) `unit_size_charge`."""
set_unit_size_charge!(value::StorageTechnology, val) = value.unit_size_charge = val
"""Set [`StorageTechnology`](@ref) `efficiency`."""
set_efficiency!(value::StorageTechnology, val) = value.efficiency = val
"""Set [`StorageTechnology`](@ref) `unit_size_discharge`."""
set_unit_size_discharge!(value::StorageTechnology, val) = value.unit_size_discharge = val
"""Set [`StorageTechnology`](@ref) `capacity_limits_discharge`."""
set_capacity_limits_discharge!(value::StorageTechnology, val) = value.capacity_limits_discharge = val
"""Set [`StorageTechnology`](@ref) `capital_costs_charge`."""
set_capital_costs_charge!(value::StorageTechnology, val) = value.capital_costs_charge = val
"""Set [`StorageTechnology`](@ref) `capital_costs_discharge`."""
set_capital_costs_discharge!(value::StorageTechnology, val) = value.capital_costs_discharge = val

function serialize_openapi_struct(technology::StorageTechnology{T}, vals...) where T <: PSY.Storage
    base_struct = APIServer.StorageTechnology(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:StorageTechnology}, vals::Dict)
    return IS.deserialize_struct(APIServer.StorageTechnology, vals)
end
