# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.

@doc raw"""DemandSideTechnology

    DemandSideTechnology(;
        name=nothing,
        id=nothing,
        available=nothing,
        region=nothing,
        power_systems_type=nothing,
        technology_efficiency=0.0,
        price_per_unit=0.0,
        min_power=0.0,
    )

    - name::String
    - id::Int64
    - available::Bool
    - region::Vector{Int64}
    - power_systems_type::String
    - technology_efficiency::Float64
    - price_per_unit::Float64
    - min_power::Float64
"""
Base.@kwdef mutable struct DemandSideTechnology <: OpenAPI.APIModel
    name::Union{Nothing, String} = nothing
    id::Union{Nothing, Int64} = nothing
    available::Union{Nothing, Bool} = nothing
    region::Union{Nothing, Vector{Int64}} = nothing
    power_systems_type::Union{Nothing, String} = nothing
    technology_efficiency::Union{Nothing, Float64} = 0.0
    price_per_unit::Union{Nothing, Float64} = 0.0
    min_power::Union{Nothing, Float64} = 0.0

    function DemandSideTechnology(
        name,
        id,
        available,
        region,
        power_systems_type,
        technology_efficiency,
        price_per_unit,
        min_power,
    )
        OpenAPI.validate_property(DemandSideTechnology, Symbol("name"), name)
        OpenAPI.validate_property(DemandSideTechnology, Symbol("id"), id)
        OpenAPI.validate_property(DemandSideTechnology, Symbol("available"), available)
        OpenAPI.validate_property(DemandSideTechnology, Symbol("region"), region)
        OpenAPI.validate_property(
            DemandSideTechnology,
            Symbol("power_systems_type"),
            power_systems_type,
        )
        OpenAPI.validate_property(
            DemandSideTechnology,
            Symbol("technology_efficiency"),
            technology_efficiency,
        )
        OpenAPI.validate_property(
            DemandSideTechnology,
            Symbol("price_per_unit"),
            price_per_unit,
        )
        OpenAPI.validate_property(DemandSideTechnology, Symbol("min_power"), min_power)
        return new(
            name,
            id,
            available,
            region,
            power_systems_type,
            technology_efficiency,
            price_per_unit,
            min_power,
        )
    end
end # type DemandSideTechnology

const _property_types_DemandSideTechnology = Dict{Symbol, String}(
    Symbol("name") => "String",
    Symbol("id") => "Int64",
    Symbol("available") => "Bool",
    Symbol("region") => "Vector{Int64}",
    Symbol("power_systems_type") => "String",
    Symbol("technology_efficiency") => "Float64",
    Symbol("price_per_unit") => "Float64",
    Symbol("min_power") => "Float64",
)
OpenAPI.property_type(::Type{DemandSideTechnology}, name::Symbol) =
    Union{Nothing, eval(Base.Meta.parse(_property_types_DemandSideTechnology[name]))}

function check_required(o::DemandSideTechnology)
    o.name === nothing && (return false)
    o.available === nothing && (return false)
    o.power_systems_type === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{DemandSideTechnology}, name::Symbol, val) end
