#=
Unit conversion system for power systems components.

Core abstraction: a UnitCategory defines a physical quantity (power, impedance, etc.)
with a natural unit and a way to compute the per-unit base value for any component.

Portfolios does not support System-base of Device-base units, so this system only supports 
conversion between natural units and user-specified display units.
=#

# ============================================================
# Unit categories
# ============================================================

# Can import relevant units from PSY 
abstract type UnitCategory end

struct PowerCategory <: UnitCategory end
struct ImpedanceCategory <: UnitCategory end
struct AdmittanceCategory <: UnitCategory end
struct VoltageCategory <: UnitCategory end
struct CurrentCategory <: UnitCategory end
struct CostCategory <: UnitCategory end
struct PowerCostCategory <: UnitCategory end
struct EnergyCostCategory <: UnitCategory end
struct OPSTimeCategory <: UnitCategory end
struct INVTimeCategory <: UnitCategory end
struct EnergyCategory <: UnitCategory end

const POWER = PowerCategory()
const IMPEDANCE = ImpedanceCategory()
const ADMITTANCE = AdmittanceCategory()
const VOLTAGE = VoltageCategory()
const CURRENT = CurrentCategory()
const COST = CostCategory()
const POWER_COST = PowerCostCategory()
const ENERGY_COST = EnergyCostCategory()
const OPS_TIME = OPSTimeCategory()
const INV_TIME = INVTimeCategory()
const ENERGY = EnergyCategory()

"""
    natural_unit(category) → Unitful.Units

The natural (physical) unit for this category.
"""
natural_unit(::PowerCategory) = u"MW"
natural_unit(::ImpedanceCategory) = u"Ω"
natural_unit(::AdmittanceCategory) = u"S"
natural_unit(::VoltageCategory) = u"kV"
natural_unit(::CurrentCategory) = u"kA"
natural_unit(::OPSTimeCategory) = u"hr"
natural_unit(::INVTimeCategory) = u"yr"
natural_unit(::EnergyCategory) = natural_unit(POWER) * natural_unit(OPS_TIME)

natural_unit(::CostCategory) = USD
natural_unit(::PowerCostCategory) = USD / u"MW"
natural_unit(::EnergyCostCategory) = USD / (u"MW" * u"hr")

# --- Return value with its default natural units ---
function convert_units(c, val::Number, cat::UnitCategory, to::NaturalUnit)
    return val * natural_unit(cat)
end

# --- Convert from natural units to a target Unitful unit ---
function convert_units(c, val::Number, cat::UnitCategory, to::Unitful.Units)
    val = val * natural_unit(cat)
    return uconvert(to, val)
end

# --- Convert from a Unitful quantity to default natural units ---
function convert_units(c, val::Quantity, cat::UnitCategory, to::UnitCategory)
    return uconvert(natural_unit(to), val)
end
