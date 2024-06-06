#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandRequirement{T <: Dict{String, Any}(&quot;type&quot; =&gt; &quot;string&quot;, &quot;description&quot; =&gt; &quot;maps to a valid PowerSystems.jl for PCM modeling&quot;)} <: 
        name::string
        power_systems_type::string
        available::boolean
    end



# Arguments
- `name::string`:
- `power_systems_type::string`:
- `available::boolean`:
"""
mutable struct DemandRequirement{T <: Dict{String, Any}(&quot;type&quot; =&gt; &quot;string&quot;, &quot;description&quot; =&gt; &quot;maps to a valid PowerSystems.jl for PCM modeling&quot;)} <: 
    name::string
    power_systems_type::string
    available::boolean
end


function DemandRequirement{T}(; name, power_systems_type, available, ) where T <: Dict{String, Any}("type" => "string", "description" => "maps to a valid PowerSystems.jl for PCM modeling")
    DemandRequirement{T}(name, power_systems_type, available, )
end

"""Get [`DemandRequirement`](@ref) `name`."""
get_name(value::DemandRequirement) = value.name
"""Get [`DemandRequirement`](@ref) `power_systems_type`."""
get_power_systems_type(value::DemandRequirement) = value.power_systems_type
"""Get [`DemandRequirement`](@ref) `available`."""
get_available(value::DemandRequirement) = value.available

"""Set [`DemandRequirement`](@ref) `name`."""
set_name!(value::DemandRequirement, val) = value.name = val
"""Set [`DemandRequirement`](@ref) `power_systems_type`."""
set_power_systems_type!(value::DemandRequirement, val) = value.power_systems_type = val
"""Set [`DemandRequirement`](@ref) `available`."""
set_available!(value::DemandRequirement, val) = value.available = val
