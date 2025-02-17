#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct HourlyMatching <: Requirements
        name::String
        internal::InfrastructureSystemsInternal
        ext::Dict
        available::Bool
        eligible_regions::Vector{Region}
    end



# Arguments
- `name::String`: The technology name
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `available::Bool`: Availability
- `eligible_regions::Vector{Region}`: (default: `Vector{Region}()`) List of regions to be subjected to hourly matching requirements.
"""
mutable struct HourlyMatching <: Requirements
    "The technology name"
    name::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Availability"
    available::Bool
    "List of regions to be subjected to hourly matching requirements."
    eligible_regions::Vector{Region}
end


function HourlyMatching(; name, internal=InfrastructureSystemsInternal(), ext=Dict(), available, eligible_regions=Vector{Region}(), )
    HourlyMatching(name, internal, ext, available, eligible_regions, )
end

"""Get [`HourlyMatching`](@ref) `name`."""
get_name(value::HourlyMatching) = value.name
"""Get [`HourlyMatching`](@ref) `internal`."""
get_internal(value::HourlyMatching) = value.internal
"""Get [`HourlyMatching`](@ref) `ext`."""
get_ext(value::HourlyMatching) = value.ext
"""Get [`HourlyMatching`](@ref) `available`."""
get_available(value::HourlyMatching) = value.available
"""Get [`HourlyMatching`](@ref) `eligible_regions`."""
get_eligible_regions(value::HourlyMatching) = value.eligible_regions

"""Set [`HourlyMatching`](@ref) `name`."""
set_name!(value::HourlyMatching, val) = value.name = val
"""Set [`HourlyMatching`](@ref) `internal`."""
set_internal!(value::HourlyMatching, val) = value.internal = val
"""Set [`HourlyMatching`](@ref) `ext`."""
set_ext!(value::HourlyMatching, val) = value.ext = val
"""Set [`HourlyMatching`](@ref) `available`."""
set_available!(value::HourlyMatching, val) = value.available = val
"""Set [`HourlyMatching`](@ref) `eligible_regions`."""
set_eligible_regions!(value::HourlyMatching, val) = value.eligible_regions = val
