"""
$(TYPEDEF)
$(TYPEDFIELDS)

    CapitalCost(capital, interconnection)
    CapitalCost(; capital, interconnection)

An investment cost for candidate generation and transmission technologies which includes 
overnight capital costs and last-mile interconnection costs.
"""

@kwdef mutable struct CapitalCost <: InvestmentCost
    capital::ValueCurve
    interconnection::Float64
end

# Constructor for demo purposes; non-functional.
function CapitalCost(::Nothing)
    return CapitalCost(LinearCurve(0.0), 0.0)
end

"""
Return the `capital` field of [`CapitalCost`](@ref).
"""
get_capital(value::CapitalCost) = value.capital
"""
Return the `interconnection` field of [`CapitalCost`](@ref).
"""
get_interconnection(value::CapitalCost) = value.interconnection

"""
Set the `capital` field of [`CapitalCost`](@ref).
"""
set_capital!(value::CapitalCost, val) = value.capital = val
"""
Set the `interconnection` field of [`CapitalCost`](@ref).
"""
set_interconnection!(value::CapitalCost, val) = value.interconnection = val
