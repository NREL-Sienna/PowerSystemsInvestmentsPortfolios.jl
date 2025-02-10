#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct FlexibleDemandSideTechnology{T <: PSY.StaticInjection} <: Technology
        max_demand_delay::Float64
        name::String
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        ext::Dict
        max_demand_advance::Float64
        demand_energy_efficiency::Float64
        region::Union{Nothing, Region}
        variable_cost_per_mwh::PSY.ValueCurve
        available::Bool
    end



# Arguments
- `max_demand_delay::Float64`: Maximum number of hours that demand can be deferred or delayed.
- `name::String`: The technology name
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `max_demand_advance::Float64`: Maximum number of hours that demand can be scheduled in advance of the original schedule (hours).
- `demand_energy_efficiency::Float64`: Energy efficiency associated with time shifting demand. Represents energy losses due to time shifting
- `region::Union{Nothing, Region}`: (default: `nothing`) Region where tech operates in
- `variable_cost_per_mwh::PSY.ValueCurve`: Variable operations and maintenance costs associated with flexible demand deferral
- `available::Bool`: identifies whether the technology is available
"""
mutable struct FlexibleDemandSideTechnology{T <: PSY.StaticInjection} <: Technology
    "Maximum number of hours that demand can be deferred or delayed."
    max_demand_delay::Float64
    "The technology name"
    name::String
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Maximum number of hours that demand can be scheduled in advance of the original schedule (hours)."
    max_demand_advance::Float64
    "Energy efficiency associated with time shifting demand. Represents energy losses due to time shifting"
    demand_energy_efficiency::Float64
    "Region where tech operates in"
    region::Union{Nothing, Region}
    "Variable operations and maintenance costs associated with flexible demand deferral"
    variable_cost_per_mwh::PSY.ValueCurve
    "identifies whether the technology is available"
    available::Bool
end


function FlexibleDemandSideTechnology{T}(; max_demand_delay, name, power_systems_type, internal=InfrastructureSystemsInternal(), ext=Dict(), max_demand_advance, demand_energy_efficiency, region=nothing, variable_cost_per_mwh, available, ) where T <: PSY.StaticInjection
    FlexibleDemandSideTechnology{T}(max_demand_delay, name, power_systems_type, internal, ext, max_demand_advance, demand_energy_efficiency, region, variable_cost_per_mwh, available, )
end

"""Get [`FlexibleDemandSideTechnology`](@ref) `max_demand_delay`."""
get_max_demand_delay(value::FlexibleDemandSideTechnology) = value.max_demand_delay
"""Get [`FlexibleDemandSideTechnology`](@ref) `name`."""
get_name(value::FlexibleDemandSideTechnology) = value.name
"""Get [`FlexibleDemandSideTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::FlexibleDemandSideTechnology) = value.power_systems_type
"""Get [`FlexibleDemandSideTechnology`](@ref) `internal`."""
get_internal(value::FlexibleDemandSideTechnology) = value.internal
"""Get [`FlexibleDemandSideTechnology`](@ref) `ext`."""
get_ext(value::FlexibleDemandSideTechnology) = value.ext
"""Get [`FlexibleDemandSideTechnology`](@ref) `max_demand_advance`."""
get_max_demand_advance(value::FlexibleDemandSideTechnology) = value.max_demand_advance
"""Get [`FlexibleDemandSideTechnology`](@ref) `demand_energy_efficiency`."""
get_demand_energy_efficiency(value::FlexibleDemandSideTechnology) = value.demand_energy_efficiency
"""Get [`FlexibleDemandSideTechnology`](@ref) `region`."""
get_region(value::FlexibleDemandSideTechnology) = value.region
"""Get [`FlexibleDemandSideTechnology`](@ref) `variable_cost_per_mwh`."""
get_variable_cost_per_mwh(value::FlexibleDemandSideTechnology) = value.variable_cost_per_mwh
"""Get [`FlexibleDemandSideTechnology`](@ref) `available`."""
get_available(value::FlexibleDemandSideTechnology) = value.available

"""Set [`FlexibleDemandSideTechnology`](@ref) `max_demand_delay`."""
set_max_demand_delay!(value::FlexibleDemandSideTechnology, val) = value.max_demand_delay = val
"""Set [`FlexibleDemandSideTechnology`](@ref) `name`."""
set_name!(value::FlexibleDemandSideTechnology, val) = value.name = val
"""Set [`FlexibleDemandSideTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::FlexibleDemandSideTechnology, val) = value.power_systems_type = val
"""Set [`FlexibleDemandSideTechnology`](@ref) `internal`."""
set_internal!(value::FlexibleDemandSideTechnology, val) = value.internal = val
"""Set [`FlexibleDemandSideTechnology`](@ref) `ext`."""
set_ext!(value::FlexibleDemandSideTechnology, val) = value.ext = val
"""Set [`FlexibleDemandSideTechnology`](@ref) `max_demand_advance`."""
set_max_demand_advance!(value::FlexibleDemandSideTechnology, val) = value.max_demand_advance = val
"""Set [`FlexibleDemandSideTechnology`](@ref) `demand_energy_efficiency`."""
set_demand_energy_efficiency!(value::FlexibleDemandSideTechnology, val) = value.demand_energy_efficiency = val
"""Set [`FlexibleDemandSideTechnology`](@ref) `region`."""
set_region!(value::FlexibleDemandSideTechnology, val) = value.region = val
"""Set [`FlexibleDemandSideTechnology`](@ref) `variable_cost_per_mwh`."""
set_variable_cost_per_mwh!(value::FlexibleDemandSideTechnology, val) = value.variable_cost_per_mwh = val
"""Set [`FlexibleDemandSideTechnology`](@ref) `available`."""
set_available!(value::FlexibleDemandSideTechnology, val) = value.available = val
