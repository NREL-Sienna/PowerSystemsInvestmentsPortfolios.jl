#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct FinancialData <: Financials
        base_year::Int64
        internal::InfrastructureSystemsInternal
        discount_rate::Float64
        inflation_rate::Float64
        capital_recovery_period::Int64
    end



# Arguments
- `base_year::Int64`: Base economic year. All costs will be converted to a net present value in this year.
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `discount_rate::Float64`: Name of region
- `inflation_rate::Float64`: A unique zone identification number (positive integer)
- `capital_recovery_period::Int64`: Option for providing additional data
"""
mutable struct FinancialData <: Financials
    "Base economic year. All costs will be converted to a net present value in this year."
    base_year::Int64
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Name of region"
    discount_rate::Float64
    "A unique zone identification number (positive integer)"
    inflation_rate::Float64
    "Option for providing additional data"
    capital_recovery_period::Int64
end


function FinancialData(; base_year, internal=InfrastructureSystemsInternal(), discount_rate, inflation_rate, capital_recovery_period, )
    FinancialData(base_year, internal, discount_rate, inflation_rate, capital_recovery_period, )
end

"""Get [`FinancialData`](@ref) `base_year`."""
get_base_year(value::FinancialData) = value.base_year
"""Get [`FinancialData`](@ref) `internal`."""
get_internal(value::FinancialData) = value.internal
"""Get [`FinancialData`](@ref) `discount_rate`."""
get_discount_rate(value::FinancialData) = value.discount_rate
"""Get [`FinancialData`](@ref) `inflation_rate`."""
get_inflation_rate(value::FinancialData) = value.inflation_rate
"""Get [`FinancialData`](@ref) `capital_recovery_period`."""
get_capital_recovery_period(value::FinancialData) = value.capital_recovery_period

"""Set [`FinancialData`](@ref) `base_year`."""
set_base_year!(value::FinancialData, val) = value.base_year = val
"""Set [`FinancialData`](@ref) `internal`."""
set_internal!(value::FinancialData, val) = value.internal = val
"""Set [`FinancialData`](@ref) `discount_rate`."""
set_discount_rate!(value::FinancialData, val) = value.discount_rate = val
"""Set [`FinancialData`](@ref) `inflation_rate`."""
set_inflation_rate!(value::FinancialData, val) = value.inflation_rate = val
"""Set [`FinancialData`](@ref) `capital_recovery_period`."""
set_capital_recovery_period!(value::FinancialData, val) = value.capital_recovery_period = val
