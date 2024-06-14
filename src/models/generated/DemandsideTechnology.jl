#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandsideTechnology{T <: PSY.StaticInjection} <: IS.InfrastructureSystemsComponent
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
mutable struct DemandsideTechnology{T <: PSY.StaticInjection} <: IS.InfrastructureSystemsComponent
    "The technology name"
    name::String
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Option for providing additional data"
    ext::Dict
    "identifies whether the technology is available"
    available::Bool
end


function DemandsideTechnology{T}(; name, power_systems_type, ext=Dict(), available, ) where T <: PSY.StaticInjection
    DemandsideTechnology{T}(name, power_systems_type, ext, available, )
end

"""Get [`DemandsideTechnology`](@ref) `name`."""
get_name(value::DemandsideTechnology) = value.name
"""Get [`DemandsideTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::DemandsideTechnology) = value.power_systems_type
"""Get [`DemandsideTechnology`](@ref) `ext`."""
get_ext(value::DemandsideTechnology) = value.ext
"""Get [`DemandsideTechnology`](@ref) `available`."""
get_available(value::DemandsideTechnology) = value.available

"""Set [`DemandsideTechnology`](@ref) `name`."""
set_name!(value::DemandsideTechnology, val) = value.name = val
"""Set [`DemandsideTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::DemandsideTechnology, val) = value.power_systems_type = val
"""Set [`DemandsideTechnology`](@ref) `ext`."""
set_ext!(value::DemandsideTechnology, val) = value.ext = val
"""Set [`DemandsideTechnology`](@ref) `available`."""
set_available!(value::DemandsideTechnology, val) = value.available = val
