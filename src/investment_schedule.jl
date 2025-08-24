"""
    InvestmentScheduleResults

A mutable struct that stores the results of investment decisions over multiple investment periods.

# Fields

  - `results::Dict`: Dictionary mapping investment periods to technology investment results.
    Structure: InvestmentPeriod => (TypeTechnology, "name") => BuildCapacity
    Another idea would be the structure to be:
    Structure: InvestmentPeriod => TypeTechnology => Dict{String, BuildCapacity}

    Where:

      + InvestmentPeriod: Time period when investment decisions are made
      + TypeTechnology: The type of technology being invested in
      + "name": String identifier for the specific technology instance
      + BuildCapacity: The capacity to be built for that technology in that period
"""
mutable struct InvestmentScheduleResults
    results::Dict  # InvestmentPeriod => (TypeTechnology, "name") => BuildCapacity
end