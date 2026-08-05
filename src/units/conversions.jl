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

const _UNIT_AWARE =
    Union{Technology, Requirement, SupplementalAttribute}

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
struct EmissionsCategory <: UnitCategory end
struct FuelCurveCategory <: UnitCategory end
struct PowerCostCategory <: UnitCategory end
struct EnergyCostCategory <: UnitCategory end
struct FuelCostCategory <: UnitCategory end
struct OPSTimeCategory <: UnitCategory end
struct INVTimeCategory <: UnitCategory end
struct EnergyCategory <: UnitCategory end
struct RampingCategory <: UnitCategory end

const POWER = PowerCategory()
const IMPEDANCE = ImpedanceCategory()
const ADMITTANCE = AdmittanceCategory()
const VOLTAGE = VoltageCategory()
const CURRENT = CurrentCategory()
const COST = CostCategory()
const FUEL = FuelCategory()
const FUEL_CONSUMPTION_ENERGY = FuelConsumptionEnergyCategory()
const FUEL_CONSUMPTION_POWER = FuelConsumptionPowerCategory()
const EMISSIONS = EmissionsCategory()
const FUEL_CURVE = FuelCurveCategory()
const POWER_COST = PowerCostCategory()
const ENERGY_COST = EnergyCostCategory()
const FUEL_COST = FuelCostCategory()
const OPS_TIME = OPSTimeCategory()
const INV_TIME = INVTimeCategory()
const ENERGY = EnergyCategory()
const RAMPING = RampingCategory()

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
natural_unit(::RampingCategory) = u"MW/minute"

natural_unit(::CostCategory) = USD
natural_unit(::PowerCostCategory) = (x_unit=u"MW", y_unit=USD)
natural_unit(::EnergyCostCategory) = (x_unit=u"MW" * u"hr", y_unit=USD)

natural_unit(::FuelCategory) = MMBtu
natural_unit(::FuelConsumptionEnergyCategory) = (x_unit=u"MW" * u"hr", y_unit=MMBtu)
natural_unit(::FuelConsumptionPowerCategory) = MMBtu / u"MW"
natural_unit(::EmissionsCategory) = tonne / MMBtu
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

#######################################################
# Units-aware get_value / set_value
#
# Fields are stored internally in a pre-defined set of natural units (NU). The 4-arg `get_value`
# converts from the default units to a requested target unit.
#######################################################

val_to_symbol(::Val{T}) where {T} = T
val_to_string(v::Val) = String(val_to_symbol(v))

"""
    get_value(t::Technology, field::Val, conversion_unit::Val, units) -> value

Get `t`'s field value, converting from our default natural units to `units`.
Returns a `Unitful.Quantity`. Public getters can wrap this in `_strip_units`
for the bare-number form, with `_unitful` companions returning the wrapped value.
"""
function get_value(t::T, field::Val{U}, from, to) where {T <: _UNIT_AWARE, U}
    value = Base.getproperty(t, val_to_symbol(field))
    return _natural_unit_conversions(t, value, natural_unit(_unit_category(from)), to)
end

"""
    set_value(t::Technology, field::Val, val, conversion_unit::Val) -> value

Set `t`'s field value, converting from `val`'s units to our default natural units.
Returns the value in natural units.
"""

# ---- From Unitful.Quantity (natural units): inverse conversion ----
function set_value(
    t::T,
    field::U,
    value,
    from::Union{Unitful.Units, ConversionUnits, FuelCurveUnits},
    to::Val,
) where {T <: _UNIT_AWARE, U}
    return IS._strip_units(
        _natural_unit_conversions(t, value, from, natural_unit(_unit_category(to))),
    )
end

function set_value(t::T, field::Val{U}, value, from::Val, to::Val) where {T <: _UNIT_AWARE, U}
    return IS._strip_units(
        _natural_unit_conversions(
            t,
            value,
            natural_unit(_unit_category(from)),
            natural_unit(_unit_category(to)),
        ),
    )
end

# ---- From Number or when a Unitful Quantity cannot be specified (assuming natural units) ----
# function set_value(t::Technology, field, value, to::Val)
#     units = natural_unit(_unit_category(to))
#     @warn "Setting field $(val_to_string(field)) with a unitless number. Assuming units of $units."
#     return value
# end

# _set_value(t::Technology, val::Quantity, cu::Val) =
#     IS._strip_units(convert_units(t, val, cu, cu))

# _set_value(t::Technology, val::Quantity, cu::Val)

_natural_unit_conversions(base, value::Number, from, to) =
    convert_units(base, value, from, to)

# ---- Nothing passthrough ----
_natural_unit_conversions(base, ::Nothing, ::Val, ::Any) = nothing

# ---- Compound field types ----
_natural_unit_conversions(base, v::MinMax, cu, u) = (
    min=_natural_unit_conversions(base, v.min, cu, u),
    max=_natural_unit_conversions(base, v.max, cu, u),
)

_natural_unit_conversions(base, v::UpDown, cu, u) = (
    up=_natural_unit_conversions(base, v.up, cu, u),
    down=_natural_unit_conversions(base, v.down, cu, u),
)

_natural_unit_conversions(base, v::PSY.StartUpShutDown, cu, u) = (
    startup=_natural_unit_conversions(base, v.startup, cu, u),
    shutdown=_natural_unit_conversions(base, v.shutdown, cu, u),
)

_natural_unit_conversions(base, v::PSY.StartUpStages, cu, u) = (
    hot=IS._strip_units(_natural_unit_conversions(base, v.hot, cu, u)),
    warm=IS._strip_units(_natural_unit_conversions(base, v.warm, cu, u)),
    cold=IS._strip_units(_natural_unit_conversions(base, v.cold, cu, u)),
)

_natural_unit_conversions(base, v::PSY.STORAGE_OPERATION_MODES, cu, u) = (
    charge=IS._strip_units(_natural_unit_conversions(base, v.charge, cu, u)),
    discharge=IS._strip_units(_natural_unit_conversions(base, v.discharge, cu, u)),
)

# _set_value(t::Technology, val::Quantity, cu::Val)

# Physical category implied by a field's conversion unit.
_unit_category(::Val{:mw}) = POWER
_unit_category(::Val{:mwh}) = ENERGY
_unit_category(::Val{:ohm}) = IMPEDANCE
_unit_category(::Val{:kv}) = VOLTAGE
_unit_category(::Val{:hr}) = OPS_TIME
_unit_category(::Val{:yr}) = INV_TIME
_unit_category(::Val{:usd_per_mw}) = POWER_COST
_unit_category(::Val{:usd_per_mwh}) = ENERGY_COST
_unit_category(::Val{:usd_per_mmbtu}) = FUEL_COST
_unit_category(::Val{:usd}) = COST
_unit_category(::Val{:mmbtu}) = FUEL
_unit_category(::Val{:mmbtu_per_mwh}) = FUEL_CONSUMPTION_ENERGY
_unit_category(::Val{:mmbtu_per_mw}) = FUEL_CONSUMPTION_POWER
_unit_category(::Val{:fuel_curve}) = FUEL_CURVE
_unit_category(::Val{:t_per_mmbtu}) = EMISSIONS
_unit_category(::Val{:mw_per_min}) = RAMPING
supports_requirements(::Technology) = true