#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandRequirement{T <: PSY.StaticInjection} <: Technology
        name::String
        value_of_lost_load::Float64
        power_systems_type::String
        peak_demand_mw::Float64
        internal::InfrastructureSystemsInternal
        id::Int64
        ext::Dict
        region::Union{Nothing, Vector{Region}}
        available::Bool
    end



# Arguments
- `name::String`: The technology name
- `value_of_lost_load::Float64`: Value of unserved load, USD/MWh
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `peak_demand_mw::Float64`: (default: `0.0`) Peak demand value in MW
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `id::Int64`: ID for individual demand requirement
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `region::Union{Nothing, Vector{Region}}`: (default: `Vector()`) Region
- `available::Bool`: (default: `true`) identifies whether the technology is available
"""
mutable struct DemandRequirement{T <: PSY.StaticInjection} <: Technology
    "The technology name"
    name::String
    "Value of unserved load, USD/MWh"
    value_of_lost_load::Float64
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Peak demand value in MW"
    peak_demand_mw::Float64
    "Internal field"
    internal::InfrastructureSystemsInternal
    "ID for individual demand requirement"
    id::Int64
    "Option for providing additional data"
    ext::Dict
    "Region"
    region::Union{Nothing, Vector{Region}}
    "identifies whether the technology is available"
    available::Bool
end


function DemandRequirement{T}(; name, value_of_lost_load, power_systems_type, peak_demand_mw=0.0, internal=InfrastructureSystemsInternal(), id, ext=Dict(), region=Vector(), available=true, ) where T <: PSY.StaticInjection
    DemandRequirement{T}(name, value_of_lost_load, power_systems_type, peak_demand_mw, internal, id, ext, region, available, )
end

"""Get [`DemandRequirement`](@ref) `name`."""
get_name(value::DemandRequirement) = value.name
"""Get [`DemandRequirement`](@ref) `value_of_lost_load`."""
get_value_of_lost_load(value::DemandRequirement) = value.value_of_lost_load
"""Get [`DemandRequirement`](@ref) `power_systems_type`."""
get_power_systems_type(value::DemandRequirement) = value.power_systems_type
"""Get [`DemandRequirement`](@ref) `peak_demand_mw`."""
get_peak_demand_mw(value::DemandRequirement) = value.peak_demand_mw
"""Get [`DemandRequirement`](@ref) `internal`."""
get_internal(value::DemandRequirement) = value.internal
"""Get [`DemandRequirement`](@ref) `id`."""
get_id(value::DemandRequirement) = value.id
"""Get [`DemandRequirement`](@ref) `ext`."""
get_ext(value::DemandRequirement) = value.ext
"""Get [`DemandRequirement`](@ref) `region`."""
get_region(value::DemandRequirement) = value.region
"""Get [`DemandRequirement`](@ref) `available`."""
get_available(value::DemandRequirement) = value.available

"""Set [`DemandRequirement`](@ref) `name`."""
set_name!(value::DemandRequirement, val) = value.name = val
"""Set [`DemandRequirement`](@ref) `value_of_lost_load`."""
set_value_of_lost_load!(value::DemandRequirement, val) = value.value_of_lost_load = val
"""Set [`DemandRequirement`](@ref) `power_systems_type`."""
set_power_systems_type!(value::DemandRequirement, val) = value.power_systems_type = val
"""Set [`DemandRequirement`](@ref) `peak_demand_mw`."""
set_peak_demand_mw!(value::DemandRequirement, val) = value.peak_demand_mw = val
"""Set [`DemandRequirement`](@ref) `internal`."""
set_internal!(value::DemandRequirement, val) = value.internal = val
"""Set [`DemandRequirement`](@ref) `id`."""
set_id!(value::DemandRequirement, val) = value.id = val
"""Set [`DemandRequirement`](@ref) `ext`."""
set_ext!(value::DemandRequirement, val) = value.ext = val
"""Set [`DemandRequirement`](@ref) `region`."""
set_region!(value::DemandRequirement, val) = value.region = val
"""Set [`DemandRequirement`](@ref) `available`."""
set_available!(value::DemandRequirement, val) = value.available = val
