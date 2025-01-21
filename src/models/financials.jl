"""
Supertype for all structs that contain financial data

Financial data include any data that is necessary to calculate total system cost.
Examples of this data include the base financial year, the discount rate, and the capital recovery period.
This does not include capital and operation costs, which are defined separately for each technology.
"""

abstract type Financials <: IS.InfrastructureSystemsComponent end

supports_time_series(::Financials) = true
supports_supplemental_attributes(::Financials) = true
