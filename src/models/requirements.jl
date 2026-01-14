"""
    Requirement

Supertype for all portfolio requirements.

Requirements represent policies or other regional factors that may constrain
expansion decisions. Examples include:
- Carbon emissions caps and taxes (`CarbonCaps`, `CarbonTax`)
- System capacity requirements (`CapacityReserveMargin`)
- Energy share mandates (`EnergyShareRequirements`)
- Clean energy matching requirements (`HourlyMatching`)
- Minimum and maximum capacity limits (`MinimumCapacityRequirements`, `MaximumCapacityRequirements`)
"""

abstract type Requirement <: IS.InfrastructureSystemsComponent end

supports_time_series(::Requirement) = true
supports_supplemental_attributes(::Requirement) = true
