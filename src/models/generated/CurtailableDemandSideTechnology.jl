#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct CurtailableDemandSideTechnology{T <: PSY.StaticInjection} <: Technology
        name::String
        curtailment_cost_mwh::Vector{Float64}
        internal::InfrastructureSystemsInternal
        segments::Vector{Int64}
        curtailment_cost::Vector{Float64}
        voll::Float64
        ext::Dict
        max_demand_curtailment::Vector{Float64}
        available::Bool
    end



# Arguments
- `name::String`: The technology name
- `curtailment_cost_mwh::Vector{Float64}`: Energy cost of curtailment
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `segments::Vector{Int64}`: Demand segment IDs
- `curtailment_cost::Vector{Float64}`: Fraction of VOLL for curtailment cost
- `voll::Float64`: value of lost load
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `max_demand_curtailment::Vector{Float64}`: percent of demand that can be curtailed in that segment
- `available::Bool`: identifies whether the technology is available
"""
mutable struct CurtailableDemandSideTechnology{T <: PSY.StaticInjection} <: Technology
    "The technology name"
    name::String
    "Energy cost of curtailment"
    curtailment_cost_mwh::Vector{Float64}
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Demand segment IDs"
    segments::Vector{Int64}
    "Fraction of VOLL for curtailment cost"
    curtailment_cost::Vector{Float64}
    "value of lost load"
    voll::Float64
    "Option for providing additional data"
    ext::Dict
    "percent of demand that can be curtailed in that segment"
    max_demand_curtailment::Vector{Float64}
    "identifies whether the technology is available"
    available::Bool
end


function CurtailableDemandSideTechnology{T}(; name, curtailment_cost_mwh, internal=InfrastructureSystemsInternal(), segments, curtailment_cost, voll, ext=Dict(), max_demand_curtailment, available, ) where T <: PSY.StaticInjection
    CurtailableDemandSideTechnology{T}(name, curtailment_cost_mwh, internal, segments, curtailment_cost, voll, ext, max_demand_curtailment, available, )
end

"""Get [`CurtailableDemandSideTechnology`](@ref) `name`."""
get_name(value::CurtailableDemandSideTechnology) = value.name
"""Get [`CurtailableDemandSideTechnology`](@ref) `curtailment_cost_mwh`."""
get_curtailment_cost_mwh(value::CurtailableDemandSideTechnology) = value.curtailment_cost_mwh
"""Get [`CurtailableDemandSideTechnology`](@ref) `internal`."""
get_internal(value::CurtailableDemandSideTechnology) = value.internal
"""Get [`CurtailableDemandSideTechnology`](@ref) `segments`."""
get_segments(value::CurtailableDemandSideTechnology) = value.segments
"""Get [`CurtailableDemandSideTechnology`](@ref) `curtailment_cost`."""
get_curtailment_cost(value::CurtailableDemandSideTechnology) = value.curtailment_cost
"""Get [`CurtailableDemandSideTechnology`](@ref) `voll`."""
get_voll(value::CurtailableDemandSideTechnology) = value.voll
"""Get [`CurtailableDemandSideTechnology`](@ref) `ext`."""
get_ext(value::CurtailableDemandSideTechnology) = value.ext
"""Get [`CurtailableDemandSideTechnology`](@ref) `max_demand_curtailment`."""
get_max_demand_curtailment(value::CurtailableDemandSideTechnology) = value.max_demand_curtailment
"""Get [`CurtailableDemandSideTechnology`](@ref) `available`."""
get_available(value::CurtailableDemandSideTechnology) = value.available

"""Set [`CurtailableDemandSideTechnology`](@ref) `name`."""
set_name!(value::CurtailableDemandSideTechnology, val) = value.name = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `curtailment_cost_mwh`."""
set_curtailment_cost_mwh!(value::CurtailableDemandSideTechnology, val) = value.curtailment_cost_mwh = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `internal`."""
set_internal!(value::CurtailableDemandSideTechnology, val) = value.internal = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `segments`."""
set_segments!(value::CurtailableDemandSideTechnology, val) = value.segments = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `curtailment_cost`."""
set_curtailment_cost!(value::CurtailableDemandSideTechnology, val) = value.curtailment_cost = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `voll`."""
set_voll!(value::CurtailableDemandSideTechnology, val) = value.voll = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `ext`."""
set_ext!(value::CurtailableDemandSideTechnology, val) = value.ext = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `max_demand_curtailment`."""
set_max_demand_curtailment!(value::CurtailableDemandSideTechnology, val) = value.max_demand_curtailment = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `available`."""
set_available!(value::CurtailableDemandSideTechnology, val) = value.available = val
