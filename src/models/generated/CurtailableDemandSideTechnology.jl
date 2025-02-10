#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct CurtailableDemandSideTechnology{T <: PSY.StaticInjection} <: Technology
        name::String
        power_systems_type::String
        curtailment_cost_mwh::Vector{Float64}
        segments::Vector{Int64}
        curtailment_cost::Vector{Float64}
        voll::Float64
        ext::Dict
        internal::InfrastructureSystemsInternal
        max_demand_curtailment::Vector{Float64}
        available::Bool
    end



# Arguments
- `name::String`: The technology name
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `curtailment_cost_mwh::Vector{Float64}`: Energy cost of curtailment
- `segments::Vector{Int64}`: Demand segment IDs
- `curtailment_cost::Vector{Float64}`: Fraction of VOLL for curtailment cost
- `voll::Float64`: value of lost load
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `max_demand_curtailment::Vector{Float64}`: percent of demand that can be curtailed in that segment
- `available::Bool`: identifies whether the technology is available
"""
mutable struct CurtailableDemandSideTechnology{T <: PSY.StaticInjection} <: Technology
    "The technology name"
    name::String
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Energy cost of curtailment"
    curtailment_cost_mwh::Vector{Float64}
    "Demand segment IDs"
    segments::Vector{Int64}
    "Fraction of VOLL for curtailment cost"
    curtailment_cost::Vector{Float64}
    "value of lost load"
    voll::Float64
    "Option for providing additional data"
    ext::Dict
    "Internal field"
    internal::InfrastructureSystemsInternal
    "percent of demand that can be curtailed in that segment"
    max_demand_curtailment::Vector{Float64}
    "identifies whether the technology is available"
    available::Bool
end


function CurtailableDemandSideTechnology{T}(; name, power_systems_type, curtailment_cost_mwh, segments, curtailment_cost, voll, ext=Dict(), internal=InfrastructureSystemsInternal(), max_demand_curtailment, available, ) where T <: PSY.StaticInjection
    CurtailableDemandSideTechnology{T}(name, power_systems_type, curtailment_cost_mwh, segments, curtailment_cost, voll, ext, internal, max_demand_curtailment, available, )
end

"""Get [`CurtailableDemandSideTechnology`](@ref) `name`."""
get_name(value::CurtailableDemandSideTechnology) = value.name
"""Get [`CurtailableDemandSideTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::CurtailableDemandSideTechnology) = value.power_systems_type
"""Get [`CurtailableDemandSideTechnology`](@ref) `curtailment_cost_mwh`."""
get_curtailment_cost_mwh(value::CurtailableDemandSideTechnology) = value.curtailment_cost_mwh
"""Get [`CurtailableDemandSideTechnology`](@ref) `segments`."""
get_segments(value::CurtailableDemandSideTechnology) = value.segments
"""Get [`CurtailableDemandSideTechnology`](@ref) `curtailment_cost`."""
get_curtailment_cost(value::CurtailableDemandSideTechnology) = value.curtailment_cost
"""Get [`CurtailableDemandSideTechnology`](@ref) `voll`."""
get_voll(value::CurtailableDemandSideTechnology) = value.voll
"""Get [`CurtailableDemandSideTechnology`](@ref) `ext`."""
get_ext(value::CurtailableDemandSideTechnology) = value.ext
"""Get [`CurtailableDemandSideTechnology`](@ref) `internal`."""
get_internal(value::CurtailableDemandSideTechnology) = value.internal
"""Get [`CurtailableDemandSideTechnology`](@ref) `max_demand_curtailment`."""
get_max_demand_curtailment(value::CurtailableDemandSideTechnology) = value.max_demand_curtailment
"""Get [`CurtailableDemandSideTechnology`](@ref) `available`."""
get_available(value::CurtailableDemandSideTechnology) = value.available

"""Set [`CurtailableDemandSideTechnology`](@ref) `name`."""
set_name!(value::CurtailableDemandSideTechnology, val) = value.name = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::CurtailableDemandSideTechnology, val) = value.power_systems_type = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `curtailment_cost_mwh`."""
set_curtailment_cost_mwh!(value::CurtailableDemandSideTechnology, val) = value.curtailment_cost_mwh = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `segments`."""
set_segments!(value::CurtailableDemandSideTechnology, val) = value.segments = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `curtailment_cost`."""
set_curtailment_cost!(value::CurtailableDemandSideTechnology, val) = value.curtailment_cost = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `voll`."""
set_voll!(value::CurtailableDemandSideTechnology, val) = value.voll = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `ext`."""
set_ext!(value::CurtailableDemandSideTechnology, val) = value.ext = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `internal`."""
set_internal!(value::CurtailableDemandSideTechnology, val) = value.internal = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `max_demand_curtailment`."""
set_max_demand_curtailment!(value::CurtailableDemandSideTechnology, val) = value.max_demand_curtailment = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `available`."""
set_available!(value::CurtailableDemandSideTechnology, val) = value.available = val

function serialize_openapi_struct(technology::CurtailableDemandSideTechnology{T}, vals...) where T <: PSY.StaticInjection
    base_struct = APIServer.CurtailableDemandSideTechnology(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:CurtailableDemandSideTechnology}, vals...)
    base_struct = APIServer.CurtailableDemandSideTechnology(; vals...)
    return base_struct
end
