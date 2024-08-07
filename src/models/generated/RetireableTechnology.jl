#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct RetireableTechnology{T <: PSY.Generator} <: Technology
        name::String
        can_retire::Dict{PrimeMovers,Dict{String, Int64}}
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        ext::Dict
    end



# Arguments
- `name::String`: The technology name
- `can_retire::Dict{PrimeMovers,Dict{String, Int64}}`: (default: `Dict()`) Dictionary of PrimeMovers in each region that can retire
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
"""
mutable struct RetireableTechnology{T <: PSY.Generator} <: Technology
    "The technology name"
    name::String
    "Dictionary of PrimeMovers in each region that can retire"
    can_retire::Dict{PrimeMovers,Dict{String, Int64}}
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
end


function RetireableTechnology{T}(; name, can_retire=Dict(), power_systems_type, internal=InfrastructureSystemsInternal(), ext=Dict(), ) where T <: PSY.Generator
    RetireableTechnology{T}(name, can_retire, power_systems_type, internal, ext, )
end

"""Get [`RetireableTechnology`](@ref) `name`."""
get_name(value::RetireableTechnology) = value.name
"""Get [`RetireableTechnology`](@ref) `can_retire`."""
get_can_retire(value::RetireableTechnology) = value.can_retire
"""Get [`RetireableTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::RetireableTechnology) = value.power_systems_type
"""Get [`RetireableTechnology`](@ref) `internal`."""
get_internal(value::RetireableTechnology) = value.internal
"""Get [`RetireableTechnology`](@ref) `ext`."""
get_ext(value::RetireableTechnology) = value.ext

"""Set [`RetireableTechnology`](@ref) `name`."""
set_name!(value::RetireableTechnology, val) = value.name = val
"""Set [`RetireableTechnology`](@ref) `can_retire`."""
set_can_retire!(value::RetireableTechnology, val) = value.can_retire = val
"""Set [`RetireableTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::RetireableTechnology, val) = value.power_systems_type = val
"""Set [`RetireableTechnology`](@ref) `internal`."""
set_internal!(value::RetireableTechnology, val) = value.internal = val
"""Set [`RetireableTechnology`](@ref) `ext`."""
set_ext!(value::RetireableTechnology, val) = value.ext = val
