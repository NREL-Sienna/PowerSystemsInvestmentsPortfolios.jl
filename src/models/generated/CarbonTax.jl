#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct CarbonTax <: Requirements
        name::String
        tax_dollars_per_ton::Float64
        internal::InfrastructureSystemsInternal
        ext::Dict
        available::Bool
        eligible_regions::Vector{Region}
    end



# Arguments
- `name::String`: The technology name
- `tax_dollars_per_ton::Float64`: (default: `1.0`) Emission limit in terms of rate (USD/tCO2)
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `available::Bool`: Availability
- `eligible_regions::Vector{Region}`: (default: `Vector{Region}()`) List of regions that contribute to the carbon cap constraint.
"""
mutable struct CarbonTax <: Requirements
    "The technology name"
    name::String
    "Emission limit in terms of rate (USD/tCO2)"
    tax_dollars_per_ton::Float64
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Availability"
    available::Bool
    "List of regions that contribute to the carbon cap constraint."
    eligible_regions::Vector{Region}
end


function CarbonTax(; name, tax_dollars_per_ton=1.0, internal=InfrastructureSystemsInternal(), ext=Dict(), available, eligible_regions=Vector{Region}(), )
    CarbonTax(name, tax_dollars_per_ton, internal, ext, available, eligible_regions, )
end

"""Get [`CarbonTax`](@ref) `name`."""
get_name(value::CarbonTax) = value.name
"""Get [`CarbonTax`](@ref) `tax_dollars_per_ton`."""
get_tax_dollars_per_ton(value::CarbonTax) = value.tax_dollars_per_ton
"""Get [`CarbonTax`](@ref) `internal`."""
get_internal(value::CarbonTax) = value.internal
"""Get [`CarbonTax`](@ref) `ext`."""
get_ext(value::CarbonTax) = value.ext
"""Get [`CarbonTax`](@ref) `available`."""
get_available(value::CarbonTax) = value.available
"""Get [`CarbonTax`](@ref) `eligible_regions`."""
get_eligible_regions(value::CarbonTax) = value.eligible_regions

"""Set [`CarbonTax`](@ref) `name`."""
set_name!(value::CarbonTax, val) = value.name = val
"""Set [`CarbonTax`](@ref) `tax_dollars_per_ton`."""
set_tax_dollars_per_ton!(value::CarbonTax, val) = value.tax_dollars_per_ton = val
"""Set [`CarbonTax`](@ref) `internal`."""
set_internal!(value::CarbonTax, val) = value.internal = val
"""Set [`CarbonTax`](@ref) `ext`."""
set_ext!(value::CarbonTax, val) = value.ext = val
"""Set [`CarbonTax`](@ref) `available`."""
set_available!(value::CarbonTax, val) = value.available = val
"""Set [`CarbonTax`](@ref) `eligible_regions`."""
set_eligible_regions!(value::CarbonTax, val) = value.eligible_regions = val
