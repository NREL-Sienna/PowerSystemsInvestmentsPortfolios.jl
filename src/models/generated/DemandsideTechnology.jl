#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandsideTechnology{T <: Dict{String, Any}(&quot;type&quot; =&gt; &quot;string&quot;, &quot;description&quot; =&gt; &quot;maps to a valid PowerSystems.jl for PCM modeling&quot;)} <: 
        name::string
        power_systems_type::string
        available::boolean
    end



# Arguments
- `name::string`:
- `power_systems_type::string`:
- `available::boolean`:
"""
mutable struct DemandsideTechnology{T <: Dict{String, Any}(&quot;type&quot; =&gt; &quot;string&quot;, &quot;description&quot; =&gt; &quot;maps to a valid PowerSystems.jl for PCM modeling&quot;)} <: 
    name::string
    power_systems_type::string
    available::boolean
end


function DemandsideTechnology{T}(; name, power_systems_type, available, ) where T <: Dict{String, Any}("type" => "string", "description" => "maps to a valid PowerSystems.jl for PCM modeling")
    DemandsideTechnology{T}(name, power_systems_type, available, )
end

"""Get [`DemandsideTechnology`](@ref) `name`."""
get_name(value::DemandsideTechnology) = value.name
"""Get [`DemandsideTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::DemandsideTechnology) = value.power_systems_type
"""Get [`DemandsideTechnology`](@ref) `available`."""
get_available(value::DemandsideTechnology) = value.available

"""Set [`DemandsideTechnology`](@ref) `name`."""
set_name!(value::DemandsideTechnology, val) = value.name = val
"""Set [`DemandsideTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::DemandsideTechnology, val) = value.power_systems_type = val
"""Set [`DemandsideTechnology`](@ref) `available`."""
set_available!(value::DemandsideTechnology, val) = value.available = val
