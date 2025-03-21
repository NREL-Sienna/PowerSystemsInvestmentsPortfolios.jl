#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct CurtailableDemandSideTechnology{T <: PSY.StaticInjection} <: Technology
        name::String
        power_systems_type::String
        curtailment_cost_mwh::PSY.ValueCurve
        curtailment_cost::PSY.ValueCurve
        internal::InfrastructureSystemsInternal
        voll::Float64
        id::Int64
        ext::Dict
        region::Union{Nothing, Vector{Region}}
        available::Bool
    end



# Arguments
- `name::String`: The technology name
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `curtailment_cost_mwh::PSY.ValueCurve`: Energy cost of curtailment
- `curtailment_cost::PSY.ValueCurve`: Fraction of VOLL for curtailment cost
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `voll::Float64`: value of lost load
- `id::Int64`: ID for demand side technology
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `region::Union{Nothing, Vector{Region}}`: (default: `Vector()`) Region
- `available::Bool`: identifies whether the technology is available
"""
mutable struct CurtailableDemandSideTechnology{T <: PSY.StaticInjection} <: Technology
    "The technology name"
    name::String
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Energy cost of curtailment"
    curtailment_cost_mwh::PSY.ValueCurve
    "Fraction of VOLL for curtailment cost"
    curtailment_cost::PSY.ValueCurve
    "Internal field"
    internal::InfrastructureSystemsInternal
    "value of lost load"
    voll::Float64
    "ID for demand side technology"
    id::Int64
    "Option for providing additional data"
    ext::Dict
    "Region"
    region::Union{Nothing, Vector{Region}}
    "identifies whether the technology is available"
    available::Bool
end


function CurtailableDemandSideTechnology{T}(; name, power_systems_type, curtailment_cost_mwh, curtailment_cost, internal=InfrastructureSystemsInternal(), voll, id, ext=Dict(), region=Vector(), available, ) where T <: PSY.StaticInjection
    CurtailableDemandSideTechnology{T}(name, power_systems_type, curtailment_cost_mwh, curtailment_cost, internal, voll, id, ext, region, available, )
end

"""Get [`CurtailableDemandSideTechnology`](@ref) `name`."""
get_name(value::CurtailableDemandSideTechnology) = value.name
"""Get [`CurtailableDemandSideTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::CurtailableDemandSideTechnology) = value.power_systems_type
"""Get [`CurtailableDemandSideTechnology`](@ref) `curtailment_cost_mwh`."""
get_curtailment_cost_mwh(value::CurtailableDemandSideTechnology) = value.curtailment_cost_mwh
"""Get [`CurtailableDemandSideTechnology`](@ref) `curtailment_cost`."""
get_curtailment_cost(value::CurtailableDemandSideTechnology) = value.curtailment_cost
"""Get [`CurtailableDemandSideTechnology`](@ref) `internal`."""
get_internal(value::CurtailableDemandSideTechnology) = value.internal
"""Get [`CurtailableDemandSideTechnology`](@ref) `voll`."""
get_voll(value::CurtailableDemandSideTechnology) = value.voll
"""Get [`CurtailableDemandSideTechnology`](@ref) `id`."""
get_id(value::CurtailableDemandSideTechnology) = value.id
"""Get [`CurtailableDemandSideTechnology`](@ref) `ext`."""
get_ext(value::CurtailableDemandSideTechnology) = value.ext
"""Get [`CurtailableDemandSideTechnology`](@ref) `region`."""
get_region(value::CurtailableDemandSideTechnology) = value.region
"""Get [`CurtailableDemandSideTechnology`](@ref) `available`."""
get_available(value::CurtailableDemandSideTechnology) = value.available

"""Set [`CurtailableDemandSideTechnology`](@ref) `name`."""
set_name!(value::CurtailableDemandSideTechnology, val) = value.name = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::CurtailableDemandSideTechnology, val) = value.power_systems_type = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `curtailment_cost_mwh`."""
set_curtailment_cost_mwh!(value::CurtailableDemandSideTechnology, val) = value.curtailment_cost_mwh = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `curtailment_cost`."""
set_curtailment_cost!(value::CurtailableDemandSideTechnology, val) = value.curtailment_cost = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `internal`."""
set_internal!(value::CurtailableDemandSideTechnology, val) = value.internal = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `voll`."""
set_voll!(value::CurtailableDemandSideTechnology, val) = value.voll = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `id`."""
set_id!(value::CurtailableDemandSideTechnology, val) = value.id = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `ext`."""
set_ext!(value::CurtailableDemandSideTechnology, val) = value.ext = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `region`."""
set_region!(value::CurtailableDemandSideTechnology, val) = value.region = val
"""Set [`CurtailableDemandSideTechnology`](@ref) `available`."""
set_available!(value::CurtailableDemandSideTechnology, val) = value.available = val

function serialize_openapi_struct(technology::CurtailableDemandSideTechnology{T}, vals...) where T <: PSY.StaticInjection
    base_struct = APIServer.CurtailableDemandSideTechnology(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:CurtailableDemandSideTechnology}, vals::Dict)
    return IS.deserialize_struct(APIServer.CurtailableDemandSideTechnology, vals)
end
