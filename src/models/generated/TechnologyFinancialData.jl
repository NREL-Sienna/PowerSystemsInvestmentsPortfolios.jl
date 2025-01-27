#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct TechnologyFinancialData <: Financials
        name::String
        internal::InfrastructureSystemsInternal
        interest_rate::Float64
        capital_recovery_period::Int64
        technology_base_year::Int64
    end



# Arguments
- `name::String`: Name of data
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `interest_rate::Float64`: (default: `0.0`) Interest rate
- `capital_recovery_period::Int64`: Capital recovery period (in years) used for determining overnight capital costs from annualized investment costs
- `technology_base_year::Int64`: Year for which all dollar values for this technology are reported. Will be converted to dollars in the portfolio base year.
"""
mutable struct TechnologyFinancialData <: Financials
    "Name of data"
    name::String
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Interest rate"
    interest_rate::Float64
    "Capital recovery period (in years) used for determining overnight capital costs from annualized investment costs"
    capital_recovery_period::Int64
    "Year for which all dollar values for this technology are reported. Will be converted to dollars in the portfolio base year."
    technology_base_year::Int64
end


function TechnologyFinancialData(; name, internal=InfrastructureSystemsInternal(), interest_rate=0.0, capital_recovery_period, technology_base_year, )
    TechnologyFinancialData(name, internal, interest_rate, capital_recovery_period, technology_base_year, )
end

"""Get [`TechnologyFinancialData`](@ref) `name`."""
get_name(value::TechnologyFinancialData) = value.name
"""Get [`TechnologyFinancialData`](@ref) `internal`."""
get_internal(value::TechnologyFinancialData) = value.internal
"""Get [`TechnologyFinancialData`](@ref) `interest_rate`."""
get_interest_rate(value::TechnologyFinancialData) = value.interest_rate
"""Get [`TechnologyFinancialData`](@ref) `capital_recovery_period`."""
get_capital_recovery_period(value::TechnologyFinancialData) = value.capital_recovery_period
"""Get [`TechnologyFinancialData`](@ref) `technology_base_year`."""
get_technology_base_year(value::TechnologyFinancialData) = value.technology_base_year

"""Set [`TechnologyFinancialData`](@ref) `name`."""
set_name!(value::TechnologyFinancialData, val) = value.name = val
"""Set [`TechnologyFinancialData`](@ref) `internal`."""
set_internal!(value::TechnologyFinancialData, val) = value.internal = val
"""Set [`TechnologyFinancialData`](@ref) `interest_rate`."""
set_interest_rate!(value::TechnologyFinancialData, val) = value.interest_rate = val
"""Set [`TechnologyFinancialData`](@ref) `capital_recovery_period`."""
set_capital_recovery_period!(value::TechnologyFinancialData, val) = value.capital_recovery_period = val
"""Set [`TechnologyFinancialData`](@ref) `technology_base_year`."""
set_technology_base_year!(value::TechnologyFinancialData, val) = value.technology_base_year = val

serialize(val::TechnologyFinancialData) = serialize_struct(val)
IS.deserialize(T::Type{<:TechnologyFinancialData}, val::Dict) = IS.deserialize_struct(T, val)

function build_openapi_struct(::Type{<:TechnologyFinancialData}, vals...)
    base_struct = APIClient.TechnologyFinancialData(; vals...)
    return base_struct
end
