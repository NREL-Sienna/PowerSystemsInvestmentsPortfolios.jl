#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct TransportTechnology{T <: PSY.Device} <: IS.InfrastructureSystemsComponent
        name::String
        power_systems_type::String
        ext::Dict
        available::Bool
    end



# Arguments
- `name::String`: The technology name
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `available::Bool`: identifies whether the technology is available
"""
mutable struct TransportTechnology{T <: PSY.Device} <: IS.InfrastructureSystemsComponent
    "The technology name"
    name::String
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Option for providing additional data"
    ext::Dict
    "identifies whether the technology is available"
    available::Bool
end


function TransportTechnology{T}(; name, power_systems_type, ext=Dict(), available, ) where T <: PSY.Device
    TransportTechnology{T}(name, power_systems_type, ext, available, )
end

"""Get [`TransportTechnology`](@ref) `name`."""
get_name(value::TransportTechnology) = value.name
"""Get [`TransportTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::TransportTechnology) = value.power_systems_type
"""Get [`TransportTechnology`](@ref) `ext`."""
get_ext(value::TransportTechnology) = value.ext
"""Get [`TransportTechnology`](@ref) `available`."""
get_available(value::TransportTechnology) = value.available

"""Set [`TransportTechnology`](@ref) `name`."""
set_name!(value::TransportTechnology, val) = value.name = val
"""Set [`TransportTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::TransportTechnology, val) = value.power_systems_type = val
"""Set [`TransportTechnology`](@ref) `ext`."""
set_ext!(value::TransportTechnology, val) = value.ext = val
"""Set [`TransportTechnology`](@ref) `available`."""
set_available!(value::TransportTechnology, val) = value.available = val
