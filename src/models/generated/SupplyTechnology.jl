#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct SupplyTechnology{T <: PSY.Generator} <: Technology
        base_power::Float64
        prime_mover_type::PrimeMovers
        capital_cost::IS.FunctionData
        minimum_required_capacity::Float64
        gen_ID::String
        available::Bool
        name::String
        initial_capacity::Float64
        fuel::ThermalFuels
        power_systems_type::String
        variable_cost::IS.FunctionData
        ext::Dict
        balancing_topology::String
        operations_cost::IS.FunctionData
        maximum_capacity::Float64
        capacity_factor::Float64
    end



# Arguments
- `base_power::Float64`: Base power
- `prime_mover_type::PrimeMovers`: (default: `OT`) Prime mover for generator
- `capital_cost::IS.FunctionData`: Capital costs for investing in a technology.
- `minimum_required_capacity::Float64`: Minimum required capacity for a technology
- `gen_ID::String`: ID for individual generator
- `available::Bool`: identifies whether the technology is available
- `name::String`: The technology name
- `initial_capacity::Float64`: Pre-existing capacity for a technology
- `fuel::ThermalFuels`: (default: `OTHER`) Fuel type according to IEA
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `variable_cost::IS.FunctionData`: Variable O&M costs for a technology
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `balancing_topology::String`: Set of balancing nodes
- `operations_cost::IS.FunctionData`: Fixed O&M costs for a technology
- `maximum_capacity::Float64`: Maximum allowable installed capacity for a technology
- `capacity_factor::Float64`: Derating factor to account for planned or forced outages of a technology
"""
mutable struct SupplyTechnology{T <: PSY.Generator} <: Technology
    "Base power"
    base_power::Float64
    "Prime mover for generator"
    prime_mover_type::PrimeMovers
    "Capital costs for investing in a technology."
    capital_cost::IS.FunctionData
    "Minimum required capacity for a technology"
    minimum_required_capacity::Float64
    "ID for individual generator"
    gen_ID::String
    "identifies whether the technology is available"
    available::Bool
    "The technology name"
    name::String
    "Pre-existing capacity for a technology"
    initial_capacity::Float64
    "Fuel type according to IEA"
    fuel::ThermalFuels
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Variable O&M costs for a technology"
    variable_cost::IS.FunctionData
    "Option for providing additional data"
    ext::Dict
    "Set of balancing nodes"
    balancing_topology::String
    "Fixed O&M costs for a technology"
    operations_cost::IS.FunctionData
    "Maximum allowable installed capacity for a technology"
    maximum_capacity::Float64
    "Derating factor to account for planned or forced outages of a technology"
    capacity_factor::Float64
end


function SupplyTechnology{T}(; base_power, prime_mover_type=OT, capital_cost, minimum_required_capacity, gen_ID, available, name, initial_capacity, fuel=OTHER, power_systems_type, variable_cost, ext=Dict(), balancing_topology, operations_cost, maximum_capacity, capacity_factor, ) where T <: PSY.Generator
    SupplyTechnology{T}(base_power, prime_mover_type, capital_cost, minimum_required_capacity, gen_ID, available, name, initial_capacity, fuel, power_systems_type, variable_cost, ext, balancing_topology, operations_cost, maximum_capacity, capacity_factor, )
end

"""Get [`SupplyTechnology`](@ref) `base_power`."""
get_base_power(value::SupplyTechnology) = value.base_power
"""Get [`SupplyTechnology`](@ref) `prime_mover_type`."""
get_prime_mover_type(value::SupplyTechnology) = value.prime_mover_type
"""Get [`SupplyTechnology`](@ref) `capital_cost`."""
get_capital_cost(value::SupplyTechnology) = value.capital_cost
"""Get [`SupplyTechnology`](@ref) `minimum_required_capacity`."""
get_minimum_required_capacity(value::SupplyTechnology) = value.minimum_required_capacity
"""Get [`SupplyTechnology`](@ref) `gen_ID`."""
get_gen_ID(value::SupplyTechnology) = value.gen_ID
"""Get [`SupplyTechnology`](@ref) `available`."""
get_available(value::SupplyTechnology) = value.available
"""Get [`SupplyTechnology`](@ref) `name`."""
get_name(value::SupplyTechnology) = value.name
"""Get [`SupplyTechnology`](@ref) `initial_capacity`."""
get_initial_capacity(value::SupplyTechnology) = value.initial_capacity
"""Get [`SupplyTechnology`](@ref) `fuel`."""
get_fuel(value::SupplyTechnology) = value.fuel
"""Get [`SupplyTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::SupplyTechnology) = value.power_systems_type
"""Get [`SupplyTechnology`](@ref) `variable_cost`."""
get_variable_cost(value::SupplyTechnology) = value.variable_cost
"""Get [`SupplyTechnology`](@ref) `ext`."""
get_ext(value::SupplyTechnology) = value.ext
"""Get [`SupplyTechnology`](@ref) `balancing_topology`."""
get_balancing_topology(value::SupplyTechnology) = value.balancing_topology
"""Get [`SupplyTechnology`](@ref) `operations_cost`."""
get_operations_cost(value::SupplyTechnology) = value.operations_cost
"""Get [`SupplyTechnology`](@ref) `maximum_capacity`."""
get_maximum_capacity(value::SupplyTechnology) = value.maximum_capacity
"""Get [`SupplyTechnology`](@ref) `capacity_factor`."""
get_capacity_factor(value::SupplyTechnology) = value.capacity_factor

"""Set [`SupplyTechnology`](@ref) `base_power`."""
set_base_power!(value::SupplyTechnology, val) = value.base_power = val
"""Set [`SupplyTechnology`](@ref) `prime_mover_type`."""
set_prime_mover_type!(value::SupplyTechnology, val) = value.prime_mover_type = val
"""Set [`SupplyTechnology`](@ref) `capital_cost`."""
set_capital_cost!(value::SupplyTechnology, val) = value.capital_cost = val
"""Set [`SupplyTechnology`](@ref) `minimum_required_capacity`."""
set_minimum_required_capacity!(value::SupplyTechnology, val) = value.minimum_required_capacity = val
"""Set [`SupplyTechnology`](@ref) `gen_ID`."""
set_gen_ID!(value::SupplyTechnology, val) = value.gen_ID = val
"""Set [`SupplyTechnology`](@ref) `available`."""
set_available!(value::SupplyTechnology, val) = value.available = val
"""Set [`SupplyTechnology`](@ref) `name`."""
set_name!(value::SupplyTechnology, val) = value.name = val
"""Set [`SupplyTechnology`](@ref) `initial_capacity`."""
set_initial_capacity!(value::SupplyTechnology, val) = value.initial_capacity = val
"""Set [`SupplyTechnology`](@ref) `fuel`."""
set_fuel!(value::SupplyTechnology, val) = value.fuel = val
"""Set [`SupplyTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::SupplyTechnology, val) = value.power_systems_type = val
"""Set [`SupplyTechnology`](@ref) `variable_cost`."""
set_variable_cost!(value::SupplyTechnology, val) = value.variable_cost = val
"""Set [`SupplyTechnology`](@ref) `ext`."""
set_ext!(value::SupplyTechnology, val) = value.ext = val
"""Set [`SupplyTechnology`](@ref) `balancing_topology`."""
set_balancing_topology!(value::SupplyTechnology, val) = value.balancing_topology = val
"""Set [`SupplyTechnology`](@ref) `operations_cost`."""
set_operations_cost!(value::SupplyTechnology, val) = value.operations_cost = val
"""Set [`SupplyTechnology`](@ref) `maximum_capacity`."""
set_maximum_capacity!(value::SupplyTechnology, val) = value.maximum_capacity = val
"""Set [`SupplyTechnology`](@ref) `capacity_factor`."""
set_capacity_factor!(value::SupplyTechnology, val) = value.capacity_factor = val
