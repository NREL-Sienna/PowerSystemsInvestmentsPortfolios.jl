#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandRequirement{T <: PSY.StaticInjection} <: Technology
        name::String
        internal::InfrastructureSystemsInternal
        demand_mw_z::Float64
        value_lost_load::Float64
        cost_of_curtailment_mw::Union{Float64, Dict{Int64, Float64}}
        cost_of_curtailment_mwh::Union{Float64, Dict{Int64, Float64}}
        max_curtailment::Union{Float64, Dict{Int64, Float64}}
        region::String
        ext::Dict
        available::Bool
    end



# Arguments
- `name::String`: The technology name
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `demand_mw_z::Float64`: (default: `0.0`) Demand profile in MW
- `value_lost_load::Float64`: (default: `0.0`) Value of lost load/non-served energy (USD/MWh)
- `cost_of_curtailment_mw::Union{Float64, Dict{Int64, Float64}}`: (default: `0.0`) Cost of non-served energy, fraction of value of lost load
- `cost_of_curtailment_mwh::Union{Float64, Dict{Int64, Float64}}`: (default: `0.0`) Cost of non-served energy, fraction of value of lost load
- `max_curtailment::Union{Float64, Dict{Int64, Float64}}`: (default: `0.0`) Maximum percentage of demand that can be curtailed in an investment period
- `region::String`: Corresponding region for peak demand
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `available::Bool`: (default: `true`) identifies whether the technology is available
"""
mutable struct DemandRequirement{T <: PSY.StaticInjection} <: Technology
    "The technology name"
    name::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Demand profile in MW"
    demand_mw_z::Float64
    "Value of lost load/non-served energy (USD/MWh)"
    value_lost_load::Float64
    "Cost of non-served energy, fraction of value of lost load"
    cost_of_curtailment_mw::Union{Float64, Dict{Int64, Float64}}
    "Cost of non-served energy, fraction of value of lost load"
    cost_of_curtailment_mwh::Union{Float64, Dict{Int64, Float64}}
    "Maximum percentage of demand that can be curtailed in an investment period"
    max_curtailment::Union{Float64, Dict{Int64, Float64}}
    "Corresponding region for peak demand"
    region::String
    "Option for providing additional data"
    ext::Dict
    "identifies whether the technology is available"
    available::Bool
end


function DemandRequirement{T}(; name, internal=InfrastructureSystemsInternal(), demand_mw_z=0.0, value_lost_load=0.0, cost_of_curtailment_mw=0.0, cost_of_curtailment_mwh=0.0, max_curtailment=0.0, region, ext=Dict(), available=true, ) where T <: PSY.StaticInjection
    DemandRequirement{T}(name, internal, demand_mw_z, value_lost_load, cost_of_curtailment_mw, cost_of_curtailment_mwh, max_curtailment, region, ext, available, )
end

"""Get [`DemandRequirement`](@ref) `name`."""
get_name(value::DemandRequirement) = value.name
"""Get [`DemandRequirement`](@ref) `internal`."""
get_internal(value::DemandRequirement) = value.internal
"""Get [`DemandRequirement`](@ref) `demand_mw_z`."""
get_demand_mw_z(value::DemandRequirement) = value.demand_mw_z
"""Get [`DemandRequirement`](@ref) `value_lost_load`."""
get_value_lost_load(value::DemandRequirement) = value.value_lost_load
"""Get [`DemandRequirement`](@ref) `cost_of_curtailment_mw`."""
get_cost_of_curtailment_mw(value::DemandRequirement) = value.cost_of_curtailment_mw
"""Get [`DemandRequirement`](@ref) `cost_of_curtailment_mwh`."""
get_cost_of_curtailment_mwh(value::DemandRequirement) = value.cost_of_curtailment_mwh
"""Get [`DemandRequirement`](@ref) `max_curtailment`."""
get_max_curtailment(value::DemandRequirement) = value.max_curtailment
"""Get [`DemandRequirement`](@ref) `region`."""
get_region(value::DemandRequirement) = value.region
"""Get [`DemandRequirement`](@ref) `ext`."""
get_ext(value::DemandRequirement) = value.ext
"""Get [`DemandRequirement`](@ref) `available`."""
get_available(value::DemandRequirement) = value.available

"""Set [`DemandRequirement`](@ref) `name`."""
set_name!(value::DemandRequirement, val) = value.name = val
"""Set [`DemandRequirement`](@ref) `internal`."""
set_internal!(value::DemandRequirement, val) = value.internal = val
"""Set [`DemandRequirement`](@ref) `demand_mw_z`."""
set_demand_mw_z!(value::DemandRequirement, val) = value.demand_mw_z = val
"""Set [`DemandRequirement`](@ref) `value_lost_load`."""
set_value_lost_load!(value::DemandRequirement, val) = value.value_lost_load = val
"""Set [`DemandRequirement`](@ref) `cost_of_curtailment_mw`."""
set_cost_of_curtailment_mw!(value::DemandRequirement, val) = value.cost_of_curtailment_mw = val
"""Set [`DemandRequirement`](@ref) `cost_of_curtailment_mwh`."""
set_cost_of_curtailment_mwh!(value::DemandRequirement, val) = value.cost_of_curtailment_mwh = val
"""Set [`DemandRequirement`](@ref) `max_curtailment`."""
set_max_curtailment!(value::DemandRequirement, val) = value.max_curtailment = val
"""Set [`DemandRequirement`](@ref) `region`."""
set_region!(value::DemandRequirement, val) = value.region = val
"""Set [`DemandRequirement`](@ref) `ext`."""
set_ext!(value::DemandRequirement, val) = value.ext = val
"""Set [`DemandRequirement`](@ref) `available`."""
set_available!(value::DemandRequirement, val) = value.available = val
