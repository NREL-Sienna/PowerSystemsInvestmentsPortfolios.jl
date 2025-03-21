#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct CurtailableDemandSideTechnology{T <: PSY.StaticInjection} <: Technology
        name::String
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        curtailment_cost::PSY.ValueCurve
        id::Int64
        ext::Dict
        region::Union{Nothing, Vector{Region}}
        max_demand_curtailment::Float64
        available::Bool
        min_power::Float64
    end



# Arguments
- `name::String`: The technology name
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `curtailment_cost::PSY.ValueCurve`: Energy cost of curtailment
- `id::Int64`: ID for demand side technology
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `region::Union{Nothing, Vector{Region}}`: (default: `Vector()`) Region
- `max_demand_curtailment::Float64`: (default: `1.0`) percent of demand that can be curtailed
- `available::Bool`: identifies whether the technology is available
- `min_power::Float64`: (default: `0.0`) Minimum operation of demandside unit as a fraction of total capacity
"""
mutable struct CurtailableDemandSideTechnology{T <: PSY.StaticInjection} <: Technology
    "The technology name"
    name::String
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Energy cost of curtailment"
    curtailment_cost::PSY.ValueCurve
    "ID for demand side technology"
    id::Int64
    "Option for providing additional data"
    ext::Dict
    "Region"
    region::Union{Nothing, Vector{Region}}
    "percent of demand that can be curtailed"
    max_demand_curtailment::Float64
    "identifies whether the technology is available"
    available::Bool
    "Minimum operation of demandside unit as a fraction of total capacity"
    min_power::Float64
end


function CurtailableDemandSideTechnology{T}(; name, power_systems_type, internal=InfrastructureSystemsInternal(), curtailment_cost, id, ext=Dict(), region=Vector(), max_demand_curtailment=1.0, available, min_power=0.0, ) where T <: PSY.StaticInjection
    CurtailableDemandSideTechnology{T}(name, power_systems_type, internal, curtailment_cost, id, ext, region, max_demand_curtailment, available, min_power, )
end

"""Get [`CurtailableDemandSideTechnology`](@ref) `name`."""
get_name(value::CurtailableDemandSideTechnology) = value.name
"""Get [`CurtailableDemandSideTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::CurtailableDemandSideTechnology) = value.power_systems_type
"""Get [`CurtailableDemandSideTechnology`](@ref) `internal`."""
get_internal(value::CurtailableDemandSideTechnology) = value.internal
"""Get [`CurtailableDemandSideTechnology`](@ref) `curtailment_cost`."""
get_curtailment_cost(value::CurtailableDemandSideTechnology) = value.curtailment_cost
"""Get [`CurtailableDemandSideTechnology`](@ref) `id`."""
get_id(value::CurtailableDemandSideTechnology) = value.id
"""Get [`CurtailableDemandSideTechnology`](@ref) `ext`."""
get_ext(value::CurtailableDemandSideTechnology) = value.ext
"""Get [`CurtailableDemandSideTechnology`](@ref) `region`."""
get_region(value::CurtailableDemandSideTechnology) = value.region
"""Get [`CurtailableDemandSideTechnology`](@ref) `max_demand_curtailment`."""
get_max_demand_curtailment(value::CurtailableDemandSideTechnology) = value.max_demand_curtailment
"""Get [`CurtailableDemandSideTechnology`](@ref) `available`."""
get_available(value::CurtailableDemandSideTechnology) = value.available
"""Get [`CurtailableDemandSideTechnology`](@ref) `min_power`."""
get_min_power(value::CurtailableDemandSideTechnology) = value.min_power

"""Set [`CurtailableDemandSideTechnology`](@ref) `name`."""
set_name!(value::CurtailableDemandSideTechnology, val) = value.name = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::CurtailableDemandSideTechnology, val) = value.power_systems_type = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `internal`."""
set_internal!(value::CurtailableDemandSideTechnology, val) = value.internal = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `curtailment_cost`."""
set_curtailment_cost!(value::CurtailableDemandSideTechnology, val) = value.curtailment_cost = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `id`."""
set_id!(value::CurtailableDemandSideTechnology, val) = value.id = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `ext`."""
set_ext!(value::CurtailableDemandSideTechnology, val) = value.ext = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `region`."""
set_region!(value::CurtailableDemandSideTechnology, val) = value.region = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `max_demand_curtailment`."""
set_max_demand_curtailment!(value::CurtailableDemandSideTechnology, val) = value.max_demand_curtailment = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `available`."""
set_available!(value::CurtailableDemandSideTechnology, val) = value.available = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `min_power`."""
set_min_power!(value::CurtailableDemandSideTechnology, val) = value.min_power = val

function serialize_openapi_struct(technology::CurtailableDemandSideTechnology{T}, vals...) where T <: PSY.StaticInjection
    base_struct = APIServer.CurtailableDemandSideTechnology(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:CurtailableDemandSideTechnology}, vals::Dict)
    return IS.deserialize_struct(APIServer.CurtailableDemandSideTechnology, vals)
end
