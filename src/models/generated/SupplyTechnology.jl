#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct SupplyTechnology{T <: PSY.Generator} <: InfrastructureSystemsComponent
        base_power::Float64
        capital_cost::Float64
        minimum_required_capacity::Float64
        prime_mover_type::String
        available::Bool
        gen_ID::String
        name::String
        initial_capacity::Float64
        fuel::String
        power_systems_type::String
        variable_cost::Float64
        balancing_topology::String
        operations_cost::Float64
        maximum_capacity::Float64
        capacity_factor::String
    end



# Arguments
- `base_power::Float64`: Base power
- `capital_cost::Float64`: Capital costs for investing in a technology.
- `minimum_required_capacity::Float64`: Minimum required capacity for a technology
- `prime_mover_type::String`: Prime mover for generator
- `available::Bool`: identifies whether the technology is available
- `gen_ID::String`: ID for individual generator
- `name::String`: The technology name
- `initial_capacity::Float64`: Pre-existing capacity for a technology
- `fuel::String`: Fuel type according to IEA
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `variable_cost::Float64`: Variable O&M costs for a technology
- `balancing_topology::String`: Set of balancing nodes
- `operations_cost::Float64`: Fixed O&M costs for a technology
- `maximum_capacity::Float64`: Maximum allowable installed capacity for a technology
- `capacity_factor::String`: Derating factor to account for planned or forced outages of a technology
"""
mutable struct SupplyTechnology{T <: PSY.Generator} <: InfrastructureSystemsComponent
    "Base power"
    base_power::Float64
    "Capital costs for investing in a technology."
    capital_cost::Float64
    "Minimum required capacity for a technology"
    minimum_required_capacity::Float64
    "Prime mover for generator"
    prime_mover_type::String
    "identifies whether the technology is available"
    available::Bool
    "ID for individual generator"
    gen_ID::String
    "The technology name"
    name::String
    "Pre-existing capacity for a technology"
    initial_capacity::Float64
    "Fuel type according to IEA"
    fuel::String
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Variable O&M costs for a technology"
    variable_cost::Float64
    "Set of balancing nodes"
    balancing_topology::String
    "Fixed O&M costs for a technology"
    operations_cost::Float64
    "Maximum allowable installed capacity for a technology"
    maximum_capacity::Float64
    "Derating factor to account for planned or forced outages of a technology"
    capacity_factor::String
end


function SupplyTechnology{T}(; base_power, capital_cost, minimum_required_capacity, prime_mover_type, available, gen_ID, name, initial_capacity, fuel, power_systems_type, variable_cost, balancing_topology, operations_cost, maximum_capacity, capacity_factor, ) where T <: PSY.Generator
    SupplyTechnology{T}(base_power, capital_cost, minimum_required_capacity, prime_mover_type, available, gen_ID, name, initial_capacity, fuel, power_systems_type, variable_cost, balancing_topology, operations_cost, maximum_capacity, capacity_factor, )
end

"""Get [`SupplyTechnology`](@ref) `base_power`."""
get_base_power(value::SupplyTechnology) = value.base_power
"""Get [`SupplyTechnology`](@ref) `capital_cost`."""
get_capital_cost(value::SupplyTechnology) = value.capital_cost
"""Get [`SupplyTechnology`](@ref) `minimum_required_capacity`."""
get_minimum_required_capacity(value::SupplyTechnology) = value.minimum_required_capacity
"""Get [`SupplyTechnology`](@ref) `prime_mover_type`."""
get_prime_mover_type(value::SupplyTechnology) = value.prime_mover_type
"""Get [`SupplyTechnology`](@ref) `available`."""
get_available(value::SupplyTechnology) = value.available
"""Get [`SupplyTechnology`](@ref) `gen_ID`."""
get_gen_ID(value::SupplyTechnology) = value.gen_ID
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
"""Set [`SupplyTechnology`](@ref) `capital_cost`."""
set_capital_cost!(value::SupplyTechnology, val) = value.capital_cost = val
"""Set [`SupplyTechnology`](@ref) `minimum_required_capacity`."""
set_minimum_required_capacity!(value::SupplyTechnology, val) = value.minimum_required_capacity = val
"""Set [`SupplyTechnology`](@ref) `prime_mover_type`."""
set_prime_mover_type!(value::SupplyTechnology, val) = value.prime_mover_type = val
"""Set [`SupplyTechnology`](@ref) `available`."""
set_available!(value::SupplyTechnology, val) = value.available = val
"""Set [`SupplyTechnology`](@ref) `gen_ID`."""
set_gen_ID!(value::SupplyTechnology, val) = value.gen_ID = val
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
"""Set [`SupplyTechnology`](@ref) `balancing_topology`."""
set_balancing_topology!(value::SupplyTechnology, val) = value.balancing_topology = val
"""Set [`SupplyTechnology`](@ref) `operations_cost`."""
set_operations_cost!(value::SupplyTechnology, val) = value.operations_cost = val
"""Set [`SupplyTechnology`](@ref) `maximum_capacity`."""
set_maximum_capacity!(value::SupplyTechnology, val) = value.maximum_capacity = val
"""Set [`SupplyTechnology`](@ref) `capacity_factor`."""
set_capacity_factor!(value::SupplyTechnology, val) = value.capacity_factor = val
