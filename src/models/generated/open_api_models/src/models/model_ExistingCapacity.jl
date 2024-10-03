# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""ExistingCapacity

    ExistingCapacity(;
        internal=nothing,
        ext=nothing,
        existing_capacity=nothing,
    )

    - internal::InfrastructureSystemsInternal : Internal field
    - ext::Dict : Option for providing additional data
    - existing_capacity::Vector{PSYGenerator} : List of individual units to map to a specific SupplyTechnology
"""
Base.@kwdef mutable struct ExistingCapacity <: OpenAPI.APIModel
    internal = nothing # spec type: Union{ Nothing, InfrastructureSystemsInternal }
    ext::Union{Nothing, Dict} = nothing
    existing_capacity = nothing # spec type: Union{ Nothing, Vector{PSYGenerator} }

    function ExistingCapacity(internal, ext, existing_capacity, )
        OpenAPI.validate_property(ExistingCapacity, Symbol("internal"), internal)
        OpenAPI.validate_property(ExistingCapacity, Symbol("ext"), ext)
        OpenAPI.validate_property(ExistingCapacity, Symbol("existing_capacity"), existing_capacity)
        return new(internal, ext, existing_capacity, )
    end
end # type ExistingCapacity

const _property_types_ExistingCapacity = Dict{Symbol,String}(Symbol("internal")=>"InfrastructureSystemsInternal", Symbol("ext")=>"Dict", Symbol("existing_capacity")=>"Vector{PSYGenerator}", )
OpenAPI.property_type(::Type{ ExistingCapacity }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_ExistingCapacity[name]))}

function check_required(o::ExistingCapacity)
    o.existing_capacity === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ ExistingCapacity }, name::Symbol, val)
end