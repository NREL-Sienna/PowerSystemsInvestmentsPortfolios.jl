#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct SupplyTechnology{T <: PSY.Generator} <: Technology
        base_power::Float64
        heat_rate_mmbtu_per_mwh::Union{Float64, PSY.ValueCurve, Dict{ThermalFuels, PSY.ValueCurve}}
        outage_factor::Float64
        prime_mover_type::PrimeMovers
        minimum_required_capacity::Float64
        cofire_level_min::Union{Nothing, Dict{ThermalFuels, Float64}}
        capital_costs::PSY.ValueCurve
        rsv_cost::Float64
        cofire_start_max::Union{Nothing, Dict{ThermalFuels, Float64}}
        gen_ID::Int64
        available::Bool
        co2::Union{Float64, Dict{String, Float64}, Dict{ThermalFuels, Float64}}
        name::String
        cofire_start_min::Union{Nothing, Dict{ThermalFuels, Float64}}
        ramp_dn_percentage::Float64
        down_time::Float64
        initial_capacity::Float64
        start_fuel_mmbtu_per_mw::Float64
        operation_costs::PSY.OperationalCost
        rsv_max::Float64
        fuel::Union{String, ThermalFuels, Vector{ThermalFuels}, Vector{String}}
        power_systems_type::String
        cofire_level_max::Union{Nothing, Dict{ThermalFuels, Float64}}
        internal::InfrastructureSystemsInternal
        ext::Dict
        balancing_topology::String
        region::Union{Nothing, Region}
        maximum_capacity::Float64
        cluster::Int64
        ramp_up_percentage::Float64
        unit_size::Float64
        reg_cost::Float64
        min_generation_percentage::Float64
        start_cost_per_mw::Float64
        reg_max::Float64
        up_time::Float64
    end



# Arguments
- `base_power::Float64`: Base power
- `heat_rate_mmbtu_per_mwh::Union{Float64, PSY.ValueCurve, Dict{ThermalFuels, PSY.ValueCurve}}`: (default: `0.0`) Heat rate of generator, MMBTU/MWh
- `outage_factor::Float64`: (default: `1.0`) Derating factor to account for planned or forced outages of a technology
- `prime_mover_type::PrimeMovers`: (default: `PrimeMovers.OT`) Prime mover for generator
- `minimum_required_capacity::Float64`: (default: `0.0`) Minimum required capacity for a technology
- `cofire_level_min::Union{Nothing, Dict{ThermalFuels, Float64}}`: (default: `nothing`) Minimum blending level of each fuel during normal generation process for multi-fuel generator
- `capital_costs::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a technology.
- `rsv_cost::Float64`: (default: `0.0`) Cost of providing upwards spinning or contingency reserves
- `cofire_start_max::Union{Nothing, Dict{ThermalFuels, Float64}}`: (default: `nothing`) Maximum blending level of each fuel during start-up process for multi-fuel generator
- `gen_ID::Int64`: ID for individual generator
- `available::Bool`: (default: `True`) identifies whether the technology is available
- `co2::Union{Float64, Dict{String, Float64}, Dict{ThermalFuels, Float64}}`: (default: `0.0`) Carbon Intensity of fuel
- `name::String`: The technology name
- `cofire_start_min::Union{Nothing, Dict{ThermalFuels, Float64}}`: (default: `nothing`) Minimum blending level of each fuel during start-up process for multi-fuel generator
- `ramp_dn_percentage::Float64`: (default: `100.0`) Maximum decrease in output between operation periods. Fraction of total capacity
- `down_time::Float64`: (default: `0.0`) Minimum amount of time a resource has to remain in the shutdown state.
- `initial_capacity::Float64`: (default: `0.0`) Pre-existing capacity for a technology
- `start_fuel_mmbtu_per_mw::Float64`: (default: `0.0`) Startup fuel use per MW of nameplate capacity of each generator (MMBtu/MW per start)
- `operation_costs::PSY.OperationalCost`: (default: `ThermalGenerationCost()`) Fixed and variable O&M costs for a technology
- `rsv_max::Float64`: (default: `0.0`) Fraction of nameplate capacity that can committed to provided upwards spinning or contingency reserves.
- `fuel::Union{String, ThermalFuels, Vector{ThermalFuels}, Vector{String}}`: (default: `ThermalFuels.OTHER`) Fuel type according to IEA
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `cofire_level_max::Union{Nothing, Dict{ThermalFuels, Float64}}`: (default: `nothing`) Maximum blending level of each fuel during normal generation process for multi-fuel generator
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `balancing_topology::String`: Set of balancing nodes
- `region::Union{Nothing, Region}`: (default: `nothing`) Zone where tech operates in
- `maximum_capacity::Float64`: (default: `Inf`) Maximum allowable installed capacity for a technology
- `cluster::Int64`: (default: `1`) Number of the cluster when representing multiple clusters of a given technology in a given region.
- `ramp_up_percentage::Float64`: (default: `100.0`) Maximum increase in output between operation periods. Fraction of total capacity
- `unit_size::Float64`: (default: `0.0`) Used for discrete investment decisions. Size of each unit being built (MW)
- `reg_cost::Float64`: (default: `0.0`) Cost of providing regulation reserves 
- `min_generation_percentage::Float64`: (default: `0.0`) Minimum generation as a fraction of total capacity
- `start_cost_per_mw::Float64`: (default: `0.0`) Cost per MW of nameplate capacity to start a generator (/MW per start).
- `reg_max::Float64`: (default: `0.0`) Fraction of nameplate capacity that can committed to provided regulation reserves
- `up_time::Float64`: (default: `0.0`) Minimum amount of time a resource has to stay in the committed state.
"""
mutable struct SupplyTechnology{T <: PSY.Generator} <: Technology
    "Base power"
    base_power::Float64
    "Heat rate of generator, MMBTU/MWh"
    heat_rate_mmbtu_per_mwh::Union{Float64, PSY.ValueCurve, Dict{ThermalFuels, PSY.ValueCurve}}
    "Derating factor to account for planned or forced outages of a technology"
    outage_factor::Float64
    "Prime mover for generator"
    prime_mover_type::PrimeMovers
    "Minimum required capacity for a technology"
    minimum_required_capacity::Float64
    "Minimum blending level of each fuel during normal generation process for multi-fuel generator"
    cofire_level_min::Union{Nothing, Dict{ThermalFuels, Float64}}
    "Capital costs for investing in a technology."
    capital_costs::PSY.ValueCurve
    "Cost of providing upwards spinning or contingency reserves"
    rsv_cost::Float64
    "Maximum blending level of each fuel during start-up process for multi-fuel generator"
    cofire_start_max::Union{Nothing, Dict{ThermalFuels, Float64}}
    "ID for individual generator"
    gen_ID::Int64
    "identifies whether the technology is available"
    available::Bool
    "Carbon Intensity of fuel"
    co2::Union{Float64, Dict{String, Float64}, Dict{ThermalFuels, Float64}}
    "The technology name"
    name::String
    "Minimum blending level of each fuel during start-up process for multi-fuel generator"
    cofire_start_min::Union{Nothing, Dict{ThermalFuels, Float64}}
    "Maximum decrease in output between operation periods. Fraction of total capacity"
    ramp_dn_percentage::Float64
    "Minimum amount of time a resource has to remain in the shutdown state."
    down_time::Float64
    "Pre-existing capacity for a technology"
    initial_capacity::Float64
    "Startup fuel use per MW of nameplate capacity of each generator (MMBtu/MW per start)"
    start_fuel_mmbtu_per_mw::Float64
    "Fixed and variable O&M costs for a technology"
    operation_costs::PSY.OperationalCost
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
    "Zone where tech operates in"
    region::Union{Nothing, Region}
    "Maximum allowable installed capacity for a technology"
    maximum_capacity::Float64
    "Number of the cluster when representing multiple clusters of a given technology in a given region."
    cluster::Int64
    "Maximum increase in output between operation periods. Fraction of total capacity"
    ramp_up_percentage::Float64
    "Used for discrete investment decisions. Size of each unit being built (MW)"
    unit_size::Float64
    "Cost of providing regulation reserves "
    reg_cost::Float64
    "Minimum generation as a fraction of total capacity"
    min_generation_percentage::Float64
    "Cost per MW of nameplate capacity to start a generator (/MW per start)."
    start_cost_per_mw::Float64
    "Fraction of nameplate capacity that can committed to provided regulation reserves"
    reg_max::Float64
    "Minimum amount of time a resource has to stay in the committed state."
    up_time::Float64
end


function SupplyTechnology{T}(; base_power, heat_rate_mmbtu_per_mwh=0.0, outage_factor=1.0, prime_mover_type=PrimeMovers.OT, minimum_required_capacity=0.0, cofire_level_min=nothing, capital_costs=LinearCurve(0.0), rsv_cost=0.0, cofire_start_max=nothing, gen_ID, available=True, co2=0.0, name, cofire_start_min=nothing, ramp_dn_percentage=100.0, down_time=0.0, initial_capacity=0.0, start_fuel_mmbtu_per_mw=0.0, operation_costs=ThermalGenerationCost(), rsv_max=0.0, fuel=ThermalFuels.OTHER, power_systems_type, cofire_level_max=nothing, internal=InfrastructureSystemsInternal(), ext=Dict(), balancing_topology, region=nothing, maximum_capacity=Inf, cluster=1, ramp_up_percentage=100.0, unit_size=0.0, reg_cost=0.0, min_generation_percentage=0.0, start_cost_per_mw=0.0, reg_max=0.0, up_time=0.0, ) where T <: PSY.Generator
    SupplyTechnology{T}(base_power, heat_rate_mmbtu_per_mwh, outage_factor, prime_mover_type, minimum_required_capacity, cofire_level_min, capital_costs, rsv_cost, cofire_start_max, gen_ID, available, co2, name, cofire_start_min, ramp_dn_percentage, down_time, initial_capacity, start_fuel_mmbtu_per_mw, operation_costs, rsv_max, fuel, power_systems_type, cofire_level_max, internal, ext, balancing_topology, region, maximum_capacity, cluster, ramp_up_percentage, unit_size, reg_cost, min_generation_percentage, start_cost_per_mw, reg_max, up_time, )
end

"""Get [`SupplyTechnology`](@ref) `base_power`."""
get_base_power(value::SupplyTechnology) = value.base_power
"""Get [`SupplyTechnology`](@ref) `heat_rate_mmbtu_per_mwh`."""
get_heat_rate_mmbtu_per_mwh(value::SupplyTechnology) = value.heat_rate_mmbtu_per_mwh
"""Get [`SupplyTechnology`](@ref) `outage_factor`."""
get_outage_factor(value::SupplyTechnology) = value.outage_factor
"""Get [`SupplyTechnology`](@ref) `prime_mover_type`."""
get_prime_mover_type(value::SupplyTechnology) = value.prime_mover_type
"""Get [`SupplyTechnology`](@ref) `minimum_required_capacity`."""
get_minimum_required_capacity(value::SupplyTechnology) = value.minimum_required_capacity
"""Get [`SupplyTechnology`](@ref) `cofire_level_min`."""
get_cofire_level_min(value::SupplyTechnology) = value.cofire_level_min
"""Get [`SupplyTechnology`](@ref) `capital_costs`."""
get_capital_costs(value::SupplyTechnology) = value.capital_costs
"""Get [`SupplyTechnology`](@ref) `rsv_cost`."""
get_rsv_cost(value::SupplyTechnology) = value.rsv_cost
"""Get [`SupplyTechnology`](@ref) `cofire_start_max`."""
get_cofire_start_max(value::SupplyTechnology) = value.cofire_start_max
"""Get [`SupplyTechnology`](@ref) `gen_ID`."""
get_gen_ID(value::SupplyTechnology) = value.gen_ID
"""Get [`SupplyTechnology`](@ref) `available`."""
get_available(value::SupplyTechnology) = value.available
"""Get [`SupplyTechnology`](@ref) `co2`."""
get_co2(value::SupplyTechnology) = value.co2
"""Get [`SupplyTechnology`](@ref) `name`."""
get_name(value::SupplyTechnology) = value.name
"""Get [`SupplyTechnology`](@ref) `cofire_start_min`."""
get_cofire_start_min(value::SupplyTechnology) = value.cofire_start_min
"""Get [`SupplyTechnology`](@ref) `ramp_dn_percentage`."""
get_ramp_dn_percentage(value::SupplyTechnology) = value.ramp_dn_percentage
"""Get [`SupplyTechnology`](@ref) `down_time`."""
get_down_time(value::SupplyTechnology) = value.down_time
"""Get [`SupplyTechnology`](@ref) `initial_capacity`."""
get_initial_capacity(value::SupplyTechnology) = value.initial_capacity
"""Get [`SupplyTechnology`](@ref) `start_fuel_mmbtu_per_mw`."""
get_start_fuel_mmbtu_per_mw(value::SupplyTechnology) = value.start_fuel_mmbtu_per_mw
"""Get [`SupplyTechnology`](@ref) `operation_costs`."""
get_operation_costs(value::SupplyTechnology) = value.operation_costs
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
"""Get [`SupplyTechnology`](@ref) `maximum_capacity`."""
get_maximum_capacity(value::SupplyTechnology) = value.maximum_capacity
"""Get [`SupplyTechnology`](@ref) `cluster`."""
get_cluster(value::SupplyTechnology) = value.cluster
"""Get [`SupplyTechnology`](@ref) `ramp_up_percentage`."""
get_ramp_up_percentage(value::SupplyTechnology) = value.ramp_up_percentage
"""Get [`SupplyTechnology`](@ref) `unit_size`."""
get_unit_size(value::SupplyTechnology) = value.unit_size
"""Get [`SupplyTechnology`](@ref) `reg_cost`."""
get_reg_cost(value::SupplyTechnology) = value.reg_cost
"""Get [`SupplyTechnology`](@ref) `min_generation_percentage`."""
get_min_generation_percentage(value::SupplyTechnology) = value.min_generation_percentage
"""Get [`SupplyTechnology`](@ref) `start_cost_per_mw`."""
get_start_cost_per_mw(value::SupplyTechnology) = value.start_cost_per_mw
"""Get [`SupplyTechnology`](@ref) `reg_max`."""
get_reg_max(value::SupplyTechnology) = value.reg_max
"""Get [`SupplyTechnology`](@ref) `up_time`."""
get_up_time(value::SupplyTechnology) = value.up_time

"""Set [`SupplyTechnology`](@ref) `base_power`."""
set_base_power!(value::SupplyTechnology, val) = value.base_power = val
"""Set [`SupplyTechnology`](@ref) `heat_rate_mmbtu_per_mwh`."""
set_heat_rate_mmbtu_per_mwh!(value::SupplyTechnology, val) = value.heat_rate_mmbtu_per_mwh = val
"""Set [`SupplyTechnology`](@ref) `outage_factor`."""
set_outage_factor!(value::SupplyTechnology, val) = value.outage_factor = val
"""Set [`SupplyTechnology`](@ref) `prime_mover_type`."""
set_prime_mover_type!(value::SupplyTechnology, val) = value.prime_mover_type = val
"""Set [`SupplyTechnology`](@ref) `minimum_required_capacity`."""
set_minimum_required_capacity!(value::SupplyTechnology, val) = value.minimum_required_capacity = val
"""Set [`SupplyTechnology`](@ref) `cofire_level_min`."""
set_cofire_level_min!(value::SupplyTechnology, val) = value.cofire_level_min = val
"""Set [`SupplyTechnology`](@ref) `capital_costs`."""
set_capital_costs!(value::SupplyTechnology, val) = value.capital_costs = val
"""Set [`SupplyTechnology`](@ref) `rsv_cost`."""
set_rsv_cost!(value::SupplyTechnology, val) = value.rsv_cost = val
"""Set [`SupplyTechnology`](@ref) `cofire_start_max`."""
set_cofire_start_max!(value::SupplyTechnology, val) = value.cofire_start_max = val
"""Set [`SupplyTechnology`](@ref) `gen_ID`."""
set_gen_ID!(value::SupplyTechnology, val) = value.gen_ID = val
"""Set [`SupplyTechnology`](@ref) `available`."""
set_available!(value::SupplyTechnology, val) = value.available = val
"""Set [`SupplyTechnology`](@ref) `co2`."""
set_co2!(value::SupplyTechnology, val) = value.co2 = val
"""Set [`SupplyTechnology`](@ref) `name`."""
set_name!(value::SupplyTechnology, val) = value.name = val
"""Set [`SupplyTechnology`](@ref) `cofire_start_min`."""
set_cofire_start_min!(value::SupplyTechnology, val) = value.cofire_start_min = val
"""Set [`SupplyTechnology`](@ref) `ramp_dn_percentage`."""
set_ramp_dn_percentage!(value::SupplyTechnology, val) = value.ramp_dn_percentage = val
"""Set [`SupplyTechnology`](@ref) `down_time`."""
set_down_time!(value::SupplyTechnology, val) = value.down_time = val
"""Set [`SupplyTechnology`](@ref) `initial_capacity`."""
set_initial_capacity!(value::SupplyTechnology, val) = value.initial_capacity = val
"""Set [`SupplyTechnology`](@ref) `start_fuel_mmbtu_per_mw`."""
set_start_fuel_mmbtu_per_mw!(value::SupplyTechnology, val) = value.start_fuel_mmbtu_per_mw = val
"""Set [`SupplyTechnology`](@ref) `operation_costs`."""
set_operation_costs!(value::SupplyTechnology, val) = value.operation_costs = val
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
"""Set [`SupplyTechnology`](@ref) `maximum_capacity`."""
set_maximum_capacity!(value::SupplyTechnology, val) = value.maximum_capacity = val
"""Set [`SupplyTechnology`](@ref) `cluster`."""
set_cluster!(value::SupplyTechnology, val) = value.cluster = val
"""Set [`SupplyTechnology`](@ref) `ramp_up_percentage`."""
set_ramp_up_percentage!(value::SupplyTechnology, val) = value.ramp_up_percentage = val
"""Set [`SupplyTechnology`](@ref) `unit_size`."""
set_unit_size!(value::SupplyTechnology, val) = value.unit_size = val
"""Set [`SupplyTechnology`](@ref) `reg_cost`."""
set_reg_cost!(value::SupplyTechnology, val) = value.reg_cost = val
"""Set [`SupplyTechnology`](@ref) `min_generation_percentage`."""
set_min_generation_percentage!(value::SupplyTechnology, val) = value.min_generation_percentage = val
"""Set [`SupplyTechnology`](@ref) `start_cost_per_mw`."""
set_start_cost_per_mw!(value::SupplyTechnology, val) = value.start_cost_per_mw = val
"""Set [`SupplyTechnology`](@ref) `reg_max`."""
set_reg_max!(value::SupplyTechnology, val) = value.reg_max = val
"""Set [`SupplyTechnology`](@ref) `up_time`."""
set_up_time!(value::SupplyTechnology, val) = value.up_time = val
