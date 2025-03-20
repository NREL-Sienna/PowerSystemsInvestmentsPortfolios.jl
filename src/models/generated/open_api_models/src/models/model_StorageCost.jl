# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.

@doc raw"""StorageCost
Cost representation for storage units

    StorageCost(;
        charge_variable_cost=nothing,
        discharge_variable_cost=nothing,
        fixed=0.0,
        shut_down=0.0,
        start_up=nothing,
        energy_shortage_cost=0.0,
        energy_surplus_cost=0.0,
    )

    - charge_variable_cost::CostCurve
    - discharge_variable_cost::CostCurve
    - fixed::Float64
    - shut_down::Float64
    - start_up::StorageCostStartUp
    - energy_shortage_cost::Float64
    - energy_surplus_cost::Float64
"""
Base.@kwdef mutable struct StorageCost <: OpenAPI.APIModel
    charge_variable_cost = nothing # spec type: Union{ Nothing, CostCurve }
    discharge_variable_cost = nothing # spec type: Union{ Nothing, CostCurve }
    fixed::Union{Nothing, Float64} = 0.0
    shut_down::Union{Nothing, Float64} = 0.0
    start_up = nothing # spec type: Union{ Nothing, StorageCostStartUp }
    energy_shortage_cost::Union{Nothing, Float64} = 0.0
    energy_surplus_cost::Union{Nothing, Float64} = 0.0

    function StorageCost(
        charge_variable_cost,
        discharge_variable_cost,
        fixed,
        shut_down,
        start_up,
        energy_shortage_cost,
        energy_surplus_cost,
    )
        OpenAPI.validate_property(
            StorageCost,
            Symbol("charge_variable_cost"),
            charge_variable_cost,
        )
        OpenAPI.validate_property(
            StorageCost,
            Symbol("discharge_variable_cost"),
            discharge_variable_cost,
        )
        OpenAPI.validate_property(StorageCost, Symbol("fixed"), fixed)
        OpenAPI.validate_property(StorageCost, Symbol("shut_down"), shut_down)
        OpenAPI.validate_property(StorageCost, Symbol("start_up"), start_up)
        OpenAPI.validate_property(
            StorageCost,
            Symbol("energy_shortage_cost"),
            energy_shortage_cost,
        )
        OpenAPI.validate_property(
            StorageCost,
            Symbol("energy_surplus_cost"),
            energy_surplus_cost,
        )
        return new(
            charge_variable_cost,
            discharge_variable_cost,
            fixed,
            shut_down,
            start_up,
            energy_shortage_cost,
            energy_surplus_cost,
        )
    end
end # type StorageCost

const _property_types_StorageCost = Dict{Symbol, String}(
    Symbol("charge_variable_cost") => "CostCurve",
    Symbol("discharge_variable_cost") => "CostCurve",
    Symbol("fixed") => "Float64",
    Symbol("shut_down") => "Float64",
    Symbol("start_up") => "StorageCostStartUp",
    Symbol("energy_shortage_cost") => "Float64",
    Symbol("energy_surplus_cost") => "Float64",
)
OpenAPI.property_type(::Type{StorageCost}, name::Symbol) =
    Union{Nothing, eval(Base.Meta.parse(_property_types_StorageCost[name]))}

function check_required(o::StorageCost)
    o.fixed === nothing && (return false)
    o.shut_down === nothing && (return false)
    o.start_up === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{StorageCost}, name::Symbol, val) end
