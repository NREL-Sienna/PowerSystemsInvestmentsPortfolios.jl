#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct StorageTechnology{T <: PSY.Storage} <: InfrastructureSystemsComponent
        name::String
        storage_tech::String
        power_systems_type::String
        available::Bool
    end



# Arguments
- `name::String`: The technology name
- `storage_tech::String`: Storage Technology Type
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `available::Bool`: identifies whether the technology is available
"""
mutable struct StorageTechnology{T <: PSY.Storage} <: InfrastructureSystemsComponent
    "The technology name"
    name::String
    "Storage Technology Type"
    storage_tech::String
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "identifies whether the technology is available"
    available::Bool
end


function StorageTechnology{T}(; name, storage_tech, power_systems_type, available, ) where T <: PSY.Storage
    StorageTechnology{T}(name, storage_tech, power_systems_type, available, )
end

"""Get [`StorageTechnology`](@ref) `name`."""
get_name(value::StorageTechnology) = value.name
"""Get [`StorageTechnology`](@ref) `storage_tech`."""
get_storage_tech(value::StorageTechnology) = value.storage_tech
"""Get [`StorageTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::StorageTechnology) = value.power_systems_type
"""Get [`StorageTechnology`](@ref) `available`."""
get_available(value::StorageTechnology) = value.available

"""Set [`StorageTechnology`](@ref) `name`."""
set_name!(value::StorageTechnology, val) = value.name = val
"""Set [`StorageTechnology`](@ref) `storage_tech`."""
set_storage_tech!(value::StorageTechnology, val) = value.storage_tech = val
"""Set [`StorageTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::StorageTechnology, val) = value.power_systems_type = val
"""Set [`StorageTechnology`](@ref) `available`."""
set_available!(value::StorageTechnology, val) = value.available = val
