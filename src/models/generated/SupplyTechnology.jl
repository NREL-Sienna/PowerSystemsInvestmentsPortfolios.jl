#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct SupplyTechnology{T <: PSY.Generator} <: Technology
        base_power::Float64
        heat_rate_mmbtu_per_mwh::Union{Float64, PSY.ValueCurve, Dict{ThermalFuels, PSY.ValueCurve}}
        zone::Int64
        prime_mover_type::PrimeMovers
        outage_factor::Float64
        cofire_level_min::Union{Nothing, Dict{ThermalFuels, Float64}}
        rsv_cost::Float64
        cofire_start_max::Union{Nothing, Dict{ThermalFuels, Float64}}
        available::Bool
        cofire_start_min::Union{Nothing, Dict{ThermalFuels, Float64}}
        co2::Union{Float64, Dict{String, Float64}, Dict{ThermalFuels, Float64}}
        name::String
        ramp_dn_percentage::Float64
        max_cap_mw::Float64
        id::Int64
        existing_cap_mw::Float64
        down_time::Float64
        start_fuel_mmbtu_per_mw::Float64
        rsv_max::Float64
        fuel::Union{String, ThermalFuels, Vector{ThermalFuels}, Vector{String}}
        power_systems_type::String
        cofire_level_max::Union{Nothing, Dict{ThermalFuels, Float64}}
        internal::InfrastructureSystemsInternal
        ext::Dict
        balancing_topology::String
        region::String
        min_power::Float64
        cluster::Int64
        inv_cost_per_mwyr::PSY.ValueCurve
        min_cap_mw::Float64
        ramp_up_percentage::Float64
        maintenance_duration::Int64
        maintenance_cycle_length_years::Int64
        reg_cost::Float64
        start_cost_per_mw::Float64
        cap_size::Float64
        reg_max::Float64
        up_time::Float64
        om_costs::PSY.OperationalCost
        maintenance_begin_cadence::Int64
    end



# Arguments
- `base_power::Float64`: Base power
- `heat_rate_mmbtu_per_mwh::Union{Float64, PSY.ValueCurve, Dict{ThermalFuels, PSY.ValueCurve}}`: (default: `0.0`) Heat rate of generator, MMBTU/MWh
- `zone::Int64`: Zone number where tech operates in
- `prime_mover_type::PrimeMovers`: (default: `PrimeMovers.OT`) Prime mover for generator
- `outage_factor::Float64`: (default: `1.0`) Derating factor to account for planned or forced outages of a technology
- `cofire_level_min::Union{Nothing, Dict{ThermalFuels, Float64}}`: (default: `nothing`) Minimum blending level of each fuel during normal generation process for multi-fuel generator
- `rsv_cost::Float64`: (default: `0.0`) Cost of providing upwards spinning or contingency reserves
- `cofire_start_max::Union{Nothing, Dict{ThermalFuels, Float64}}`: (default: `nothing`) Maximum blending level of each fuel during start-up process for multi-fuel generator
- `available::Bool`: (default: `True`) identifies whether the technology is available
- `cofire_start_min::Union{Nothing, Dict{ThermalFuels, Float64}}`: (default: `nothing`) Minimum blending level of each fuel during start-up process for multi-fuel generator
- `co2::Union{Float64, Dict{String, Float64}, Dict{ThermalFuels, Float64}}`: (default: `0.0`) Carbon Intensity of fuel
- `name::String`: The technology name
- `ramp_dn_percentage::Float64`: (default: `100.0`) Maximum decrease in output between operation periods. Fraction of total capacity
- `max_cap_mw::Float64`: (default: `Inf`) Maximum allowable installed capacity for a technology
- `id::Int64`: ID for individual generator
- `existing_cap_mw::Float64`: (default: `0.0`) Pre-existing capacity for a technology
- `down_time::Float64`: (default: `0.0`) Minimum amount of time a resource has to remain in the shutdown state.
- `start_fuel_mmbtu_per_mw::Float64`: (default: `0.0`) Startup fuel use per MW of nameplate capacity of each generator (MMBtu/MW per start)
- `rsv_max::Float64`: (default: `0.0`) Fraction of nameplate capacity that can committed to provided upwards spinning or contingency reserves.
- `fuel::Union{String, ThermalFuels, Vector{ThermalFuels}, Vector{String}}`: (default: `ThermalFuels.OTHER`) Fuel type according to IEA
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `cofire_level_max::Union{Nothing, Dict{ThermalFuels, Float64}}`: (default: `nothing`) Maximum blending level of each fuel during normal generation process for multi-fuel generator
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `balancing_topology::String`: Set of balancing nodes
- `region::String`: Region/zone technology operates in
- `min_power::Float64`: (default: `0.0`) Minimum generation as a fraction of total capacity
- `cluster::Int64`: (default: `1`) Number of the cluster when representing multiple clusters of a given technology in a given region.
- `inv_cost_per_mwyr::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a technology.
- `min_cap_mw::Float64`: (default: `0.0`) Minimum required capacity for a technology
- `ramp_up_percentage::Float64`: (default: `100.0`) Maximum increase in output between operation periods. Fraction of total capacity
- `maintenance_duration::Int64`: (default: `0`) Duration of the maintenance period, in number of timesteps.
- `maintenance_cycle_length_years::Int64`: (default: `0`) Length of scheduled maintenance cycle, in years.
- `reg_cost::Float64`: (default: `0.0`) Cost of providing regulation reserves 
- `start_cost_per_mw::Float64`: (default: `0.0`) Cost per MW of nameplate capacity to start a generator (/MW per start).
- `cap_size::Float64`: (default: `1.0`) Cap_size
- `reg_max::Float64`: (default: `0.0`) Fraction of nameplate capacity that can committed to provided regulation reserves
- `up_time::Float64`: (default: `0.0`) Minimum amount of time a resource has to stay in the committed state.
- `om_costs::PSY.OperationalCost`: (default: `ThermalGenerationCost()`) Fixed and variable O&M costs for a technology
- `maintenance_begin_cadence::Int64`: (default: `1`) Cadence of timesteps in which scheduled maintenance can begin.
"""
mutable struct SupplyTechnology{T <: PSY.Generator} <: Technology
    "Base power"
    base_power::Float64
    "Heat rate of generator, MMBTU/MWh"
    heat_rate_mmbtu_per_mwh::Union{Float64, PSY.ValueCurve, Dict{ThermalFuels, PSY.ValueCurve}}
    "Zone number where tech operates in"
    zone::Int64
    "Prime mover for generator"
    prime_mover_type::PrimeMovers
    "Derating factor to account for planned or forced outages of a technology"
    outage_factor::Float64
    "Minimum blending level of each fuel during normal generation process for multi-fuel generator"
    cofire_level_min::Union{Nothing, Dict{ThermalFuels, Float64}}
    "Cost of providing upwards spinning or contingency reserves"
    rsv_cost::Float64
    "Maximum blending level of each fuel during start-up process for multi-fuel generator"
    cofire_start_max::Union{Nothing, Dict{ThermalFuels, Float64}}
    "identifies whether the technology is available"
    available::Bool
    "Minimum blending level of each fuel during start-up process for multi-fuel generator"
    cofire_start_min::Union{Nothing, Dict{ThermalFuels, Float64}}
    "Carbon Intensity of fuel"
    co2::Union{Float64, Dict{String, Float64}, Dict{ThermalFuels, Float64}}
    "The technology name"
    name::String
    "Maximum decrease in output between operation periods. Fraction of total capacity"
    ramp_dn_percentage::Float64
    "Maximum allowable installed capacity for a technology"
    max_cap_mw::Float64
    "ID for individual generator"
    id::Int64
    "Pre-existing capacity for a technology"
    existing_cap_mw::Float64
    "Minimum amount of time a resource has to remain in the shutdown state."
    down_time::Float64
    "Startup fuel use per MW of nameplate capacity of each generator (MMBtu/MW per start)"
    start_fuel_mmbtu_per_mw::Float64
    "Fraction of nameplate capacity that can committed to provided upwards spinning or contingency reserves."
    rsv_max::Float64
    "Fuel type according to IEA"
    fuel::Union{String, ThermalFuels, Vector{ThermalFuels}, Vector{String}}
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Maximum blending level of each fuel during normal generation process for multi-fuel generator"
    cofire_level_max::Union{Nothing, Dict{ThermalFuels, Float64}}
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Set of balancing nodes"
    balancing_topology::String
    "Region/zone technology operates in"
    region::String
    "Minimum generation as a fraction of total capacity"
    min_power::Float64
    "Number of the cluster when representing multiple clusters of a given technology in a given region."
    cluster::Int64
    "Capital costs for investing in a technology."
    inv_cost_per_mwyr::PSY.ValueCurve
    "Minimum required capacity for a technology"
    min_cap_mw::Float64
    "Maximum increase in output between operation periods. Fraction of total capacity"
    ramp_up_percentage::Float64
    "Duration of the maintenance period, in number of timesteps."
    maintenance_duration::Int64
    "Length of scheduled maintenance cycle, in years."
    maintenance_cycle_length_years::Int64
    "Cost of providing regulation reserves "
    reg_cost::Float64
    "Cost per MW of nameplate capacity to start a generator (/MW per start)."
    start_cost_per_mw::Float64
    "Cap_size"
    cap_size::Float64
    "Fraction of nameplate capacity that can committed to provided regulation reserves"
    reg_max::Float64
    "Minimum amount of time a resource has to stay in the committed state."
    up_time::Float64
    "Fixed and variable O&M costs for a technology"
    om_costs::PSY.OperationalCost
    "Cadence of timesteps in which scheduled maintenance can begin."
    maintenance_begin_cadence::Int64
end


function SupplyTechnology{T}(; base_power, heat_rate_mmbtu_per_mwh=0.0, zone, prime_mover_type=PrimeMovers.OT, outage_factor=1.0, cofire_level_min=nothing, rsv_cost=0.0, cofire_start_max=nothing, available=True, cofire_start_min=nothing, co2=0.0, name, ramp_dn_percentage=100.0, max_cap_mw=Inf, id, existing_cap_mw=0.0, down_time=0.0, start_fuel_mmbtu_per_mw=0.0, rsv_max=0.0, fuel=ThermalFuels.OTHER, power_systems_type, cofire_level_max=nothing, internal=InfrastructureSystemsInternal(), ext=Dict(), balancing_topology, region, min_power=0.0, cluster=1, inv_cost_per_mwyr=LinearCurve(0.0), min_cap_mw=0.0, ramp_up_percentage=100.0, maintenance_duration=0, maintenance_cycle_length_years=0, reg_cost=0.0, start_cost_per_mw=0.0, cap_size=1.0, reg_max=0.0, up_time=0.0, om_costs=ThermalGenerationCost(), maintenance_begin_cadence=1, ) where T <: PSY.Generator
    SupplyTechnology{T}(base_power, heat_rate_mmbtu_per_mwh, zone, prime_mover_type, outage_factor, cofire_level_min, rsv_cost, cofire_start_max, available, cofire_start_min, co2, name, ramp_dn_percentage, max_cap_mw, id, existing_cap_mw, down_time, start_fuel_mmbtu_per_mw, rsv_max, fuel, power_systems_type, cofire_level_max, internal, ext, balancing_topology, region, min_power, cluster, inv_cost_per_mwyr, min_cap_mw, ramp_up_percentage, maintenance_duration, maintenance_cycle_length_years, reg_cost, start_cost_per_mw, cap_size, reg_max, up_time, om_costs, maintenance_begin_cadence, )
end

"""Get [`SupplyTechnology`](@ref) `base_power`."""
get_base_power(value::SupplyTechnology) = value.base_power
"""Get [`SupplyTechnology`](@ref) `heat_rate_mmbtu_per_mwh`."""
get_heat_rate_mmbtu_per_mwh(value::SupplyTechnology) = value.heat_rate_mmbtu_per_mwh
"""Get [`SupplyTechnology`](@ref) `zone`."""
get_zone(value::SupplyTechnology) = value.zone
"""Get [`SupplyTechnology`](@ref) `prime_mover_type`."""
get_prime_mover_type(value::SupplyTechnology) = value.prime_mover_type
"""Get [`SupplyTechnology`](@ref) `outage_factor`."""
get_outage_factor(value::SupplyTechnology) = value.outage_factor
"""Get [`SupplyTechnology`](@ref) `cofire_level_min`."""
get_cofire_level_min(value::SupplyTechnology) = value.cofire_level_min
"""Get [`SupplyTechnology`](@ref) `rsv_cost`."""
get_rsv_cost(value::SupplyTechnology) = value.rsv_cost
"""Get [`SupplyTechnology`](@ref) `cofire_start_max`."""
get_cofire_start_max(value::SupplyTechnology) = value.cofire_start_max
"""Get [`SupplyTechnology`](@ref) `available`."""
get_available(value::SupplyTechnology) = value.available
"""Get [`SupplyTechnology`](@ref) `cofire_start_min`."""
get_cofire_start_min(value::SupplyTechnology) = value.cofire_start_min
"""Get [`SupplyTechnology`](@ref) `co2`."""
get_co2(value::SupplyTechnology) = value.co2
"""Get [`SupplyTechnology`](@ref) `name`."""
get_name(value::SupplyTechnology) = value.name
"""Get [`SupplyTechnology`](@ref) `ramp_dn_percentage`."""
get_ramp_dn_percentage(value::SupplyTechnology) = value.ramp_dn_percentage
"""Get [`SupplyTechnology`](@ref) `max_cap_mw`."""
get_max_cap_mw(value::SupplyTechnology) = value.max_cap_mw
"""Get [`SupplyTechnology`](@ref) `id`."""
get_id(value::SupplyTechnology) = value.id
"""Get [`SupplyTechnology`](@ref) `existing_cap_mw`."""
get_existing_cap_mw(value::SupplyTechnology) = value.existing_cap_mw
"""Get [`SupplyTechnology`](@ref) `down_time`."""
get_down_time(value::SupplyTechnology) = value.down_time
"""Get [`SupplyTechnology`](@ref) `start_fuel_mmbtu_per_mw`."""
get_start_fuel_mmbtu_per_mw(value::SupplyTechnology) = value.start_fuel_mmbtu_per_mw
"""Get [`SupplyTechnology`](@ref) `rsv_max`."""
get_rsv_max(value::SupplyTechnology) = value.rsv_max
"""Get [`SupplyTechnology`](@ref) `fuel`."""
get_fuel(value::SupplyTechnology) = value.fuel
"""Get [`SupplyTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::SupplyTechnology) = value.power_systems_type
"""Get [`SupplyTechnology`](@ref) `cofire_level_max`."""
get_cofire_level_max(value::SupplyTechnology) = value.cofire_level_max
"""Get [`SupplyTechnology`](@ref) `internal`."""
get_internal(value::SupplyTechnology) = value.internal
"""Get [`SupplyTechnology`](@ref) `ext`."""
get_ext(value::SupplyTechnology) = value.ext
"""Get [`SupplyTechnology`](@ref) `balancing_topology`."""
get_balancing_topology(value::SupplyTechnology) = value.balancing_topology
"""Get [`SupplyTechnology`](@ref) `region`."""
get_region(value::SupplyTechnology) = value.region
"""Get [`SupplyTechnology`](@ref) `min_power`."""
get_min_power(value::SupplyTechnology) = value.min_power
"""Get [`SupplyTechnology`](@ref) `cluster`."""
get_cluster(value::SupplyTechnology) = value.cluster
"""Get [`SupplyTechnology`](@ref) `inv_cost_per_mwyr`."""
get_inv_cost_per_mwyr(value::SupplyTechnology) = value.inv_cost_per_mwyr
"""Get [`SupplyTechnology`](@ref) `min_cap_mw`."""
get_min_cap_mw(value::SupplyTechnology) = value.min_cap_mw
"""Get [`SupplyTechnology`](@ref) `ramp_up_percentage`."""
get_ramp_up_percentage(value::SupplyTechnology) = value.ramp_up_percentage
"""Get [`SupplyTechnology`](@ref) `maintenance_duration`."""
get_maintenance_duration(value::SupplyTechnology) = value.maintenance_duration
"""Get [`SupplyTechnology`](@ref) `maintenance_cycle_length_years`."""
get_maintenance_cycle_length_years(value::SupplyTechnology) = value.maintenance_cycle_length_years
"""Get [`SupplyTechnology`](@ref) `reg_cost`."""
get_reg_cost(value::SupplyTechnology) = value.reg_cost
"""Get [`SupplyTechnology`](@ref) `start_cost_per_mw`."""
get_start_cost_per_mw(value::SupplyTechnology) = value.start_cost_per_mw
"""Get [`SupplyTechnology`](@ref) `cap_size`."""
get_cap_size(value::SupplyTechnology) = value.cap_size
"""Get [`SupplyTechnology`](@ref) `reg_max`."""
get_reg_max(value::SupplyTechnology) = value.reg_max
"""Get [`SupplyTechnology`](@ref) `up_time`."""
get_up_time(value::SupplyTechnology) = value.up_time
"""Get [`SupplyTechnology`](@ref) `om_costs`."""
get_om_costs(value::SupplyTechnology) = value.om_costs
"""Get [`SupplyTechnology`](@ref) `maintenance_begin_cadence`."""
get_maintenance_begin_cadence(value::SupplyTechnology) = value.maintenance_begin_cadence

"""Set [`SupplyTechnology`](@ref) `base_power`."""
set_base_power!(value::SupplyTechnology, val) = value.base_power = val
"""Set [`SupplyTechnology`](@ref) `heat_rate_mmbtu_per_mwh`."""
set_heat_rate_mmbtu_per_mwh!(value::SupplyTechnology, val) = value.heat_rate_mmbtu_per_mwh = val
"""Set [`SupplyTechnology`](@ref) `zone`."""
set_zone!(value::SupplyTechnology, val) = value.zone = val
"""Set [`SupplyTechnology`](@ref) `prime_mover_type`."""
set_prime_mover_type!(value::SupplyTechnology, val) = value.prime_mover_type = val
"""Set [`SupplyTechnology`](@ref) `outage_factor`."""
set_outage_factor!(value::SupplyTechnology, val) = value.outage_factor = val
"""Set [`SupplyTechnology`](@ref) `cofire_level_min`."""
set_cofire_level_min!(value::SupplyTechnology, val) = value.cofire_level_min = val
"""Set [`SupplyTechnology`](@ref) `rsv_cost`."""
set_rsv_cost!(value::SupplyTechnology, val) = value.rsv_cost = val
"""Set [`SupplyTechnology`](@ref) `cofire_start_max`."""
set_cofire_start_max!(value::SupplyTechnology, val) = value.cofire_start_max = val
"""Set [`SupplyTechnology`](@ref) `available`."""
set_available!(value::SupplyTechnology, val) = value.available = val
"""Set [`SupplyTechnology`](@ref) `cofire_start_min`."""
set_cofire_start_min!(value::SupplyTechnology, val) = value.cofire_start_min = val
"""Set [`SupplyTechnology`](@ref) `co2`."""
set_co2!(value::SupplyTechnology, val) = value.co2 = val
"""Set [`SupplyTechnology`](@ref) `name`."""
set_name!(value::SupplyTechnology, val) = value.name = val
"""Set [`SupplyTechnology`](@ref) `ramp_dn_percentage`."""
set_ramp_dn_percentage!(value::SupplyTechnology, val) = value.ramp_dn_percentage = val
"""Set [`SupplyTechnology`](@ref) `max_cap_mw`."""
set_max_cap_mw!(value::SupplyTechnology, val) = value.max_cap_mw = val
"""Set [`SupplyTechnology`](@ref) `id`."""
set_id!(value::SupplyTechnology, val) = value.id = val
"""Set [`SupplyTechnology`](@ref) `existing_cap_mw`."""
set_existing_cap_mw!(value::SupplyTechnology, val) = value.existing_cap_mw = val
"""Set [`SupplyTechnology`](@ref) `down_time`."""
set_down_time!(value::SupplyTechnology, val) = value.down_time = val
"""Set [`SupplyTechnology`](@ref) `start_fuel_mmbtu_per_mw`."""
set_start_fuel_mmbtu_per_mw!(value::SupplyTechnology, val) = value.start_fuel_mmbtu_per_mw = val
"""Set [`SupplyTechnology`](@ref) `rsv_max`."""
set_rsv_max!(value::SupplyTechnology, val) = value.rsv_max = val
"""Set [`SupplyTechnology`](@ref) `fuel`."""
set_fuel!(value::SupplyTechnology, val) = value.fuel = val
"""Set [`SupplyTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::SupplyTechnology, val) = value.power_systems_type = val
"""Set [`SupplyTechnology`](@ref) `cofire_level_max`."""
set_cofire_level_max!(value::SupplyTechnology, val) = value.cofire_level_max = val
"""Set [`SupplyTechnology`](@ref) `internal`."""
set_internal!(value::SupplyTechnology, val) = value.internal = val
"""Set [`SupplyTechnology`](@ref) `ext`."""
set_ext!(value::SupplyTechnology, val) = value.ext = val
"""Set [`SupplyTechnology`](@ref) `balancing_topology`."""
set_balancing_topology!(value::SupplyTechnology, val) = value.balancing_topology = val
"""Set [`SupplyTechnology`](@ref) `region`."""
set_region!(value::SupplyTechnology, val) = value.region = val
"""Set [`SupplyTechnology`](@ref) `min_power`."""
set_min_power!(value::SupplyTechnology, val) = value.min_power = val
"""Set [`SupplyTechnology`](@ref) `cluster`."""
set_cluster!(value::SupplyTechnology, val) = value.cluster = val
"""Set [`SupplyTechnology`](@ref) `inv_cost_per_mwyr`."""
set_inv_cost_per_mwyr!(value::SupplyTechnology, val) = value.inv_cost_per_mwyr = val
"""Set [`SupplyTechnology`](@ref) `min_cap_mw`."""
set_min_cap_mw!(value::SupplyTechnology, val) = value.min_cap_mw = val
"""Set [`SupplyTechnology`](@ref) `ramp_up_percentage`."""
set_ramp_up_percentage!(value::SupplyTechnology, val) = value.ramp_up_percentage = val
"""Set [`SupplyTechnology`](@ref) `maintenance_duration`."""
set_maintenance_duration!(value::SupplyTechnology, val) = value.maintenance_duration = val
"""Set [`SupplyTechnology`](@ref) `maintenance_cycle_length_years`."""
set_maintenance_cycle_length_years!(value::SupplyTechnology, val) = value.maintenance_cycle_length_years = val
"""Set [`SupplyTechnology`](@ref) `reg_cost`."""
set_reg_cost!(value::SupplyTechnology, val) = value.reg_cost = val
"""Set [`SupplyTechnology`](@ref) `start_cost_per_mw`."""
set_start_cost_per_mw!(value::SupplyTechnology, val) = value.start_cost_per_mw = val
"""Set [`SupplyTechnology`](@ref) `cap_size`."""
set_cap_size!(value::SupplyTechnology, val) = value.cap_size = val
"""Set [`SupplyTechnology`](@ref) `reg_max`."""
set_reg_max!(value::SupplyTechnology, val) = value.reg_max = val
"""Set [`SupplyTechnology`](@ref) `up_time`."""
set_up_time!(value::SupplyTechnology, val) = value.up_time = val
"""Set [`SupplyTechnology`](@ref) `om_costs`."""
set_om_costs!(value::SupplyTechnology, val) = value.om_costs = val
"""Set [`SupplyTechnology`](@ref) `maintenance_begin_cadence`."""
set_maintenance_begin_cadence!(value::SupplyTechnology, val) = value.maintenance_begin_cadence = val
