"""
Supertype for all structs that contain financial data

Financial data include any data that is necessary to calculate total system cost.
Examples of this data include the base financial year, the discount rate, and the capital recovery period.
This does not include capital and operation costs, which are defined separately for each technology.
"""

abstract type FinancialData <: IS.DeviceParameter end

supports_time_series(::FinancialData) = true

IS.serialize(val::FinancialData) = IS.serialize_struct(val)
IS.deserialize(T::Type{<:FinancialData}, val::Dict) = IS.deserialize_struct(T, val)
