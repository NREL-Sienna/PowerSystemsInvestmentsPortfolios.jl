#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct StorageTechnology{T <: PSY.Storage} <: ResourceTechnology
        name::String
        region::Vector{RegionTopology}
        id::Int64
        available::Bool
        power_systems_type::String
        prime_mover_type::PrimeMovers
        storage_tech::StorageTech
        capital_costs_energy::PSY.ValueCurve
        capital_costs_charge::Union{Nothing, PSY.ValueCurve}
        capital_costs_discharge::PSY.ValueCurve
        operation_costs::PSY.OperationalCost
        min_discharge_fraction::Float64
        unit_size_charge::Union{Nothing, Float64}
        unit_size_discharge::Float64
        unit_size_energy::Float64
        capacity_limits_charge::Union{Nothing, MinMax}
        capacity_limits_discharge::MinMax
        capacity_limits_energy::MinMax
        duration_limits::MinMax
        efficiency::InOut
        losses::Float64
        lifetime::Int
        financial_data::TechnologyFinancialData
        ext::Dict
        internal::InfrastructureSystemsInternal
    end

Candidate storage technology in a region.

# Arguments
- `name::String`: The technology name
- `region::Vector{RegionTopology}`: (default: `Vector()`) Location where technology is operated
- `id::Int64`: ID for individual storage technology
- `available::Bool`: Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `power_systems_type::String`: Corresponding type in PowerSystems.jl to be used in PCM modeling
- `prime_mover_type::PrimeMovers`: (default: `PrimeMovers.OT`) Prime mover technology according to EIA 923.
- `storage_tech::StorageTech`: (default: `StorageTech.OTHER_CHEM`) Storage Technology Complementary to EIA 923.
- `capital_costs_energy::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a technology. (USD/MWh)
- `capital_costs_charge::Union{Nothing, PSY.ValueCurve}`: (default: `nothing`) Capital costs for investing in a technology. (USD/MW)
- `capital_costs_discharge::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a technology. (USD/MW)
- `operation_costs::PSY.OperationalCost`: (default: `StorageCost()`) Fixed and variable O&M costs for a technology
- `min_discharge_fraction::Float64`: (default: `0.0`) Minimum discharge as a fraction of total discharge capacity
- `unit_size_charge::Union{Nothing, Float64}`: (default: `nothing`) Used for discrete investment decisions. Unit size of charging capacity (MW)
- `unit_size_discharge::Float64`: (default: `0.0`) Used for discrete investment decisions. Size of each unit of discharging capacity being built (MW)
- `unit_size_energy::Float64`: (default: `0.0`) Used for discrete investment decisions. Size of each unit being built (MWh)
- `capacity_limits_charge::Union{Nothing, MinMax}`: (default: `nothing`) allowable installed power capacity for a storage technology (MW)
- `capacity_limits_discharge::MinMax`: (default: `(min=0,max=1e8)`) allowable installed power capacity for a storage technology (MW)
- `capacity_limits_energy::MinMax`: (default: `(min=0,max=1e8)`) allowable installed energy capacity for a storage technology (MWh)
- `duration_limits::MinMax`: (default: `(min=0,max=1000.0)`) Minimum and maximum duration limits (energy to discharge capacity ratio) for a storage technology (hours)
- `efficiency::InOut`: (default: `(in=1, out=1)`) Efficiency of charging storage, fraction of total charge (in) and discharge (out) capacity
- `losses::Float64`: (default: `0.00`) Self-discharge of storage (fraction of energy stored per hour)
- `lifetime::Int`: (default: `100`) Maximum number of years a technology can be active once installed (years)
- `financial_data::TechnologyFinancialData`: Struct containing relevant financial information for a technology
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
"""
mutable struct StorageTechnology{T <: PSY.Storage} <: ResourceTechnology
    "The technology name"
    name::String
    "Location where technology is operated"
    region::Vector{RegionTopology}
    "ID for individual storage technology"
    id::Int64
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
    "Corresponding type in PowerSystems.jl to be used in PCM modeling"
    power_systems_type::String
    "Prime mover technology according to EIA 923."
    prime_mover_type::PrimeMovers
    "Storage Technology Complementary to EIA 923."
    storage_tech::StorageTech
    "Capital costs for investing in a technology. (USD/MWh)"
    capital_costs_energy::PSY.ValueCurve
    "Capital costs for investing in a technology. (USD/MW)"
    capital_costs_charge::Union{Nothing, PSY.ValueCurve}
    "Capital costs for investing in a technology. (USD/MW)"
    capital_costs_discharge::PSY.ValueCurve
    "Fixed and variable O&M costs for a technology"
    operation_costs::PSY.OperationalCost
    "Minimum discharge as a fraction of total discharge capacity"
    min_discharge_fraction::Float64
    "Used for discrete investment decisions. Unit size of charging capacity (MW)"
    unit_size_charge::Union{Nothing, Float64}
    "Used for discrete investment decisions. Size of each unit of discharging capacity being built (MW)"
    unit_size_discharge::Float64
    "Used for discrete investment decisions. Size of each unit being built (MWh)"
    unit_size_energy::Float64
    "allowable installed power capacity for a storage technology (MW)"
    capacity_limits_charge::Union{Nothing, MinMax}
    "allowable installed power capacity for a storage technology (MW)"
    capacity_limits_discharge::MinMax
    "allowable installed energy capacity for a storage technology (MWh)"
    capacity_limits_energy::MinMax
    "Minimum and maximum duration limits (energy to discharge capacity ratio) for a storage technology (hours)"
    duration_limits::MinMax
    "Efficiency of charging storage, fraction of total charge (in) and discharge (out) capacity"
    efficiency::InOut
    "Self-discharge of storage (fraction of energy stored per hour)"
    losses::Float64
    "Maximum number of years a technology can be active once installed (years)"
    lifetime::Int
    "Struct containing relevant financial information for a technology"
    financial_data::TechnologyFinancialData
    "Optional dictionary to provide additional data"
    ext::Dict
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
end


function StorageTechnology{T}(; name, region=Vector(), id, available, power_systems_type, prime_mover_type=PrimeMovers.OT, storage_tech=StorageTech.OTHER_CHEM, capital_costs_energy=LinearCurve(0.0), capital_costs_charge=nothing, capital_costs_discharge=LinearCurve(0.0), operation_costs=StorageCost(), min_discharge_fraction=0.0, unit_size_charge=nothing, unit_size_discharge=0.0, unit_size_energy=0.0, capacity_limits_charge=nothing, capacity_limits_discharge=(min=0,max=1e8), capacity_limits_energy=(min=0,max=1e8), duration_limits=(min=0,max=1000.0), efficiency=(in=1, out=1), losses=0.00, lifetime=100, financial_data, ext=Dict(), internal=InfrastructureSystemsInternal(), ) where T <: PSY.Storage
    StorageTechnology{T}(name, region, id, available, power_systems_type, prime_mover_type, storage_tech, capital_costs_energy, capital_costs_charge, capital_costs_discharge, operation_costs, min_discharge_fraction, unit_size_charge, unit_size_discharge, unit_size_energy, capacity_limits_charge, capacity_limits_discharge, capacity_limits_energy, duration_limits, efficiency, losses, lifetime, financial_data, ext, internal, )
end

"""Get [`StorageTechnology`](@ref) `name`."""
get_name(value::StorageTechnology) = value.name
"""Get [`StorageTechnology`](@ref) `region`."""
get_region(value::StorageTechnology) = value.region
"""Get [`StorageTechnology`](@ref) `id`."""
get_id(value::StorageTechnology) = value.id
"""Get [`StorageTechnology`](@ref) `available`."""
get_available(value::StorageTechnology) = value.available
"""Get [`StorageTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::StorageTechnology) = value.power_systems_type
"""Get [`StorageTechnology`](@ref) `prime_mover_type`."""
get_prime_mover_type(value::StorageTechnology) = value.prime_mover_type
"""Get [`StorageTechnology`](@ref) `storage_tech`."""
get_storage_tech(value::StorageTechnology) = value.storage_tech
"""Get [`StorageTechnology`](@ref) `capital_costs_energy`."""
get_capital_costs_energy(value::StorageTechnology) = value.capital_costs_energy
"""Get [`StorageTechnology`](@ref) `capital_costs_charge`."""
get_capital_costs_charge(value::StorageTechnology) = value.capital_costs_charge
"""Get [`StorageTechnology`](@ref) `capital_costs_discharge`."""
get_capital_costs_discharge(value::StorageTechnology) = value.capital_costs_discharge
"""Get [`StorageTechnology`](@ref) `operation_costs`."""
get_operation_costs(value::StorageTechnology) = value.operation_costs
"""Get [`StorageTechnology`](@ref) `min_discharge_fraction` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`get_min_discharge_fraction_unitful`](@ref)."""
get_min_discharge_fraction(value::StorageTechnology, units) = InfrastructureSystems._strip_units(get_value(value, Val(:min_discharge_fraction), Val(:mw), units))
"""Get [`StorageTechnology`](@ref) `min_discharge_fraction` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`get_min_discharge_fraction`](@ref)."""
get_min_discharge_fraction_unitful(value::StorageTechnology, units) = get_value(value, Val(:min_discharge_fraction), Val(:mw), units)
InfrastructureSystems.display_units_arg(::typeof(get_min_discharge_fraction), ::Type{StorageTechnology{T}}) where {T <: PSY.Storage} = InfrastructureSystems.NU
InfrastructureSystems.display_units_arg(::typeof(get_min_discharge_fraction_unitful), ::Type{StorageTechnology{T}}) where {T <: PSY.Storage} = InfrastructureSystems.NU
"""Get [`StorageTechnology`](@ref) `unit_size_charge` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`get_unit_size_charge_unitful`](@ref)."""
get_unit_size_charge(value::StorageTechnology, units) = InfrastructureSystems._strip_units(get_value(value, Val(:unit_size_charge), Val(:mw), units))
"""Get [`StorageTechnology`](@ref) `unit_size_charge` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`get_unit_size_charge`](@ref)."""
get_unit_size_charge_unitful(value::StorageTechnology, units) = get_value(value, Val(:unit_size_charge), Val(:mw), units)
InfrastructureSystems.display_units_arg(::typeof(get_unit_size_charge), ::Type{StorageTechnology{T}}) where {T <: PSY.Storage} = InfrastructureSystems.NU
InfrastructureSystems.display_units_arg(::typeof(get_unit_size_charge_unitful), ::Type{StorageTechnology{T}}) where {T <: PSY.Storage} = InfrastructureSystems.NU
"""Get [`StorageTechnology`](@ref) `unit_size_discharge` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`get_unit_size_discharge_unitful`](@ref)."""
get_unit_size_discharge(value::StorageTechnology, units) = InfrastructureSystems._strip_units(get_value(value, Val(:unit_size_discharge), Val(:mw), units))
"""Get [`StorageTechnology`](@ref) `unit_size_discharge` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`get_unit_size_discharge`](@ref)."""
get_unit_size_discharge_unitful(value::StorageTechnology, units) = get_value(value, Val(:unit_size_discharge), Val(:mw), units)
InfrastructureSystems.display_units_arg(::typeof(get_unit_size_discharge), ::Type{StorageTechnology{T}}) where {T <: PSY.Storage} = InfrastructureSystems.NU
InfrastructureSystems.display_units_arg(::typeof(get_unit_size_discharge_unitful), ::Type{StorageTechnology{T}}) where {T <: PSY.Storage} = InfrastructureSystems.NU
"""Get [`StorageTechnology`](@ref) `unit_size_energy` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`get_unit_size_energy_unitful`](@ref)."""
get_unit_size_energy(value::StorageTechnology, units) = InfrastructureSystems._strip_units(get_value(value, Val(:unit_size_energy), Val(:mwh), units))
"""Get [`StorageTechnology`](@ref) `unit_size_energy` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`get_unit_size_energy`](@ref)."""
get_unit_size_energy_unitful(value::StorageTechnology, units) = get_value(value, Val(:unit_size_energy), Val(:mwh), units)
InfrastructureSystems.display_units_arg(::typeof(get_unit_size_energy), ::Type{StorageTechnology{T}}) where {T <: PSY.Storage} = InfrastructureSystems.NU
InfrastructureSystems.display_units_arg(::typeof(get_unit_size_energy_unitful), ::Type{StorageTechnology{T}}) where {T <: PSY.Storage} = InfrastructureSystems.NU
"""Get [`StorageTechnology`](@ref) `capacity_limits_charge` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`get_capacity_limits_charge_unitful`](@ref)."""
get_capacity_limits_charge(value::StorageTechnology, units) = InfrastructureSystems._strip_units(get_value(value, Val(:capacity_limits_charge), Val(:mw), units))
"""Get [`StorageTechnology`](@ref) `capacity_limits_charge` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`get_capacity_limits_charge`](@ref)."""
get_capacity_limits_charge_unitful(value::StorageTechnology, units) = get_value(value, Val(:capacity_limits_charge), Val(:mw), units)
InfrastructureSystems.display_units_arg(::typeof(get_capacity_limits_charge), ::Type{StorageTechnology{T}}) where {T <: PSY.Storage} = InfrastructureSystems.NU
InfrastructureSystems.display_units_arg(::typeof(get_capacity_limits_charge_unitful), ::Type{StorageTechnology{T}}) where {T <: PSY.Storage} = InfrastructureSystems.NU
"""Get [`StorageTechnology`](@ref) `capacity_limits_discharge` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`get_capacity_limits_discharge_unitful`](@ref)."""
get_capacity_limits_discharge(value::StorageTechnology, units) = InfrastructureSystems._strip_units(get_value(value, Val(:capacity_limits_discharge), Val(:mw), units))
"""Get [`StorageTechnology`](@ref) `capacity_limits_discharge` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`get_capacity_limits_discharge`](@ref)."""
get_capacity_limits_discharge_unitful(value::StorageTechnology, units) = get_value(value, Val(:capacity_limits_discharge), Val(:mw), units)
InfrastructureSystems.display_units_arg(::typeof(get_capacity_limits_discharge), ::Type{StorageTechnology{T}}) where {T <: PSY.Storage} = InfrastructureSystems.NU
InfrastructureSystems.display_units_arg(::typeof(get_capacity_limits_discharge_unitful), ::Type{StorageTechnology{T}}) where {T <: PSY.Storage} = InfrastructureSystems.NU
"""Get [`StorageTechnology`](@ref) `capacity_limits_energy` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`get_capacity_limits_energy_unitful`](@ref)."""
get_capacity_limits_energy(value::StorageTechnology, units) = InfrastructureSystems._strip_units(get_value(value, Val(:capacity_limits_energy), Val(:mwh), units))
"""Get [`StorageTechnology`](@ref) `capacity_limits_energy` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`get_capacity_limits_energy`](@ref)."""
get_capacity_limits_energy_unitful(value::StorageTechnology, units) = get_value(value, Val(:capacity_limits_energy), Val(:mwh), units)
InfrastructureSystems.display_units_arg(::typeof(get_capacity_limits_energy), ::Type{StorageTechnology{T}}) where {T <: PSY.Storage} = InfrastructureSystems.NU
InfrastructureSystems.display_units_arg(::typeof(get_capacity_limits_energy_unitful), ::Type{StorageTechnology{T}}) where {T <: PSY.Storage} = InfrastructureSystems.NU
"""Get [`StorageTechnology`](@ref) `duration_limits` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`get_duration_limits_unitful`](@ref)."""
get_duration_limits(value::StorageTechnology, units) = InfrastructureSystems._strip_units(get_value(value, Val(:duration_limits), Val(:hr), units))
"""Get [`StorageTechnology`](@ref) `duration_limits` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`get_duration_limits`](@ref)."""
get_duration_limits_unitful(value::StorageTechnology, units) = get_value(value, Val(:duration_limits), Val(:hr), units)
InfrastructureSystems.display_units_arg(::typeof(get_duration_limits), ::Type{StorageTechnology{T}}) where {T <: PSY.Storage} = InfrastructureSystems.NU
InfrastructureSystems.display_units_arg(::typeof(get_duration_limits_unitful), ::Type{StorageTechnology{T}}) where {T <: PSY.Storage} = InfrastructureSystems.NU
"""Get [`StorageTechnology`](@ref) `efficiency`."""
get_efficiency(value::StorageTechnology) = value.efficiency
"""Get [`StorageTechnology`](@ref) `losses`."""
get_losses(value::StorageTechnology) = value.losses
"""Get [`StorageTechnology`](@ref) `lifetime` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`get_lifetime_unitful`](@ref)."""
get_lifetime(value::StorageTechnology, units) = InfrastructureSystems._strip_units(get_value(value, Val(:lifetime), Val(:yr), units))
"""Get [`StorageTechnology`](@ref) `lifetime` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`get_lifetime`](@ref)."""
get_lifetime_unitful(value::StorageTechnology, units) = get_value(value, Val(:lifetime), Val(:yr), units)
InfrastructureSystems.display_units_arg(::typeof(get_lifetime), ::Type{StorageTechnology{T}}) where {T <: PSY.Storage} = InfrastructureSystems.NU
InfrastructureSystems.display_units_arg(::typeof(get_lifetime_unitful), ::Type{StorageTechnology{T}}) where {T <: PSY.Storage} = InfrastructureSystems.NU
"""Get [`StorageTechnology`](@ref) `financial_data`."""
get_financial_data(value::StorageTechnology) = value.financial_data
"""Get [`StorageTechnology`](@ref) `ext`."""
get_ext(value::StorageTechnology) = value.ext
"""Get [`StorageTechnology`](@ref) `internal`."""
get_internal(value::StorageTechnology) = value.internal

"""Set [`StorageTechnology`](@ref) `name`."""
set_name!(value::StorageTechnology, val) = value.name = val
"""Set [`StorageTechnology`](@ref) `region`."""
set_region!(value::StorageTechnology, val) = value.region = val
"""Set [`StorageTechnology`](@ref) `id`."""
set_id!(value::StorageTechnology, val) = value.id = val
"""Set [`StorageTechnology`](@ref) `available`."""
set_available!(value::StorageTechnology, val) = value.available = val
"""Set [`StorageTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::StorageTechnology, val) = value.power_systems_type = val
"""Set [`StorageTechnology`](@ref) `prime_mover_type`."""
set_prime_mover_type!(value::StorageTechnology, val) = value.prime_mover_type = val
"""Set [`StorageTechnology`](@ref) `storage_tech`."""
set_storage_tech!(value::StorageTechnology, val) = value.storage_tech = val
"""Set [`StorageTechnology`](@ref) `capital_costs_energy`."""
set_capital_costs_energy!(value::StorageTechnology, val) = value.capital_costs_energy = val
"""Set [`StorageTechnology`](@ref) `capital_costs_charge`."""
set_capital_costs_charge!(value::StorageTechnology, val) = value.capital_costs_charge = val
"""Set [`StorageTechnology`](@ref) `capital_costs_discharge`."""
set_capital_costs_discharge!(value::StorageTechnology, val) = value.capital_costs_discharge = val
"""Set [`StorageTechnology`](@ref) `operation_costs`."""
set_operation_costs!(value::StorageTechnology, val) = value.operation_costs = val
"""Set [`StorageTechnology`](@ref) `min_discharge_fraction`."""
set_min_discharge_fraction!(value::StorageTechnology, val) = value.min_discharge_fraction = set_value(value, Val(:min_discharge_fraction), val, Val(:mw))
"""Set [`StorageTechnology`](@ref) `unit_size_charge`."""
set_unit_size_charge!(value::StorageTechnology, val) = value.unit_size_charge = set_value(value, Val(:unit_size_charge), val, Val(:mw))
"""Set [`StorageTechnology`](@ref) `unit_size_discharge`."""
set_unit_size_discharge!(value::StorageTechnology, val) = value.unit_size_discharge = set_value(value, Val(:unit_size_discharge), val, Val(:mw))
"""Set [`StorageTechnology`](@ref) `unit_size_energy`."""
set_unit_size_energy!(value::StorageTechnology, val) = value.unit_size_energy = set_value(value, Val(:unit_size_energy), val, Val(:mwh))
"""Set [`StorageTechnology`](@ref) `capacity_limits_charge`."""
set_capacity_limits_charge!(value::StorageTechnology, val) = value.capacity_limits_charge = set_value(value, Val(:capacity_limits_charge), val, Val(:mw))
"""Set [`StorageTechnology`](@ref) `capacity_limits_discharge`."""
set_capacity_limits_discharge!(value::StorageTechnology, val) = value.capacity_limits_discharge = set_value(value, Val(:capacity_limits_discharge), val, Val(:mw))
"""Set [`StorageTechnology`](@ref) `capacity_limits_energy`."""
set_capacity_limits_energy!(value::StorageTechnology, val) = value.capacity_limits_energy = set_value(value, Val(:capacity_limits_energy), val, Val(:mwh))
"""Set [`StorageTechnology`](@ref) `duration_limits`."""
set_duration_limits!(value::StorageTechnology, val) = value.duration_limits = set_value(value, Val(:duration_limits), val, Val(:hr))
"""Set [`StorageTechnology`](@ref) `efficiency`."""
set_efficiency!(value::StorageTechnology, val) = value.efficiency = val
"""Set [`StorageTechnology`](@ref) `losses`."""
set_losses!(value::StorageTechnology, val) = value.losses = val
"""Set [`StorageTechnology`](@ref) `lifetime`."""
set_lifetime!(value::StorageTechnology, val) = value.lifetime = set_value(value, Val(:lifetime), val, Val(:yr))
"""Set [`StorageTechnology`](@ref) `financial_data`."""
set_financial_data!(value::StorageTechnology, val) = value.financial_data = val
"""Set [`StorageTechnology`](@ref) `ext`."""
set_ext!(value::StorageTechnology, val) = value.ext = val
"""Set [`StorageTechnology`](@ref) `internal`."""
set_internal!(value::StorageTechnology, val) = value.internal = val

function serialize_openapi_struct(technology::StorageTechnology{T}, vals...) where T <: PSY.Storage
    base_struct = APIServer.StorageTechnology(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:StorageTechnology}, vals::Dict)
    return IS.deserialize_struct(APIServer.StorageTechnology, vals)
end
