#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct FinancialData <: Financials
        name::String
        base_year::Int64
        internal::InfrastructureSystemsInternal
        discount_rate::Float64
        inflation_rate::Float64
        interest_rate::Float64
        capital_recovery_period::Int64
    end



# Arguments
- `name::String`: Name of data
- `base_year::Int64`: Base economic year. All costs will be converted to a net present value in this year.
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `discount_rate::Float64`: Discount rate
- `inflation_rate::Float64`: Inflation rate
- `interest_rate::Float64`: Interest rate
- `capital_recovery_period::Int64`: Capital recovery period (in years) used for determining overnight capital costs from annualized investment costs
"""
mutable struct FinancialData <: Financials
    "Name of data"
    name::String
    "Base economic year. All costs will be converted to a net present value in this year."
    base_year::Int64
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Discount rate"
    discount_rate::Float64
    "Inflation rate"
    inflation_rate::Float64
    "Interest rate"
    interest_rate::Float64
    "Capital recovery period (in years) used for determining overnight capital costs from annualized investment costs"
    capital_recovery_period::Int64
end


function FinancialData(; name, base_year, internal=InfrastructureSystemsInternal(), discount_rate, inflation_rate, interest_rate, capital_recovery_period, )
    FinancialData(name, base_year, internal, discount_rate, inflation_rate, interest_rate, capital_recovery_period, )
end

"""Get [`FinancialData`](@ref) `name`."""
get_name(value::FinancialData) = value.name
"""Get [`FinancialData`](@ref) `base_year`."""
get_base_year(value::FinancialData) = value.base_year
"""Get [`FinancialData`](@ref) `internal`."""
get_internal(value::FinancialData) = value.internal
"""Get [`FinancialData`](@ref) `discount_rate`."""
get_discount_rate(value::FinancialData) = value.discount_rate
"""Get [`FinancialData`](@ref) `inflation_rate`."""
get_inflation_rate(value::FinancialData) = value.inflation_rate
"""Get [`FinancialData`](@ref) `interest_rate`."""
get_interest_rate(value::FinancialData) = value.interest_rate
"""Get [`FinancialData`](@ref) `capital_recovery_period`."""
get_capital_recovery_period(value::FinancialData) = value.capital_recovery_period

"""Set [`FinancialData`](@ref) `name`."""
set_name!(value::FinancialData, val) = value.name = val
"""Set [`FinancialData`](@ref) `base_year`."""
set_base_year!(value::FinancialData, val) = value.base_year = val
"""Set [`FinancialData`](@ref) `internal`."""
set_internal!(value::FinancialData, val) = value.internal = val
"""Set [`FinancialData`](@ref) `discount_rate`."""
set_discount_rate!(value::FinancialData, val) = value.discount_rate = val
"""Set [`FinancialData`](@ref) `inflation_rate`."""
set_inflation_rate!(value::FinancialData, val) = value.inflation_rate = val
"""Set [`FinancialData`](@ref) `interest_rate`."""
set_interest_rate!(value::FinancialData, val) = value.interest_rate = val
"""Set [`FinancialData`](@ref) `capital_recovery_period`."""
set_capital_recovery_period!(value::FinancialData, val) = value.capital_recovery_period = val
