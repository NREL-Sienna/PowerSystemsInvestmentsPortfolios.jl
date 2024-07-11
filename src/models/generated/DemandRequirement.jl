#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct DemandRequirement{T <: PSY.StaticInjection} <: Technology
        available::Bool
        name::String
        value_lost_load::Float64
        cost_of_curtailment::Float64
        load_growth::Float64
        power_systems_type::String
        internal::InfrastructureSystemsInternal
        ext::Dict
        region::String
        load_fraction::Float64
        peak_load::Float64
        max_curtailment::Float64
    end



# Arguments
- `available::Bool`: (default: `true`) identifies whether the technology is available
- `name::String`: The technology name
- `value_lost_load::Float64`: (default: `0.0`) Value of lost load/non-served energy ($/MWh)
- `cost_of_curtailment::Float64`: (default: `0.0`) Cost of non-served energy, fraction of value of lost load
- `load_growth::Float64`: (default: `0.0`) Annual load growth (%)
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `region::String`: Corresponding region for peak demand
- `load_fraction::Float64`: (default: `1.0`) Demand representedt as a fraction of peak load
- `peak_load::Float64`: (default: `100.0`) Demand value (MW) for single timepoint (for now)
- `max_curtailment::Float64`: (default: `0.0`) Maximum percentage of demand that can be curtailed in an investment period
"""
mutable struct DemandRequirement{T <: PSY.StaticInjection} <: Technology
    "identifies whether the technology is available"
    available::Bool
    "The technology name"
    name::String
    "Value of lost load/non-served energy ($/MWh)"
    value_lost_load::Float64
    "Cost of non-served energy, fraction of value of lost load"
    cost_of_curtailment::Float64
    "Annual load growth (%)"
    load_growth::Float64
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Corresponding region for peak demand"
    region::String
    "Demand representedt as a fraction of peak load"
    load_fraction::Float64
    "Demand value (MW) for single timepoint (for now)"
    peak_load::Float64
    "Maximum percentage of demand that can be curtailed in an investment period"
    max_curtailment::Float64
end


function DemandRequirement{T}(; available=true, name, value_lost_load=0.0, cost_of_curtailment=0.0, load_growth=0.0, power_systems_type, internal=InfrastructureSystemsInternal(), ext=Dict(), region, load_fraction=1.0, peak_load=100.0, max_curtailment=0.0, ) where T <: PSY.StaticInjection
    DemandRequirement{T}(available, name, value_lost_load, cost_of_curtailment, load_growth, power_systems_type, internal, ext, region, load_fraction, peak_load, max_curtailment, )
end

"""Get [`DemandRequirement`](@ref) `available`."""
get_available(value::DemandRequirement) = value.available
"""Get [`DemandRequirement`](@ref) `name`."""
get_name(value::DemandRequirement) = value.name
"""Get [`DemandRequirement`](@ref) `value_lost_load`."""
get_value_lost_load(value::DemandRequirement) = value.value_lost_load
"""Get [`DemandRequirement`](@ref) `cost_of_curtailment`."""
get_cost_of_curtailment(value::DemandRequirement) = value.cost_of_curtailment
"""Get [`DemandRequirement`](@ref) `load_growth`."""
get_load_growth(value::DemandRequirement) = value.load_growth
"""Get [`DemandRequirement`](@ref) `power_systems_type`."""
get_power_systems_type(value::DemandRequirement) = value.power_systems_type
"""Get [`DemandRequirement`](@ref) `internal`."""
get_internal(value::DemandRequirement) = value.internal
"""Get [`DemandRequirement`](@ref) `ext`."""
get_ext(value::DemandRequirement) = value.ext
"""Get [`DemandRequirement`](@ref) `region`."""
get_region(value::DemandRequirement) = value.region
"""Get [`DemandRequirement`](@ref) `load_fraction`."""
get_load_fraction(value::DemandRequirement) = value.load_fraction
"""Get [`DemandRequirement`](@ref) `peak_load`."""
get_peak_load(value::DemandRequirement) = value.peak_load
"""Get [`DemandRequirement`](@ref) `max_curtailment`."""
get_max_curtailment(value::DemandRequirement) = value.max_curtailment

"""Set [`DemandRequirement`](@ref) `available`."""
set_available!(value::DemandRequirement, val) = value.available = val
"""Set [`DemandRequirement`](@ref) `name`."""
set_name!(value::DemandRequirement, val) = value.name = val
"""Set [`DemandRequirement`](@ref) `value_lost_load`."""
set_value_lost_load!(value::DemandRequirement, val) = value.value_lost_load = val
"""Set [`DemandRequirement`](@ref) `cost_of_curtailment`."""
set_cost_of_curtailment!(value::DemandRequirement, val) = value.cost_of_curtailment = val
"""Set [`DemandRequirement`](@ref) `load_growth`."""
set_load_growth!(value::DemandRequirement, val) = value.load_growth = val
"""Set [`DemandRequirement`](@ref) `power_systems_type`."""
set_power_systems_type!(value::DemandRequirement, val) = value.power_systems_type = val
"""Set [`DemandRequirement`](@ref) `internal`."""
set_internal!(value::DemandRequirement, val) = value.internal = val
"""Set [`DemandRequirement`](@ref) `ext`."""
set_ext!(value::DemandRequirement, val) = value.ext = val
"""Set [`DemandRequirement`](@ref) `region`."""
set_region!(value::DemandRequirement, val) = value.region = val
"""Set [`DemandRequirement`](@ref) `load_fraction`."""
set_load_fraction!(value::DemandRequirement, val) = value.load_fraction = val
"""Set [`DemandRequirement`](@ref) `peak_load`."""
set_peak_load!(value::DemandRequirement, val) = value.peak_load = val
"""Set [`DemandRequirement`](@ref) `max_curtailment`."""
set_max_curtailment!(value::DemandRequirement, val) = value.max_curtailment = val
