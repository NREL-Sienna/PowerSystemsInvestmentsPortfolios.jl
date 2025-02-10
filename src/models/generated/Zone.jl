#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct Zone <: Region
        name::String
        internal::InfrastructureSystemsInternal
        id::Int64
        ext::Dict
    end



# Arguments
- `name::String`: Name of region
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `id::Int64`: A unique zone identification number (positive integer)
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
"""
mutable struct Zone <: Region
    "Name of region"
    name::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "A unique zone identification number (positive integer)"
    id::Int64
    "Option for providing additional data"
    ext::Dict
end


function Zone(; name, internal=InfrastructureSystemsInternal(), id, ext=Dict(), )
    Zone(name, internal, id, ext, )
end

"""Get [`Zone`](@ref) `name`."""
get_name(value::Zone) = value.name
"""Get [`Zone`](@ref) `internal`."""
get_internal(value::Zone) = value.internal
"""Get [`Zone`](@ref) `id`."""
get_id(value::Zone) = value.id
"""Get [`Zone`](@ref) `ext`."""
get_ext(value::Zone) = value.ext

"""Set [`Zone`](@ref) `name`."""
set_name!(value::Zone, val) = value.name = val
"""Set [`Zone`](@ref) `internal`."""
set_internal!(value::Zone, val) = value.internal = val
"""Set [`Zone`](@ref) `id`."""
set_id!(value::Zone, val) = value.id = val
"""Set [`Zone`](@ref) `ext`."""
set_ext!(value::Zone, val) = value.ext = val

serialize(val::Zone) = serialize_struct(val)
IS.deserialize(T::Type{<:Zone}, val::Dict) = IS.deserialize_struct(T, val)
function serialize_openapi_struct(technology::Zone, vals...)
    base_struct = APIServer.Zone(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:Zone}, vals...)
    base_struct = APIServer.Zone(; vals...)
    return base_struct
end
