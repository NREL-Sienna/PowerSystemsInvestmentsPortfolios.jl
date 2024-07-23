#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct CoLocatedSupplyStorageTechnology{T <: PSY.Generator} <: Technology
        base_power::Float64
        capital_cost_energy::PSY.ValueCurve
        initial_capacity_power::Float64
        prime_mover_type::PrimeMovers
        capital_cost_gen::PSY.ValueCurve
        efficiency_up_dc::Float64
        capital_cost_inv::PSY.ValueCurve
        capital_cost_power::PSY.ValueCurve
        maximum_capacity_power::Float64
        operations_cost_inv::PSY.OperationalCost
        efficiency_up_ac::Float64
        efficiency_down_dc::Float64
        gen_ID::String
        available::Bool
        name::String
        storage_tech::StorageTech
        minimum_required_capacity_gen::Float64
        self_discharge::Float64
        initial_gen_capacity::Float64
        minimum_inverter_capacity::Float64
        minimum_required_capacity_power::Float64
        operations_cost_gen::PSY.OperationalCost
        minimum_duration::Float64
        inverter_ratio::Float64
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        ext::Dict
        balancing_topology::String
        initial_capacity_inverter::Float64
        region::String
        maximum_inverter_capacity::Float64
        maximum_duration::Float64
        initial_capacity_energy::Float64
        operations_cost_power::PSY.OperationalCost
        maximum_capacity_energy::Float64
        operations_cost_energy::PSY.OperationalCost
        minimum_required_capacity_energy::Float64
        maximum_gen_capacity::Float64
        efficiency_down_ac::Float64
    end



# Arguments
- `base_power::Float64`: Base power
- `capital_cost_energy::PSY.ValueCurve`: (default: `0.0`) Capital costs for energy capacity of storage technology
- `initial_capacity_power::Float64`: Pre-existing power capacity for a technology (MW)
- `prime_mover_type::PrimeMovers`: (default: `PrimeMovers.OT`) Prime mover for generator
- `capital_cost_gen::PSY.ValueCurve`: (default: `0.0`) Capital costs for investing in a technology.
- `efficiency_up_dc::Float64`: (default: `1.0`) Efficiency of charging storage
- `capital_cost_inv::PSY.ValueCurve`: (default: `0.0`) Capital costs for energy capacity of storage technology
- `capital_cost_power::PSY.ValueCurve`: (default: `0.0`) Capital costs for investing in a technology.
- `maximum_capacity_power::Float64`: (default: `-1`) Maximum allowable installed power capacity for a storage technology
- `operations_cost_inv::PSY.OperationalCost`: Fixed O&M costs for energy capacity of storage technology
- `efficiency_up_ac::Float64`: (default: `1.0`) Efficiency of charging storage
- `efficiency_down_dc::Float64`: (default: `1.0`) Efficiency of discharging storage
- `gen_ID::String`: ID for individual generator
- `available::Bool`: identifies whether the technology is available
- `name::String`: The technology name
- `storage_tech::StorageTech`: Storage Technology Type
- `minimum_required_capacity_gen::Float64`: (default: `-1`) Minimum required capacity for a technology
- `self_discharge::Float64`: (default: `1.0`) Efficiency of discharging storage
- `initial_gen_capacity::Float64`: Pre-existing capacity for a technology
- `minimum_inverter_capacity::Float64`: (default: `-1`) Minimum allowable installed capacity for a technology
- `minimum_required_capacity_power::Float64`: (default: `-1`) Minimum required power capacity for a storage technology
- `operations_cost_gen::PSY.OperationalCost`: Fixed O&M costs for a technology
- `minimum_duration::Float64`: (default: `0.0`) Minimum required durection for a storage technology
- `inverter_ratio::Float64`: (default: `-1.0`) Ratio of generation capacity to grid connection capacity built
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `balancing_topology::String`: Set of balancing nodes
- `initial_capacity_inverter::Float64`: The existing capacity of co-located VRE-STOR resource's inverter in MW (AC)
- `region::String`: (default: `1.0`) Region/zone technology operates in
- `maximum_inverter_capacity::Float64`: (default: `-1`) Maximum allowable installed capacity for a technology
- `maximum_duration::Float64`: (default: `1000.0`) Maximum allowable durection for a storage technology
- `initial_capacity_energy::Float64`: Pre-existing energy capacity for a technology (MWh)
- `operations_cost_power::PSY.OperationalCost`: Fixed O&M costs for a technology
- `maximum_capacity_energy::Float64`: (default: `-1`) Maximum allowable installed energy capacity for a storage technology
- `operations_cost_energy::PSY.OperationalCost`: Fixed O&M costs for energy capacity of storage technology
- `minimum_required_capacity_energy::Float64`: (default: `-1`) Minimum required energy capacity for a storage technology
- `maximum_gen_capacity::Float64`: (default: `-1`) Maximum allowable installed capacity for a technology
- `efficiency_down_ac::Float64`: (default: `1.0`) Efficiency of discharging storage
"""
mutable struct CoLocatedSupplyStorageTechnology{T <: PSY.Generator} <: Technology
    "Base power"
    base_power::Float64
    "Capital costs for energy capacity of storage technology"
    capital_cost_energy::PSY.ValueCurve
    "Pre-existing power capacity for a technology (MW)"
    initial_capacity_power::Float64
    "Prime mover for generator"
    prime_mover_type::PrimeMovers
    "Capital costs for investing in a technology."
    capital_cost_gen::PSY.ValueCurve
    "Efficiency of charging storage"
    efficiency_up_dc::Float64
    "Capital costs for energy capacity of storage technology"
    capital_cost_inv::PSY.ValueCurve
    "Capital costs for investing in a technology."
    capital_cost_power::PSY.ValueCurve
    "Maximum allowable installed power capacity for a storage technology"
    maximum_capacity_power::Float64
    "Fixed O&M costs for energy capacity of storage technology"
    operations_cost_inv::PSY.OperationalCost
    "Efficiency of charging storage"
    efficiency_up_ac::Float64
    "Efficiency of discharging storage"
    efficiency_down_dc::Float64
    "ID for individual generator"
    gen_ID::String
    "identifies whether the technology is available"
    available::Bool
    "The technology name"
    name::String
    "Storage Technology Type"
    storage_tech::StorageTech
    "Minimum required capacity for a technology"
    minimum_required_capacity_gen::Float64
    "Efficiency of discharging storage"
    self_discharge::Float64
    "Pre-existing capacity for a technology"
    initial_gen_capacity::Float64
    "Minimum allowable installed capacity for a technology"
    minimum_inverter_capacity::Float64
    "Minimum required power capacity for a storage technology"
    minimum_required_capacity_power::Float64
    "Fixed O&M costs for a technology"
    operations_cost_gen::PSY.OperationalCost
    "Minimum required durection for a storage technology"
    minimum_duration::Float64
    "Ratio of generation capacity to grid connection capacity built"
    inverter_ratio::Float64
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Set of balancing nodes"
    balancing_topology::String
    "The existing capacity of co-located VRE-STOR resource's inverter in MW (AC)"
    initial_capacity_inverter::Float64
    "Region/zone technology operates in"
    region::String
    "Maximum allowable installed capacity for a technology"
    maximum_inverter_capacity::Float64
    "Maximum allowable durection for a storage technology"
    maximum_duration::Float64
    "Pre-existing energy capacity for a technology (MWh)"
    initial_capacity_energy::Float64
    "Fixed O&M costs for a technology"
    operations_cost_power::PSY.OperationalCost
    "Maximum allowable installed energy capacity for a storage technology"
    maximum_capacity_energy::Float64
    "Fixed O&M costs for energy capacity of storage technology"
    operations_cost_energy::PSY.OperationalCost
    "Minimum required energy capacity for a storage technology"
    minimum_required_capacity_energy::Float64
    "Maximum allowable installed capacity for a technology"
    maximum_gen_capacity::Float64
    "Efficiency of discharging storage"
    efficiency_down_ac::Float64
end


function CoLocatedSupplyStorageTechnology{T}(; base_power, capital_cost_energy=0.0, initial_capacity_power, prime_mover_type=PrimeMovers.OT, capital_cost_gen=0.0, efficiency_up_dc=1.0, capital_cost_inv=0.0, capital_cost_power=0.0, maximum_capacity_power=-1, operations_cost_inv, efficiency_up_ac=1.0, efficiency_down_dc=1.0, gen_ID, available, name, storage_tech, minimum_required_capacity_gen=-1, self_discharge=1.0, initial_gen_capacity, minimum_inverter_capacity=-1, minimum_required_capacity_power=-1, operations_cost_gen, minimum_duration=0.0, inverter_ratio=-1.0, power_systems_type, internal=InfrastructureSystemsInternal(), ext=Dict(), balancing_topology, initial_capacity_inverter, region=1.0, maximum_inverter_capacity=-1, maximum_duration=1000.0, initial_capacity_energy, operations_cost_power, maximum_capacity_energy=-1, operations_cost_energy, minimum_required_capacity_energy=-1, maximum_gen_capacity=-1, efficiency_down_ac=1.0, ) where T <: PSY.Generator
    CoLocatedSupplyStorageTechnology{T}(base_power, capital_cost_energy, initial_capacity_power, prime_mover_type, capital_cost_gen, efficiency_up_dc, capital_cost_inv, capital_cost_power, maximum_capacity_power, operations_cost_inv, efficiency_up_ac, efficiency_down_dc, gen_ID, available, name, storage_tech, minimum_required_capacity_gen, self_discharge, initial_gen_capacity, minimum_inverter_capacity, minimum_required_capacity_power, operations_cost_gen, minimum_duration, inverter_ratio, power_systems_type, internal, ext, balancing_topology, initial_capacity_inverter, region, maximum_inverter_capacity, maximum_duration, initial_capacity_energy, operations_cost_power, maximum_capacity_energy, operations_cost_energy, minimum_required_capacity_energy, maximum_gen_capacity, efficiency_down_ac, )
end

"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `base_power`."""
get_base_power(value::CoLocatedSupplyStorageTechnology) = value.base_power
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `capital_cost_energy`."""
get_capital_cost_energy(value::CoLocatedSupplyStorageTechnology) = value.capital_cost_energy
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `initial_capacity_power`."""
get_initial_capacity_power(value::CoLocatedSupplyStorageTechnology) = value.initial_capacity_power
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `prime_mover_type`."""
get_prime_mover_type(value::CoLocatedSupplyStorageTechnology) = value.prime_mover_type
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `capital_cost_gen`."""
get_capital_cost_gen(value::CoLocatedSupplyStorageTechnology) = value.capital_cost_gen
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `efficiency_up_dc`."""
get_efficiency_up_dc(value::CoLocatedSupplyStorageTechnology) = value.efficiency_up_dc
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `capital_cost_inv`."""
get_capital_cost_inv(value::CoLocatedSupplyStorageTechnology) = value.capital_cost_inv
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `capital_cost_power`."""
get_capital_cost_power(value::CoLocatedSupplyStorageTechnology) = value.capital_cost_power
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `maximum_capacity_power`."""
get_maximum_capacity_power(value::CoLocatedSupplyStorageTechnology) = value.maximum_capacity_power
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `operations_cost_inv`."""
get_operations_cost_inv(value::CoLocatedSupplyStorageTechnology) = value.operations_cost_inv
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `efficiency_up_ac`."""
get_efficiency_up_ac(value::CoLocatedSupplyStorageTechnology) = value.efficiency_up_ac
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `efficiency_down_dc`."""
get_efficiency_down_dc(value::CoLocatedSupplyStorageTechnology) = value.efficiency_down_dc
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `gen_ID`."""
get_gen_ID(value::CoLocatedSupplyStorageTechnology) = value.gen_ID
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `available`."""
get_available(value::CoLocatedSupplyStorageTechnology) = value.available
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `name`."""
get_name(value::CoLocatedSupplyStorageTechnology) = value.name
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `storage_tech`."""
get_storage_tech(value::CoLocatedSupplyStorageTechnology) = value.storage_tech
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `minimum_required_capacity_gen`."""
get_minimum_required_capacity_gen(value::CoLocatedSupplyStorageTechnology) = value.minimum_required_capacity_gen
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `self_discharge`."""
get_self_discharge(value::CoLocatedSupplyStorageTechnology) = value.self_discharge
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `initial_gen_capacity`."""
get_initial_gen_capacity(value::CoLocatedSupplyStorageTechnology) = value.initial_gen_capacity
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `minimum_inverter_capacity`."""
get_minimum_inverter_capacity(value::CoLocatedSupplyStorageTechnology) = value.minimum_inverter_capacity
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `minimum_required_capacity_power`."""
get_minimum_required_capacity_power(value::CoLocatedSupplyStorageTechnology) = value.minimum_required_capacity_power
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `operations_cost_gen`."""
get_operations_cost_gen(value::CoLocatedSupplyStorageTechnology) = value.operations_cost_gen
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `minimum_duration`."""
get_minimum_duration(value::CoLocatedSupplyStorageTechnology) = value.minimum_duration
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `inverter_ratio`."""
get_inverter_ratio(value::CoLocatedSupplyStorageTechnology) = value.inverter_ratio
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::CoLocatedSupplyStorageTechnology) = value.power_systems_type
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `internal`."""
get_internal(value::CoLocatedSupplyStorageTechnology) = value.internal
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `ext`."""
get_ext(value::CoLocatedSupplyStorageTechnology) = value.ext
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `balancing_topology`."""
get_balancing_topology(value::CoLocatedSupplyStorageTechnology) = value.balancing_topology
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `initial_capacity_inverter`."""
get_initial_capacity_inverter(value::CoLocatedSupplyStorageTechnology) = value.initial_capacity_inverter
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `region`."""
get_region(value::CoLocatedSupplyStorageTechnology) = value.region
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `maximum_inverter_capacity`."""
get_maximum_inverter_capacity(value::CoLocatedSupplyStorageTechnology) = value.maximum_inverter_capacity
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `maximum_duration`."""
get_maximum_duration(value::CoLocatedSupplyStorageTechnology) = value.maximum_duration
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `initial_capacity_energy`."""
get_initial_capacity_energy(value::CoLocatedSupplyStorageTechnology) = value.initial_capacity_energy
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `operations_cost_power`."""
get_operations_cost_power(value::CoLocatedSupplyStorageTechnology) = value.operations_cost_power
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `maximum_capacity_energy`."""
get_maximum_capacity_energy(value::CoLocatedSupplyStorageTechnology) = value.maximum_capacity_energy
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `operations_cost_energy`."""
get_operations_cost_energy(value::CoLocatedSupplyStorageTechnology) = value.operations_cost_energy
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `minimum_required_capacity_energy`."""
get_minimum_required_capacity_energy(value::CoLocatedSupplyStorageTechnology) = value.minimum_required_capacity_energy
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `maximum_gen_capacity`."""
get_maximum_gen_capacity(value::CoLocatedSupplyStorageTechnology) = value.maximum_gen_capacity
"""Get [`CoLocatedSupplyStorageTechnology`](@ref) `efficiency_down_ac`."""
get_efficiency_down_ac(value::CoLocatedSupplyStorageTechnology) = value.efficiency_down_ac

"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `base_power`."""
set_base_power!(value::CoLocatedSupplyStorageTechnology, val) = value.base_power = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `capital_cost_energy`."""
set_capital_cost_energy!(value::CoLocatedSupplyStorageTechnology, val) = value.capital_cost_energy = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `initial_capacity_power`."""
set_initial_capacity_power!(value::CoLocatedSupplyStorageTechnology, val) = value.initial_capacity_power = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `prime_mover_type`."""
set_prime_mover_type!(value::CoLocatedSupplyStorageTechnology, val) = value.prime_mover_type = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `capital_cost_gen`."""
set_capital_cost_gen!(value::CoLocatedSupplyStorageTechnology, val) = value.capital_cost_gen = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `efficiency_up_dc`."""
set_efficiency_up_dc!(value::CoLocatedSupplyStorageTechnology, val) = value.efficiency_up_dc = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `capital_cost_inv`."""
set_capital_cost_inv!(value::CoLocatedSupplyStorageTechnology, val) = value.capital_cost_inv = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `capital_cost_power`."""
set_capital_cost_power!(value::CoLocatedSupplyStorageTechnology, val) = value.capital_cost_power = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `maximum_capacity_power`."""
set_maximum_capacity_power!(value::CoLocatedSupplyStorageTechnology, val) = value.maximum_capacity_power = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `operations_cost_inv`."""
set_operations_cost_inv!(value::CoLocatedSupplyStorageTechnology, val) = value.operations_cost_inv = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `efficiency_up_ac`."""
set_efficiency_up_ac!(value::CoLocatedSupplyStorageTechnology, val) = value.efficiency_up_ac = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `efficiency_down_dc`."""
set_efficiency_down_dc!(value::CoLocatedSupplyStorageTechnology, val) = value.efficiency_down_dc = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `gen_ID`."""
set_gen_ID!(value::CoLocatedSupplyStorageTechnology, val) = value.gen_ID = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `available`."""
set_available!(value::CoLocatedSupplyStorageTechnology, val) = value.available = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `name`."""
set_name!(value::CoLocatedSupplyStorageTechnology, val) = value.name = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `storage_tech`."""
set_storage_tech!(value::CoLocatedSupplyStorageTechnology, val) = value.storage_tech = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `minimum_required_capacity_gen`."""
set_minimum_required_capacity_gen!(value::CoLocatedSupplyStorageTechnology, val) = value.minimum_required_capacity_gen = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `self_discharge`."""
set_self_discharge!(value::CoLocatedSupplyStorageTechnology, val) = value.self_discharge = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `initial_gen_capacity`."""
set_initial_gen_capacity!(value::CoLocatedSupplyStorageTechnology, val) = value.initial_gen_capacity = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `minimum_inverter_capacity`."""
set_minimum_inverter_capacity!(value::CoLocatedSupplyStorageTechnology, val) = value.minimum_inverter_capacity = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `minimum_required_capacity_power`."""
set_minimum_required_capacity_power!(value::CoLocatedSupplyStorageTechnology, val) = value.minimum_required_capacity_power = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `operations_cost_gen`."""
set_operations_cost_gen!(value::CoLocatedSupplyStorageTechnology, val) = value.operations_cost_gen = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `minimum_duration`."""
set_minimum_duration!(value::CoLocatedSupplyStorageTechnology, val) = value.minimum_duration = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `inverter_ratio`."""
set_inverter_ratio!(value::CoLocatedSupplyStorageTechnology, val) = value.inverter_ratio = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::CoLocatedSupplyStorageTechnology, val) = value.power_systems_type = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `internal`."""
set_internal!(value::CoLocatedSupplyStorageTechnology, val) = value.internal = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `ext`."""
set_ext!(value::CoLocatedSupplyStorageTechnology, val) = value.ext = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `balancing_topology`."""
set_balancing_topology!(value::CoLocatedSupplyStorageTechnology, val) = value.balancing_topology = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `initial_capacity_inverter`."""
set_initial_capacity_inverter!(value::CoLocatedSupplyStorageTechnology, val) = value.initial_capacity_inverter = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `region`."""
set_region!(value::CoLocatedSupplyStorageTechnology, val) = value.region = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `maximum_inverter_capacity`."""
set_maximum_inverter_capacity!(value::CoLocatedSupplyStorageTechnology, val) = value.maximum_inverter_capacity = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `maximum_duration`."""
set_maximum_duration!(value::CoLocatedSupplyStorageTechnology, val) = value.maximum_duration = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `initial_capacity_energy`."""
set_initial_capacity_energy!(value::CoLocatedSupplyStorageTechnology, val) = value.initial_capacity_energy = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `operations_cost_power`."""
set_operations_cost_power!(value::CoLocatedSupplyStorageTechnology, val) = value.operations_cost_power = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `maximum_capacity_energy`."""
set_maximum_capacity_energy!(value::CoLocatedSupplyStorageTechnology, val) = value.maximum_capacity_energy = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `operations_cost_energy`."""
set_operations_cost_energy!(value::CoLocatedSupplyStorageTechnology, val) = value.operations_cost_energy = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `minimum_required_capacity_energy`."""
set_minimum_required_capacity_energy!(value::CoLocatedSupplyStorageTechnology, val) = value.minimum_required_capacity_energy = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `maximum_gen_capacity`."""
set_maximum_gen_capacity!(value::CoLocatedSupplyStorageTechnology, val) = value.maximum_gen_capacity = val
"""Set [`CoLocatedSupplyStorageTechnology`](@ref) `efficiency_down_ac`."""
set_efficiency_down_ac!(value::CoLocatedSupplyStorageTechnology, val) = value.efficiency_down_ac = val
