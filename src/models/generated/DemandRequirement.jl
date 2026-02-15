#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandRequirement{T <: PSY.StaticInjection} <: DemandTechnology
        services::Vector{PSY.Service}
        available::Bool
        name::String
        id::Int64
        value_of_lost_load::Float64
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        ext::Dict
        region::Vector{RegionTopology}
        unserved_demand_curve::PSY.ValueCurve
        peak_demand_mw::Float64
    end

Demand requirements for a region.

# Arguments
- `services::Vector{PSY.Service}`: (default: `Vector()`) Services that this technology contributes to
- `available::Bool`: (default: `true`) Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `name::String`: The technology name
- `id::Int64`: ID for individual demand requirement
- `value_of_lost_load::Float64`: Value of unserved load (USD/MWh)
- `power_systems_type::String`: Corresponding type in PowerSystems.jl to be used in PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
- `region::Vector{RegionTopology}`: (default: `Vector()`) Zone or node where the demand requirement is located
- `unserved_demand_curve::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Piecewise curve to scale the cost of unserved load based on the value of lost load
- `peak_demand_mw::Float64`: (default: `0.0`) Peak demand value of DemandRequirement. Required if timeseries data for the DemandRequirement is normalized (MW)
"""
mutable struct DemandRequirement{T <: PSY.StaticInjection} <: DemandTechnology
    "Services that this technology contributes to"
    services::Vector{PSY.Service}
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
    "The technology name"
    name::String
    "ID for individual demand requirement"
    id::Int64
    "Value of unserved load (USD/MWh)"
    value_of_lost_load::Float64
    "Corresponding type in PowerSystems.jl to be used in PCM modeling"
    power_systems_type::String
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
    "Optional dictionary to provide additional data"
    ext::Dict
    "Zone or node where the demand requirement is located"
    region::Vector{RegionTopology}
    "Piecewise curve to scale the cost of unserved load based on the value of lost load"
    unserved_demand_curve::PSY.ValueCurve
    "Peak demand value of DemandRequirement. Required if timeseries data for the DemandRequirement is normalized (MW)"
    peak_demand_mw::Float64
end


function DemandRequirement{T}(; services=Vector(), available=true, name, id, value_of_lost_load, power_systems_type, internal=InfrastructureSystemsInternal(), ext=Dict(), region=Vector(), unserved_demand_curve=LinearCurve(0.0), peak_demand_mw=0.0, ) where T <: PSY.StaticInjection
    DemandRequirement{T}(services, available, name, id, value_of_lost_load, power_systems_type, internal, ext, region, unserved_demand_curve, peak_demand_mw, )
end

"""Get [`DemandRequirement`](@ref) `services`."""
get_services(value::DemandRequirement) = value.services
"""Get [`DemandRequirement`](@ref) `available`."""
get_available(value::DemandRequirement) = value.available
"""Get [`DemandRequirement`](@ref) `name`."""
get_name(value::DemandRequirement) = value.name
"""Get [`DemandRequirement`](@ref) `id`."""
get_id(value::DemandRequirement) = value.id
"""Get [`DemandRequirement`](@ref) `value_of_lost_load`."""
get_value_of_lost_load(value::DemandRequirement) = value.value_of_lost_load
"""Get [`DemandRequirement`](@ref) `power_systems_type`."""
get_power_systems_type(value::DemandRequirement) = value.power_systems_type
"""Get [`DemandRequirement`](@ref) `internal`."""
get_internal(value::DemandRequirement) = value.internal
"""Get [`DemandRequirement`](@ref) `ext`."""
get_ext(value::DemandRequirement) = value.ext
"""Get [`DemandRequirement`](@ref) `region`."""
get_region(value::DemandRequirement) = value.region
"""Get [`DemandRequirement`](@ref) `unserved_demand_curve`."""
get_unserved_demand_curve(value::DemandRequirement) = value.unserved_demand_curve
"""Get [`DemandRequirement`](@ref) `peak_demand_mw`."""
get_peak_demand_mw(value::DemandRequirement) = value.peak_demand_mw

"""Set [`DemandRequirement`](@ref) `services`."""
set_services!(value::DemandRequirement, val) = value.services = val
"""Set [`DemandRequirement`](@ref) `available`."""
set_available!(value::DemandRequirement, val) = value.available = val
"""Set [`DemandRequirement`](@ref) `name`."""
set_name!(value::DemandRequirement, val) = value.name = val
"""Set [`DemandRequirement`](@ref) `id`."""
set_id!(value::DemandRequirement, val) = value.id = val
"""Set [`DemandRequirement`](@ref) `value_of_lost_load`."""
set_value_of_lost_load!(value::DemandRequirement, val) = value.value_of_lost_load = val
"""Set [`DemandRequirement`](@ref) `power_systems_type`."""
set_power_systems_type!(value::DemandRequirement, val) = value.power_systems_type = val
"""Set [`DemandRequirement`](@ref) `internal`."""
set_internal!(value::DemandRequirement, val) = value.internal = val
"""Set [`DemandRequirement`](@ref) `ext`."""
set_ext!(value::DemandRequirement, val) = value.ext = val
"""Set [`DemandRequirement`](@ref) `region`."""
set_region!(value::DemandRequirement, val) = value.region = val
"""Set [`DemandRequirement`](@ref) `unserved_demand_curve`."""
set_unserved_demand_curve!(value::DemandRequirement, val) = value.unserved_demand_curve = val
"""Set [`DemandRequirement`](@ref) `peak_demand_mw`."""
set_peak_demand_mw!(value::DemandRequirement, val) = value.peak_demand_mw = val

function serialize_openapi_struct(technology::DemandRequirement{T}, vals...) where T <: PSY.StaticInjection
    base_struct = APIServer.DemandRequirement(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:DemandRequirement}, vals::Dict)
    return IS.deserialize_struct(APIServer.DemandRequirement, vals)
end
