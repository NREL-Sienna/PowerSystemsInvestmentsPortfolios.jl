#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandRequirement{T <: PSY.StaticInjection} <: Technology
        name::String
        zone::Int64
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        demand_mw_z::Float64
        ext::Dict
        region::String
        available::Bool
    end



# Arguments
- `name::String`: The technology name
- `zone::Int64`: Zone Number
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `demand_mw_z::Float64`: (default: `0.0`) Demand profile in MW
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `region::String`: Corresponding region for peak demand
- `available::Bool`: (default: `true`) identifies whether the technology is available
"""
mutable struct DemandRequirement{T <: PSY.StaticInjection} <: Technology
    "The technology name"
    name::String
    "Zone Number"
    zone::Int64
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Demand profile in MW"
    demand_mw_z::Float64
    "Option for providing additional data"
    ext::Dict
    "Corresponding region for peak demand"
    region::String
    "identifies whether the technology is available"
    available::Bool
end


function DemandRequirement{T}(; name, zone, power_systems_type, internal=InfrastructureSystemsInternal(), demand_mw_z=0.0, ext=Dict(), region, available=true, ) where T <: PSY.StaticInjection
    DemandRequirement{T}(name, zone, power_systems_type, internal, demand_mw_z, ext, region, available, )
end

"""Get [`DemandRequirement`](@ref) `name`."""
get_name(value::DemandRequirement) = value.name
"""Get [`DemandRequirement`](@ref) `zone`."""
get_zone(value::DemandRequirement) = value.zone
"""Get [`DemandRequirement`](@ref) `power_systems_type`."""
get_power_systems_type(value::DemandRequirement) = value.power_systems_type
"""Get [`DemandRequirement`](@ref) `internal`."""
get_internal(value::DemandRequirement) = value.internal
"""Get [`DemandRequirement`](@ref) `demand_mw_z`."""
get_demand_mw_z(value::DemandRequirement) = value.demand_mw_z
"""Get [`DemandRequirement`](@ref) `ext`."""
get_ext(value::DemandRequirement) = value.ext
"""Get [`DemandRequirement`](@ref) `region`."""
get_region(value::DemandRequirement) = value.region
"""Get [`DemandRequirement`](@ref) `available`."""
get_available(value::DemandRequirement) = value.available

"""Set [`DemandRequirement`](@ref) `name`."""
set_name!(value::DemandRequirement, val) = value.name = val
"""Set [`DemandRequirement`](@ref) `zone`."""
set_zone!(value::DemandRequirement, val) = value.zone = val
"""Set [`DemandRequirement`](@ref) `power_systems_type`."""
set_power_systems_type!(value::DemandRequirement, val) = value.power_systems_type = val
"""Set [`DemandRequirement`](@ref) `internal`."""
set_internal!(value::DemandRequirement, val) = value.internal = val
"""Set [`DemandRequirement`](@ref) `demand_mw_z`."""
set_demand_mw_z!(value::DemandRequirement, val) = value.demand_mw_z = val
"""Set [`DemandRequirement`](@ref) `ext`."""
set_ext!(value::DemandRequirement, val) = value.ext = val
"""Set [`DemandRequirement`](@ref) `region`."""
set_region!(value::DemandRequirement, val) = value.region = val
"""Set [`DemandRequirement`](@ref) `available`."""
set_available!(value::DemandRequirement, val) = value.available = val
