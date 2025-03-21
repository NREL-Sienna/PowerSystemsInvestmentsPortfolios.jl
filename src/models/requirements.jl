"""
Supertype for all portfolio requirements

Requirement include policies or other regional factors that may constrain
expansion decisions. Common requirements are carbon caps and system
capacity requirements.
"""

abstract type Requirement <: IS.InfrastructureSystemsComponent end

supports_time_series(::Requirement) = true
supports_supplemental_attributes(::Requirement) = true
