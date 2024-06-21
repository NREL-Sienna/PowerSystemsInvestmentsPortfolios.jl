#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct StorageTechnology{T <: PSY.Storage} <: Technology
        name::String
        storage_tech::StorageTech
        power_systems_type::String
        prime_mover_type::PrimeMovers
        ext::Dict
        available::Bool
    end



# Arguments
- `name::String`: The technology name
- `storage_tech::StorageTech`: Storage Technology Type
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `prime_mover_type::PrimeMovers`: Prime mover for storage
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `available::Bool`: identifies whether the technology is available
"""
mutable struct StorageTechnology{T <: PSY.Storage} <: Technology
    "The technology name"
    name::String
    "Storage Technology Type"
    storage_tech::StorageTech
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Prime mover for storage"
    prime_mover_type::PrimeMovers
    "Option for providing additional data"
    ext::Dict
    "identifies whether the technology is available"
    available::Bool
end


function StorageTechnology{T}(; name, storage_tech, power_systems_type, prime_mover_type, ext=Dict(), available, ) where T <: PSY.Storage
    StorageTechnology{T}(name, storage_tech, power_systems_type, prime_mover_type, ext, available, )
end

"""Get [`StorageTechnology`](@ref) `name`."""
get_name(value::StorageTechnology) = value.name
"""Get [`StorageTechnology`](@ref) `storage_tech`."""
get_storage_tech(value::StorageTechnology) = value.storage_tech
"""Get [`StorageTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::StorageTechnology) = value.power_systems_type
"""Get [`StorageTechnology`](@ref) `prime_mover_type`."""
get_prime_mover_type(value::StorageTechnology) = value.prime_mover_type
"""Get [`StorageTechnology`](@ref) `ext`."""
get_ext(value::StorageTechnology) = value.ext
"""Get [`StorageTechnology`](@ref) `available`."""
get_available(value::StorageTechnology) = value.available

"""Set [`StorageTechnology`](@ref) `name`."""
set_name!(value::StorageTechnology, val) = value.name = val
"""Set [`StorageTechnology`](@ref) `storage_tech`."""
set_storage_tech!(value::StorageTechnology, val) = value.storage_tech = val
"""Set [`StorageTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::StorageTechnology, val) = value.power_systems_type = val
"""Set [`StorageTechnology`](@ref) `prime_mover_type`."""
set_prime_mover_type!(value::StorageTechnology, val) = value.prime_mover_type = val
"""Set [`StorageTechnology`](@ref) `ext`."""
set_ext!(value::StorageTechnology, val) = value.ext = val
"""Set [`StorageTechnology`](@ref) `available`."""
set_available!(value::StorageTechnology, val) = value.available = val
