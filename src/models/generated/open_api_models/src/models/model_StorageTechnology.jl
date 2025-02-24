# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.

@doc raw"""StorageTechnology

    StorageTechnology(;
        name=nothing,
        base_year=nothing,
        region=nothing,
        id=nothing,
        available=nothing,
        power_systems_type=nothing,
        balancing_topology=nothing,
        base_power=nothing,
        prime_mover_type="OT",
        storage_tech=nothing,
        capital_costs_energy=nothing,
        capital_costs_power=nothing,
        operations_costs_energy=nothing,
        operations_costs_power=nothing,
        existing_capacity_power=0.0,
        existing_capacity_energy=0.0,
        unit_size_power=0.0,
        unit_size_energy=0.0,
        max_capacity_power=1e8,
        max_capacity_energy=1e8,
        min_capacity_power=0.0,
        min_capacity_energy=0.0,
        min_duration=0.0,
        max_duration=1000.0,
        efficiency_in=1.0,
        efficiency_out=1.0,
        losses=1.0,
        lifetime=100,
        financial_data=nothing,
    )

    - name::String
    - base_year::Int64
    - region::SupplyTechnologyRegion
    - id::Int64
    - available::Bool
    - power_systems_type::String
    - balancing_topology::String
    - base_power::Float64
    - prime_mover_type::String
    - storage_tech::String : defines the storage technology used in an energy Storage system, based on the options in EIA form 923.
    - capital_costs_energy::ValueCurve
    - capital_costs_power::ValueCurve
    - operations_costs_energy::StorageCost
    - operations_costs_power::StorageCost
    - existing_capacity_power::Float64
    - existing_capacity_energy::Float64
    - unit_size_power::Float64
    - unit_size_energy::Float64
    - max_capacity_power::Float64
    - max_capacity_energy::Float64
    - min_capacity_power::Float64
    - min_capacity_energy::Float64
    - min_duration::Float64
    - max_duration::Float64
    - efficiency_in::Float64
    - efficiency_out::Float64
    - losses::Float64
    - lifetime::Int64
    - financial_data::String
"""
Base.@kwdef mutable struct StorageTechnology <: OpenAPI.APIModel
    name::Union{Nothing, String} = nothing
    base_year::Union{Nothing, Int64} = nothing
    region = nothing # spec type: Union{ Nothing, SupplyTechnologyRegion }
    id::Union{Nothing, Int64} = nothing
    available::Union{Nothing, Bool} = nothing
    power_systems_type::Union{Nothing, String} = nothing
    balancing_topology::Union{Nothing, String} = nothing
    base_power::Union{Nothing, Float64} = nothing
    prime_mover_type::Union{Nothing, String} = "OT"
    storage_tech::Union{Nothing, String} = nothing
    capital_costs_energy = nothing # spec type: Union{ Nothing, ValueCurve }
    capital_costs_power = nothing # spec type: Union{ Nothing, ValueCurve }
    operations_costs_energy = nothing # spec type: Union{ Nothing, StorageCost }
    operations_costs_power = nothing # spec type: Union{ Nothing, StorageCost }
    existing_capacity_power::Union{Nothing, Float64} = 0.0
    existing_capacity_energy::Union{Nothing, Float64} = 0.0
    unit_size_power::Union{Nothing, Float64} = 0.0
    unit_size_energy::Union{Nothing, Float64} = 0.0
    max_capacity_power::Union{Nothing, Float64} = 1e8
    max_capacity_energy::Union{Nothing, Float64} = 1e8
    min_capacity_power::Union{Nothing, Float64} = 0.0
    min_capacity_energy::Union{Nothing, Float64} = 0.0
    min_duration::Union{Nothing, Float64} = 0.0
    max_duration::Union{Nothing, Float64} = 1000.0
    efficiency_in::Union{Nothing, Float64} = 1.0
    efficiency_out::Union{Nothing, Float64} = 1.0
    losses::Union{Nothing, Float64} = 1.0
    lifetime::Union{Nothing, Int64} = 100
    financial_data::Union{Nothing, String} = nothing

    function StorageTechnology(
        name,
        base_year,
        region,
        id,
        available,
        power_systems_type,
        balancing_topology,
        base_power,
        prime_mover_type,
        storage_tech,
        capital_costs_energy,
        capital_costs_power,
        operations_costs_energy,
        operations_costs_power,
        existing_capacity_power,
        existing_capacity_energy,
        unit_size_power,
        unit_size_energy,
        max_capacity_power,
        max_capacity_energy,
        min_capacity_power,
        min_capacity_energy,
        min_duration,
        max_duration,
        efficiency_in,
        efficiency_out,
        losses,
        lifetime,
        financial_data,
    )
        OpenAPI.validate_property(StorageTechnology, Symbol("name"), name)
        OpenAPI.validate_property(StorageTechnology, Symbol("base_year"), base_year)
        OpenAPI.validate_property(StorageTechnology, Symbol("region"), region)
        OpenAPI.validate_property(StorageTechnology, Symbol("id"), id)
        OpenAPI.validate_property(StorageTechnology, Symbol("available"), available)
        OpenAPI.validate_property(
            StorageTechnology,
            Symbol("power_systems_type"),
            power_systems_type,
        )
        OpenAPI.validate_property(
            StorageTechnology,
            Symbol("balancing_topology"),
            balancing_topology,
        )
        OpenAPI.validate_property(StorageTechnology, Symbol("base_power"), base_power)
        OpenAPI.validate_property(
            StorageTechnology,
            Symbol("prime_mover_type"),
            prime_mover_type,
        )
        OpenAPI.validate_property(StorageTechnology, Symbol("storage_tech"), storage_tech)
        OpenAPI.validate_property(
            StorageTechnology,
            Symbol("capital_costs_energy"),
            capital_costs_energy,
        )
        OpenAPI.validate_property(
            StorageTechnology,
            Symbol("capital_costs_power"),
            capital_costs_power,
        )
        OpenAPI.validate_property(
            StorageTechnology,
            Symbol("operations_costs_energy"),
            operations_costs_energy,
        )
        OpenAPI.validate_property(
            StorageTechnology,
            Symbol("operations_costs_power"),
            operations_costs_power,
        )
        OpenAPI.validate_property(
            StorageTechnology,
            Symbol("existing_capacity_power"),
            existing_capacity_power,
        )
        OpenAPI.validate_property(
            StorageTechnology,
            Symbol("existing_capacity_energy"),
            existing_capacity_energy,
        )
        OpenAPI.validate_property(
            StorageTechnology,
            Symbol("unit_size_power"),
            unit_size_power,
        )
        OpenAPI.validate_property(
            StorageTechnology,
            Symbol("unit_size_energy"),
            unit_size_energy,
        )
        OpenAPI.validate_property(
            StorageTechnology,
            Symbol("max_capacity_power"),
            max_capacity_power,
        )
        OpenAPI.validate_property(
            StorageTechnology,
            Symbol("max_capacity_energy"),
            max_capacity_energy,
        )
        OpenAPI.validate_property(
            StorageTechnology,
            Symbol("min_capacity_power"),
            min_capacity_power,
        )
        OpenAPI.validate_property(
            StorageTechnology,
            Symbol("min_capacity_energy"),
            min_capacity_energy,
        )
        OpenAPI.validate_property(StorageTechnology, Symbol("min_duration"), min_duration)
        OpenAPI.validate_property(StorageTechnology, Symbol("max_duration"), max_duration)
        OpenAPI.validate_property(StorageTechnology, Symbol("efficiency_in"), efficiency_in)
        OpenAPI.validate_property(
            StorageTechnology,
            Symbol("efficiency_out"),
            efficiency_out,
        )
        OpenAPI.validate_property(StorageTechnology, Symbol("losses"), losses)
        OpenAPI.validate_property(StorageTechnology, Symbol("lifetime"), lifetime)
        OpenAPI.validate_property(
            StorageTechnology,
            Symbol("financial_data"),
            financial_data,
        )
        return new(
            name,
            base_year,
            region,
            id,
            available,
            power_systems_type,
            balancing_topology,
            base_power,
            prime_mover_type,
            storage_tech,
            capital_costs_energy,
            capital_costs_power,
            operations_costs_energy,
            operations_costs_power,
            existing_capacity_power,
            existing_capacity_energy,
            unit_size_power,
            unit_size_energy,
            max_capacity_power,
            max_capacity_energy,
            min_capacity_power,
            min_capacity_energy,
            min_duration,
            max_duration,
            efficiency_in,
            efficiency_out,
            losses,
            lifetime,
            financial_data,
        )
    end
end # type StorageTechnology

const _property_types_StorageTechnology = Dict{Symbol, String}(
    Symbol("name") => "String",
    Symbol("base_year") => "Int64",
    Symbol("region") => "SupplyTechnologyRegion",
    Symbol("id") => "Int64",
    Symbol("available") => "Bool",
    Symbol("power_systems_type") => "String",
    Symbol("balancing_topology") => "String",
    Symbol("base_power") => "Float64",
    Symbol("prime_mover_type") => "String",
    Symbol("storage_tech") => "String",
    Symbol("capital_costs_energy") => "ValueCurve",
    Symbol("capital_costs_power") => "ValueCurve",
    Symbol("operations_costs_energy") => "StorageCost",
    Symbol("operations_costs_power") => "StorageCost",
    Symbol("existing_capacity_power") => "Float64",
    Symbol("existing_capacity_energy") => "Float64",
    Symbol("unit_size_power") => "Float64",
    Symbol("unit_size_energy") => "Float64",
    Symbol("max_capacity_power") => "Float64",
    Symbol("max_capacity_energy") => "Float64",
    Symbol("min_capacity_power") => "Float64",
    Symbol("min_capacity_energy") => "Float64",
    Symbol("min_duration") => "Float64",
    Symbol("max_duration") => "Float64",
    Symbol("efficiency_in") => "Float64",
    Symbol("efficiency_out") => "Float64",
    Symbol("losses") => "Float64",
    Symbol("lifetime") => "Int64",
    Symbol("financial_data") => "String",
)
OpenAPI.property_type(::Type{StorageTechnology}, name::Symbol) =
    Union{Nothing, eval(Base.Meta.parse(_property_types_StorageTechnology[name]))}

function check_required(o::StorageTechnology)
    o.name === nothing && (return false)
    o.available === nothing && (return false)
    o.power_systems_type === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{StorageTechnology}, name::Symbol, val)
    if name === Symbol("prime_mover_type")
        OpenAPI.validate_param(
            name,
            "StorageTechnology",
            :enum,
            val,
            [
                "BA",
                "BT",
                "CA",
                "CC",
                "CE",
                "CP",
                "CS",
                "CT",
                "ES",
                "FC",
                "FW",
                "GT",
                "HA",
                "HB",
                "HK",
                "HY",
                "IC",
                "PS",
                "OT",
                "ST",
                "PVe",
                "WT",
                "WS",
            ],
        )
    end

    if name === Symbol("storage_tech")
        OpenAPI.validate_param(
            name,
            "StorageTechnology",
            :enum,
            val,
            [
                "PTES",
                "LIB",
                "LAB",
                "FLWB",
                "SIB",
                "ZIB",
                "HGS",
                "LAES",
                "OTHER_CHEM",
                "OTHER_MECH",
                "OTHER_THERM",
            ],
        )
    end
end
