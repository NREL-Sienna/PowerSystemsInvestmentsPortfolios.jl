"""
    FinancialData

Supertype for all structs that contain financial data.

Financial data includes information necessary to calculate total system cost,
such as:
- Base financial year
- Discount rates
- Capital recovery periods
- Technology-specific cost data

Note: This does not include capital and operation costs, which are defined 
separately for each technology via `TechnologyFinancialData`.
"""

abstract type FinancialData <: IS.DeviceParameter end

supports_time_series(::FinancialData) = true

IS.serialize(val::FinancialData) = IS.serialize_struct(val)
IS.deserialize(T::Type{<:FinancialData}, val::Dict) = IS.deserialize_struct(T, val)
