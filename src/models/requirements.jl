"""
Supertype for all portfolio requirements

Requirements include policies or other regional factors that may constrain
expansion decisions. Common requirements are carbon caps and system
capacity requirements.
"""

abstract type Requirements <: IS.InfrastructureSystemsComponent end

supports_time_series(::Requirements) = true
supports_supplemental_attributes(::Requirements) = true