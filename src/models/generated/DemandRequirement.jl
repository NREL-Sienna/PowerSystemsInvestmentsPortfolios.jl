#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandRequirement{T <: PSY.StaticInjection} <: Technology
        name::String
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        demand_mw_z::Float64
        value_lost_load::Float64
        max_curtailment::Float64
        ext::Dict
        cost_of_curtailment::Float64
        region::String
        available::Bool
    end



# Arguments
- `name::String`: The technology name
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `demand_mw_z::Float64`: (default: `0.0`) Demand profile in MW
- `value_lost_load::Float64`: (default: `0.0`) Value of lost load/non-served energy (USD/MWh)
- `max_curtailment::Float64`: (default: `0.0`) Maximum percentage of demand that can be curtailed in an investment period
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `cost_of_curtailment::Float64`: (default: `0.0`) Cost of non-served energy, fraction of value of lost load
- `region::String`: Corresponding region for peak demand
- `available::Bool`: (default: `true`) identifies whether the technology is available
"""
mutable struct DemandRequirement{T <: PSY.StaticInjection} <: Technology
    "The technology name"
    name::String
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Demand profile in MW"
    demand_mw_z::Float64
    "Value of lost load/non-served energy (USD/MWh)"
    value_lost_load::Float64
    "Maximum percentage of demand that can be curtailed in an investment period"
    max_curtailment::Float64
    "Option for providing additional data"
    ext::Dict
    "Cost of non-served energy, fraction of value of lost load"
    cost_of_curtailment::Float64
    "Corresponding region for peak demand"
    region::String
    "identifies whether the technology is available"
    available::Bool
end


function DemandRequirement{T}(; name, power_systems_type, internal=InfrastructureSystemsInternal(), demand_mw_z=0.0, value_lost_load=0.0, max_curtailment=0.0, ext=Dict(), cost_of_curtailment=0.0, region, available=true, ) where T <: PSY.StaticInjection
    DemandRequirement{T}(name, power_systems_type, internal, demand_mw_z, value_lost_load, max_curtailment, ext, cost_of_curtailment, region, available, )
end

"""Get [`DemandRequirement`](@ref) `name`."""
get_name(value::DemandRequirement) = value.name
"""Get [`DemandRequirement`](@ref) `power_systems_type`."""
get_power_systems_type(value::DemandRequirement) = value.power_systems_type
"""Get [`DemandRequirement`](@ref) `internal`."""
get_internal(value::DemandRequirement) = value.internal
"""Get [`DemandRequirement`](@ref) `demand_mw_z`."""
get_demand_mw_z(value::DemandRequirement) = value.demand_mw_z
"""Get [`DemandRequirement`](@ref) `value_lost_load`."""
get_value_lost_load(value::DemandRequirement) = value.value_lost_load
"""Get [`DemandRequirement`](@ref) `max_curtailment`."""
get_max_curtailment(value::DemandRequirement) = value.max_curtailment
"""Get [`DemandRequirement`](@ref) `ext`."""
get_ext(value::DemandRequirement) = value.ext
"""Get [`DemandRequirement`](@ref) `cost_of_curtailment`."""
get_cost_of_curtailment(value::DemandRequirement) = value.cost_of_curtailment
"""Get [`DemandRequirement`](@ref) `region`."""
get_region(value::DemandRequirement) = value.region
"""Get [`DemandRequirement`](@ref) `available`."""
get_available(value::DemandRequirement) = value.available

"""Set [`DemandRequirement`](@ref) `name`."""
set_name!(value::DemandRequirement, val) = value.name = val
"""Set [`DemandRequirement`](@ref) `power_systems_type`."""
set_power_systems_type!(value::DemandRequirement, val) = value.power_systems_type = val
"""Set [`DemandRequirement`](@ref) `internal`."""
set_internal!(value::DemandRequirement, val) = value.internal = val
"""Set [`DemandRequirement`](@ref) `demand_mw_z`."""
set_demand_mw_z!(value::DemandRequirement, val) = value.demand_mw_z = val
"""Set [`DemandRequirement`](@ref) `value_lost_load`."""
set_value_lost_load!(value::DemandRequirement, val) = value.value_lost_load = val
"""Set [`DemandRequirement`](@ref) `max_curtailment`."""
set_max_curtailment!(value::DemandRequirement, val) = value.max_curtailment = val
"""Set [`DemandRequirement`](@ref) `ext`."""
set_ext!(value::DemandRequirement, val) = value.ext = val
"""Set [`DemandRequirement`](@ref) `cost_of_curtailment`."""
set_cost_of_curtailment!(value::DemandRequirement, val) = value.cost_of_curtailment = val
"""Set [`DemandRequirement`](@ref) `region`."""
set_region!(value::DemandRequirement, val) = value.region = val
"""Set [`DemandRequirement`](@ref) `available`."""
set_available!(value::DemandRequirement, val) = value.available = val
