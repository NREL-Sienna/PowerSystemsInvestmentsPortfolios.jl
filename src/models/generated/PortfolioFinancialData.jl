#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct PortfolioFinancialData <: Financials
        name::String
        base_year::Int64
        internal::InfrastructureSystemsInternal
        discount_rate::Float64
        inflation_rate::Float64
        interest_rate::Float64
    end



# Arguments
- `name::String`: Name of data
- `base_year::Int64`: Base economic year. All costs will be converted to a net present value in this year.
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `discount_rate::Float64`: Discount rate
- `inflation_rate::Float64`: Inflation rate
- `interest_rate::Float64`: (default: `0.0`) Interest rate
"""
mutable struct PortfolioFinancialData <: Financials
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
end


function PortfolioFinancialData(; name, base_year, internal=InfrastructureSystemsInternal(), discount_rate, inflation_rate, interest_rate=0.0, )
    PortfolioFinancialData(name, base_year, internal, discount_rate, inflation_rate, interest_rate, )
end

"""Get [`PortfolioFinancialData`](@ref) `name`."""
get_name(value::PortfolioFinancialData) = value.name
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

"""Set [`PortfolioFinancialData`](@ref) `name`."""
set_name!(value::PortfolioFinancialData, val) = value.name = val
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

serialize(val::PortfolioFinancialData) = serialize_struct(val)
IS.deserialize(T::Type{<:PortfolioFinancialData}, val::Dict) = IS.deserialize_struct(T, val)

function build_openapi_struct(::Type{<:PortfolioFinancialData}, vals...)
    base_struct = APIClient.PortfolioFinancialData(; vals...)
    return base_struct
end
