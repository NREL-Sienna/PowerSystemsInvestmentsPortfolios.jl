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
struct FuelCategory <: UnitCategory end
struct FuelConsumptionEnergyCategory <: UnitCategory end
struct FuelConsumptionPowerCategory <: UnitCategory end
struct FuelCurveCategory <: UnitCategory end
struct PowerCostCategory <: UnitCategory end
struct EnergyCostCategory <: UnitCategory end
struct FuelCostCategory <: UnitCategory end
struct OPSTimeCategory <: UnitCategory end
struct INVTimeCategory <: UnitCategory end
struct EnergyCategory <: UnitCategory end

const POWER = PowerCategory()
const IMPEDANCE = ImpedanceCategory()
const ADMITTANCE = AdmittanceCategory()
const VOLTAGE = VoltageCategory()
const CURRENT = CurrentCategory()
const COST = CostCategory()
const FUEL = FuelCategory()
const FUEL_CONSUMPTION_ENERGY = FuelConsumptionEnergyCategory()
const FUEL_CONSUMPTION_POWER = FuelConsumptionPowerCategory()
const FUEL_CURVE = FuelCurveCategory()
const POWER_COST = PowerCostCategory()
const ENERGY_COST = EnergyCostCategory()
const FUEL_COST = FuelCostCategory()
const OPS_TIME = OPSTimeCategory()
const INV_TIME = INVTimeCategory()
const ENERGY = EnergyCategory()

const FuelCurveUnits = NamedTuple{
    (:energy_unit, :fuel_unit, :currency_unit),
    T,
} where {T <: Tuple{<:Unitful.Units, <:Unitful.Units, <:Unitful.Units}}
const ConversionUnits =
    NamedTuple{(:x_unit, :y_unit), T} where {T <: Tuple{<:Unitful.Units, <:Unitful.Units}}

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
natural_unit(::PowerCostCategory) = (x_unit=u"MW", y_unit=USD)
natural_unit(::EnergyCostCategory) = (x_unit=u"MW" * u"hr", y_unit=USD)

natural_unit(::FuelCategory) = MMBtu
natural_unit(::FuelConsumptionEnergyCategory) = (x_unit=u"MW" * u"hr", y_unit=MMBtu)
natural_unit(::FuelConsumptionPowerCategory) = (x_unit=u"MW", y_unit=MMBtu)
natural_unit(::FuelCostCategory) = (x_unit=MMBtu, y_unit=USD)
natural_unit(::FuelCurveCategory) =
    (energy_unit=u"MW" * u"hr", fuel_unit=MMBtu, currency_unit=USD)

# --- Return value with its default natural units ---
function convert_units(c, val::Number, from::UnitCategory, to::IS.NaturalUnit)
    return val * natural_unit(from)
end

# --- Convert from natural units to a target Unitful unit ---
function convert_units(c, val::Number, from::UnitCategory, to::Unitful.Units)
    units = natural_unit(from)
    val = val * units
    return uconvert(to, val)
end

function convert_units(c, val::Number, from::Unitful.Units, to::Unitful.Units)
    val = val * from
    return uconvert(to, val)
end

# --- Convert from a Unitful quantity to default natural units ---
function convert_units(c, val::Quantity, from::UnitCategory, to::UnitCategory)
    return uconvert(natural_unit(to), val)
end
