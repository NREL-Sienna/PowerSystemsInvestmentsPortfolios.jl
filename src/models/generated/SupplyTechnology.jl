#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct SupplyTechnology{T <: PSY.Generator} <: Technology
        base_power::Float64
        outage_factor::Float64
        prime_mover_type::PrimeMovers
        capital_cost::PSY.ValueCurve
        cofire_level_min::Union{Nothing, Dict{ThermalFuels, Float64}}
        minimum_required_capacity::Float64
        cofire_start_max::Union{Nothing, Dict{ThermalFuels, Float64}}
        gen_ID::String
        cofire_start_min::Union{Nothing, Dict{ThermalFuels, Float64}}
        available::Bool
        name::String
        ramp_down::Float64
        down_time::Float64
        initial_capacity::Float64
        fuel::Union{ThermalFuels, Dict{ThermalFuels, ThermalFuels}}
        cofire_level_max::Union{Nothing, Dict{ThermalFuels, Float64}}
        start_fuel::Float64
        heat_rate::Union{PSY.ValueCurve, Dict{ThermalFuels, PSY.ValueCurve}}
        minimum_generation::Float64
        ext::Dict
        balancing_topology::String
        internal::InfrastructureSystemsInternal
        region::String
        operations_cost::PSY.OperationalCost
        maximum_capacity::Float64
        cluster::Int64
        maintenance_duration::Int64
        start_cost::Float64
        maintenance_cycle_length_years::Int64
        up_time::Float64
        ramp_up::Float64
        maintenance_begin_cadence::Int64
    end



# Arguments
- `base_power::Float64`: Base power
- `outage_factor::Float64`: (default: `1.0`) Derating factor to account for planned or forced outages of a technology
- `prime_mover_type::PrimeMovers`: (default: `PrimeMovers.OT`) Prime mover for generator
- `capital_cost::PSY.ValueCurve`: (default: `0.0`) Capital costs for investing in a technology.
- `cofire_level_min::Union{Nothing, Dict{ThermalFuels, Float64}}`: Minimum blending level of each fuel during normal generation process for multi-fuel generator
- `minimum_required_capacity::Float64`: (default: `0.0`) Minimum required capacity for a technology
- `cofire_start_max::Union{Nothing, Dict{ThermalFuels, Float64}}`: Maximum blending level of each fuel during start-up process for multi-fuel generator
- `gen_ID::String`: ID for individual generator
- `cofire_start_min::Union{Nothing, Dict{ThermalFuels, Float64}}`: Minimum blending level of each fuel during start-up process for multi-fuel generator
- `available::Bool`: (default: `True`) identifies whether the technology is available
- `name::String`: The technology name
- `ramp_down::Float64`: (default: `100.0`) Maximum decrease in output between operation periods. Fraction of total capacity
- `down_time::Float64`: (default: `0.0`) Minimum amount of time a resource has to remain in the shutdown state.
- `initial_capacity::Float64`: Pre-existing capacity for a technology
- `fuel::Union{ThermalFuels, Dict{ThermalFuels, ThermalFuels}}`: (default: `ThermalFuels.OTHER`) Fuel type according to IEA
- `cofire_level_max::Union{Nothing, Dict{ThermalFuels, Float64}}`: Maximum blending level of each fuel during normal generation process for multi-fuel generator
- `start_fuel::Float64`: (default: `0.0`) Startup fuel use per MW of nameplate capacity of each generator (MMBtu/MW per start)
- `heat_rate::Union{PSY.ValueCurve, Dict{ThermalFuels, PSY.ValueCurve}}`: (default: `1.0`) Heat rate of generator, MMBTU/MWh
- `minimum_generation::Float64`: (default: `0.0`) Minimum generation as a fraction of total capacity
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `balancing_topology::String`: Set of balancing nodes
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `region::String`: Region/zone technology operates in
- `operations_cost::PSY.OperationalCost`: Fixed O&M costs for a technology
- `maximum_capacity::Float64`: (default: `Inf`) Maximum allowable installed capacity for a technology
- `cluster::Int64`: (default: `1`) Number of the cluster when representing multiple clusters of a given technology in a given region.
- `maintenance_duration::Int64`: (default: `0`) Duration of the maintenance period, in number of timesteps.
- `start_cost::Float64`: (default: `0.0`) Cost per MW of nameplate capacity to start a generator (/MW per start).
- `maintenance_cycle_length_years::Int64`: (default: `0`) Length of scheduled maintenance cycle, in years.
- `up_time::Float64`: (default: `0.0`) Minimum amount of time a resource has to stay in the committed state.
- `ramp_up::Float64`: (default: `100.0`) Maximum increase in output between operation periods. Fraction of total capacity
- `maintenance_begin_cadence::Int64`: (default: `1`) Cadence of timesteps in which scheduled maintenance can begin.
"""
mutable struct SupplyTechnology{T <: PSY.Generator} <: Technology
    "Base power"
    base_power::Float64
    "Derating factor to account for planned or forced outages of a technology"
    outage_factor::Float64
    "Prime mover for generator"
    prime_mover_type::PrimeMovers
    "Capital costs for investing in a technology."
    capital_cost::PSY.ValueCurve
    "Minimum blending level of each fuel during normal generation process for multi-fuel generator"
    cofire_level_min::Union{Nothing, Dict{ThermalFuels, Float64}}
    "Minimum required capacity for a technology"
    minimum_required_capacity::Float64
    "Maximum blending level of each fuel during start-up process for multi-fuel generator"
    cofire_start_max::Union{Nothing, Dict{ThermalFuels, Float64}}
    "ID for individual generator"
    gen_ID::String
    "Minimum blending level of each fuel during start-up process for multi-fuel generator"
    cofire_start_min::Union{Nothing, Dict{ThermalFuels, Float64}}
    "identifies whether the technology is available"
    available::Bool
    "The technology name"
    name::String
    "Maximum decrease in output between operation periods. Fraction of total capacity"
    ramp_down::Float64
    "Minimum amount of time a resource has to remain in the shutdown state."
    down_time::Float64
    "Pre-existing capacity for a technology"
    initial_capacity::Float64
    "Fuel type according to IEA"
    fuel::Union{ThermalFuels, Dict{ThermalFuels, ThermalFuels}}
    "Maximum blending level of each fuel during normal generation process for multi-fuel generator"
    cofire_level_max::Union{Nothing, Dict{ThermalFuels, Float64}}
    "Startup fuel use per MW of nameplate capacity of each generator (MMBtu/MW per start)"
    start_fuel::Float64
    "Heat rate of generator, MMBTU/MWh"
    heat_rate::Union{PSY.ValueCurve, Dict{ThermalFuels, PSY.ValueCurve}}
    "Minimum generation as a fraction of total capacity"
    minimum_generation::Float64
    "Option for providing additional data"
    ext::Dict
    "Set of balancing nodes"
    balancing_topology::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Region/zone technology operates in"
    region::String
    "Fixed O&M costs for a technology"
    operations_cost::PSY.OperationalCost
    "Maximum allowable installed capacity for a technology"
    maximum_capacity::Float64
    "Number of the cluster when representing multiple clusters of a given technology in a given region."
    cluster::Int64
    "Duration of the maintenance period, in number of timesteps."
    maintenance_duration::Int64
    "Cost per MW of nameplate capacity to start a generator (/MW per start)."
    start_cost::Float64
    "Length of scheduled maintenance cycle, in years."
    maintenance_cycle_length_years::Int64
    "Minimum amount of time a resource has to stay in the committed state."
    up_time::Float64
    "Maximum increase in output between operation periods. Fraction of total capacity"
    ramp_up::Float64
    "Cadence of timesteps in which scheduled maintenance can begin."
    maintenance_begin_cadence::Int64
end


function SupplyTechnology{T}(; base_power, outage_factor=1.0, prime_mover_type=PrimeMovers.OT, capital_cost=0.0, cofire_level_min, minimum_required_capacity=0.0, cofire_start_max, gen_ID, cofire_start_min, available=True, name, ramp_down=100.0, down_time=0.0, initial_capacity, fuel=ThermalFuels.OTHER, cofire_level_max, start_fuel=0.0, heat_rate=1.0, minimum_generation=0.0, ext=Dict(), balancing_topology, internal=InfrastructureSystemsInternal(), region, operations_cost, maximum_capacity=Inf, cluster=1, maintenance_duration=0, start_cost=0.0, maintenance_cycle_length_years=0, up_time=0.0, ramp_up=100.0, maintenance_begin_cadence=1, ) where T <: PSY.Generator
    SupplyTechnology{T}(base_power, outage_factor, prime_mover_type, capital_cost, cofire_level_min, minimum_required_capacity, cofire_start_max, gen_ID, cofire_start_min, available, name, ramp_down, down_time, initial_capacity, fuel, cofire_level_max, start_fuel, heat_rate, minimum_generation, ext, balancing_topology, internal, region, operations_cost, maximum_capacity, cluster, maintenance_duration, start_cost, maintenance_cycle_length_years, up_time, ramp_up, maintenance_begin_cadence, )
end

"""Get [`SupplyTechnology`](@ref) `base_power`."""
get_base_power(value::SupplyTechnology) = value.base_power
"""Get [`SupplyTechnology`](@ref) `outage_factor`."""
get_outage_factor(value::SupplyTechnology) = value.outage_factor
"""Get [`SupplyTechnology`](@ref) `prime_mover_type`."""
get_prime_mover_type(value::SupplyTechnology) = value.prime_mover_type
"""Get [`SupplyTechnology`](@ref) `capital_cost`."""
get_capital_cost(value::SupplyTechnology) = value.capital_cost
"""Get [`SupplyTechnology`](@ref) `cofire_level_min`."""
get_cofire_level_min(value::SupplyTechnology) = value.cofire_level_min
"""Get [`SupplyTechnology`](@ref) `minimum_required_capacity`."""
get_minimum_required_capacity(value::SupplyTechnology) = value.minimum_required_capacity
"""Get [`SupplyTechnology`](@ref) `cofire_start_max`."""
get_cofire_start_max(value::SupplyTechnology) = value.cofire_start_max
"""Get [`SupplyTechnology`](@ref) `gen_ID`."""
get_gen_ID(value::SupplyTechnology) = value.gen_ID
"""Get [`SupplyTechnology`](@ref) `cofire_start_min`."""
get_cofire_start_min(value::SupplyTechnology) = value.cofire_start_min
"""Get [`SupplyTechnology`](@ref) `available`."""
get_available(value::SupplyTechnology) = value.available
"""Get [`SupplyTechnology`](@ref) `name`."""
get_name(value::SupplyTechnology) = value.name
"""Get [`SupplyTechnology`](@ref) `ramp_down`."""
get_ramp_down(value::SupplyTechnology) = value.ramp_down
"""Get [`SupplyTechnology`](@ref) `down_time`."""
get_down_time(value::SupplyTechnology) = value.down_time
"""Get [`SupplyTechnology`](@ref) `initial_capacity`."""
get_initial_capacity(value::SupplyTechnology) = value.initial_capacity
"""Get [`SupplyTechnology`](@ref) `fuel`."""
get_fuel(value::SupplyTechnology) = value.fuel
"""Get [`SupplyTechnology`](@ref) `cofire_level_max`."""
get_cofire_level_max(value::SupplyTechnology) = value.cofire_level_max
"""Get [`SupplyTechnology`](@ref) `start_fuel`."""
get_start_fuel(value::SupplyTechnology) = value.start_fuel
"""Get [`SupplyTechnology`](@ref) `heat_rate`."""
get_heat_rate(value::SupplyTechnology) = value.heat_rate
"""Get [`SupplyTechnology`](@ref) `minimum_generation`."""
get_minimum_generation(value::SupplyTechnology) = value.minimum_generation
"""Get [`SupplyTechnology`](@ref) `ext`."""
get_ext(value::SupplyTechnology) = value.ext
"""Get [`SupplyTechnology`](@ref) `balancing_topology`."""
get_balancing_topology(value::SupplyTechnology) = value.balancing_topology
"""Get [`SupplyTechnology`](@ref) `internal`."""
get_internal(value::SupplyTechnology) = value.internal
"""Get [`SupplyTechnology`](@ref) `region`."""
get_region(value::SupplyTechnology) = value.region
"""Get [`SupplyTechnology`](@ref) `operations_cost`."""
get_operations_cost(value::SupplyTechnology) = value.operations_cost
"""Get [`SupplyTechnology`](@ref) `maximum_capacity`."""
get_maximum_capacity(value::SupplyTechnology) = value.maximum_capacity
"""Get [`SupplyTechnology`](@ref) `cluster`."""
get_cluster(value::SupplyTechnology) = value.cluster
"""Get [`SupplyTechnology`](@ref) `maintenance_duration`."""
get_maintenance_duration(value::SupplyTechnology) = value.maintenance_duration
"""Get [`SupplyTechnology`](@ref) `start_cost`."""
get_start_cost(value::SupplyTechnology) = value.start_cost
"""Get [`SupplyTechnology`](@ref) `maintenance_cycle_length_years`."""
get_maintenance_cycle_length_years(value::SupplyTechnology) = value.maintenance_cycle_length_years
"""Get [`SupplyTechnology`](@ref) `up_time`."""
get_up_time(value::SupplyTechnology) = value.up_time
"""Get [`SupplyTechnology`](@ref) `ramp_up`."""
get_ramp_up(value::SupplyTechnology) = value.ramp_up
"""Get [`SupplyTechnology`](@ref) `maintenance_begin_cadence`."""
get_maintenance_begin_cadence(value::SupplyTechnology) = value.maintenance_begin_cadence

"""Set [`SupplyTechnology`](@ref) `base_power`."""
set_base_power!(value::SupplyTechnology, val) = value.base_power = val
"""Set [`SupplyTechnology`](@ref) `outage_factor`."""
set_outage_factor!(value::SupplyTechnology, val) = value.outage_factor = val
"""Set [`SupplyTechnology`](@ref) `prime_mover_type`."""
set_prime_mover_type!(value::SupplyTechnology, val) = value.prime_mover_type = val
"""Set [`SupplyTechnology`](@ref) `capital_cost`."""
set_capital_cost!(value::SupplyTechnology, val) = value.capital_cost = val
"""Set [`SupplyTechnology`](@ref) `cofire_level_min`."""
set_cofire_level_min!(value::SupplyTechnology, val) = value.cofire_level_min = val
"""Set [`SupplyTechnology`](@ref) `minimum_required_capacity`."""
set_minimum_required_capacity!(value::SupplyTechnology, val) = value.minimum_required_capacity = val
"""Set [`SupplyTechnology`](@ref) `cofire_start_max`."""
set_cofire_start_max!(value::SupplyTechnology, val) = value.cofire_start_max = val
"""Set [`SupplyTechnology`](@ref) `gen_ID`."""
set_gen_ID!(value::SupplyTechnology, val) = value.gen_ID = val
"""Set [`SupplyTechnology`](@ref) `cofire_start_min`."""
set_cofire_start_min!(value::SupplyTechnology, val) = value.cofire_start_min = val
"""Set [`SupplyTechnology`](@ref) `available`."""
set_available!(value::SupplyTechnology, val) = value.available = val
"""Set [`SupplyTechnology`](@ref) `name`."""
set_name!(value::SupplyTechnology, val) = value.name = val
"""Set [`SupplyTechnology`](@ref) `ramp_down`."""
set_ramp_down!(value::SupplyTechnology, val) = value.ramp_down = val
"""Set [`SupplyTechnology`](@ref) `down_time`."""
set_down_time!(value::SupplyTechnology, val) = value.down_time = val
"""Set [`SupplyTechnology`](@ref) `initial_capacity`."""
set_initial_capacity!(value::SupplyTechnology, val) = value.initial_capacity = val
"""Set [`SupplyTechnology`](@ref) `fuel`."""
set_fuel!(value::SupplyTechnology, val) = value.fuel = val
"""Set [`SupplyTechnology`](@ref) `cofire_level_max`."""
set_cofire_level_max!(value::SupplyTechnology, val) = value.cofire_level_max = val
"""Set [`SupplyTechnology`](@ref) `start_fuel`."""
set_start_fuel!(value::SupplyTechnology, val) = value.start_fuel = val
"""Set [`SupplyTechnology`](@ref) `heat_rate`."""
set_heat_rate!(value::SupplyTechnology, val) = value.heat_rate = val
"""Set [`SupplyTechnology`](@ref) `minimum_generation`."""
set_minimum_generation!(value::SupplyTechnology, val) = value.minimum_generation = val
"""Set [`SupplyTechnology`](@ref) `ext`."""
set_ext!(value::SupplyTechnology, val) = value.ext = val
"""Set [`SupplyTechnology`](@ref) `balancing_topology`."""
set_balancing_topology!(value::SupplyTechnology, val) = value.balancing_topology = val
"""Set [`SupplyTechnology`](@ref) `internal`."""
set_internal!(value::SupplyTechnology, val) = value.internal = val
"""Set [`SupplyTechnology`](@ref) `region`."""
set_region!(value::SupplyTechnology, val) = value.region = val
"""Set [`SupplyTechnology`](@ref) `operations_cost`."""
set_operations_cost!(value::SupplyTechnology, val) = value.operations_cost = val
"""Set [`SupplyTechnology`](@ref) `maximum_capacity`."""
set_maximum_capacity!(value::SupplyTechnology, val) = value.maximum_capacity = val
"""Set [`SupplyTechnology`](@ref) `cluster`."""
set_cluster!(value::SupplyTechnology, val) = value.cluster = val
"""Set [`SupplyTechnology`](@ref) `maintenance_duration`."""
set_maintenance_duration!(value::SupplyTechnology, val) = value.maintenance_duration = val
"""Set [`SupplyTechnology`](@ref) `start_cost`."""
set_start_cost!(value::SupplyTechnology, val) = value.start_cost = val
"""Set [`SupplyTechnology`](@ref) `maintenance_cycle_length_years`."""
set_maintenance_cycle_length_years!(value::SupplyTechnology, val) = value.maintenance_cycle_length_years = val
"""Set [`SupplyTechnology`](@ref) `up_time`."""
set_up_time!(value::SupplyTechnology, val) = value.up_time = val
"""Set [`SupplyTechnology`](@ref) `ramp_up`."""
set_ramp_up!(value::SupplyTechnology, val) = value.ramp_up = val
"""Set [`SupplyTechnology`](@ref) `maintenance_begin_cadence`."""
set_maintenance_begin_cadence!(value::SupplyTechnology, val) = value.maintenance_begin_cadence = val
