# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""StorageTechnology

    StorageTechnology(;
        base_power=nothing,
        om_costs_energy=nothing,
        zone=nothing,
        prime_mover_type=nothing,
        existing_cap_energy=nothing,
        rsv_cost=nothing,
        available=nothing,
        existing_cap_power=nothing,
        name=nothing,
        storage_tech=nothing,
        capital_costs_power=nothing,
        max_duration=nothing,
        unit_size_power=nothing,
        id=nothing,
        min_cap_power=nothing,
        capital_costs_energy=nothing,
        losses=nothing,
        eff_down=nothing,
        rsv_max=nothing,
        max_cap_power=nothing,
        power_systems_type=nothing,
        internal=nothing,
        om_costs_power=nothing,
        balancing_topology=nothing,
        min_cap_energy=nothing,
        initial_state_of_charge=nothing,
        eff_up=nothing,
        unit_size_energy=nothing,
        ext=nothing,
        reg_cost=nothing,
        min_duration=nothing,
        max_cap_energy=nothing,
        reg_max=nothing,
    )

    - base_power::Float64 : Base power
    - om_costs_energy::PSYOperationalCost : Fixed and variable O&amp;M costs for a technology
    - zone::Union{NothingInt64Zone} : Zone number
    - prime_mover_type::PrimeMovers : Prime mover for generator
    - existing_cap_energy::Float64 : Pre-existing energy capacity for a technology (MWh)
    - rsv_cost::Float64 : Cost of providing upwards spinning or contingency reserves
    - available::Bool : identifies whether the technology is available
    - existing_cap_power::Float64 : Pre-existing power capacity for a technology (MW)
    - name::String : The technology name
    - storage_tech::StorageTech : Storage Technology Type
    - capital_costs_power::PSYValueCurve : Capital costs for investing in a technology.
    - max_duration::Float64 : Maximum allowable durection for a storage technology
    - unit_size_power::Float64 : Used for discrete investment decisions. Size of each unit being built (MW)
    - id::Int64 : ID for individual generator
    - min_cap_power::Float64 : Minimum required power capacity for a storage technology
    - capital_costs_energy::PSYValueCurve : Capital costs for investing in a technology.
    - losses::Float64 : Power loss (pct per hour)
    - eff_down::Float64 : Efficiency of discharging storage
    - rsv_max::Float64 : Fraction of nameplate capacity that can committed to provided upwards spinning or contingency reserves.
    - max_cap_power::Float64 : Maximum allowable installed power capacity for a storage technology
    - power_systems_type::String : maps to a valid PowerSystems.jl for PCM modeling
    - internal::InfrastructureSystemsInternal : Internal field
    - om_costs_power::PSYOperationalCost : Fixed and variable O&amp;M costs for a technology
    - balancing_topology::String : Set of balancing nodes
    - min_cap_energy::Float64 : Minimum required energy capacity for a storage technology
    - initial_state_of_charge::Float64 : State of charge for storage technology in the first timepoint (MWh).
    - eff_up::Float64 : Efficiency of charging storage
    - unit_size_energy::Float64 : Used for discrete investment decisions. Size of each unit being built (MW)
    - ext::Dict : Option for providing additional data
    - reg_cost::Float64 : Cost of providing regulation reserves 
    - min_duration::Float64 : Minimum required durection for a storage technology
    - max_cap_energy::Float64 : Maximum allowable installed energy capacity for a storage technology
    - reg_max::Float64 : Fraction of nameplate capacity that can committed to provided regulation reserves
"""
Base.@kwdef mutable struct StorageTechnology <: OpenAPI.APIModel
    base_power::Union{Nothing, Float64} = nothing
    om_costs_energy = nothing # spec type: Union{ Nothing, PSYOperationalCost }
    zone = nothing # spec type: Union{ Nothing, Union{NothingInt64Zone} }
    prime_mover_type = nothing # spec type: Union{ Nothing, PrimeMovers }
    existing_cap_energy::Union{Nothing, Float64} = nothing
    rsv_cost::Union{Nothing, Float64} = nothing
    available::Union{Nothing, Bool} = nothing
    existing_cap_power::Union{Nothing, Float64} = nothing
    name::Union{Nothing, String} = nothing
    storage_tech = nothing # spec type: Union{ Nothing, StorageTech }
    capital_costs_power = nothing # spec type: Union{ Nothing, PSYValueCurve }
    max_duration::Union{Nothing, Float64} = nothing
    unit_size_power::Union{Nothing, Float64} = nothing
    id::Union{Nothing, Int64} = nothing
    min_cap_power::Union{Nothing, Float64} = nothing
    capital_costs_energy = nothing # spec type: Union{ Nothing, PSYValueCurve }
    losses::Union{Nothing, Float64} = nothing
    eff_down::Union{Nothing, Float64} = nothing
    rsv_max::Union{Nothing, Float64} = nothing
    max_cap_power::Union{Nothing, Float64} = nothing
    power_systems_type::Union{Nothing, String} = nothing
    internal = nothing # spec type: Union{ Nothing, InfrastructureSystemsInternal }
    om_costs_power = nothing # spec type: Union{ Nothing, PSYOperationalCost }
    balancing_topology::Union{Nothing, String} = nothing
    min_cap_energy::Union{Nothing, Float64} = nothing
    initial_state_of_charge::Union{Nothing, Float64} = nothing
    eff_up::Union{Nothing, Float64} = nothing
    unit_size_energy::Union{Nothing, Float64} = nothing
    ext::Union{Nothing, Dict} = nothing
    reg_cost::Union{Nothing, Float64} = nothing
    min_duration::Union{Nothing, Float64} = nothing
    max_cap_energy::Union{Nothing, Float64} = nothing
    reg_max::Union{Nothing, Float64} = nothing

    function StorageTechnology(base_power, om_costs_energy, zone, prime_mover_type, existing_cap_energy, rsv_cost, available, existing_cap_power, name, storage_tech, capital_costs_power, max_duration, unit_size_power, id, min_cap_power, capital_costs_energy, losses, eff_down, rsv_max, max_cap_power, power_systems_type, internal, om_costs_power, balancing_topology, min_cap_energy, initial_state_of_charge, eff_up, unit_size_energy, ext, reg_cost, min_duration, max_cap_energy, reg_max, )
        OpenAPI.validate_property(StorageTechnology, Symbol("base_power"), base_power)
        OpenAPI.validate_property(StorageTechnology, Symbol("om_costs_energy"), om_costs_energy)
        OpenAPI.validate_property(StorageTechnology, Symbol("zone"), zone)
        OpenAPI.validate_property(StorageTechnology, Symbol("prime_mover_type"), prime_mover_type)
        OpenAPI.validate_property(StorageTechnology, Symbol("existing_cap_energy"), existing_cap_energy)
        OpenAPI.validate_property(StorageTechnology, Symbol("rsv_cost"), rsv_cost)
        OpenAPI.validate_property(StorageTechnology, Symbol("available"), available)
        OpenAPI.validate_property(StorageTechnology, Symbol("existing_cap_power"), existing_cap_power)
        OpenAPI.validate_property(StorageTechnology, Symbol("name"), name)
        OpenAPI.validate_property(StorageTechnology, Symbol("storage_tech"), storage_tech)
        OpenAPI.validate_property(StorageTechnology, Symbol("capital_costs_power"), capital_costs_power)
        OpenAPI.validate_property(StorageTechnology, Symbol("max_duration"), max_duration)
        OpenAPI.validate_property(StorageTechnology, Symbol("unit_size_power"), unit_size_power)
        OpenAPI.validate_property(StorageTechnology, Symbol("id"), id)
        OpenAPI.validate_property(StorageTechnology, Symbol("min_cap_power"), min_cap_power)
        OpenAPI.validate_property(StorageTechnology, Symbol("capital_costs_energy"), capital_costs_energy)
        OpenAPI.validate_property(StorageTechnology, Symbol("losses"), losses)
        OpenAPI.validate_property(StorageTechnology, Symbol("eff_down"), eff_down)
        OpenAPI.validate_property(StorageTechnology, Symbol("rsv_max"), rsv_max)
        OpenAPI.validate_property(StorageTechnology, Symbol("max_cap_power"), max_cap_power)
        OpenAPI.validate_property(StorageTechnology, Symbol("power_systems_type"), power_systems_type)
        OpenAPI.validate_property(StorageTechnology, Symbol("internal"), internal)
        OpenAPI.validate_property(StorageTechnology, Symbol("om_costs_power"), om_costs_power)
        OpenAPI.validate_property(StorageTechnology, Symbol("balancing_topology"), balancing_topology)
        OpenAPI.validate_property(StorageTechnology, Symbol("min_cap_energy"), min_cap_energy)
        OpenAPI.validate_property(StorageTechnology, Symbol("initial_state_of_charge"), initial_state_of_charge)
        OpenAPI.validate_property(StorageTechnology, Symbol("eff_up"), eff_up)
        OpenAPI.validate_property(StorageTechnology, Symbol("unit_size_energy"), unit_size_energy)
        OpenAPI.validate_property(StorageTechnology, Symbol("ext"), ext)
        OpenAPI.validate_property(StorageTechnology, Symbol("reg_cost"), reg_cost)
        OpenAPI.validate_property(StorageTechnology, Symbol("min_duration"), min_duration)
        OpenAPI.validate_property(StorageTechnology, Symbol("max_cap_energy"), max_cap_energy)
        OpenAPI.validate_property(StorageTechnology, Symbol("reg_max"), reg_max)
        return new(base_power, om_costs_energy, zone, prime_mover_type, existing_cap_energy, rsv_cost, available, existing_cap_power, name, storage_tech, capital_costs_power, max_duration, unit_size_power, id, min_cap_power, capital_costs_energy, losses, eff_down, rsv_max, max_cap_power, power_systems_type, internal, om_costs_power, balancing_topology, min_cap_energy, initial_state_of_charge, eff_up, unit_size_energy, ext, reg_cost, min_duration, max_cap_energy, reg_max, )
    end
end # type StorageTechnology

const _property_types_StorageTechnology = Dict{Symbol,String}(Symbol("base_power")=>"Float64", Symbol("om_costs_energy")=>"PSYOperationalCost", Symbol("zone")=>"Union{NothingInt64Zone}", Symbol("prime_mover_type")=>"PrimeMovers", Symbol("existing_cap_energy")=>"Float64", Symbol("rsv_cost")=>"Float64", Symbol("available")=>"Bool", Symbol("existing_cap_power")=>"Float64", Symbol("name")=>"String", Symbol("storage_tech")=>"StorageTech", Symbol("capital_costs_power")=>"PSYValueCurve", Symbol("max_duration")=>"Float64", Symbol("unit_size_power")=>"Float64", Symbol("id")=>"Int64", Symbol("min_cap_power")=>"Float64", Symbol("capital_costs_energy")=>"PSYValueCurve", Symbol("losses")=>"Float64", Symbol("eff_down")=>"Float64", Symbol("rsv_max")=>"Float64", Symbol("max_cap_power")=>"Float64", Symbol("power_systems_type")=>"String", Symbol("internal")=>"InfrastructureSystemsInternal", Symbol("om_costs_power")=>"PSYOperationalCost", Symbol("balancing_topology")=>"String", Symbol("min_cap_energy")=>"Float64", Symbol("initial_state_of_charge")=>"Float64", Symbol("eff_up")=>"Float64", Symbol("unit_size_energy")=>"Float64", Symbol("ext")=>"Dict", Symbol("reg_cost")=>"Float64", Symbol("min_duration")=>"Float64", Symbol("max_cap_energy")=>"Float64", Symbol("reg_max")=>"Float64", )
OpenAPI.property_type(::Type{ StorageTechnology }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_StorageTechnology[name]))}

function check_required(o::StorageTechnology)
    o.available === nothing && (return false)
    o.name === nothing && (return false)
    o.power_systems_type === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ StorageTechnology }, name::Symbol, val)
    if name === Symbol("prime_mover_type")
        OpenAPI.validate_param(name, "StorageTechnology", :enum, val, [BT, CA, CC, CS, CT, FC, GT, HA, HB, HK, HY, IC, OT, ST, PVe, WT, WS])
    end
    if name === Symbol("storage_tech")
        OpenAPI.validate_param(name, "StorageTechnology", :enum, val, [PTES, LIB, LAB, FLWB, SIB, ZIB, HGS, LAES, OTHER_CHEM, OTHER_MECH, OTHER_THERM])
    end
end