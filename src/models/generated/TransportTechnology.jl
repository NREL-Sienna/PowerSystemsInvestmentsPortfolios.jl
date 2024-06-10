#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct TransportTechnology{T <: PSY.Device} <: InfrastructureSystemsComponent
        name::String
        power_systems_type::String
        available::Boolean
    end



# Arguments
- `name::String`:
- `power_systems_type::String`:
- `available::Boolean`:
"""
mutable struct TransportTechnology{T <: PSY.Device} <: InfrastructureSystemsComponent
    name::String
    power_systems_type::String
    available::Boolean
end


function TransportTechnology{T}(; name, power_systems_type, available, ) where T <: PSY.Device
    TransportTechnology{T}(name, power_systems_type, available, )
end

"""Get [`TransportTechnology`](@ref) `name`."""
get_name(value::TransportTechnology) = value.name
"""Get [`TransportTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::TransportTechnology) = value.power_systems_type
"""Get [`TransportTechnology`](@ref) `available`."""
get_available(value::TransportTechnology) = value.available

"""Set [`TransportTechnology`](@ref) `name`."""
set_name!(value::TransportTechnology, val) = value.name = val
"""Set [`TransportTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::TransportTechnology, val) = value.power_systems_type = val
"""Set [`TransportTechnology`](@ref) `available`."""
set_available!(value::TransportTechnology, val) = value.available = val
