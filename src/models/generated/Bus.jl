#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct Bus <: Region
        name::String
        internal::InfrastructureSystemsInternal
        id::Int64
        ext::Dict
    end



# Arguments
- `name::String`: Name of bus
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `id::Int64`: A unique zone identification number (positive integer)
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
"""
mutable struct Bus <: Region
    "Name of bus"
    name::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "A unique zone identification number (positive integer)"
    id::Int64
    "Option for providing additional data"
    ext::Dict
end


function Bus(; name, internal=InfrastructureSystemsInternal(), id, ext=Dict(), )
    Bus(name, internal, id, ext, )
end

"""Get [`Bus`](@ref) `name`."""
get_name(value::Bus) = value.name
"""Get [`Bus`](@ref) `internal`."""
get_internal(value::Bus) = value.internal
"""Get [`Bus`](@ref) `id`."""
get_id(value::Bus) = value.id
"""Get [`Bus`](@ref) `ext`."""
get_ext(value::Bus) = value.ext

"""Set [`Bus`](@ref) `name`."""
set_name!(value::Bus, val) = value.name = val
"""Set [`Bus`](@ref) `internal`."""
set_internal!(value::Bus, val) = value.internal = val
"""Set [`Bus`](@ref) `id`."""
set_id!(value::Bus, val) = value.id = val
"""Set [`Bus`](@ref) `ext`."""
set_ext!(value::Bus, val) = value.ext = val
