#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandRequirement{T <: PSY.StaticInjection} <: Technology
        load_growth::Float64
        name::String
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        ext::Dict
        region::String
        available::Bool
        peak_load::Float64
    end



# Arguments
- `load_growth::Float64`: Annual load growth (%)
- `name::String`: The technology name
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `region::String`: Corresponding region for peak demand
- `available::Bool`: identifies whether the technology is available
- `peak_load::Float64`: Demand value (MW) for single timepoint (for now)
"""
mutable struct DemandRequirement{T <: PSY.StaticInjection} <: Technology
    "Annual load growth (%)"
    load_growth::Float64
    "The technology name"
    name::String
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Corresponding region for peak demand"
    region::String
    "identifies whether the technology is available"
    available::Bool
    "Demand value (MW) for single timepoint (for now)"
    peak_load::Float64
end


function DemandRequirement{T}(; load_growth, name, power_systems_type, internal=InfrastructureSystemsInternal(), ext=Dict(), region, available, peak_load, ) where T <: PSY.StaticInjection
    DemandRequirement{T}(load_growth, name, power_systems_type, internal, ext, region, available, peak_load, )
end

"""Get [`DemandRequirement`](@ref) `load_growth`."""
get_load_growth(value::DemandRequirement) = value.load_growth
"""Get [`DemandRequirement`](@ref) `name`."""
get_name(value::DemandRequirement) = value.name
"""Get [`DemandRequirement`](@ref) `power_systems_type`."""
get_power_systems_type(value::DemandRequirement) = value.power_systems_type
"""Get [`DemandRequirement`](@ref) `internal`."""
get_internal(value::DemandRequirement) = value.internal
"""Get [`DemandRequirement`](@ref) `ext`."""
get_ext(value::DemandRequirement) = value.ext
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
"""Set [`DemandRequirement`](@ref) `internal`."""
set_internal!(value::DemandRequirement, val) = value.internal = val
"""Set [`DemandRequirement`](@ref) `ext`."""
set_ext!(value::DemandRequirement, val) = value.ext = val
"""Set [`DemandRequirement`](@ref) `region`."""
set_region!(value::DemandRequirement, val) = value.region = val
"""Set [`DemandRequirement`](@ref) `available`."""
set_available!(value::DemandRequirement, val) = value.available = val
"""Set [`DemandRequirement`](@ref) `peak_load`."""
set_peak_load!(value::DemandRequirement, val) = value.peak_load = val
