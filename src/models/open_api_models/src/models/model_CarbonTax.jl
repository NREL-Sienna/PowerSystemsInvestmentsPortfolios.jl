# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.

@doc raw"""CarbonTax

    CarbonTax(;
        name=nothing,
        id=nothing,
        available=nothing,
        eligible_regions=nothing,
        tax_dollars_per_ton=0.0,
    )

    - name::String
    - id::Int64
    - available::Bool
    - eligible_regions::Vector{Int64}
    - tax_dollars_per_ton::Float64
"""
Base.@kwdef mutable struct CarbonTax <: OpenAPI.APIModel
    name::Union{Nothing, String} = nothing
    id::Union{Nothing, Int64} = nothing
    available::Union{Nothing, Bool} = nothing
    eligible_regions::Union{Nothing, Vector{Int64}} = nothing
    tax_dollars_per_ton::Union{Nothing, Float64} = 0.0

    function CarbonTax(name, id, available, eligible_regions, tax_dollars_per_ton)
        OpenAPI.validate_property(CarbonTax, Symbol("name"), name)
        OpenAPI.validate_property(CarbonTax, Symbol("id"), id)
        OpenAPI.validate_property(CarbonTax, Symbol("available"), available)
        OpenAPI.validate_property(CarbonTax, Symbol("eligible_regions"), eligible_regions)
        OpenAPI.validate_property(
            CarbonTax,
            Symbol("tax_dollars_per_ton"),
            tax_dollars_per_ton,
        )
        return new(name, id, available, eligible_regions, tax_dollars_per_ton)
    end
end # type CarbonTax

const _property_types_CarbonTax = Dict{Symbol, String}(
    Symbol("name") => "String",
    Symbol("id") => "Int64",
    Symbol("available") => "Bool",
    Symbol("eligible_regions") => "Vector{Int64}",
    Symbol("tax_dollars_per_ton") => "Float64",
)
OpenAPI.property_type(::Type{CarbonTax}, name::Symbol) =
    Union{Nothing, eval(Base.Meta.parse(_property_types_CarbonTax[name]))}

function check_required(o::CarbonTax)
    o.name === nothing && (return false)
    o.available === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{CarbonTax}, name::Symbol, val) end
