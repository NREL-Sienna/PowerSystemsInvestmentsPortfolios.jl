#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct Bus <: Region
        name::String
        angle_limit::Float64
        internal::InfrastructureSystemsInternal
        id::Int64
        ext::Dict
        bustype::Union{Nothing, PSY.ACBusTypes}
    end



# Arguments
- `name::String`: Name of bus
- `angle_limit::Float64`: (default: `0.0`) Votlage angle limit (radians)
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `id::Int64`: A unique zone identification number (positive integer)
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `bustype::Union{Nothing, PSY.ACBusTypes}`: (default: `nothing`) Used to describe the connectivity and behavior of this bus.
"""
mutable struct Bus <: Region
    "Name of bus"
    name::String
    "Votlage angle limit (radians)"
    angle_limit::Float64
    "Internal field"
    internal::InfrastructureSystemsInternal
    "A unique zone identification number (positive integer)"
    id::Int64
    "Option for providing additional data"
    ext::Dict
    "Used to describe the connectivity and behavior of this bus."
    bustype::Union{Nothing, PSY.ACBusTypes}
end


function Bus(; name, angle_limit=0.0, internal=InfrastructureSystemsInternal(), id, ext=Dict(), bustype=nothing, )
    Bus(name, angle_limit, internal, id, ext, bustype, )
end

"""Get [`Bus`](@ref) `name`."""
get_name(value::Bus) = value.name
"""Get [`Bus`](@ref) `angle_limit`."""
get_angle_limit(value::Bus) = value.angle_limit
"""Get [`Bus`](@ref) `internal`."""
get_internal(value::Bus) = value.internal
"""Get [`Bus`](@ref) `id`."""
get_id(value::Bus) = value.id
"""Get [`Bus`](@ref) `ext`."""
get_ext(value::Bus) = value.ext
"""Get [`Bus`](@ref) `bustype`."""
get_bustype(value::Bus) = value.bustype

"""Set [`Bus`](@ref) `name`."""
set_name!(value::Bus, val) = value.name = val
"""Set [`Bus`](@ref) `angle_limit`."""
set_angle_limit!(value::Bus, val) = value.angle_limit = val
"""Set [`Bus`](@ref) `internal`."""
set_internal!(value::Bus, val) = value.internal = val
"""Set [`Bus`](@ref) `id`."""
set_id!(value::Bus, val) = value.id = val
"""Set [`Bus`](@ref) `ext`."""
set_ext!(value::Bus, val) = value.ext = val
"""Set [`Bus`](@ref) `bustype`."""
set_bustype!(value::Bus, val) = value.bustype = val
