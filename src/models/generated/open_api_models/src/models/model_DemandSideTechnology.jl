# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.

@doc raw"""DemandSideTechnology

    DemandSideTechnology(;
        name=nothing,
        available=nothing,
        power_systems_type=nothing,
        technology_efficiency=0.0,
        price_per_unit=0.0,
        min_power=0.0,
        ramp_up_percentage=1.0,
        ramp_dn_percentage=1.0,
    )

    - name::String
    - available::Bool
    - power_systems_type::String
    - technology_efficiency::Float64
    - price_per_unit::Float64
    - min_power::Float64
    - ramp_up_percentage::Float64
    - ramp_dn_percentage::Float64
"""
Base.@kwdef mutable struct DemandSideTechnology <: OpenAPI.APIModel
    name::Union{Nothing, String} = nothing
    available::Union{Nothing, Bool} = nothing
    power_systems_type::Union{Nothing, String} = nothing
    technology_efficiency::Union{Nothing, Float64} = 0.0
    price_per_unit::Union{Nothing, Float64} = 0.0
    min_power::Union{Nothing, Float64} = 0.0
    ramp_up_percentage::Union{Nothing, Float64} = 1.0
    ramp_dn_percentage::Union{Nothing, Float64} = 1.0

    function DemandSideTechnology(
        name,
        available,
        power_systems_type,
        technology_efficiency,
        price_per_unit,
        min_power,
        ramp_up_percentage,
        ramp_dn_percentage,
    )
        OpenAPI.validate_property(DemandSideTechnology, Symbol("name"), name)
        OpenAPI.validate_property(DemandSideTechnology, Symbol("available"), available)
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
        OpenAPI.validate_property(
            DemandSideTechnology,
            Symbol("ramp_up_percentage"),
            ramp_up_percentage,
        )
        OpenAPI.validate_property(
            DemandSideTechnology,
            Symbol("ramp_dn_percentage"),
            ramp_dn_percentage,
        )
        return new(
            name,
            available,
            power_systems_type,
            technology_efficiency,
            price_per_unit,
            min_power,
            ramp_up_percentage,
            ramp_dn_percentage,
        )
    end
end # type DemandSideTechnology

const _property_types_DemandSideTechnology = Dict{Symbol, String}(
    Symbol("name") => "String",
    Symbol("available") => "Bool",
    Symbol("power_systems_type") => "String",
    Symbol("technology_efficiency") => "Float64",
    Symbol("price_per_unit") => "Float64",
    Symbol("min_power") => "Float64",
    Symbol("ramp_up_percentage") => "Float64",
    Symbol("ramp_dn_percentage") => "Float64",
)
OpenAPI.property_type(::Type{DemandSideTechnology}, name::Symbol) =
    Union{Nothing, eval(Base.Meta.parse(_property_types_DemandSideTechnology[name]))}

function check_required(o::DemandSideTechnology)
    o.name === nothing && (return false)
    o.available === nothing && (return false)
    o.power_systems_type === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{DemandSideTechnology}, name::Symbol, val)
end
