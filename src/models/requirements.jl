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
abstract type Requirement <: PSY.Service end

get_id(val::Requirement) = IS.get_id(val)
set_id!(val::Requirement, id) = IS.set_id!(val, id)
supports_time_series(::Requirement) = true
supports_supplemental_attributes(::Requirement) = true
