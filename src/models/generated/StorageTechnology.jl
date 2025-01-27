#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct StorageTechnology{T <: PSY.Storage} <: Technology
        base_power::Float64
        prime_mover_type::PrimeMovers
        lifetime::Int
        min_capacity_energy::Float64
        available::Bool
        name::String
        storage_tech::StorageTech
        capital_costs_power::PSY.ValueCurve
        max_duration::Float64
        operations_costs_power::PSY.OperationalCost
        unit_size_power::Float64
        id::Int64
        losses::Float64
        capital_costs_energy::PSY.ValueCurve
        financial_data::TechnologyFinancialData
        existing_capacity_power::Float64
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        min_capacity_power::Float64
        max_capacity_power::Float64
        balancing_topology::String
        efficiency_out::Float64
        region::Union{Nothing, Region, Vector{Region}}
        ext::Dict
        unit_size_energy::Float64
        max_capacity_energy::Float64
        efficiency_in::Float64
        base_year::Int
        existing_capacity_energy::Float64
        min_duration::Float64
        operations_costs_energy::PSY.OperationalCost
    end



# Arguments
- `base_power::Float64`: Base power
- `prime_mover_type::PrimeMovers`: (default: `PrimeMovers.OT`) Prime mover for generator
- `lifetime::Int`: (default: `100`) Maximum number of years a technology can be active once installed
- `min_capacity_energy::Float64`: (default: `0.0`) Minimum required energy capacity for a storage technology
- `available::Bool`: identifies whether the technology is available
- `name::String`: The technology name
- `storage_tech::StorageTech`: Storage Technology Type
- `capital_costs_power::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a technology.
- `max_duration::Float64`: (default: `1000.0`) Maximum allowable durection for a storage technology
- `operations_costs_power::PSY.OperationalCost`: (default: `StorageCost()`) Fixed and variable O&M costs for a technology
- `unit_size_power::Float64`: (default: `0.0`) Used for discrete investment decisions. Size of each unit being built (MW)
- `id::Int64`: ID for individual generator
- `losses::Float64`: (default: `1.0`) Power loss (pct per hour)
- `capital_costs_energy::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a technology.
- `financial_data::TechnologyFinancialData`: Struct containing relevant financial information for a technology
- `existing_capacity_power::Float64`: (default: `0.0`) Pre-existing power capacity for a technology (MW)
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `min_capacity_power::Float64`: (default: `0.0`) Minimum required power capacity for a storage technology
- `max_capacity_power::Float64`: (default: `1e8`) Maximum allowable installed power capacity for a storage technology
- `balancing_topology::String`: Set of balancing nodes
- `efficiency_out::Float64`: (default: `1.0`) Efficiency of discharging storage
- `region::Union{Nothing, Region, Vector{Region}}`: (default: `nothing`) Region
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `unit_size_energy::Float64`: (default: `0.0`) Used for discrete investment decisions. Size of each unit being built (MW)
- `max_capacity_energy::Float64`: (default: `1e8`) Maximum allowable installed energy capacity for a storage technology
- `efficiency_in::Float64`: (default: `1.0`) Efficiency of charging storage
- `base_year::Int`: (default: `2020`) Reference year for technology data
- `existing_capacity_energy::Float64`: (default: `0.0`) Pre-existing energy capacity for a technology (MWh)
- `min_duration::Float64`: (default: `0.0`) Minimum required durection for a storage technology
- `operations_costs_energy::PSY.OperationalCost`: (default: `StorageCost()`) Fixed and variable O&M costs for a technology
"""
mutable struct StorageTechnology{T <: PSY.Storage} <: Technology
    "Base power"
    base_power::Float64
    "Prime mover for generator"
    prime_mover_type::PrimeMovers
    "Maximum number of years a technology can be active once installed"
    lifetime::Int
    "Minimum required energy capacity for a storage technology"
    min_capacity_energy::Float64
    "identifies whether the technology is available"
    available::Bool
    "The technology name"
    name::String
    "Storage Technology Type"
    storage_tech::StorageTech
    "Capital costs for investing in a technology."
    capital_costs_power::PSY.ValueCurve
    "Maximum allowable durection for a storage technology"
    max_duration::Float64
    "Fixed and variable O&M costs for a technology"
    operations_costs_power::PSY.OperationalCost
    "Used for discrete investment decisions. Size of each unit being built (MW)"
    unit_size_power::Float64
    "ID for individual generator"
    id::Int64
    "Power loss (pct per hour)"
    losses::Float64
    "Capital costs for investing in a technology."
    capital_costs_energy::PSY.ValueCurve
    "Struct containing relevant financial information for a technology"
    financial_data::TechnologyFinancialData
    "Pre-existing power capacity for a technology (MW)"
    existing_capacity_power::Float64
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Minimum required power capacity for a storage technology"
    min_capacity_power::Float64
    "Maximum allowable installed power capacity for a storage technology"
    max_capacity_power::Float64
    "Set of balancing nodes"
    balancing_topology::String
    "Efficiency of discharging storage"
    efficiency_out::Float64
    "Region"
    region::Union{Nothing, Region, Vector{Region}}
    "Option for providing additional data"
    ext::Dict
    "Used for discrete investment decisions. Size of each unit being built (MW)"
    unit_size_energy::Float64
    "Maximum allowable installed energy capacity for a storage technology"
    max_capacity_energy::Float64
    "Efficiency of charging storage"
    efficiency_in::Float64
    "Reference year for technology data"
    base_year::Int
    "Pre-existing energy capacity for a technology (MWh)"
    existing_capacity_energy::Float64
    "Minimum required durection for a storage technology"
    min_duration::Float64
    "Fixed and variable O&M costs for a technology"
    operations_costs_energy::PSY.OperationalCost
end


function StorageTechnology{T}(; base_power, prime_mover_type=PrimeMovers.OT, lifetime=100, min_capacity_energy=0.0, available, name, storage_tech, capital_costs_power=LinearCurve(0.0), max_duration=1000.0, operations_costs_power=StorageCost(), unit_size_power=0.0, id, losses=1.0, capital_costs_energy=LinearCurve(0.0), financial_data, existing_capacity_power=0.0, power_systems_type, internal=InfrastructureSystemsInternal(), min_capacity_power=0.0, max_capacity_power=1e8, balancing_topology, efficiency_out=1.0, region=nothing, ext=Dict(), unit_size_energy=0.0, max_capacity_energy=1e8, efficiency_in=1.0, base_year=2020, existing_capacity_energy=0.0, min_duration=0.0, operations_costs_energy=StorageCost(), ) where T <: PSY.Storage
    StorageTechnology{T}(base_power, prime_mover_type, lifetime, min_capacity_energy, available, name, storage_tech, capital_costs_power, max_duration, operations_costs_power, unit_size_power, id, losses, capital_costs_energy, financial_data, existing_capacity_power, power_systems_type, internal, min_capacity_power, max_capacity_power, balancing_topology, efficiency_out, region, ext, unit_size_energy, max_capacity_energy, efficiency_in, base_year, existing_capacity_energy, min_duration, operations_costs_energy, )
end

"""Get [`StorageTechnology`](@ref) `base_power`."""
get_base_power(value::StorageTechnology) = value.base_power
"""Get [`StorageTechnology`](@ref) `prime_mover_type`."""
get_prime_mover_type(value::StorageTechnology) = value.prime_mover_type
"""Get [`StorageTechnology`](@ref) `lifetime`."""
get_lifetime(value::StorageTechnology) = value.lifetime
"""Get [`StorageTechnology`](@ref) `min_capacity_energy`."""
get_min_capacity_energy(value::StorageTechnology) = value.min_capacity_energy
"""Get [`StorageTechnology`](@ref) `available`."""
get_available(value::StorageTechnology) = value.available
"""Get [`StorageTechnology`](@ref) `name`."""
get_name(value::StorageTechnology) = value.name
"""Get [`StorageTechnology`](@ref) `storage_tech`."""
get_storage_tech(value::StorageTechnology) = value.storage_tech
"""Get [`StorageTechnology`](@ref) `capital_costs_power`."""
get_capital_costs_power(value::StorageTechnology) = value.capital_costs_power
"""Get [`StorageTechnology`](@ref) `max_duration`."""
get_max_duration(value::StorageTechnology) = value.max_duration
"""Get [`StorageTechnology`](@ref) `operations_costs_power`."""
get_operations_costs_power(value::StorageTechnology) = value.operations_costs_power
"""Get [`StorageTechnology`](@ref) `unit_size_power`."""
get_unit_size_power(value::StorageTechnology) = value.unit_size_power
"""Get [`StorageTechnology`](@ref) `id`."""
get_id(value::StorageTechnology) = value.id
"""Get [`StorageTechnology`](@ref) `losses`."""
get_losses(value::StorageTechnology) = value.losses
"""Get [`StorageTechnology`](@ref) `capital_costs_energy`."""
get_capital_costs_energy(value::StorageTechnology) = value.capital_costs_energy
"""Get [`StorageTechnology`](@ref) `financial_data`."""
get_financial_data(value::StorageTechnology) = value.financial_data
"""Get [`StorageTechnology`](@ref) `existing_capacity_power`."""
get_existing_capacity_power(value::StorageTechnology) = value.existing_capacity_power
"""Get [`StorageTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::StorageTechnology) = value.power_systems_type
"""Get [`StorageTechnology`](@ref) `internal`."""
get_internal(value::StorageTechnology) = value.internal
"""Get [`StorageTechnology`](@ref) `min_capacity_power`."""
get_min_capacity_power(value::StorageTechnology) = value.min_capacity_power
"""Get [`StorageTechnology`](@ref) `max_capacity_power`."""
get_max_capacity_power(value::StorageTechnology) = value.max_capacity_power
"""Get [`StorageTechnology`](@ref) `balancing_topology`."""
get_balancing_topology(value::StorageTechnology) = value.balancing_topology
"""Get [`StorageTechnology`](@ref) `efficiency_out`."""
get_efficiency_out(value::StorageTechnology) = value.efficiency_out
"""Get [`StorageTechnology`](@ref) `region`."""
get_region(value::StorageTechnology) = value.region
"""Get [`StorageTechnology`](@ref) `ext`."""
get_ext(value::StorageTechnology) = value.ext
"""Get [`StorageTechnology`](@ref) `unit_size_energy`."""
get_unit_size_energy(value::StorageTechnology) = value.unit_size_energy
"""Get [`StorageTechnology`](@ref) `max_capacity_energy`."""
get_max_capacity_energy(value::StorageTechnology) = value.max_capacity_energy
"""Get [`StorageTechnology`](@ref) `efficiency_in`."""
get_efficiency_in(value::StorageTechnology) = value.efficiency_in
"""Get [`StorageTechnology`](@ref) `base_year`."""
get_base_year(value::StorageTechnology) = value.base_year
"""Get [`StorageTechnology`](@ref) `existing_capacity_energy`."""
get_existing_capacity_energy(value::StorageTechnology) = value.existing_capacity_energy
"""Get [`StorageTechnology`](@ref) `min_duration`."""
get_min_duration(value::StorageTechnology) = value.min_duration
"""Get [`StorageTechnology`](@ref) `operations_costs_energy`."""
get_operations_costs_energy(value::StorageTechnology) = value.operations_costs_energy

"""Set [`StorageTechnology`](@ref) `base_power`."""
set_base_power!(value::StorageTechnology, val) = value.base_power = val
"""Set [`StorageTechnology`](@ref) `prime_mover_type`."""
set_prime_mover_type!(value::StorageTechnology, val) = value.prime_mover_type = val
"""Set [`StorageTechnology`](@ref) `lifetime`."""
set_lifetime!(value::StorageTechnology, val) = value.lifetime = val
"""Set [`StorageTechnology`](@ref) `min_capacity_energy`."""
set_min_capacity_energy!(value::StorageTechnology, val) = value.min_capacity_energy = val
"""Set [`StorageTechnology`](@ref) `available`."""
set_available!(value::StorageTechnology, val) = value.available = val
"""Set [`StorageTechnology`](@ref) `name`."""
set_name!(value::StorageTechnology, val) = value.name = val
"""Set [`StorageTechnology`](@ref) `storage_tech`."""
set_storage_tech!(value::StorageTechnology, val) = value.storage_tech = val
"""Set [`StorageTechnology`](@ref) `capital_costs_power`."""
set_capital_costs_power!(value::StorageTechnology, val) = value.capital_costs_power = val
"""Set [`StorageTechnology`](@ref) `max_duration`."""
set_max_duration!(value::StorageTechnology, val) = value.max_duration = val
"""Set [`StorageTechnology`](@ref) `operations_costs_power`."""
set_operations_costs_power!(value::StorageTechnology, val) = value.operations_costs_power = val
"""Set [`StorageTechnology`](@ref) `unit_size_power`."""
set_unit_size_power!(value::StorageTechnology, val) = value.unit_size_power = val
"""Set [`StorageTechnology`](@ref) `id`."""
set_id!(value::StorageTechnology, val) = value.id = val
"""Set [`StorageTechnology`](@ref) `losses`."""
set_losses!(value::StorageTechnology, val) = value.losses = val
"""Set [`StorageTechnology`](@ref) `capital_costs_energy`."""
set_capital_costs_energy!(value::StorageTechnology, val) = value.capital_costs_energy = val
"""Set [`StorageTechnology`](@ref) `financial_data`."""
set_financial_data!(value::StorageTechnology, val) = value.financial_data = val
"""Set [`StorageTechnology`](@ref) `existing_capacity_power`."""
set_existing_capacity_power!(value::StorageTechnology, val) = value.existing_capacity_power = val
"""Set [`StorageTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::StorageTechnology, val) = value.power_systems_type = val
"""Set [`StorageTechnology`](@ref) `internal`."""
set_internal!(value::StorageTechnology, val) = value.internal = val
"""Set [`StorageTechnology`](@ref) `min_capacity_power`."""
set_min_capacity_power!(value::StorageTechnology, val) = value.min_capacity_power = val
"""Set [`StorageTechnology`](@ref) `max_capacity_power`."""
set_max_capacity_power!(value::StorageTechnology, val) = value.max_capacity_power = val
"""Set [`StorageTechnology`](@ref) `balancing_topology`."""
set_balancing_topology!(value::StorageTechnology, val) = value.balancing_topology = val
"""Set [`StorageTechnology`](@ref) `efficiency_out`."""
set_efficiency_out!(value::StorageTechnology, val) = value.efficiency_out = val
"""Set [`StorageTechnology`](@ref) `region`."""
set_region!(value::StorageTechnology, val) = value.region = val
"""Set [`StorageTechnology`](@ref) `ext`."""
set_ext!(value::StorageTechnology, val) = value.ext = val
"""Set [`StorageTechnology`](@ref) `unit_size_energy`."""
set_unit_size_energy!(value::StorageTechnology, val) = value.unit_size_energy = val
"""Set [`StorageTechnology`](@ref) `max_capacity_energy`."""
set_max_capacity_energy!(value::StorageTechnology, val) = value.max_capacity_energy = val
"""Set [`StorageTechnology`](@ref) `efficiency_in`."""
set_efficiency_in!(value::StorageTechnology, val) = value.efficiency_in = val
"""Set [`StorageTechnology`](@ref) `base_year`."""
set_base_year!(value::StorageTechnology, val) = value.base_year = val
"""Set [`StorageTechnology`](@ref) `existing_capacity_energy`."""
set_existing_capacity_energy!(value::StorageTechnology, val) = value.existing_capacity_energy = val
"""Set [`StorageTechnology`](@ref) `min_duration`."""
set_min_duration!(value::StorageTechnology, val) = value.min_duration = val
"""Set [`StorageTechnology`](@ref) `operations_costs_energy`."""
set_operations_costs_energy!(value::StorageTechnology, val) = value.operations_costs_energy = val

function IS.serialize(technology::StorageTechnology{T}) where T <: PSY.Storage
    data = Dict{String, Any}()
    for name in fieldnames(StorageTechnology{T})
        val = serialize_uuid_handling(getfield(technology, name))
        if name == :ext
            if !IS.is_ext_valid_for_serialization(val)
                error(
                    "component type=$technology name=$(get_name(technology)) has a value in its " *
                    "ext field that cannot be serialized.",
                )
            end
        end
        data[string(name)] = val
    end

    add_serialization_metadata!(data, StorageTechnology{T})
    data[IS.METADATA_KEY][IS.CONSTRUCT_WITH_PARAMETERS_KEY] = true

    return data
end

IS.deserialize(T::Type{<:StorageTechnology}, val::Dict) = IS.deserialize_struct(T, val)


function build_openapi_struct(::Type{<:StorageTechnology}, vals...)
    base_struct = APIClient.StorageTechnology(; vals...)
    return base_struct
end
