#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct HourlyMatching <: Requirement
        name::String
        internal::InfrastructureSystemsInternal
        id::Int64
        ext::Dict
        available::Bool
    end

Policy requirement that all DemandSideTechnologies in `qualified_demand` must have their demand met by an equal amount of electricity generation from `qualified_supply` at all hours, such that: `sum(P)_qualified_supply >= sum(D)_qualified_demand`

# Arguments
- `name::String`: The policy name
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
- `id::Int64`: ID for individual policy
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `available::Bool`: Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
"""
mutable struct HourlyMatching <: Requirement
    "The policy name"
    name::String
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
    "ID for individual policy"
    id::Int64
    "Optional dictionary to provide additional data"
    ext::Dict
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
end


function HourlyMatching(; name, internal=InfrastructureSystemsInternal(), id, ext=Dict(), available, )
    HourlyMatching(name, internal, id, ext, available, )
end

"""Get [`HourlyMatching`](@ref) `name`."""
get_name(value::HourlyMatching) = value.name
"""Get [`HourlyMatching`](@ref) `internal`."""
get_internal(value::HourlyMatching) = value.internal
"""Get [`HourlyMatching`](@ref) `id`."""
get_id(value::HourlyMatching) = value.id
"""Get [`HourlyMatching`](@ref) `ext`."""
get_ext(value::HourlyMatching) = value.ext
"""Get [`HourlyMatching`](@ref) `available`."""
get_available(value::HourlyMatching) = value.available

"""Set [`HourlyMatching`](@ref) `name`."""
set_name!(value::HourlyMatching, val) = value.name = val
"""Set [`HourlyMatching`](@ref) `internal`."""
set_internal!(value::HourlyMatching, val) = value.internal = val
"""Set [`HourlyMatching`](@ref) `id`."""
set_id!(value::HourlyMatching, val) = value.id = val
"""Set [`HourlyMatching`](@ref) `ext`."""
set_ext!(value::HourlyMatching, val) = value.ext = val
"""Set [`HourlyMatching`](@ref) `available`."""
set_available!(value::HourlyMatching, val) = value.available = val

function serialize_openapi_struct(technology::HourlyMatching, vals...)
    base_struct = APIServer.HourlyMatching(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:HourlyMatching}, vals::Dict)
    return IS.deserialize_struct(APIServer.HourlyMatching, vals)
end
