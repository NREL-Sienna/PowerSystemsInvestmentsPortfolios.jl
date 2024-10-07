#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandRequirement{T <: PSY.StaticInjection} <: Technology
        name::String
        zone::Union{Nothing, Int64, Zone}
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        ext::Dict
        demand_mw::Float64
        available::Bool
    end



# Arguments
- `name::String`: The technology name
- `zone::Union{Nothing, Int64, Zone}`: Zone Number
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `demand_mw::Float64`: (default: `0.0`) Demand profile in MW
- `available::Bool`: (default: `true`) identifies whether the technology is available
"""
mutable struct DemandRequirement{T <: PSY.StaticInjection} <: Technology
    "The technology name"
    name::String
    "Zone Number"
    zone::Union{Nothing, Int64, Zone}
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Demand profile in MW"
    demand_mw::Float64
    "identifies whether the technology is available"
    available::Bool
end


function DemandRequirement{T}(; name, zone, power_systems_type, internal=InfrastructureSystemsInternal(), ext=Dict(), demand_mw=0.0, available=true, ) where T <: PSY.StaticInjection
    DemandRequirement{T}(name, zone, power_systems_type, internal, ext, demand_mw, available, )
end

"""Get [`DemandRequirement`](@ref) `name`."""
get_name(value::DemandRequirement) = value.name
"""Get [`DemandRequirement`](@ref) `zone`."""
get_zone(value::DemandRequirement) = value.zone
"""Get [`DemandRequirement`](@ref) `power_systems_type`."""
get_power_systems_type(value::DemandRequirement) = value.power_systems_type
"""Get [`DemandRequirement`](@ref) `internal`."""
get_internal(value::DemandRequirement) = value.internal
"""Get [`DemandRequirement`](@ref) `ext`."""
get_ext(value::DemandRequirement) = value.ext
"""Get [`DemandRequirement`](@ref) `demand_mw`."""
get_demand_mw(value::DemandRequirement) = value.demand_mw
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
"""Set [`DemandRequirement`](@ref) `ext`."""
set_ext!(value::DemandRequirement, val) = value.ext = val
"""Set [`DemandRequirement`](@ref) `demand_mw`."""
set_demand_mw!(value::DemandRequirement, val) = value.demand_mw = val
"""Set [`DemandRequirement`](@ref) `available`."""
set_available!(value::DemandRequirement, val) = value.available = val

function IS.serialize(technology::DemandRequirement{T}) where T <: PSY.StaticInjection
    data = Dict{String, Any}()
    for name in fieldnames(DemandRequirement{T})
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

    add_serialization_metadata!(data, DemandRequirement{T})
    data[IS.METADATA_KEY][IS.CONSTRUCT_WITH_PARAMETERS_KEY] = false

    return data
end

IS.deserialize(T::Type{<:DemandRequirement}, val::Dict) = IS.deserialize_struct(T, val)
