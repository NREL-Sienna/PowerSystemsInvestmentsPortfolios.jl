# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""CurtailableDemandSideTechnology

    CurtailableDemandSideTechnology(;
        name=nothing,
        available=nothing,
        power_systems_type=nothing,
        voll=nothing,
        segments=nothing,
        curtailment_cost=nothing,
        max_demand_curtailment=nothing,
        curtailment_cost_mwh=nothing,
        ext=nothing,
    )

    - name::String
    - available::Bool
    - power_systems_type::String
    - voll::Float64
    - segments::Vector{Int64}
    - curtailment_cost::Vector{Float64}
    - max_demand_curtailment::Vector{Float64}
    - curtailment_cost_mwh::Vector{Float64}
    - ext::Any
"""
Base.@kwdef mutable struct CurtailableDemandSideTechnology <: OpenAPI.APIModel
    name::Union{Nothing, String} = nothing
    available::Union{Nothing, Bool} = nothing
    power_systems_type::Union{Nothing, String} = nothing
    voll::Union{Nothing, Float64} = nothing
    segments::Union{Nothing, Vector{Int64}} = nothing
    curtailment_cost::Union{Nothing, Vector{Float64}} = nothing
    max_demand_curtailment::Union{Nothing, Vector{Float64}} = nothing
    curtailment_cost_mwh::Union{Nothing, Vector{Float64}} = nothing
    ext::Union{Nothing, Any} = nothing

    function CurtailableDemandSideTechnology(name, available, power_systems_type, voll, segments, curtailment_cost, max_demand_curtailment, curtailment_cost_mwh, ext, )
        OpenAPI.validate_property(CurtailableDemandSideTechnology, Symbol("name"), name)
        OpenAPI.validate_property(CurtailableDemandSideTechnology, Symbol("available"), available)
        OpenAPI.validate_property(CurtailableDemandSideTechnology, Symbol("power_systems_type"), power_systems_type)
        OpenAPI.validate_property(CurtailableDemandSideTechnology, Symbol("voll"), voll)
        OpenAPI.validate_property(CurtailableDemandSideTechnology, Symbol("segments"), segments)
        OpenAPI.validate_property(CurtailableDemandSideTechnology, Symbol("curtailment_cost"), curtailment_cost)
        OpenAPI.validate_property(CurtailableDemandSideTechnology, Symbol("max_demand_curtailment"), max_demand_curtailment)
        OpenAPI.validate_property(CurtailableDemandSideTechnology, Symbol("curtailment_cost_mwh"), curtailment_cost_mwh)
        OpenAPI.validate_property(CurtailableDemandSideTechnology, Symbol("ext"), ext)
        return new(name, available, power_systems_type, voll, segments, curtailment_cost, max_demand_curtailment, curtailment_cost_mwh, ext, )
    end
end # type CurtailableDemandSideTechnology

const _property_types_CurtailableDemandSideTechnology = Dict{Symbol,String}(Symbol("name")=>"String", Symbol("available")=>"Bool", Symbol("power_systems_type")=>"String", Symbol("voll")=>"Float64", Symbol("segments")=>"Vector{Int64}", Symbol("curtailment_cost")=>"Vector{Float64}", Symbol("max_demand_curtailment")=>"Vector{Float64}", Symbol("curtailment_cost_mwh")=>"Vector{Float64}", Symbol("ext")=>"Any", )
OpenAPI.property_type(::Type{ CurtailableDemandSideTechnology }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_CurtailableDemandSideTechnology[name]))}

function check_required(o::CurtailableDemandSideTechnology)
    o.name === nothing && (return false)
    o.available === nothing && (return false)
    o.power_systems_type === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ CurtailableDemandSideTechnology }, name::Symbol, val)









end
