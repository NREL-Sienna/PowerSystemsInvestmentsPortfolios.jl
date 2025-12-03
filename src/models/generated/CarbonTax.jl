#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct CarbonTax <: Requirement
        name::String
        target_year::Int64
        tax_dollars_per_ton::Float64
        internal::InfrastructureSystemsInternal
        id::Int64
        ext::Dict
        available::Bool
        eligible_regions::Vector{RegionTopology}
    end

Policy requirement that defines an additional cost penalty per ton of CO2 produced in the target in the eligible regions

# Arguments
- `name::String`: The requirement name
- `target_year::Int64`: (default: `2050`) Year in which carbon tax will be applied
- `tax_dollars_per_ton::Float64`: (default: `0.0`) Cost penalty per ton of CO2 emitted by technologies in the eligible regions during the target year (USD/tCO2)
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
- `id::Int64`: ID for individual policy
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `available::Bool`: Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `eligible_regions::Vector{RegionTopology}`: (default: `Vector{RegionTopology}()`) List of regions that contribute to the carbon cap constraint.
"""
mutable struct CarbonTax <: Requirement
    "The requirement name"
    name::String
    "Year in which carbon tax will be applied"
    target_year::Int64
    "Cost penalty per ton of CO2 emitted by technologies in the eligible regions during the target year (USD/tCO2)"
    tax_dollars_per_ton::Float64
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
    "ID for individual policy"
    id::Int64
    "Optional dictionary to provide additional data"
    ext::Dict
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
    "List of regions that contribute to the carbon cap constraint."
    eligible_regions::Vector{RegionTopology}
end


function CarbonTax(; name, target_year=2050, tax_dollars_per_ton=0.0, internal=InfrastructureSystemsInternal(), id, ext=Dict(), available, eligible_regions=Vector{RegionTopology}(), )
    CarbonTax(name, target_year, tax_dollars_per_ton, internal, id, ext, available, eligible_regions, )
end

"""Get [`CarbonTax`](@ref) `name`."""
get_name(value::CarbonTax) = value.name
"""Get [`CarbonTax`](@ref) `target_year`."""
get_target_year(value::CarbonTax) = value.target_year
"""Get [`CarbonTax`](@ref) `tax_dollars_per_ton`."""
get_tax_dollars_per_ton(value::CarbonTax) = value.tax_dollars_per_ton
"""Get [`CarbonTax`](@ref) `internal`."""
get_internal(value::CarbonTax) = value.internal
"""Get [`CarbonTax`](@ref) `id`."""
get_id(value::CarbonTax) = value.id
"""Get [`CarbonTax`](@ref) `ext`."""
get_ext(value::CarbonTax) = value.ext
"""Get [`CarbonTax`](@ref) `available`."""
get_available(value::CarbonTax) = value.available
"""Get [`CarbonTax`](@ref) `eligible_regions`."""
get_eligible_regions(value::CarbonTax) = value.eligible_regions

"""Set [`CarbonTax`](@ref) `name`."""
set_name!(value::CarbonTax, val) = value.name = val
"""Set [`CarbonTax`](@ref) `target_year`."""
set_target_year!(value::CarbonTax, val) = value.target_year = val
"""Set [`CarbonTax`](@ref) `tax_dollars_per_ton`."""
set_tax_dollars_per_ton!(value::CarbonTax, val) = value.tax_dollars_per_ton = val
"""Set [`CarbonTax`](@ref) `internal`."""
set_internal!(value::CarbonTax, val) = value.internal = val
"""Set [`CarbonTax`](@ref) `id`."""
set_id!(value::CarbonTax, val) = value.id = val
"""Set [`CarbonTax`](@ref) `ext`."""
set_ext!(value::CarbonTax, val) = value.ext = val
"""Set [`CarbonTax`](@ref) `available`."""
set_available!(value::CarbonTax, val) = value.available = val
"""Set [`CarbonTax`](@ref) `eligible_regions`."""
set_eligible_regions!(value::CarbonTax, val) = value.eligible_regions = val

function serialize_openapi_struct(technology::CarbonTax, vals...)
    base_struct = APIServer.CarbonTax(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:CarbonTax}, vals::Dict)
    return IS.deserialize_struct(APIServer.CarbonTax, vals)
end
