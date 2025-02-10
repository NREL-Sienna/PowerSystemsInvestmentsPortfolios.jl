#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandSideTechnology{T <: PSY.StaticInjection} <: Technology
        price_per_unit::Float64
        ramp_dn_percentage::Float64
        available::Bool
        name::String
        technology_efficiency::Float64
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        ext::Dict
        region::Union{Nothing, Region}
        min_power::Float64
        ramp_up_percentage::Float64
        capacity::Float64
    end



# Arguments
- `price_per_unit::Float64`: (default: `0.0`) Price or value per unit of output. Ex: USD per ton of hydrogen for electrolyzers
- `ramp_dn_percentage::Float64`: (default: `1.0`) Maximum decrease in output between operation periods. Fraction of total capacity
- `available::Bool`: identifies whether the technology is available
- `name::String`: The technology name
- `technology_efficiency::Float64`: (default: `0.0`) MWh of electricity per unit of output. Ex: MWh per ton of hydrogen for electrolyzers
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `region::Union{Nothing, Region}`: (default: `nothing`) Region where tech operates in
- `min_power::Float64`: (default: `0.0`) Minimum operation of demandside unit as a fraction of total capacity
- `ramp_up_percentage::Float64`: (default: `1.0`) Maximum increase in output between operation periods. Fraction of total capacity
- `capacity::Float64`: (default: `0.0`) Total capacity of technology available in the region
"""
mutable struct DemandSideTechnology{T <: PSY.StaticInjection} <: Technology
    "Price or value per unit of output. Ex: USD per ton of hydrogen for electrolyzers"
    price_per_unit::Float64
    "Maximum decrease in output between operation periods. Fraction of total capacity"
    ramp_dn_percentage::Float64
    "identifies whether the technology is available"
    available::Bool
    "The technology name"
    name::String
    "MWh of electricity per unit of output. Ex: MWh per ton of hydrogen for electrolyzers"
    technology_efficiency::Float64
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Region where tech operates in"
    region::Union{Nothing, Region}
    "Minimum operation of demandside unit as a fraction of total capacity"
    min_power::Float64
    "Maximum increase in output between operation periods. Fraction of total capacity"
    ramp_up_percentage::Float64
    "Total capacity of technology available in the region"
    capacity::Float64
end


function DemandSideTechnology{T}(; price_per_unit=0.0, ramp_dn_percentage=1.0, available, name, technology_efficiency=0.0, power_systems_type, internal=InfrastructureSystemsInternal(), ext=Dict(), region=nothing, min_power=0.0, ramp_up_percentage=1.0, capacity=0.0, ) where T <: PSY.StaticInjection
    DemandSideTechnology{T}(price_per_unit, ramp_dn_percentage, available, name, technology_efficiency, power_systems_type, internal, ext, region, min_power, ramp_up_percentage, capacity, )
end

"""Get [`DemandSideTechnology`](@ref) `price_per_unit`."""
get_price_per_unit(value::DemandSideTechnology) = value.price_per_unit
"""Get [`DemandSideTechnology`](@ref) `ramp_dn_percentage`."""
get_ramp_dn_percentage(value::DemandSideTechnology) = value.ramp_dn_percentage
"""Get [`DemandSideTechnology`](@ref) `available`."""
get_available(value::DemandSideTechnology) = value.available
"""Get [`DemandSideTechnology`](@ref) `name`."""
get_name(value::DemandSideTechnology) = value.name
"""Get [`DemandSideTechnology`](@ref) `technology_efficiency`."""
get_technology_efficiency(value::DemandSideTechnology) = value.technology_efficiency
"""Get [`DemandSideTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::DemandSideTechnology) = value.power_systems_type
"""Get [`DemandSideTechnology`](@ref) `internal`."""
get_internal(value::DemandSideTechnology) = value.internal
"""Get [`DemandSideTechnology`](@ref) `ext`."""
get_ext(value::DemandSideTechnology) = value.ext
"""Get [`DemandSideTechnology`](@ref) `region`."""
get_region(value::DemandSideTechnology) = value.region
"""Get [`DemandSideTechnology`](@ref) `min_power`."""
get_min_power(value::DemandSideTechnology) = value.min_power
"""Get [`DemandSideTechnology`](@ref) `ramp_up_percentage`."""
get_ramp_up_percentage(value::DemandSideTechnology) = value.ramp_up_percentage
"""Get [`DemandSideTechnology`](@ref) `capacity`."""
get_capacity(value::DemandSideTechnology) = value.capacity

"""Set [`DemandSideTechnology`](@ref) `price_per_unit`."""
set_price_per_unit!(value::DemandSideTechnology, val) = value.price_per_unit = val
"""Set [`DemandSideTechnology`](@ref) `ramp_dn_percentage`."""
set_ramp_dn_percentage!(value::DemandSideTechnology, val) = value.ramp_dn_percentage = val
"""Set [`DemandSideTechnology`](@ref) `available`."""
set_available!(value::DemandSideTechnology, val) = value.available = val
"""Set [`DemandSideTechnology`](@ref) `name`."""
set_name!(value::DemandSideTechnology, val) = value.name = val
"""Set [`DemandSideTechnology`](@ref) `technology_efficiency`."""
set_technology_efficiency!(value::DemandSideTechnology, val) = value.technology_efficiency = val
"""Set [`DemandSideTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::DemandSideTechnology, val) = value.power_systems_type = val
"""Set [`DemandSideTechnology`](@ref) `internal`."""
set_internal!(value::DemandSideTechnology, val) = value.internal = val
"""Set [`DemandSideTechnology`](@ref) `ext`."""
set_ext!(value::DemandSideTechnology, val) = value.ext = val
"""Set [`DemandSideTechnology`](@ref) `region`."""
set_region!(value::DemandSideTechnology, val) = value.region = val
"""Set [`DemandSideTechnology`](@ref) `min_power`."""
set_min_power!(value::DemandSideTechnology, val) = value.min_power = val
"""Set [`DemandSideTechnology`](@ref) `ramp_up_percentage`."""
set_ramp_up_percentage!(value::DemandSideTechnology, val) = value.ramp_up_percentage = val
"""Set [`DemandSideTechnology`](@ref) `capacity`."""
set_capacity!(value::DemandSideTechnology, val) = value.capacity = val
