#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct CurtailableDemandSideTechnology{T <: PSY.StaticInjection} <: Technology
        voll::Float64
        available::Bool
        name::String
        curtailment_cost::Vector{Float64}
        id::Int64
        max_demand_curtailment::Vector{Float64}
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        segments::Vector{Int64}
        ext::Dict
        region::Union{Nothing, Vector{Region}}
        curtailment_cost_mwh::Vector{Float64}
    end



# Arguments
- `voll::Float64`: value of lost load
- `available::Bool`: identifies whether the technology is available
- `name::String`: The technology name
- `curtailment_cost::Vector{Float64}`: Fraction of VOLL for curtailment cost
- `id::Int64`: ID for individual generator
- `max_demand_curtailment::Vector{Float64}`: percent of demand that can be curtailed in that segment
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `segments::Vector{Int64}`: Demand segment IDs
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `region::Union{Nothing, Vector{Region}}`: (default: `Vector()`) Region
- `curtailment_cost_mwh::Vector{Float64}`: Energy cost of curtailment
"""
mutable struct CurtailableDemandSideTechnology{T <: PSY.StaticInjection} <: Technology
    "value of lost load"
    voll::Float64
    "identifies whether the technology is available"
    available::Bool
    "The technology name"
    name::String
    "Fraction of VOLL for curtailment cost"
    curtailment_cost::Vector{Float64}
    "ID for individual generator"
    id::Int64
    "percent of demand that can be curtailed in that segment"
    max_demand_curtailment::Vector{Float64}
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Demand segment IDs"
    segments::Vector{Int64}
    "Option for providing additional data"
    ext::Dict
    "Region"
    region::Union{Nothing, Vector{Region}}
    "Energy cost of curtailment"
    curtailment_cost_mwh::Vector{Float64}
end


function CurtailableDemandSideTechnology{T}(; voll, available, name, curtailment_cost, id, max_demand_curtailment, power_systems_type, internal=InfrastructureSystemsInternal(), segments, ext=Dict(), region=Vector(), curtailment_cost_mwh, ) where T <: PSY.StaticInjection
    CurtailableDemandSideTechnology{T}(voll, available, name, curtailment_cost, id, max_demand_curtailment, power_systems_type, internal, segments, ext, region, curtailment_cost_mwh, )
end

"""Get [`CurtailableDemandSideTechnology`](@ref) `voll`."""
get_voll(value::CurtailableDemandSideTechnology) = value.voll
"""Get [`CurtailableDemandSideTechnology`](@ref) `available`."""
get_available(value::CurtailableDemandSideTechnology) = value.available
"""Get [`CurtailableDemandSideTechnology`](@ref) `name`."""
get_name(value::CurtailableDemandSideTechnology) = value.name
"""Get [`CurtailableDemandSideTechnology`](@ref) `curtailment_cost`."""
get_curtailment_cost(value::CurtailableDemandSideTechnology) = value.curtailment_cost
"""Get [`CurtailableDemandSideTechnology`](@ref) `id`."""
get_id(value::CurtailableDemandSideTechnology) = value.id
"""Get [`CurtailableDemandSideTechnology`](@ref) `max_demand_curtailment`."""
get_max_demand_curtailment(value::CurtailableDemandSideTechnology) = value.max_demand_curtailment
"""Get [`CurtailableDemandSideTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::CurtailableDemandSideTechnology) = value.power_systems_type
"""Get [`CurtailableDemandSideTechnology`](@ref) `internal`."""
get_internal(value::CurtailableDemandSideTechnology) = value.internal
"""Get [`CurtailableDemandSideTechnology`](@ref) `segments`."""
get_segments(value::CurtailableDemandSideTechnology) = value.segments
"""Get [`CurtailableDemandSideTechnology`](@ref) `ext`."""
get_ext(value::CurtailableDemandSideTechnology) = value.ext
"""Get [`CurtailableDemandSideTechnology`](@ref) `region`."""
get_region(value::CurtailableDemandSideTechnology) = value.region
"""Get [`CurtailableDemandSideTechnology`](@ref) `curtailment_cost_mwh`."""
get_curtailment_cost_mwh(value::CurtailableDemandSideTechnology) = value.curtailment_cost_mwh

"""Set [`CurtailableDemandSideTechnology`](@ref) `voll`."""
set_voll!(value::CurtailableDemandSideTechnology, val) = value.voll = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `available`."""
set_available!(value::CurtailableDemandSideTechnology, val) = value.available = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `name`."""
set_name!(value::CurtailableDemandSideTechnology, val) = value.name = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `curtailment_cost`."""
set_curtailment_cost!(value::CurtailableDemandSideTechnology, val) = value.curtailment_cost = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `id`."""
set_id!(value::CurtailableDemandSideTechnology, val) = value.id = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `max_demand_curtailment`."""
set_max_demand_curtailment!(value::CurtailableDemandSideTechnology, val) = value.max_demand_curtailment = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::CurtailableDemandSideTechnology, val) = value.power_systems_type = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `internal`."""
set_internal!(value::CurtailableDemandSideTechnology, val) = value.internal = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `segments`."""
set_segments!(value::CurtailableDemandSideTechnology, val) = value.segments = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `ext`."""
set_ext!(value::CurtailableDemandSideTechnology, val) = value.ext = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `region`."""
set_region!(value::CurtailableDemandSideTechnology, val) = value.region = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `curtailment_cost_mwh`."""
set_curtailment_cost_mwh!(value::CurtailableDemandSideTechnology, val) = value.curtailment_cost_mwh = val

function serialize_openapi_struct(technology::CurtailableDemandSideTechnology{T}, vals...) where T <: PSY.StaticInjection
    base_struct = APIServer.CurtailableDemandSideTechnology(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:CurtailableDemandSideTechnology}, vals::Dict)
    return IS.deserialize_struct(APIServer.CurtailableDemandSideTechnology, vals)
end
