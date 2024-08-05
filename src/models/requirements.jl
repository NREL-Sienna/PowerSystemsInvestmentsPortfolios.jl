"""
Supertype for all system requirements

Requirements include policies or other regional factors that may constrain
long-term grid planning. Common requirements are carbon caps and system
capacity requirements.
"""

abstract type Requirements <: InfrastructureSystemsComponent end

supports_time_series(::Requirements) = true
supports_supplemental_attributes(::Requirements) = true