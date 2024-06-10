#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandsideTechnology{T <: PSY.StaticInjection} <: InfrastructureSystemsComponent
        name::String
        power_systems_type::String
        demand::Float
        available::Boolean
    end



# Arguments
- `name::String`:
- `power_systems_type::String`:
- `demand::Float`:
- `available::Boolean`:
"""
mutable struct DemandsideTechnology{T <: PSY.StaticInjection} <: InfrastructureSystemsComponent
    name::String
    power_systems_type::String
    demand::Float
    available::Boolean
end


function DemandsideTechnology{T}(; name, power_systems_type, demand, available, ) where T <: PSY.StaticInjection
    DemandsideTechnology{T}(name, power_systems_type, demand, available, )
end

"""Get [`DemandsideTechnology`](@ref) `name`."""
get_name(value::DemandsideTechnology) = value.name
"""Get [`DemandsideTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::DemandsideTechnology) = value.power_systems_type
"""Get [`DemandsideTechnology`](@ref) `demand`."""
get_demand(value::DemandsideTechnology) = value.demand
"""Get [`DemandsideTechnology`](@ref) `available`."""
get_available(value::DemandsideTechnology) = value.available

"""Set [`DemandsideTechnology`](@ref) `name`."""
set_name!(value::DemandsideTechnology, val) = value.name = val
"""Set [`DemandsideTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::DemandsideTechnology, val) = value.power_systems_type = val
"""Set [`DemandsideTechnology`](@ref) `demand`."""
set_demand!(value::DemandsideTechnology, val) = value.demand = val
"""Set [`DemandsideTechnology`](@ref) `available`."""
set_available!(value::DemandsideTechnology, val) = value.available = val
