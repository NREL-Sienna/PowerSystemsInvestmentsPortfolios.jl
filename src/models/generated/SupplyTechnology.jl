#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct SupplyTechnology{T <: PSY.Generator} <: ResourceTechnology
        base_power::Float64
        outage_factor::Float64
        prime_mover_type::PrimeMovers
        capital_costs::PSY.ValueCurve
        build_year::Union{Nothing, Int}
        lifetime::Int
        available::Bool
        co2::Dict{ThermalFuels, Float64}
        name::String
        id::Int64
        initial_capacity::Float64
        cofire_start_limits::Dict{ThermalFuels, MinMax}
        financial_data::TechnologyFinancialData
        start_fuel_mmbtu_per_mw::Float64
        operation_costs::PSY.OperationalCost
        fuel::Vector{ThermalFuels}
        power_systems_type::String
        cofire_level_limits::Dict{ThermalFuels, MinMax}
        internal::InfrastructureSystemsInternal
        ext::Dict
        balancing_topology::String
        region::Vector{RegionTopology}
        time_limits::UpDown
        unit_size::Float64
        min_generation_percentage::Float64
        ramp_limits::UpDown
        capacity_limits::MinMax
    end

Candidate generation technology for a region. Can represent either a thermal or renewable generation technology

# Arguments
- `base_power::Float64`: Base power (MW)
- `outage_factor::Float64`: (default: `1.0`) Derating factor to account for planned or forced outages of a technology
- `prime_mover_type::PrimeMovers`: (default: `PrimeMovers.OT`) Prime mover for generator
- `capital_costs::PSY.ValueCurve`: (default: `LinearCurve(0.0)`) Capital costs for investing in a technology. (USD/MW)
- `build_year::Union{Nothing, Int}`: (default: `nothing`) Year in which the existing technology is built. Default to nothing for new technologies
- `lifetime::Int`: (default: `100`) Maximum number of years a technology can be active once installed
- `available::Bool`: (default: `True`) Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)
- `co2::Dict{ThermalFuels, Float64}`: (default: `Dict()`) Carbon Intensity of fuel
- `name::String`: The technology name
- `id::Int64`: ID for individual technology
- `initial_capacity::Float64`: (default: `0.0`) Pre-existing capacity for a technology (MW)
- `cofire_start_limits::Dict{ThermalFuels, MinMax}`: (default: `Dict()`) Minimum and maximum blending level (%) of each fuel during start-up process for multi-fuel generator
- `financial_data::TechnologyFinancialData`: Struct containing relevant financial information for a technology
- `start_fuel_mmbtu_per_mw::Float64`: (default: `0.0`) Startup fuel use per MW of nameplate capacity of each generator (MMBtu/MW per start)
- `operation_costs::PSY.OperationalCost`: (default: `ThermalGenerationCost()`) Fixed and variable O&M costs for a technology
- `fuel::Vector{ThermalFuels}`: (default: `[ThermalFuels.OTHER]`) Fuel type according to IEA
- `power_systems_type::String`: maps to a valid PowerSystems.jl for PCM modeling
- `cofire_level_limits::Dict{ThermalFuels, MinMax}`: (default: `Dict()`) Minimum and maximum blending level (%) of each fuel during normal generation process for multi-fuel generator
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `balancing_topology::String`: Set of balancing nodes
- `region::Vector{RegionTopology}`: (default: `Vector()`) Location where technology operates. Can be a zone or node.
- `time_limits::UpDown`: (default: `(up=1.0, down=1.0)`) Minimum amount of time a resource has to stay in the committed or shutdown state.
- `unit_size::Float64`: (default: `0.0`) Used for discrete investment decisions. Size of each unit being built (MW)
- `min_generation_percentage::Float64`: (default: `0.0`) Minimum generation as a fraction of total capacity
- `ramp_limits::UpDown`: (default: `(up=1.0, down=1.0)`) Maximum decrease and increase in output between operation periods. Fraction of total capacity
- `capacity_limits::MinMax`: (default: `(min=0, max=1e8)`) Minimum and maximum allowable installed capacity for a technology (MW)
"""
mutable struct SupplyTechnology{T <: PSY.Generator} <: ResourceTechnology
    "Base power (MW)"
    base_power::Float64
    "Derating factor to account for planned or forced outages of a technology"
    outage_factor::Float64
    "Prime mover for generator"
    prime_mover_type::PrimeMovers
    "Capital costs for investing in a technology. (USD/MW)"
    capital_costs::PSY.ValueCurve
    "Year in which the existing technology is built. Default to nothing for new technologies"
    build_year::Union{Nothing, Int}
    "Maximum number of years a technology can be active once installed"
    lifetime::Int
    "Indicator of whether the component is connected and online (`true`) or disconnected, offline, or down (`false`)"
    available::Bool
    "Carbon Intensity of fuel"
    co2::Dict{ThermalFuels, Float64}
    "The technology name"
    name::String
    "ID for individual technology"
    id::Int64
    "Pre-existing capacity for a technology (MW)"
    initial_capacity::Float64
    "Minimum and maximum blending level (%) of each fuel during start-up process for multi-fuel generator"
    cofire_start_limits::Dict{ThermalFuels, MinMax}
    "Struct containing relevant financial information for a technology"
    financial_data::TechnologyFinancialData
    "Startup fuel use per MW of nameplate capacity of each generator (MMBtu/MW per start)"
    start_fuel_mmbtu_per_mw::Float64
    "Fixed and variable O&M costs for a technology"
    operation_costs::PSY.OperationalCost
    "Fuel type according to IEA"
    fuel::Vector{ThermalFuels}
    "maps to a valid PowerSystems.jl for PCM modeling"
    power_systems_type::String
    "Minimum and maximum blending level (%) of each fuel during normal generation process for multi-fuel generator"
    cofire_level_limits::Dict{ThermalFuels, MinMax}
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Set of balancing nodes"
    balancing_topology::String
    "Location where technology operates. Can be a zone or node."
    region::Vector{RegionTopology}
    "Minimum amount of time a resource has to stay in the committed or shutdown state."
    time_limits::UpDown
    "Used for discrete investment decisions. Size of each unit being built (MW)"
    unit_size::Float64
    "Minimum generation as a fraction of total capacity"
    min_generation_percentage::Float64
    "Maximum decrease and increase in output between operation periods. Fraction of total capacity"
    ramp_limits::UpDown
    "Minimum and maximum allowable installed capacity for a technology (MW)"
    capacity_limits::MinMax
end


function SupplyTechnology{T}(; base_power, outage_factor=1.0, prime_mover_type=PrimeMovers.OT, capital_costs=LinearCurve(0.0), build_year=nothing, lifetime=100, available=True, co2=Dict(), name, id, initial_capacity=0.0, cofire_start_limits=Dict(), financial_data, start_fuel_mmbtu_per_mw=0.0, operation_costs=ThermalGenerationCost(), fuel=[ThermalFuels.OTHER], power_systems_type, cofire_level_limits=Dict(), internal=InfrastructureSystemsInternal(), ext=Dict(), balancing_topology, region=Vector(), time_limits=(up=1.0, down=1.0), unit_size=0.0, min_generation_percentage=0.0, ramp_limits=(up=1.0, down=1.0), capacity_limits=(min=0, max=1e8), ) where T <: PSY.Generator
    SupplyTechnology{T}(base_power, outage_factor, prime_mover_type, capital_costs, build_year, lifetime, available, co2, name, id, initial_capacity, cofire_start_limits, financial_data, start_fuel_mmbtu_per_mw, operation_costs, fuel, power_systems_type, cofire_level_limits, internal, ext, balancing_topology, region, time_limits, unit_size, min_generation_percentage, ramp_limits, capacity_limits, )
end

"""Get [`SupplyTechnology`](@ref) `base_power`."""
get_base_power(value::SupplyTechnology) = value.base_power
"""Get [`SupplyTechnology`](@ref) `outage_factor`."""
get_outage_factor(value::SupplyTechnology) = value.outage_factor
"""Get [`SupplyTechnology`](@ref) `prime_mover_type`."""
get_prime_mover_type(value::SupplyTechnology) = value.prime_mover_type
"""Get [`SupplyTechnology`](@ref) `capital_costs`."""
get_capital_costs(value::SupplyTechnology) = value.capital_costs
"""Get [`SupplyTechnology`](@ref) `build_year`."""
get_build_year(value::SupplyTechnology) = value.build_year
"""Get [`SupplyTechnology`](@ref) `lifetime`."""
get_lifetime(value::SupplyTechnology) = value.lifetime
"""Get [`SupplyTechnology`](@ref) `available`."""
get_available(value::SupplyTechnology) = value.available
"""Get [`SupplyTechnology`](@ref) `co2`."""
get_co2(value::SupplyTechnology) = value.co2
"""Get [`SupplyTechnology`](@ref) `name`."""
get_name(value::SupplyTechnology) = value.name
"""Get [`SupplyTechnology`](@ref) `id`."""
get_id(value::SupplyTechnology) = value.id
"""Get [`SupplyTechnology`](@ref) `initial_capacity`."""
get_initial_capacity(value::SupplyTechnology) = value.initial_capacity
"""Get [`SupplyTechnology`](@ref) `cofire_start_limits`."""
get_cofire_start_limits(value::SupplyTechnology) = value.cofire_start_limits
"""Get [`SupplyTechnology`](@ref) `financial_data`."""
get_financial_data(value::SupplyTechnology) = value.financial_data
"""Get [`SupplyTechnology`](@ref) `start_fuel_mmbtu_per_mw`."""
get_start_fuel_mmbtu_per_mw(value::SupplyTechnology) = value.start_fuel_mmbtu_per_mw
"""Get [`SupplyTechnology`](@ref) `operation_costs`."""
get_operation_costs(value::SupplyTechnology) = value.operation_costs
"""Get [`SupplyTechnology`](@ref) `fuel`."""
get_fuel(value::SupplyTechnology) = value.fuel
"""Get [`SupplyTechnology`](@ref) `power_systems_type`."""
get_power_systems_type(value::SupplyTechnology) = value.power_systems_type
"""Get [`SupplyTechnology`](@ref) `cofire_level_limits`."""
get_cofire_level_limits(value::SupplyTechnology) = value.cofire_level_limits
"""Get [`SupplyTechnology`](@ref) `internal`."""
get_internal(value::SupplyTechnology) = value.internal
"""Get [`SupplyTechnology`](@ref) `ext`."""
get_ext(value::SupplyTechnology) = value.ext
"""Get [`SupplyTechnology`](@ref) `balancing_topology`."""
get_balancing_topology(value::SupplyTechnology) = value.balancing_topology
"""Get [`SupplyTechnology`](@ref) `region`."""
get_region(value::SupplyTechnology) = value.region
"""Get [`SupplyTechnology`](@ref) `time_limits`."""
get_time_limits(value::SupplyTechnology) = value.time_limits
"""Get [`SupplyTechnology`](@ref) `unit_size`."""
get_unit_size(value::SupplyTechnology) = value.unit_size
"""Get [`SupplyTechnology`](@ref) `min_generation_percentage`."""
get_min_generation_percentage(value::SupplyTechnology) = value.min_generation_percentage
"""Get [`SupplyTechnology`](@ref) `ramp_limits`."""
get_ramp_limits(value::SupplyTechnology) = value.ramp_limits
"""Get [`SupplyTechnology`](@ref) `capacity_limits`."""
get_capacity_limits(value::SupplyTechnology) = value.capacity_limits

"""Set [`SupplyTechnology`](@ref) `base_power`."""
set_base_power!(value::SupplyTechnology, val) = value.base_power = val
"""Set [`SupplyTechnology`](@ref) `outage_factor`."""
set_outage_factor!(value::SupplyTechnology, val) = value.outage_factor = val
"""Set [`SupplyTechnology`](@ref) `prime_mover_type`."""
set_prime_mover_type!(value::SupplyTechnology, val) = value.prime_mover_type = val
"""Set [`SupplyTechnology`](@ref) `capital_costs`."""
set_capital_costs!(value::SupplyTechnology, val) = value.capital_costs = val
"""Set [`SupplyTechnology`](@ref) `build_year`."""
set_build_year!(value::SupplyTechnology, val) = value.build_year = val
"""Set [`SupplyTechnology`](@ref) `lifetime`."""
set_lifetime!(value::SupplyTechnology, val) = value.lifetime = val
"""Set [`SupplyTechnology`](@ref) `available`."""
set_available!(value::SupplyTechnology, val) = value.available = val
"""Set [`SupplyTechnology`](@ref) `co2`."""
set_co2!(value::SupplyTechnology, val) = value.co2 = val
"""Set [`SupplyTechnology`](@ref) `name`."""
set_name!(value::SupplyTechnology, val) = value.name = val
"""Set [`SupplyTechnology`](@ref) `id`."""
set_id!(value::SupplyTechnology, val) = value.id = val
"""Set [`SupplyTechnology`](@ref) `initial_capacity`."""
set_initial_capacity!(value::SupplyTechnology, val) = value.initial_capacity = val
"""Set [`SupplyTechnology`](@ref) `cofire_start_limits`."""
set_cofire_start_limits!(value::SupplyTechnology, val) = value.cofire_start_limits = val
"""Set [`SupplyTechnology`](@ref) `financial_data`."""
set_financial_data!(value::SupplyTechnology, val) = value.financial_data = val
"""Set [`SupplyTechnology`](@ref) `start_fuel_mmbtu_per_mw`."""
set_start_fuel_mmbtu_per_mw!(value::SupplyTechnology, val) = value.start_fuel_mmbtu_per_mw = val
"""Set [`SupplyTechnology`](@ref) `operation_costs`."""
set_operation_costs!(value::SupplyTechnology, val) = value.operation_costs = val
"""Set [`SupplyTechnology`](@ref) `fuel`."""
set_fuel!(value::SupplyTechnology, val) = value.fuel = val
"""Set [`SupplyTechnology`](@ref) `power_systems_type`."""
set_power_systems_type!(value::SupplyTechnology, val) = value.power_systems_type = val
"""Set [`SupplyTechnology`](@ref) `cofire_level_limits`."""
set_cofire_level_limits!(value::SupplyTechnology, val) = value.cofire_level_limits = val
"""Set [`SupplyTechnology`](@ref) `internal`."""
set_internal!(value::SupplyTechnology, val) = value.internal = val
"""Set [`SupplyTechnology`](@ref) `ext`."""
set_ext!(value::SupplyTechnology, val) = value.ext = val
"""Set [`SupplyTechnology`](@ref) `balancing_topology`."""
set_balancing_topology!(value::SupplyTechnology, val) = value.balancing_topology = val
"""Set [`SupplyTechnology`](@ref) `region`."""
set_region!(value::SupplyTechnology, val) = value.region = val
"""Set [`SupplyTechnology`](@ref) `time_limits`."""
set_time_limits!(value::SupplyTechnology, val) = value.time_limits = val
"""Set [`SupplyTechnology`](@ref) `unit_size`."""
set_unit_size!(value::SupplyTechnology, val) = value.unit_size = val
"""Set [`SupplyTechnology`](@ref) `min_generation_percentage`."""
set_min_generation_percentage!(value::SupplyTechnology, val) = value.min_generation_percentage = val
"""Set [`SupplyTechnology`](@ref) `ramp_limits`."""
set_ramp_limits!(value::SupplyTechnology, val) = value.ramp_limits = val
"""Set [`SupplyTechnology`](@ref) `capacity_limits`."""
set_capacity_limits!(value::SupplyTechnology, val) = value.capacity_limits = val

function serialize_openapi_struct(technology::SupplyTechnology{T}, vals...) where T <: PSY.Generator
    base_struct = APIServer.SupplyTechnology(; vals...)
    return base_struct
end


function deserialize_openapi_struct(::Type{<:SupplyTechnology}, vals::Dict)
    return IS.deserialize_struct(APIServer.SupplyTechnology, vals)
end
