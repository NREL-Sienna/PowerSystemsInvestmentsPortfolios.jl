#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct FlexibleDemandTechnology{T <: PSY.StaticInjection} <: Technology
        max_demand_delay::Float64
        name::String
        power_systems_type::String
        var_cost_per_mwh::PSY.ValueCurve
        internal::InfrastructureSystemsInternal
        ext::Dict
        max_demand_advance::Float64
        demand_energy_efficiency::Float64
        available::Bool
    end



# Arguments
- `max_demand_delay::Float64`: Maximum number of hours that demand can be deferred or delayed (hours).
- `name::String`: The technology name
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `var_cost_per_mwh::PSY.ValueCurve`: Variable operations and maintenance costs associated with flexible demand deferral
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `max_demand_advance::Float64`: Maximum number of hours that demand can be scheduled in advance of the original schedule (hours).
- `demand_energy_efficiency::Float64`: Energy efficiency associated with time shifting demand. Represents energy losses due to time shifting
- `available::Bool`: identifies whether the technology is available
"""
mutable struct FlexibleDemandTechnology{T <: PSY.StaticInjection} <: Technology
    "Maximum number of hours that demand can be deferred or delayed (hours)."
    max_demand_delay::Float64
    "The technology name"
    name::String
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Variable operations and maintenance costs associated with flexible demand deferral"
    var_cost_per_mwh::PSY.ValueCurve
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Maximum number of hours that demand can be scheduled in advance of the original schedule (hours)."
    max_demand_advance::Float64
    "Energy efficiency associated with time shifting demand. Represents energy losses due to time shifting"
    demand_energy_efficiency::Float64
    "identifies whether the technology is available"
    available::Bool
end


function FlexibleDemandTechnology{T}(; max_demand_delay, name, power_systems_type, var_cost_per_mwh, internal=InfrastructureSystemsInternal(), ext=Dict(), max_demand_advance, demand_energy_efficiency, available, ) where T <: PSY.StaticInjection
    FlexibleDemandTechnology{T}(max_demand_delay, name, power_systems_type, var_cost_per_mwh, internal, ext, max_demand_advance, demand_energy_efficiency, available, )
end

"""Get [`FlexibleDemandTechnology`](@ref) `max_demand_delay`."""
get_max_demand_delay(value::FlexibleDemandTechnology) = value.max_demand_delay
"""Get [`FlexibleDemandTechnology`](@ref) `name`."""
get_name(value::FlexibleDemandTechnology) = value.name
"""Get [`FlexibleDemandTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::FlexibleDemandTechnology) = value.power_systems_type
"""Get [`FlexibleDemandTechnology`](@ref) `var_cost_per_mwh`."""
get_var_cost_per_mwh(value::FlexibleDemandTechnology) = value.var_cost_per_mwh
"""Get [`FlexibleDemandTechnology`](@ref) `internal`."""
get_internal(value::FlexibleDemandTechnology) = value.internal
"""Get [`FlexibleDemandTechnology`](@ref) `ext`."""
get_ext(value::FlexibleDemandTechnology) = value.ext
"""Get [`FlexibleDemandTechnology`](@ref) `max_demand_advance`."""
get_max_demand_advance(value::FlexibleDemandTechnology) = value.max_demand_advance
"""Get [`FlexibleDemandTechnology`](@ref) `demand_energy_efficiency`."""
get_demand_energy_efficiency(value::FlexibleDemandTechnology) = value.demand_energy_efficiency
"""Get [`FlexibleDemandTechnology`](@ref) `available`."""
get_available(value::FlexibleDemandTechnology) = value.available

"""Set [`FlexibleDemandTechnology`](@ref) `max_demand_delay`."""
set_max_demand_delay!(value::FlexibleDemandTechnology, val) = value.max_demand_delay = val
"""Set [`FlexibleDemandTechnology`](@ref) `name`."""
set_name!(value::FlexibleDemandTechnology, val) = value.name = val
"""Set [`FlexibleDemandTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::FlexibleDemandTechnology, val) = value.power_systems_type = val
"""Set [`FlexibleDemandTechnology`](@ref) `var_cost_per_mwh`."""
set_var_cost_per_mwh!(value::FlexibleDemandTechnology, val) = value.var_cost_per_mwh = val
"""Set [`FlexibleDemandTechnology`](@ref) `internal`."""
set_internal!(value::FlexibleDemandTechnology, val) = value.internal = val
"""Set [`FlexibleDemandTechnology`](@ref) `ext`."""
set_ext!(value::FlexibleDemandTechnology, val) = value.ext = val
"""Set [`FlexibleDemandTechnology`](@ref) `max_demand_advance`."""
set_max_demand_advance!(value::FlexibleDemandTechnology, val) = value.max_demand_advance = val
"""Set [`FlexibleDemandTechnology`](@ref) `demand_energy_efficiency`."""
set_demand_energy_efficiency!(value::FlexibleDemandTechnology, val) = value.demand_energy_efficiency = val
"""Set [`FlexibleDemandTechnology`](@ref) `available`."""
set_available!(value::FlexibleDemandTechnology, val) = value.available = val

function IS.serialize(technology::FlexibleDemandTechnology{T}) where T <: PSY.StaticInjection
    data = Dict{String, Any}()
    for name in fieldnames(FlexibleDemandTechnology{T})
        val = serialize_uuid_handling(getfield(technology, name))
        if name == :ext
            if !IS.is_ext_valid_for_serialization(val)
                error(
                    "component type=$technology name=$(get_name(technology)) has a value in its " *
                    "ext field that cannot be serialized.",
                )
            end
        end
        data[string(name)] = val
    end

    add_serialization_metadata!(data, FlexibleDemandTechnology{T})
    data[IS.METADATA_KEY][IS.CONSTRUCT_WITH_PARAMETERS_KEY] = false

    return data
end

IS.deserialize(T::Type{<:FlexibleDemandTechnology}, val::Dict) = IS.deserialize_struct(T, val)
