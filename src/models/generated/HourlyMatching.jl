#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct HourlyMatching <: Requirement
        name::String
        id::Int64
        available::Bool
        eligible_resources::Vector{ResourceTechnology}
        eligible_demand::Vector{DemandTechnology}
        ext::Dict
        internal::InfrastructureSystemsInternal
    end

Policy requirement that all DemandSideTechnologies in `qualified_demand` must have their demand met by an equal amount of electricity generation from `qualified_supply` at all hours, such that: `sum(P)_qualified_supply >= sum(D)_qualified_demand`

# Arguments
- `name::String`: The policy name
- `id::Int64`: ID for individual policy
- `available::Bool`: Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `eligible_resources::Vector{ResourceTechnology}`: (default: `Vector{ResourceTechnology}()`) List of technologies eligible to provide hourly generation for demand side technologies.
- `eligible_demand::Vector{DemandTechnology}`: (default: `Vector{DemandTechnology}()`) List of demand side technologies that need to be met with hourly matching.
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
"""
mutable struct HourlyMatching <: Requirement
    "The policy name"
    name::String
    "ID for individual policy"
    id::Int64
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
    "List of technologies eligible to provide hourly generation for demand side technologies."
    eligible_resources::Vector{ResourceTechnology}
    "List of demand side technologies that need to be met with hourly matching."
    eligible_demand::Vector{DemandTechnology}
    "Optional dictionary to provide additional data"
    ext::Dict
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
end


function HourlyMatching(; name, id, available, eligible_resources=Vector{ResourceTechnology}(), eligible_demand=Vector{DemandTechnology}(), ext=Dict(), internal=InfrastructureSystemsInternal(), )
    HourlyMatching(name, id, available, eligible_resources, eligible_demand, ext, internal, )
end

"""Get [`HourlyMatching`](@ref) `name`."""
get_name(value::HourlyMatching) = value.name
"""Get [`HourlyMatching`](@ref) `id`."""
get_id(value::HourlyMatching) = value.id
"""Get [`HourlyMatching`](@ref) `available`."""
get_available(value::HourlyMatching) = value.available
"""Get [`HourlyMatching`](@ref) `eligible_resources`."""
get_eligible_resources(value::HourlyMatching) = value.eligible_resources
"""Get [`HourlyMatching`](@ref) `eligible_demand`."""
get_eligible_demand(value::HourlyMatching) = value.eligible_demand
"""Get [`HourlyMatching`](@ref) `ext`."""
get_ext(value::HourlyMatching) = value.ext
"""Get [`HourlyMatching`](@ref) `internal`."""
get_internal(value::HourlyMatching) = value.internal

"""Set [`HourlyMatching`](@ref) `name`."""
set_name!(value::HourlyMatching, val) = value.name = val
"""Set [`HourlyMatching`](@ref) `id`."""
set_id!(value::HourlyMatching, val) = value.id = val
"""Set [`HourlyMatching`](@ref) `available`."""
set_available!(value::HourlyMatching, val) = value.available = val
"""Set [`HourlyMatching`](@ref) `eligible_resources`."""
set_eligible_resources!(value::HourlyMatching, val) = value.eligible_resources = val
"""Set [`HourlyMatching`](@ref) `eligible_demand`."""
set_eligible_demand!(value::HourlyMatching, val) = value.eligible_demand = val
"""Set [`HourlyMatching`](@ref) `ext`."""
set_ext!(value::HourlyMatching, val) = value.ext = val
"""Set [`HourlyMatching`](@ref) `internal`."""
set_internal!(value::HourlyMatching, val) = value.internal = val

function serialize_openapi_struct(technology::HourlyMatching, vals...)
    base_struct = APIServer.HourlyMatching(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:HourlyMatching}, vals::Dict)
    return IS.deserialize_struct(APIServer.HourlyMatching, vals)
end
