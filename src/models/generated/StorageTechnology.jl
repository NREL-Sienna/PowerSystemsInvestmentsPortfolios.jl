#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct StorageTechnology{T <: PSY.Storage} <: Technology
        base_power::Float64
        om_costs_energy::PSY.OperationalCost
        zone::Int64
        prime_mover_type::PrimeMovers
        existing_cap_energy::Float64
        rsv_cost::Float64
        available::Bool
        existing_cap_power::Float64
        name::String
        storage_tech::StorageTech
        capital_costs_power::PSY.ValueCurve
        max_duration::Float64
        id::Int64
        min_cap_power::Float64
        capital_costs_energy::PSY.ValueCurve
        losses::Float64
        eff_down::Float64
        rsv_max::Float64
        max_cap_power::Float64
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        om_costs_power::PSY.OperationalCost
        balancing_topology::String
        min_cap_energy::Float64
        ext::Dict
        eff_up::Float64
        reg_cost::Float64
        min_duration::Float64
        max_cap_energy::Float64
        reg_max::Float64
    end



# Arguments
- `base_power::Float64`: Base power
- `om_costs_energy::PSY.OperationalCost`: (default: `StorageCost()`) Fixed and variable O&M costs for a technology
- `zone::Int64`: Zone number
- `prime_mover_type::PrimeMovers`: (default: `PrimeMovers.OT`) Prime mover for generator
- `existing_cap_energy::Float64`: (default: `0.0`) Pre-existing energy capacity for a technology (MWh)
- `rsv_cost::Float64`: (default: `0.0`) Cost of providing upwards spinning or contingency reserves
- `available::Bool`: identifies whether the technology is available
- `existing_cap_power::Float64`: (default: `0.0`) Pre-existing power capacity for a technology (MW)
- `name::String`: The technology name
- `storage_tech::StorageTech`: Storage Technology Type
- `capital_costs_power::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a technology.
- `max_duration::Float64`: (default: `1000.0`) Maximum allowable durection for a storage technology
- `id::Int64`: ID for individual generator
- `min_cap_power::Float64`: (default: `0.0`) Minimum required power capacity for a storage technology
- `capital_costs_energy::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a technology.
- `losses::Float64`: (default: `1.0`) Power loss (pct per hour)
- `eff_down::Float64`: (default: `1.0`) Efficiency of discharging storage
- `rsv_max::Float64`: (default: `0.0`) Fraction of nameplate capacity that can committed to provided upwards spinning or contingency reserves.
- `max_cap_power::Float64`: (default: `1e8`) Maximum allowable installed power capacity for a storage technology
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `om_costs_power::PSY.OperationalCost`: (default: `StorageCost()`) Fixed and variable O&M costs for a technology
- `balancing_topology::String`: Set of balancing nodes
- `min_cap_energy::Float64`: (default: `0.0`) Minimum required energy capacity for a storage technology
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `eff_up::Float64`: (default: `1.0`) Efficiency of charging storage
- `reg_cost::Float64`: (default: `0.0`) Cost of providing regulation reserves 
- `min_duration::Float64`: (default: `0.0`) Minimum required durection for a storage technology
- `max_cap_energy::Float64`: (default: `1e8`) Maximum allowable installed energy capacity for a storage technology
- `reg_max::Float64`: (default: `0.0`) Fraction of nameplate capacity that can committed to provided regulation reserves
"""
mutable struct StorageTechnology{T <: PSY.Storage} <: Technology
    "Base power"
    base_power::Float64
    "Fixed and variable O&M costs for a technology"
    om_costs_energy::PSY.OperationalCost
    "Zone number"
    zone::Int64
    "Prime mover for generator"
    prime_mover_type::PrimeMovers
    "Pre-existing energy capacity for a technology (MWh)"
    existing_cap_energy::Float64
    "Cost of providing upwards spinning or contingency reserves"
    rsv_cost::Float64
    "identifies whether the technology is available"
    available::Bool
    "Pre-existing power capacity for a technology (MW)"
    existing_cap_power::Float64
    "The technology name"
    name::String
    "Storage Technology Type"
    storage_tech::StorageTech
    "Capital costs for investing in a technology."
    capital_costs_power::PSY.ValueCurve
    "Maximum allowable durection for a storage technology"
    max_duration::Float64
    "ID for individual generator"
    id::Int64
    "Minimum required power capacity for a storage technology"
    min_cap_power::Float64
    "Capital costs for investing in a technology."
    capital_costs_energy::PSY.ValueCurve
    "Power loss (pct per hour)"
    losses::Float64
    "Efficiency of discharging storage"
    eff_down::Float64
    "Fraction of nameplate capacity that can committed to provided upwards spinning or contingency reserves."
    rsv_max::Float64
    "Maximum allowable installed power capacity for a storage technology"
    max_cap_power::Float64
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Fixed and variable O&M costs for a technology"
    om_costs_power::PSY.OperationalCost
    "Set of balancing nodes"
    balancing_topology::String
    "Minimum required energy capacity for a storage technology"
    min_cap_energy::Float64
    "Option for providing additional data"
    ext::Dict
    "Efficiency of charging storage"
    eff_up::Float64
    "Cost of providing regulation reserves "
    reg_cost::Float64
    "Minimum required durection for a storage technology"
    min_duration::Float64
    "Maximum allowable installed energy capacity for a storage technology"
    max_cap_energy::Float64
    "Fraction of nameplate capacity that can committed to provided regulation reserves"
    reg_max::Float64
end


function StorageTechnology{T}(; base_power, om_costs_energy=StorageCost(), zone, prime_mover_type=PrimeMovers.OT, existing_cap_energy=0.0, rsv_cost=0.0, available, existing_cap_power=0.0, name, storage_tech, capital_costs_power=LinearCurve(0.0), max_duration=1000.0, id, min_cap_power=0.0, capital_costs_energy=LinearCurve(0.0), losses=1.0, eff_down=1.0, rsv_max=0.0, max_cap_power=1e8, power_systems_type, internal=InfrastructureSystemsInternal(), om_costs_power=StorageCost(), balancing_topology, min_cap_energy=0.0, ext=Dict(), eff_up=1.0, reg_cost=0.0, min_duration=0.0, max_cap_energy=1e8, reg_max=0.0, ) where T <: PSY.Storage
    StorageTechnology{T}(base_power, om_costs_energy, zone, prime_mover_type, existing_cap_energy, rsv_cost, available, existing_cap_power, name, storage_tech, capital_costs_power, max_duration, id, min_cap_power, capital_costs_energy, losses, eff_down, rsv_max, max_cap_power, power_systems_type, internal, om_costs_power, balancing_topology, min_cap_energy, ext, eff_up, reg_cost, min_duration, max_cap_energy, reg_max, )
end

"""Get [`StorageTechnology`](@ref) `base_power`."""
get_base_power(value::StorageTechnology) = value.base_power
"""Get [`StorageTechnology`](@ref) `om_costs_energy`."""
get_om_costs_energy(value::StorageTechnology) = value.om_costs_energy
"""Get [`StorageTechnology`](@ref) `zone`."""
get_zone(value::StorageTechnology) = value.zone
"""Get [`StorageTechnology`](@ref) `prime_mover_type`."""
get_prime_mover_type(value::StorageTechnology) = value.prime_mover_type
"""Get [`StorageTechnology`](@ref) `existing_cap_energy`."""
get_existing_cap_energy(value::StorageTechnology) = value.existing_cap_energy
"""Get [`StorageTechnology`](@ref) `rsv_cost`."""
get_rsv_cost(value::StorageTechnology) = value.rsv_cost
"""Get [`StorageTechnology`](@ref) `available`."""
get_available(value::StorageTechnology) = value.available
"""Get [`StorageTechnology`](@ref) `existing_cap_power`."""
get_existing_cap_power(value::StorageTechnology) = value.existing_cap_power
"""Get [`StorageTechnology`](@ref) `name`."""
get_name(value::StorageTechnology) = value.name
"""Get [`StorageTechnology`](@ref) `storage_tech`."""
get_storage_tech(value::StorageTechnology) = value.storage_tech
"""Get [`StorageTechnology`](@ref) `capital_costs_power`."""
get_capital_costs_power(value::StorageTechnology) = value.capital_costs_power
"""Get [`StorageTechnology`](@ref) `max_duration`."""
get_max_duration(value::StorageTechnology) = value.max_duration
"""Get [`StorageTechnology`](@ref) `id`."""
get_id(value::StorageTechnology) = value.id
"""Get [`StorageTechnology`](@ref) `min_cap_power`."""
get_min_cap_power(value::StorageTechnology) = value.min_cap_power
"""Get [`StorageTechnology`](@ref) `capital_costs_energy`."""
get_capital_costs_energy(value::StorageTechnology) = value.capital_costs_energy
"""Get [`StorageTechnology`](@ref) `losses`."""
get_losses(value::StorageTechnology) = value.losses
"""Get [`StorageTechnology`](@ref) `eff_down`."""
get_eff_down(value::StorageTechnology) = value.eff_down
"""Get [`StorageTechnology`](@ref) `rsv_max`."""
get_rsv_max(value::StorageTechnology) = value.rsv_max
"""Get [`StorageTechnology`](@ref) `max_cap_power`."""
get_max_cap_power(value::StorageTechnology) = value.max_cap_power
"""Get [`StorageTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::StorageTechnology) = value.power_systems_type
"""Get [`StorageTechnology`](@ref) `internal`."""
get_internal(value::StorageTechnology) = value.internal
"""Get [`StorageTechnology`](@ref) `om_costs_power`."""
get_om_costs_power(value::StorageTechnology) = value.om_costs_power
"""Get [`StorageTechnology`](@ref) `balancing_topology`."""
get_balancing_topology(value::StorageTechnology) = value.balancing_topology
"""Get [`StorageTechnology`](@ref) `min_cap_energy`."""
get_min_cap_energy(value::StorageTechnology) = value.min_cap_energy
"""Get [`StorageTechnology`](@ref) `ext`."""
get_ext(value::StorageTechnology) = value.ext
"""Get [`StorageTechnology`](@ref) `eff_up`."""
get_eff_up(value::StorageTechnology) = value.eff_up
"""Get [`StorageTechnology`](@ref) `reg_cost`."""
get_reg_cost(value::StorageTechnology) = value.reg_cost
"""Get [`StorageTechnology`](@ref) `min_duration`."""
get_min_duration(value::StorageTechnology) = value.min_duration
"""Get [`StorageTechnology`](@ref) `max_cap_energy`."""
get_max_cap_energy(value::StorageTechnology) = value.max_cap_energy
"""Get [`StorageTechnology`](@ref) `reg_max`."""
get_reg_max(value::StorageTechnology) = value.reg_max

"""Set [`StorageTechnology`](@ref) `base_power`."""
set_base_power!(value::StorageTechnology, val) = value.base_power = val
"""Set [`StorageTechnology`](@ref) `om_costs_energy`."""
set_om_costs_energy!(value::StorageTechnology, val) = value.om_costs_energy = val
"""Set [`StorageTechnology`](@ref) `zone`."""
set_zone!(value::StorageTechnology, val) = value.zone = val
"""Set [`StorageTechnology`](@ref) `prime_mover_type`."""
set_prime_mover_type!(value::StorageTechnology, val) = value.prime_mover_type = val
"""Set [`StorageTechnology`](@ref) `existing_cap_energy`."""
set_existing_cap_energy!(value::StorageTechnology, val) = value.existing_cap_energy = val
"""Set [`StorageTechnology`](@ref) `rsv_cost`."""
set_rsv_cost!(value::StorageTechnology, val) = value.rsv_cost = val
"""Set [`StorageTechnology`](@ref) `available`."""
set_available!(value::StorageTechnology, val) = value.available = val
"""Set [`StorageTechnology`](@ref) `existing_cap_power`."""
set_existing_cap_power!(value::StorageTechnology, val) = value.existing_cap_power = val
"""Set [`StorageTechnology`](@ref) `name`."""
set_name!(value::StorageTechnology, val) = value.name = val
"""Set [`StorageTechnology`](@ref) `storage_tech`."""
set_storage_tech!(value::StorageTechnology, val) = value.storage_tech = val
"""Set [`StorageTechnology`](@ref) `capital_costs_power`."""
set_capital_costs_power!(value::StorageTechnology, val) = value.capital_costs_power = val
"""Set [`StorageTechnology`](@ref) `max_duration`."""
set_max_duration!(value::StorageTechnology, val) = value.max_duration = val
"""Set [`StorageTechnology`](@ref) `id`."""
set_id!(value::StorageTechnology, val) = value.id = val
"""Set [`StorageTechnology`](@ref) `min_cap_power`."""
set_min_cap_power!(value::StorageTechnology, val) = value.min_cap_power = val
"""Set [`StorageTechnology`](@ref) `capital_costs_energy`."""
set_capital_costs_energy!(value::StorageTechnology, val) = value.capital_costs_energy = val
"""Set [`StorageTechnology`](@ref) `losses`."""
set_losses!(value::StorageTechnology, val) = value.losses = val
"""Set [`StorageTechnology`](@ref) `eff_down`."""
set_eff_down!(value::StorageTechnology, val) = value.eff_down = val
"""Set [`StorageTechnology`](@ref) `rsv_max`."""
set_rsv_max!(value::StorageTechnology, val) = value.rsv_max = val
"""Set [`StorageTechnology`](@ref) `max_cap_power`."""
set_max_cap_power!(value::StorageTechnology, val) = value.max_cap_power = val
"""Set [`StorageTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::StorageTechnology, val) = value.power_systems_type = val
"""Set [`StorageTechnology`](@ref) `internal`."""
set_internal!(value::StorageTechnology, val) = value.internal = val
"""Set [`StorageTechnology`](@ref) `om_costs_power`."""
set_om_costs_power!(value::StorageTechnology, val) = value.om_costs_power = val
"""Set [`StorageTechnology`](@ref) `balancing_topology`."""
set_balancing_topology!(value::StorageTechnology, val) = value.balancing_topology = val
"""Set [`StorageTechnology`](@ref) `min_cap_energy`."""
set_min_cap_energy!(value::StorageTechnology, val) = value.min_cap_energy = val
"""Set [`StorageTechnology`](@ref) `ext`."""
set_ext!(value::StorageTechnology, val) = value.ext = val
"""Set [`StorageTechnology`](@ref) `eff_up`."""
set_eff_up!(value::StorageTechnology, val) = value.eff_up = val
"""Set [`StorageTechnology`](@ref) `reg_cost`."""
set_reg_cost!(value::StorageTechnology, val) = value.reg_cost = val
"""Set [`StorageTechnology`](@ref) `min_duration`."""
set_min_duration!(value::StorageTechnology, val) = value.min_duration = val
"""Set [`StorageTechnology`](@ref) `max_cap_energy`."""
set_max_cap_energy!(value::StorageTechnology, val) = value.max_cap_energy = val
"""Set [`StorageTechnology`](@ref) `reg_max`."""
set_reg_max!(value::StorageTechnology, val) = value.reg_max = val
