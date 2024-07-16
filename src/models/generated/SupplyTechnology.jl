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
        initial_capacity::Float64
        fuel::Union{ThermalFuels, Dict{ThermalFuels, ThermalFuels}}
        power_systems_type::String
        cofire_level_max::Union{Nothing, Dict{ThermalFuels, Float64}}
        internal::InfrastructureSystemsInternal
        heat_rate::Union{PSY.ValueCurve, Dict{ThermalFuels, PSY.ValueCurve}}
        minimum_generation::Float64
        ext::Dict
        balancing_topology::String
        region::String
        operations_cost::PSY.OperationalCost
        maximum_capacity::Float64
        ramp_up::Float64
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
- `available::Bool`: identifies whether the technology is available
- `name::String`: The technology name
- `ramp_down::Float64`: (default: `1.0`) Maximum decrease in output between operation periods. Fraction of total capacity
- `initial_capacity::Float64`: Pre-existing capacity for a technology
- `fuel::Union{ThermalFuels, Dict{ThermalFuels, ThermalFuels}}`: (default: `ThermalFuels.OTHER`) Fuel type according to IEA
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `cofire_level_max::Union{Nothing, Dict{ThermalFuels, Float64}}`: Maximum blending level of each fuel during normal generation process for multi-fuel generator
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `heat_rate::Union{PSY.ValueCurve, Dict{ThermalFuels, PSY.ValueCurve}}`: (default: `1.0`) Heat rate of generator, MMBTU/MWh
- `minimum_generation::Float64`: (default: `0.0`) Minimum generation as a fraction of total capacity
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `balancing_topology::String`: Set of balancing nodes
- `region::String`: (default: `1.0`) Region/zone technology operates in
- `operations_cost::PSY.OperationalCost`: Fixed O&M costs for a technology
- `maximum_capacity::Float64`: (default: `Inf`) Maximum allowable installed capacity for a technology
- `ramp_up::Float64`: (default: `1.0`) Maximum increase in output between operation periods. Fraction of total capacity
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
    "Pre-existing capacity for a technology"
    initial_capacity::Float64
    "Fuel type according to IEA"
    fuel::Union{ThermalFuels, Dict{ThermalFuels, ThermalFuels}}
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Maximum blending level of each fuel during normal generation process for multi-fuel generator"
    cofire_level_max::Union{Nothing, Dict{ThermalFuels, Float64}}
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Heat rate of generator, MMBTU/MWh"
    heat_rate::Union{PSY.ValueCurve, Dict{ThermalFuels, PSY.ValueCurve}}
    "Minimum generation as a fraction of total capacity"
    minimum_generation::Float64
    "Option for providing additional data"
    ext::Dict
    "Set of balancing nodes"
    balancing_topology::String
    "Region/zone technology operates in"
    region::String
    "Fixed O&M costs for a technology"
    operations_cost::PSY.OperationalCost
    "Maximum allowable installed capacity for a technology"
    maximum_capacity::Float64
    "Maximum increase in output between operation periods. Fraction of total capacity"
    ramp_up::Float64
end


function SupplyTechnology{T}(; base_power, outage_factor=1.0, prime_mover_type=PrimeMovers.OT, capital_cost=0.0, cofire_level_min, minimum_required_capacity=0.0, cofire_start_max, gen_ID, cofire_start_min, available, name, ramp_down=1.0, initial_capacity, fuel=ThermalFuels.OTHER, power_systems_type, cofire_level_max, internal=InfrastructureSystemsInternal(), heat_rate=1.0, minimum_generation=0.0, ext=Dict(), balancing_topology, region=1.0, operations_cost, maximum_capacity=Inf, ramp_up=1.0, ) where T <: PSY.Generator
    SupplyTechnology{T}(base_power, outage_factor, prime_mover_type, capital_cost, cofire_level_min, minimum_required_capacity, cofire_start_max, gen_ID, cofire_start_min, available, name, ramp_down, initial_capacity, fuel, power_systems_type, cofire_level_max, internal, heat_rate, minimum_generation, ext, balancing_topology, region, operations_cost, maximum_capacity, ramp_up, )
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
"""Get [`SupplyTechnology`](@ref) `initial_capacity`."""
get_initial_capacity(value::SupplyTechnology) = value.initial_capacity
"""Get [`SupplyTechnology`](@ref) `fuel`."""
get_fuel(value::SupplyTechnology) = value.fuel
"""Get [`SupplyTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::SupplyTechnology) = value.power_systems_type
"""Get [`SupplyTechnology`](@ref) `cofire_level_max`."""
get_cofire_level_max(value::SupplyTechnology) = value.cofire_level_max
"""Get [`SupplyTechnology`](@ref) `internal`."""
get_internal(value::SupplyTechnology) = value.internal
"""Get [`SupplyTechnology`](@ref) `heat_rate`."""
get_heat_rate(value::SupplyTechnology) = value.heat_rate
"""Get [`SupplyTechnology`](@ref) `minimum_generation`."""
get_minimum_generation(value::SupplyTechnology) = value.minimum_generation
"""Get [`SupplyTechnology`](@ref) `ext`."""
get_ext(value::SupplyTechnology) = value.ext
"""Get [`SupplyTechnology`](@ref) `balancing_topology`."""
get_balancing_topology(value::SupplyTechnology) = value.balancing_topology
"""Get [`SupplyTechnology`](@ref) `region`."""
get_region(value::SupplyTechnology) = value.region
"""Get [`SupplyTechnology`](@ref) `operations_cost`."""
get_operations_cost(value::SupplyTechnology) = value.operations_cost
"""Get [`SupplyTechnology`](@ref) `maximum_capacity`."""
get_maximum_capacity(value::SupplyTechnology) = value.maximum_capacity
"""Get [`SupplyTechnology`](@ref) `ramp_up`."""
get_ramp_up(value::SupplyTechnology) = value.ramp_up

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
"""Set [`SupplyTechnology`](@ref) `initial_capacity`."""
set_initial_capacity!(value::SupplyTechnology, val) = value.initial_capacity = val
"""Set [`SupplyTechnology`](@ref) `fuel`."""
set_fuel!(value::SupplyTechnology, val) = value.fuel = val
"""Set [`SupplyTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::SupplyTechnology, val) = value.power_systems_type = val
"""Set [`SupplyTechnology`](@ref) `cofire_level_max`."""
set_cofire_level_max!(value::SupplyTechnology, val) = value.cofire_level_max = val
"""Set [`SupplyTechnology`](@ref) `internal`."""
set_internal!(value::SupplyTechnology, val) = value.internal = val
"""Set [`SupplyTechnology`](@ref) `heat_rate`."""
set_heat_rate!(value::SupplyTechnology, val) = value.heat_rate = val
"""Set [`SupplyTechnology`](@ref) `minimum_generation`."""
set_minimum_generation!(value::SupplyTechnology, val) = value.minimum_generation = val
"""Set [`SupplyTechnology`](@ref) `ext`."""
set_ext!(value::SupplyTechnology, val) = value.ext = val
"""Set [`SupplyTechnology`](@ref) `balancing_topology`."""
set_balancing_topology!(value::SupplyTechnology, val) = value.balancing_topology = val
"""Set [`SupplyTechnology`](@ref) `region`."""
set_region!(value::SupplyTechnology, val) = value.region = val
"""Set [`SupplyTechnology`](@ref) `operations_cost`."""
set_operations_cost!(value::SupplyTechnology, val) = value.operations_cost = val
"""Set [`SupplyTechnology`](@ref) `maximum_capacity`."""
set_maximum_capacity!(value::SupplyTechnology, val) = value.maximum_capacity = val
"""Set [`SupplyTechnology`](@ref) `ramp_up`."""
set_ramp_up!(value::SupplyTechnology, val) = value.ramp_up = val
