# Monetary Units
@dimension Money "Money" Currency
@refunit USD "USD" Currency Money false

# Fuel and emissions units
@unit MMBtu "MMBtu" MMBtu 1e6u"btu" false
@unit tonne "tonne" tonne 1e3u"kg" false

# Re-export common Unitful units for power systems
const MW = u"MW"
const kV = u"kV"
const OHMS = u"Ω"
const SIEMENS = u"S"
