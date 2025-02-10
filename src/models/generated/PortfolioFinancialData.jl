#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct PortfolioFinancialData <: Financials
        base_year::Int64
        internal::InfrastructureSystemsInternal
        discount_rate::Float64
        inflation_rate::Float64
        interest_rate::Float64
    end



# Arguments
- `base_year::Int64`: Base economic year. All costs will be converted to a net present value in this year.
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `discount_rate::Float64`: Discount rate
- `inflation_rate::Float64`: Inflation rate
- `interest_rate::Float64`: (default: `0.0`) Interest rate
"""
mutable struct PortfolioFinancialData <: Financials
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
end


function PortfolioFinancialData(; base_year, internal=InfrastructureSystemsInternal(), discount_rate, inflation_rate, interest_rate=0.0, )
    PortfolioFinancialData(base_year, internal, discount_rate, inflation_rate, interest_rate, )
end

"""Get [`PortfolioFinancialData`](@ref) `base_year`."""
get_base_year(value::PortfolioFinancialData) = value.base_year
"""Get [`PortfolioFinancialData`](@ref) `internal`."""
get_internal(value::PortfolioFinancialData) = value.internal
"""Get [`PortfolioFinancialData`](@ref) `discount_rate`."""
get_discount_rate(value::PortfolioFinancialData) = value.discount_rate
"""Get [`PortfolioFinancialData`](@ref) `inflation_rate`."""
get_inflation_rate(value::PortfolioFinancialData) = value.inflation_rate
"""Get [`PortfolioFinancialData`](@ref) `interest_rate`."""
get_interest_rate(value::PortfolioFinancialData) = value.interest_rate

"""Set [`PortfolioFinancialData`](@ref) `base_year`."""
set_base_year!(value::PortfolioFinancialData, val) = value.base_year = val
"""Set [`PortfolioFinancialData`](@ref) `internal`."""
set_internal!(value::PortfolioFinancialData, val) = value.internal = val
"""Set [`PortfolioFinancialData`](@ref) `discount_rate`."""
set_discount_rate!(value::PortfolioFinancialData, val) = value.discount_rate = val
"""Set [`PortfolioFinancialData`](@ref) `inflation_rate`."""
set_inflation_rate!(value::PortfolioFinancialData, val) = value.inflation_rate = val
"""Set [`PortfolioFinancialData`](@ref) `interest_rate`."""
set_interest_rate!(value::PortfolioFinancialData, val) = value.interest_rate = val
