#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandRequirement{T <: PSY.StaticInjection} <: InfrastructureSystemsComponent
        name::String
        power_systems_type::String
        available::Boolean
    end



# Arguments
- `name::String`:
- `power_systems_type::String`:
- `available::Boolean`:
"""
mutable struct DemandRequirement{T <: PSY.StaticInjection} <: InfrastructureSystemsComponent
    name::String
    power_systems_type::String
    available::Boolean
end


function DemandRequirement{T}(; name, power_systems_type, available, ) where T <: PSY.StaticInjection
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
