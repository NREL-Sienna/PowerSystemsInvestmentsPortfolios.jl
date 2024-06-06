#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct StorageTechnology{T <: Dict{String, Any}(&quot;type&quot; =&gt; &quot;string&quot;, &quot;description&quot; =&gt; &quot;maps to a valid PowerSystems.jl for PCM modeling&quot;)} <: 
        name::string
        storage_tech::string
        power_systems_type::string
        available::boolean
    end



# Arguments
- `name::string`:
- `storage_tech::string`:
- `power_systems_type::string`:
- `available::boolean`:
"""
mutable struct StorageTechnology{T <: Dict{String, Any}(&quot;type&quot; =&gt; &quot;string&quot;, &quot;description&quot; =&gt; &quot;maps to a valid PowerSystems.jl for PCM modeling&quot;)} <: 
    name::string
    storage_tech::string
    power_systems_type::string
    available::boolean
end


function StorageTechnology{T}(; name, storage_tech, power_systems_type, available, ) where T <: Dict{String, Any}("type" => "string", "description" => "maps to a valid PowerSystems.jl for PCM modeling")
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
