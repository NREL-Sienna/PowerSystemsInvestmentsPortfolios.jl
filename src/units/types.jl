# Monetary Units
@dimension Money "Money" Currency
@refunit USD "USD" Currency Money false

# Fuel Units
@unit MMBtu "MMBtu" MMBtu 1e6u"btu" false

# Re-export common Unitful units for power systems
const MW = u"MW"
const kV = u"kV"
const OHMS = u"Ω"
const SIEMENS = u"S"
