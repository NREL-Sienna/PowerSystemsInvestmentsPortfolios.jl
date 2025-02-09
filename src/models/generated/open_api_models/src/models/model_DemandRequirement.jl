# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""DemandRequirement

    DemandRequirement(;
        name=nothing,
        available=true,
        power_systems_type=nothing,
        demand_mw=0.0,
        region=nothing,
        ext=nothing,
    )

    - name::String
    - available::Bool
    - power_systems_type::String
    - demand_mw::Float64
    - region::DemandRequirementRegion
    - ext::Any
"""
Base.@kwdef mutable struct DemandRequirement <: OpenAPI.APIModel
    name::Union{Nothing, String} = nothing
    available::Union{Nothing, Bool} = true
    power_systems_type::Union{Nothing, String} = nothing
    demand_mw::Union{Nothing, Float64} = 0.0
    region = nothing # spec type: Union{ Nothing, DemandRequirementRegion }
    ext::Union{Nothing, Any} = nothing

    function DemandRequirement(name, available, power_systems_type, demand_mw, region, ext, )
        OpenAPI.validate_property(DemandRequirement, Symbol("name"), name)
        OpenAPI.validate_property(DemandRequirement, Symbol("available"), available)
        OpenAPI.validate_property(DemandRequirement, Symbol("power_systems_type"), power_systems_type)
        OpenAPI.validate_property(DemandRequirement, Symbol("demand_mw"), demand_mw)
        OpenAPI.validate_property(DemandRequirement, Symbol("region"), region)
        OpenAPI.validate_property(DemandRequirement, Symbol("ext"), ext)
        return new(name, available, power_systems_type, demand_mw, region, ext, )
    end
end # type DemandRequirement

const _property_types_DemandRequirement = Dict{Symbol,String}(Symbol("name")=>"String", Symbol("available")=>"Bool", Symbol("power_systems_type")=>"String", Symbol("demand_mw")=>"Float64", Symbol("region")=>"DemandRequirementRegion", Symbol("ext")=>"Any", )
OpenAPI.property_type(::Type{ DemandRequirement }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_DemandRequirement[name]))}

function check_required(o::DemandRequirement)
    o.name === nothing && (return false)
    o.available === nothing && (return false)
    o.power_systems_type === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ DemandRequirement }, name::Symbol, val)






end
