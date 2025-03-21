#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct FlexibleDemandTechnology{T <: PSY.StaticInjection} <: Technology
        available::Bool
        name::String
        var_cost_per_mwh::PSY.ValueCurve
        id::Int64
        max_demand_advance::Float64
        demand_energy_efficiency::Float64
        max_demand_delay::Float64
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        ext::Dict
        region::Union{Nothing, Vector{Region}}
    end



# Arguments
- `available::Bool`: identifies whether the technology is available
- `name::String`: The technology name
- `var_cost_per_mwh::PSY.ValueCurve`: Variable operations and maintenance costs associated with flexible demand deferral
- `id::Int64`: ID for individual demand side technology
- `max_demand_advance::Float64`: Maximum number of hours that demand can be scheduled in advance of the original schedule (hours).
- `demand_energy_efficiency::Float64`: Energy efficiency associated with time shifting demand. Represents energy losses due to time shifting
- `max_demand_delay::Float64`: Maximum number of hours that demand can be deferred or delayed (hours).
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `region::Union{Nothing, Vector{Region}}`: (default: `Vector()`) Region
"""
mutable struct FlexibleDemandTechnology{T <: PSY.StaticInjection} <: Technology
    "identifies whether the technology is available"
    available::Bool
    "The technology name"
    name::String
    "Variable operations and maintenance costs associated with flexible demand deferral"
    var_cost_per_mwh::PSY.ValueCurve
    "ID for individual demand side technology"
    id::Int64
    "Maximum number of hours that demand can be scheduled in advance of the original schedule (hours)."
    max_demand_advance::Float64
    "Energy efficiency associated with time shifting demand. Represents energy losses due to time shifting"
    demand_energy_efficiency::Float64
    "Maximum number of hours that demand can be deferred or delayed (hours)."
    max_demand_delay::Float64
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Region"
    region::Union{Nothing, Vector{Region}}
end


function FlexibleDemandTechnology{T}(; available, name, var_cost_per_mwh, id, max_demand_advance, demand_energy_efficiency, max_demand_delay, power_systems_type, internal=InfrastructureSystemsInternal(), ext=Dict(), region=Vector(), ) where T <: PSY.StaticInjection
    FlexibleDemandTechnology{T}(available, name, var_cost_per_mwh, id, max_demand_advance, demand_energy_efficiency, max_demand_delay, power_systems_type, internal, ext, region, )
end

"""Get [`FlexibleDemandTechnology`](@ref) `available`."""
get_available(value::FlexibleDemandTechnology) = value.available
"""Get [`FlexibleDemandTechnology`](@ref) `name`."""
get_name(value::FlexibleDemandTechnology) = value.name
"""Get [`FlexibleDemandTechnology`](@ref) `var_cost_per_mwh`."""
get_var_cost_per_mwh(value::FlexibleDemandTechnology) = value.var_cost_per_mwh
"""Get [`FlexibleDemandTechnology`](@ref) `id`."""
get_id(value::FlexibleDemandTechnology) = value.id
"""Get [`FlexibleDemandTechnology`](@ref) `max_demand_advance`."""
get_max_demand_advance(value::FlexibleDemandTechnology) = value.max_demand_advance
"""Get [`FlexibleDemandTechnology`](@ref) `demand_energy_efficiency`."""
get_demand_energy_efficiency(value::FlexibleDemandTechnology) = value.demand_energy_efficiency
"""Get [`FlexibleDemandTechnology`](@ref) `max_demand_delay`."""
get_max_demand_delay(value::FlexibleDemandTechnology) = value.max_demand_delay
"""Get [`FlexibleDemandTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::FlexibleDemandTechnology) = value.power_systems_type
"""Get [`FlexibleDemandTechnology`](@ref) `internal`."""
get_internal(value::FlexibleDemandTechnology) = value.internal
"""Get [`FlexibleDemandTechnology`](@ref) `ext`."""
get_ext(value::FlexibleDemandTechnology) = value.ext
"""Get [`FlexibleDemandTechnology`](@ref) `region`."""
get_region(value::FlexibleDemandTechnology) = value.region

"""Set [`FlexibleDemandTechnology`](@ref) `available`."""
set_available!(value::FlexibleDemandTechnology, val) = value.available = val
"""Set [`FlexibleDemandTechnology`](@ref) `name`."""
set_name!(value::FlexibleDemandTechnology, val) = value.name = val
"""Set [`FlexibleDemandTechnology`](@ref) `var_cost_per_mwh`."""
set_var_cost_per_mwh!(value::FlexibleDemandTechnology, val) = value.var_cost_per_mwh = val
"""Set [`FlexibleDemandTechnology`](@ref) `id`."""
set_id!(value::FlexibleDemandTechnology, val) = value.id = val
"""Set [`FlexibleDemandTechnology`](@ref) `max_demand_advance`."""
set_max_demand_advance!(value::FlexibleDemandTechnology, val) = value.max_demand_advance = val
"""Set [`FlexibleDemandTechnology`](@ref) `demand_energy_efficiency`."""
set_demand_energy_efficiency!(value::FlexibleDemandTechnology, val) = value.demand_energy_efficiency = val
"""Set [`FlexibleDemandTechnology`](@ref) `max_demand_delay`."""
set_max_demand_delay!(value::FlexibleDemandTechnology, val) = value.max_demand_delay = val
"""Set [`FlexibleDemandTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::FlexibleDemandTechnology, val) = value.power_systems_type = val
"""Set [`FlexibleDemandTechnology`](@ref) `internal`."""
set_internal!(value::FlexibleDemandTechnology, val) = value.internal = val
"""Set [`FlexibleDemandTechnology`](@ref) `ext`."""
set_ext!(value::FlexibleDemandTechnology, val) = value.ext = val
"""Set [`FlexibleDemandTechnology`](@ref) `region`."""
set_region!(value::FlexibleDemandTechnology, val) = value.region = val

function serialize_openapi_struct(technology::FlexibleDemandTechnology{T}, vals...) where T <: PSY.StaticInjection
    base_struct = APIServer.FlexibleDemandTechnology(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:FlexibleDemandTechnology}, vals::Dict)
    return IS.deserialize_struct(APIServer.FlexibleDemandTechnology, vals)
end
