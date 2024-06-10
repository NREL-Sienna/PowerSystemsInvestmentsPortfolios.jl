#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandRequirement{T <: PSY.StaticInjection} <: InfrastructureSystemsComponent
        load_growth::Float
        name::String
        power_systems_type::String
        region::String
        available::Boolean
        peak_load::Float
    end



# Arguments
- `load_growth::Float`:
- `name::String`:
- `power_systems_type::String`:
- `region::String`:
- `available::Boolean`:
- `peak_load::Float`:
"""
mutable struct DemandRequirement{T <: PSY.StaticInjection} <: InfrastructureSystemsComponent
    load_growth::Float
    name::String
    power_systems_type::String
    region::String
    available::Boolean
    peak_load::Float
end


function DemandRequirement{T}(; load_growth, name, power_systems_type, region, available, peak_load, ) where T <: PSY.StaticInjection
    DemandRequirement{T}(load_growth, name, power_systems_type, region, available, peak_load, )
end

"""Get [`DemandRequirement`](@ref) `load_growth`."""
get_load_growth(value::DemandRequirement) = value.load_growth
"""Get [`DemandRequirement`](@ref) `name`."""
get_name(value::DemandRequirement) = value.name
"""Get [`DemandRequirement`](@ref) `power_systems_type`."""
get_power_systems_type(value::DemandRequirement) = value.power_systems_type
"""Get [`DemandRequirement`](@ref) `region`."""
get_region(value::DemandRequirement) = value.region
"""Get [`DemandRequirement`](@ref) `available`."""
get_available(value::DemandRequirement) = value.available
"""Get [`DemandRequirement`](@ref) `peak_load`."""
get_peak_load(value::DemandRequirement) = value.peak_load

"""Set [`DemandRequirement`](@ref) `load_growth`."""
set_load_growth!(value::DemandRequirement, val) = value.load_growth = val
"""Set [`DemandRequirement`](@ref) `name`."""
set_name!(value::DemandRequirement, val) = value.name = val
"""Set [`DemandRequirement`](@ref) `power_systems_type`."""
set_power_systems_type!(value::DemandRequirement, val) = value.power_systems_type = val
"""Set [`DemandRequirement`](@ref) `region`."""
set_region!(value::DemandRequirement, val) = value.region = val
"""Set [`DemandRequirement`](@ref) `available`."""
set_available!(value::DemandRequirement, val) = value.available = val
"""Set [`DemandRequirement`](@ref) `peak_load`."""
set_peak_load!(value::DemandRequirement, val) = value.peak_load = val
