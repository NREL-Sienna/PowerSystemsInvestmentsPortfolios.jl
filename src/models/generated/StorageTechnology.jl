#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct StorageTechnology{T <: PSY.Storage} <: Technology
        base_power::Float64
        om_costs_charge::PSY.OperationalCost
        zone::Int64
        prime_mover_type::PrimeMovers
        rsv_cost::Float64
        available::Bool
        fixed_om_cost_per_mwhyr::PSY.ValueCurve
        name::String
        storage_tech::StorageTech
        max_duration::Float64
        max_cap_mw::Float64
        inv_cost_charge_per_mwyr::PSY.ValueCurve
        id::Int64
        existing_cap_mw::Float64
        existing_cap_mwh::Float64
        self_disch::Float64
        eff_down::Float64
        max_cap_mwh::Float64
        rsv_max::Float64
        inv_cost_per_mwhyr::PSY.ValueCurve
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        min_charge_cap_mw::Float64
        balancing_topology::String
        ext::Dict
        region::String
        eff_up::Float64
        max_charge_cap_mw::Float64
        min_cap_mw::Float64
        inv_cost_per_mwyr::PSY.ValueCurve
        cluster::Int64
        reg_cost::Float64
        min_duration::Float64
        min_cap_mwh::Float64
        reg_max::Float64
        om_costs::PSY.OperationalCost
    end



# Arguments
- `base_power::Float64`: Base power
- `om_costs_charge::PSY.OperationalCost`: (default: `StorageCost()`) Fixed and variable O&M costs for a technology
- `zone::Int64`: Zone number
- `prime_mover_type::PrimeMovers`: (default: `PrimeMovers.OT`) Prime mover for generator
- `rsv_cost::Float64`: (default: `0.0`) Cost of providing upwards spinning or contingency reserves
- `available::Bool`: identifies whether the technology is available
- `fixed_om_cost_per_mwhyr::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Fixed and variable O&M costs for a technology
- `name::String`: The technology name
- `storage_tech::StorageTech`: Storage Technology Type
- `max_duration::Float64`: (default: `1000.0`) Maximum allowable durection for a storage technology
- `max_cap_mw::Float64`: (default: `-1`) Maximum allowable installed power capacity for a storage technology
- `inv_cost_charge_per_mwyr::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a technology.
- `id::Int64`: ID for individual generator
- `existing_cap_mw::Float64`: Pre-existing power capacity for a technology (MW)
- `existing_cap_mwh::Float64`: Pre-existing energy capacity for a technology (MWh)
- `self_disch::Float64`: (default: `1.0`) Efficiency of discharging storage
- `eff_down::Float64`: (default: `1.0`) Efficiency of discharging storage
- `max_cap_mwh::Float64`: (default: `-1`) Maximum allowable installed energy capacity for a storage technology
- `rsv_max::Float64`: (default: `0.0`) Fraction of nameplate capacity that can committed to provided upwards spinning or contingency reserves.
- `inv_cost_per_mwhyr::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for energy capacity of storage technology
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `min_charge_cap_mw::Float64`: (default: `-1`) Minimum required charge capacity for a storage technology
- `balancing_topology::String`: Set of balancing nodes
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `region::String`: Region/zone technology operates in
- `eff_up::Float64`: (default: `1.0`) Efficiency of charging storage
- `max_charge_cap_mw::Float64`: (default: `-1`) Maximum allowable installed charge capacity for a storage technology
- `min_cap_mw::Float64`: (default: `0.0`) Minimum required power capacity for a storage technology
- `inv_cost_per_mwyr::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a technology.
- `cluster::Int64`: (default: `0`) Cluster
- `reg_cost::Float64`: (default: `0.0`) Cost of providing regulation reserves 
- `min_duration::Float64`: (default: `0.0`) Minimum required durection for a storage technology
- `min_cap_mwh::Float64`: (default: `0.0`) Minimum required energy capacity for a storage technology
- `reg_max::Float64`: (default: `0.0`) Fraction of nameplate capacity that can committed to provided regulation reserves
- `om_costs::PSY.OperationalCost`: (default: `StorageCost()`) Fixed and variable O&M costs for a technology
"""
mutable struct StorageTechnology{T <: PSY.Storage} <: Technology
    "Base power"
    base_power::Float64
    "Fixed and variable O&M costs for a technology"
    om_costs_charge::PSY.OperationalCost
    "Zone number"
    zone::Int64
    "Prime mover for generator"
    prime_mover_type::PrimeMovers
    "Cost of providing upwards spinning or contingency reserves"
    rsv_cost::Float64
    "identifies whether the technology is available"
    available::Bool
    "Fixed and variable O&M costs for a technology"
    fixed_om_cost_per_mwhyr::PSY.ValueCurve
    "The technology name"
    name::String
    "Storage Technology Type"
    storage_tech::StorageTech
    "Maximum allowable durection for a storage technology"
    max_duration::Float64
    "Maximum allowable installed power capacity for a storage technology"
    max_cap_mw::Float64
    "Capital costs for investing in a technology."
    inv_cost_charge_per_mwyr::PSY.ValueCurve
    "ID for individual generator"
    id::Int64
    "Pre-existing power capacity for a technology (MW)"
    existing_cap_mw::Float64
    "Pre-existing energy capacity for a technology (MWh)"
    existing_cap_mwh::Float64
    "Efficiency of discharging storage"
    self_disch::Float64
    "Efficiency of discharging storage"
    eff_down::Float64
    "Maximum allowable installed energy capacity for a storage technology"
    max_cap_mwh::Float64
    "Fraction of nameplate capacity that can committed to provided upwards spinning or contingency reserves."
    rsv_max::Float64
    "Capital costs for energy capacity of storage technology"
    inv_cost_per_mwhyr::PSY.ValueCurve
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Minimum required charge capacity for a storage technology"
    min_charge_cap_mw::Float64
    "Set of balancing nodes"
    balancing_topology::String
    "Option for providing additional data"
    ext::Dict
    "Region/zone technology operates in"
    region::String
    "Efficiency of charging storage"
    eff_up::Float64
    "Maximum allowable installed charge capacity for a storage technology"
    max_charge_cap_mw::Float64
    "Minimum required power capacity for a storage technology"
    min_cap_mw::Float64
    "Capital costs for investing in a technology."
    inv_cost_per_mwyr::PSY.ValueCurve
    "Cluster"
    cluster::Int64
    "Cost of providing regulation reserves "
    reg_cost::Float64
    "Minimum required durection for a storage technology"
    min_duration::Float64
    "Minimum required energy capacity for a storage technology"
    min_cap_mwh::Float64
    "Fraction of nameplate capacity that can committed to provided regulation reserves"
    reg_max::Float64
    "Fixed and variable O&M costs for a technology"
    om_costs::PSY.OperationalCost
end


function StorageTechnology{T}(; base_power, om_costs_charge=StorageCost(), zone, prime_mover_type=PrimeMovers.OT, rsv_cost=0.0, available, fixed_om_cost_per_mwhyr=LinearCurve(0.0), name, storage_tech, max_duration=1000.0, max_cap_mw=-1, inv_cost_charge_per_mwyr=LinearCurve(0.0), id, existing_cap_mw, existing_cap_mwh, self_disch=1.0, eff_down=1.0, max_cap_mwh=-1, rsv_max=0.0, inv_cost_per_mwhyr=LinearCurve(0.0), power_systems_type, internal=InfrastructureSystemsInternal(), min_charge_cap_mw=-1, balancing_topology, ext=Dict(), region, eff_up=1.0, max_charge_cap_mw=-1, min_cap_mw=0.0, inv_cost_per_mwyr=LinearCurve(0.0), cluster=0, reg_cost=0.0, min_duration=0.0, min_cap_mwh=0.0, reg_max=0.0, om_costs=StorageCost(), ) where T <: PSY.Storage
    StorageTechnology{T}(base_power, om_costs_charge, zone, prime_mover_type, rsv_cost, available, fixed_om_cost_per_mwhyr, name, storage_tech, max_duration, max_cap_mw, inv_cost_charge_per_mwyr, id, existing_cap_mw, existing_cap_mwh, self_disch, eff_down, max_cap_mwh, rsv_max, inv_cost_per_mwhyr, power_systems_type, internal, min_charge_cap_mw, balancing_topology, ext, region, eff_up, max_charge_cap_mw, min_cap_mw, inv_cost_per_mwyr, cluster, reg_cost, min_duration, min_cap_mwh, reg_max, om_costs, )
end

"""Get [`StorageTechnology`](@ref) `base_power`."""
get_base_power(value::StorageTechnology) = value.base_power
"""Get [`StorageTechnology`](@ref) `om_costs_charge`."""
get_om_costs_charge(value::StorageTechnology) = value.om_costs_charge
"""Get [`StorageTechnology`](@ref) `zone`."""
get_zone(value::StorageTechnology) = value.zone
"""Get [`StorageTechnology`](@ref) `prime_mover_type`."""
get_prime_mover_type(value::StorageTechnology) = value.prime_mover_type
"""Get [`StorageTechnology`](@ref) `rsv_cost`."""
get_rsv_cost(value::StorageTechnology) = value.rsv_cost
"""Get [`StorageTechnology`](@ref) `available`."""
get_available(value::StorageTechnology) = value.available
"""Get [`StorageTechnology`](@ref) `fixed_om_cost_per_mwhyr`."""
get_fixed_om_cost_per_mwhyr(value::StorageTechnology) = value.fixed_om_cost_per_mwhyr
"""Get [`StorageTechnology`](@ref) `name`."""
get_name(value::StorageTechnology) = value.name
"""Get [`StorageTechnology`](@ref) `storage_tech`."""
get_storage_tech(value::StorageTechnology) = value.storage_tech
"""Get [`StorageTechnology`](@ref) `max_duration`."""
get_max_duration(value::StorageTechnology) = value.max_duration
"""Get [`StorageTechnology`](@ref) `max_cap_mw`."""
get_max_cap_mw(value::StorageTechnology) = value.max_cap_mw
"""Get [`StorageTechnology`](@ref) `inv_cost_charge_per_mwyr`."""
get_inv_cost_charge_per_mwyr(value::StorageTechnology) = value.inv_cost_charge_per_mwyr
"""Get [`StorageTechnology`](@ref) `id`."""
get_id(value::StorageTechnology) = value.id
"""Get [`StorageTechnology`](@ref) `existing_cap_mw`."""
get_existing_cap_mw(value::StorageTechnology) = value.existing_cap_mw
"""Get [`StorageTechnology`](@ref) `existing_cap_mwh`."""
get_existing_cap_mwh(value::StorageTechnology) = value.existing_cap_mwh
"""Get [`StorageTechnology`](@ref) `self_disch`."""
get_self_disch(value::StorageTechnology) = value.self_disch
"""Get [`StorageTechnology`](@ref) `eff_down`."""
get_eff_down(value::StorageTechnology) = value.eff_down
"""Get [`StorageTechnology`](@ref) `max_cap_mwh`."""
get_max_cap_mwh(value::StorageTechnology) = value.max_cap_mwh
"""Get [`StorageTechnology`](@ref) `rsv_max`."""
get_rsv_max(value::StorageTechnology) = value.rsv_max
"""Get [`StorageTechnology`](@ref) `inv_cost_per_mwhyr`."""
get_inv_cost_per_mwhyr(value::StorageTechnology) = value.inv_cost_per_mwhyr
"""Get [`StorageTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::StorageTechnology) = value.power_systems_type
"""Get [`StorageTechnology`](@ref) `internal`."""
get_internal(value::StorageTechnology) = value.internal
"""Get [`StorageTechnology`](@ref) `min_charge_cap_mw`."""
get_min_charge_cap_mw(value::StorageTechnology) = value.min_charge_cap_mw
"""Get [`StorageTechnology`](@ref) `balancing_topology`."""
get_balancing_topology(value::StorageTechnology) = value.balancing_topology
"""Get [`StorageTechnology`](@ref) `ext`."""
get_ext(value::StorageTechnology) = value.ext
"""Get [`StorageTechnology`](@ref) `region`."""
get_region(value::StorageTechnology) = value.region
"""Get [`StorageTechnology`](@ref) `eff_up`."""
get_eff_up(value::StorageTechnology) = value.eff_up
"""Get [`StorageTechnology`](@ref) `max_charge_cap_mw`."""
get_max_charge_cap_mw(value::StorageTechnology) = value.max_charge_cap_mw
"""Get [`StorageTechnology`](@ref) `min_cap_mw`."""
get_min_cap_mw(value::StorageTechnology) = value.min_cap_mw
"""Get [`StorageTechnology`](@ref) `inv_cost_per_mwyr`."""
get_inv_cost_per_mwyr(value::StorageTechnology) = value.inv_cost_per_mwyr
"""Get [`StorageTechnology`](@ref) `cluster`."""
get_cluster(value::StorageTechnology) = value.cluster
"""Get [`StorageTechnology`](@ref) `reg_cost`."""
get_reg_cost(value::StorageTechnology) = value.reg_cost
"""Get [`StorageTechnology`](@ref) `min_duration`."""
get_min_duration(value::StorageTechnology) = value.min_duration
"""Get [`StorageTechnology`](@ref) `min_cap_mwh`."""
get_min_cap_mwh(value::StorageTechnology) = value.min_cap_mwh
"""Get [`StorageTechnology`](@ref) `reg_max`."""
get_reg_max(value::StorageTechnology) = value.reg_max
"""Get [`StorageTechnology`](@ref) `om_costs`."""
get_om_costs(value::StorageTechnology) = value.om_costs

"""Set [`StorageTechnology`](@ref) `base_power`."""
set_base_power!(value::StorageTechnology, val) = value.base_power = val
"""Set [`StorageTechnology`](@ref) `om_costs_charge`."""
set_om_costs_charge!(value::StorageTechnology, val) = value.om_costs_charge = val
"""Set [`StorageTechnology`](@ref) `zone`."""
set_zone!(value::StorageTechnology, val) = value.zone = val
"""Set [`StorageTechnology`](@ref) `prime_mover_type`."""
set_prime_mover_type!(value::StorageTechnology, val) = value.prime_mover_type = val
"""Set [`StorageTechnology`](@ref) `rsv_cost`."""
set_rsv_cost!(value::StorageTechnology, val) = value.rsv_cost = val
"""Set [`StorageTechnology`](@ref) `available`."""
set_available!(value::StorageTechnology, val) = value.available = val
"""Set [`StorageTechnology`](@ref) `fixed_om_cost_per_mwhyr`."""
set_fixed_om_cost_per_mwhyr!(value::StorageTechnology, val) = value.fixed_om_cost_per_mwhyr = val
"""Set [`StorageTechnology`](@ref) `name`."""
set_name!(value::StorageTechnology, val) = value.name = val
"""Set [`StorageTechnology`](@ref) `storage_tech`."""
set_storage_tech!(value::StorageTechnology, val) = value.storage_tech = val
"""Set [`StorageTechnology`](@ref) `max_duration`."""
set_max_duration!(value::StorageTechnology, val) = value.max_duration = val
"""Set [`StorageTechnology`](@ref) `max_cap_mw`."""
set_max_cap_mw!(value::StorageTechnology, val) = value.max_cap_mw = val
"""Set [`StorageTechnology`](@ref) `inv_cost_charge_per_mwyr`."""
set_inv_cost_charge_per_mwyr!(value::StorageTechnology, val) = value.inv_cost_charge_per_mwyr = val
"""Set [`StorageTechnology`](@ref) `id`."""
set_id!(value::StorageTechnology, val) = value.id = val
"""Set [`StorageTechnology`](@ref) `existing_cap_mw`."""
set_existing_cap_mw!(value::StorageTechnology, val) = value.existing_cap_mw = val
"""Set [`StorageTechnology`](@ref) `existing_cap_mwh`."""
set_existing_cap_mwh!(value::StorageTechnology, val) = value.existing_cap_mwh = val
"""Set [`StorageTechnology`](@ref) `self_disch`."""
set_self_disch!(value::StorageTechnology, val) = value.self_disch = val
"""Set [`StorageTechnology`](@ref) `eff_down`."""
set_eff_down!(value::StorageTechnology, val) = value.eff_down = val
"""Set [`StorageTechnology`](@ref) `max_cap_mwh`."""
set_max_cap_mwh!(value::StorageTechnology, val) = value.max_cap_mwh = val
"""Set [`StorageTechnology`](@ref) `rsv_max`."""
set_rsv_max!(value::StorageTechnology, val) = value.rsv_max = val
"""Set [`StorageTechnology`](@ref) `inv_cost_per_mwhyr`."""
set_inv_cost_per_mwhyr!(value::StorageTechnology, val) = value.inv_cost_per_mwhyr = val
"""Set [`StorageTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::StorageTechnology, val) = value.power_systems_type = val
"""Set [`StorageTechnology`](@ref) `internal`."""
set_internal!(value::StorageTechnology, val) = value.internal = val
"""Set [`StorageTechnology`](@ref) `min_charge_cap_mw`."""
set_min_charge_cap_mw!(value::StorageTechnology, val) = value.min_charge_cap_mw = val
"""Set [`StorageTechnology`](@ref) `balancing_topology`."""
set_balancing_topology!(value::StorageTechnology, val) = value.balancing_topology = val
"""Set [`StorageTechnology`](@ref) `ext`."""
set_ext!(value::StorageTechnology, val) = value.ext = val
"""Set [`StorageTechnology`](@ref) `region`."""
set_region!(value::StorageTechnology, val) = value.region = val
"""Set [`StorageTechnology`](@ref) `eff_up`."""
set_eff_up!(value::StorageTechnology, val) = value.eff_up = val
"""Set [`StorageTechnology`](@ref) `max_charge_cap_mw`."""
set_max_charge_cap_mw!(value::StorageTechnology, val) = value.max_charge_cap_mw = val
"""Set [`StorageTechnology`](@ref) `min_cap_mw`."""
set_min_cap_mw!(value::StorageTechnology, val) = value.min_cap_mw = val
"""Set [`StorageTechnology`](@ref) `inv_cost_per_mwyr`."""
set_inv_cost_per_mwyr!(value::StorageTechnology, val) = value.inv_cost_per_mwyr = val
"""Set [`StorageTechnology`](@ref) `cluster`."""
set_cluster!(value::StorageTechnology, val) = value.cluster = val
"""Set [`StorageTechnology`](@ref) `reg_cost`."""
set_reg_cost!(value::StorageTechnology, val) = value.reg_cost = val
"""Set [`StorageTechnology`](@ref) `min_duration`."""
set_min_duration!(value::StorageTechnology, val) = value.min_duration = val
"""Set [`StorageTechnology`](@ref) `min_cap_mwh`."""
set_min_cap_mwh!(value::StorageTechnology, val) = value.min_cap_mwh = val
"""Set [`StorageTechnology`](@ref) `reg_max`."""
set_reg_max!(value::StorageTechnology, val) = value.reg_max = val
"""Set [`StorageTechnology`](@ref) `om_costs`."""
set_om_costs!(value::StorageTechnology, val) = value.om_costs = val
