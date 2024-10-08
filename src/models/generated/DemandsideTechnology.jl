#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandSideTechnology{T <: PSY.StaticInjection} <: Technology
        min_power::Float64
        name::String
        ramp_up_percentage::Float64
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        price_per_unit::Float64
        ext::Dict
        technology_efficiency::Float64
        ramp_dn_percentage::Float64
        available::Bool
    end



# Arguments
- `min_power::Float64`: (default: `0.0`) Minimum operation of demandside unit as a fraction of total capacity
- `name::String`: The technology name
- `ramp_up_percentage::Float64`: (default: `1.0`) Maximum increase in output between operation periods. Fraction of total capacity
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `price_per_unit::Float64`: (default: `0.0`) Price or value per unit of output. Ex: USD per ton of hydrogen for electrolyzers
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `technology_efficiency::Float64`: (default: `0.0`) MWh of electricity per unit of output. Ex: MWh per ton of hydrogen for electrolyzers
- `ramp_dn_percentage::Float64`: (default: `1.0`) Maximum decrease in output between operation periods. Fraction of total capacity
- `available::Bool`: identifies whether the technology is available
"""
mutable struct DemandSideTechnology{T <: PSY.StaticInjection} <: Technology
    "Minimum operation of demandside unit as a fraction of total capacity"
    min_power::Float64
    "The technology name"
    name::String
    "Maximum increase in output between operation periods. Fraction of total capacity"
    ramp_up_percentage::Float64
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Price or value per unit of output. Ex: USD per ton of hydrogen for electrolyzers"
    price_per_unit::Float64
    "Option for providing additional data"
    ext::Dict
    "MWh of electricity per unit of output. Ex: MWh per ton of hydrogen for electrolyzers"
    technology_efficiency::Float64
    "Maximum decrease in output between operation periods. Fraction of total capacity"
    ramp_dn_percentage::Float64
    "identifies whether the technology is available"
    available::Bool
end


function DemandSideTechnology{T}(; min_power=0.0, name, ramp_up_percentage=1.0, power_systems_type, internal=InfrastructureSystemsInternal(), price_per_unit=0.0, ext=Dict(), technology_efficiency=0.0, ramp_dn_percentage=1.0, available, ) where T <: PSY.StaticInjection
    DemandSideTechnology{T}(min_power, name, ramp_up_percentage, power_systems_type, internal, price_per_unit, ext, technology_efficiency, ramp_dn_percentage, available, )
end

"""Get [`DemandSideTechnology`](@ref) `min_power`."""
get_min_power(value::DemandSideTechnology) = value.min_power
"""Get [`DemandSideTechnology`](@ref) `name`."""
get_name(value::DemandSideTechnology) = value.name
"""Get [`DemandSideTechnology`](@ref) `ramp_up_percentage`."""
get_ramp_up_percentage(value::DemandSideTechnology) = value.ramp_up_percentage
"""Get [`DemandSideTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::DemandSideTechnology) = value.power_systems_type
"""Get [`DemandSideTechnology`](@ref) `internal`."""
get_internal(value::DemandSideTechnology) = value.internal
"""Get [`DemandSideTechnology`](@ref) `price_per_unit`."""
get_price_per_unit(value::DemandSideTechnology) = value.price_per_unit
"""Get [`DemandSideTechnology`](@ref) `ext`."""
get_ext(value::DemandSideTechnology) = value.ext
"""Get [`DemandSideTechnology`](@ref) `technology_efficiency`."""
get_technology_efficiency(value::DemandSideTechnology) = value.technology_efficiency
"""Get [`DemandSideTechnology`](@ref) `ramp_dn_percentage`."""
get_ramp_dn_percentage(value::DemandSideTechnology) = value.ramp_dn_percentage
"""Get [`DemandSideTechnology`](@ref) `available`."""
get_available(value::DemandSideTechnology) = value.available

"""Set [`DemandSideTechnology`](@ref) `min_power`."""
set_min_power!(value::DemandSideTechnology, val) = value.min_power = val
"""Set [`DemandSideTechnology`](@ref) `name`."""
set_name!(value::DemandSideTechnology, val) = value.name = val
"""Set [`DemandSideTechnology`](@ref) `ramp_up_percentage`."""
set_ramp_up_percentage!(value::DemandSideTechnology, val) = value.ramp_up_percentage = val
"""Set [`DemandSideTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::DemandSideTechnology, val) = value.power_systems_type = val
"""Set [`DemandSideTechnology`](@ref) `internal`."""
set_internal!(value::DemandSideTechnology, val) = value.internal = val
"""Set [`DemandSideTechnology`](@ref) `price_per_unit`."""
set_price_per_unit!(value::DemandSideTechnology, val) = value.price_per_unit = val
"""Set [`DemandSideTechnology`](@ref) `ext`."""
set_ext!(value::DemandSideTechnology, val) = value.ext = val
"""Set [`DemandSideTechnology`](@ref) `technology_efficiency`."""
set_technology_efficiency!(value::DemandSideTechnology, val) = value.technology_efficiency = val
"""Set [`DemandSideTechnology`](@ref) `ramp_dn_percentage`."""
set_ramp_dn_percentage!(value::DemandSideTechnology, val) = value.ramp_dn_percentage = val
"""Set [`DemandSideTechnology`](@ref) `available`."""
set_available!(value::DemandSideTechnology, val) = value.available = val

function IS.serialize(technology::DemandSideTechnology{T}) where T <: PSY.StaticInjection
    data = Dict{String, Any}()
    for name in fieldnames(DemandSideTechnology{T})
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

    add_serialization_metadata!(data, DemandSideTechnology{T})
    data[IS.METADATA_KEY][IS.CONSTRUCT_WITH_PARAMETERS_KEY] = false

    return data
end

IS.deserialize(T::Type{<:DemandSideTechnology}, val::Dict) = IS.deserialize_struct(T, val)


function openapi_struct(::Type{<:DemandSideTechnology}, vals...)
    base_struct = APIClient.DemandSideTechnology(; vals...)
    return base_struct
end
