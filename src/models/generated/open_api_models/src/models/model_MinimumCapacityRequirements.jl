# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""MinimumCapacityRequirements

    MinimumCapacityRequirements(;
        name=nothing,
        power_systems_type=nothing,
        pricecap=nothing,
        internal=nothing,
        ext=nothing,
        min_mw=nothing,
        eligible_resources=nothing,
        available=nothing,
    )

    - name::String : The technology name
    - power_systems_type::String : maps to a valid PowerSystems.jl for PCM modeling
    - pricecap::Float64 : price threshold for policy constraint, USD/MW
    - internal::InfrastructureSystemsInternal : Internal field
    - ext::Dict : Option for providing additional data
    - min_mw::Float64 : Minimum total capacity across all eligible resources
    - eligible_resources::Vector{String} : List of resources that contribute to the carbon cap constraint.
    - available::Bool : Availability
"""
Base.@kwdef mutable struct MinimumCapacityRequirements <: OpenAPI.APIModel
    name::Union{Nothing, String} = nothing
    power_systems_type::Union{Nothing, String} = nothing
    pricecap::Union{Nothing, Float64} = nothing
    internal = nothing # spec type: Union{ Nothing, InfrastructureSystemsInternal }
    ext::Union{Nothing, Dict} = nothing
    min_mw::Union{Nothing, Float64} = nothing
    eligible_resources = nothing # spec type: Union{ Nothing, Vector{String} }
    available::Union{Nothing, Bool} = nothing

    function MinimumCapacityRequirements(name, power_systems_type, pricecap, internal, ext, min_mw, eligible_resources, available, )
        OpenAPI.validate_property(MinimumCapacityRequirements, Symbol("name"), name)
        OpenAPI.validate_property(MinimumCapacityRequirements, Symbol("power_systems_type"), power_systems_type)
        OpenAPI.validate_property(MinimumCapacityRequirements, Symbol("pricecap"), pricecap)
        OpenAPI.validate_property(MinimumCapacityRequirements, Symbol("internal"), internal)
        OpenAPI.validate_property(MinimumCapacityRequirements, Symbol("ext"), ext)
        OpenAPI.validate_property(MinimumCapacityRequirements, Symbol("min_mw"), min_mw)
        OpenAPI.validate_property(MinimumCapacityRequirements, Symbol("eligible_resources"), eligible_resources)
        OpenAPI.validate_property(MinimumCapacityRequirements, Symbol("available"), available)
        return new(name, power_systems_type, pricecap, internal, ext, min_mw, eligible_resources, available, )
    end
end # type MinimumCapacityRequirements

const _property_types_MinimumCapacityRequirements = Dict{Symbol,String}(Symbol("name")=>"String", Symbol("power_systems_type")=>"String", Symbol("pricecap")=>"Float64", Symbol("internal")=>"InfrastructureSystemsInternal", Symbol("ext")=>"Dict", Symbol("min_mw")=>"Float64", Symbol("eligible_resources")=>"Vector{String}", Symbol("available")=>"Bool", )
OpenAPI.property_type(::Type{ MinimumCapacityRequirements }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_MinimumCapacityRequirements[name]))}

function check_required(o::MinimumCapacityRequirements)
    o.name === nothing && (return false)
    o.available === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ MinimumCapacityRequirements }, name::Symbol, val)
end
