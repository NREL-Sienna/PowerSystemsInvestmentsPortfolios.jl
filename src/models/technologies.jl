"""
abstract type to represent technolgies available for investment.

Required fields for a technology Type

  - name
  - available
  - power_systems_type
  - time_series_container
  - supplemental_attributes_container
  - internal
"""
abstract type Technology <: IS.InfrastructureSystemsComponent end

abstract type ResourceTechnology <: Technology end
abstract type TransmissionTechnology <: Technology end
abstract type DemandTechnology <: Technology end

get_name(val::Technology) = val.name
get_available(val::Technology) = val.available
get_power_systems_type(val::Technology) = val.power_systems_type
get_internal(val::Technology) = val.internal
get_ext(val::Technology) = get_ext(get_internal(val))
get_time_series_container(val::Technology) = val.time_series_container
get_supplemental_attributes_container(val::Technology) =
    val.supplemental_attributes_container
supports_time_series(::Technology) = true

#######################################################
# Units-aware get_value / set_value
#
# Fields are stored internally in a pre-defined set of natural units (NU). The 4-arg `get_value`
# converts from NU to a requested target (e.g., MW, SU). The 3-arg form
# delegates to the 4-arg with DEFAULT_UNITS (= SU, a RelativeQuantity
# carrying its unit in its type).
#######################################################

"""
    get_value(c::Component, field::Val, conversion_unit::Val, units) -> value

Get `c`'s field value, converting from device-base storage to `units`.
Returns a `RelativeQuantity` (for DU/SU targets) or a `Unitful.Quantity` (for
natural units like MW). Public getters wrap this in `_strip_units` for the
bare-number form, with `_unitful` companions returning the wrapped value.
"""
function get_value(t::Technology, field::Val{T}, conversion_unit, units) where {T}
    value = Base.getproperty(t, T)
    return _convert_from_default_units(t, value, conversion_unit, units)
end

_convert_from_default_units(base, value::Number, cu::Val, units) =
    convert_units(base, value, _unit_category(cu), units)

# ---- Nothing passthrough ----
_convert_from_default_units(base, ::Nothing, ::Val, ::Any) = nothing

# ---- Compound field types ----
_convert_from_default_units(base, v::MinMax, cu, u) = (
    min=_convert_from_default_units(base, v.min, cu, u),
    max=_convert_from_default_units(base, v.max, cu, u),
)

_convert_from_default_units(base, v::UpDown, cu, u) = (
    up=_convert_from_default_units(base, v.up, cu, u),
    down=_convert_from_default_units(base, v.down, cu, u),
)

#######################################################
# Unit-aware methods for converting cost functions in Sienna.
# Current design is intended to support the following function types:
# - Cost (USD) as a function of power output and/or installed capacity (MW)
# - Fuel consumption (MMBtu) as a function of energy production (MWh)
# - Fuel cost (USD) as a function of fuel consumption (MMBtu)
#######################################################

# ----Function Data----
function _convert_from_default_units(base, v::LinearFunctionData, cu, u::ConversionUnits)
    units = natural_unit(_unit_category(cu))

    proportional_units = units.y_unit / units.x_unit
    constant_units = units.y_unit

    new_proportional_units = u.y_unit / u.x_unit
    new_constant_units = u.y_unit

    return LinearFunctionData(
        IS._strip_units(
            convert_units(
                base,
                v.proportional_term,
                proportional_units,
                new_proportional_units,
            ),
        ),
        IS._strip_units(
            convert_units(base, v.constant_term, constant_units, new_constant_units),
        ),
    )
end

function _convert_from_default_units(base, v::QuadraticFunctionData, cu, u::ConversionUnits)
    units = natural_unit(_unit_category(cu))
    quadratic_units = units.y_unit / (units.x_unit^2)
    proportional_units = units.y_unit / units.x_unit
    constant_units = units.y_unit

    new_quadratic_units = u.y_unit / (u.x_unit^2)
    new_proportional_units = u.y_unit / u.x_unit
    new_constant_units = u.y_unit
    return QuadraticFunctionData(
        IS._strip_units(
            convert_units(base, v.quadratic_term, quadratic_units, new_quadratic_units),
        ),
        IS._strip_units(
            convert_units(
                base,
                v.proportional_term,
                proportional_units,
                new_proportional_units,
            ),
        ),
        IS._strip_units(
            convert_units(base, v.constant_term, constant_units, new_constant_units),
        ),
    )
end

function _convert_from_default_units(base, v::PiecewiseLinearData, cu, u::ConversionUnits)
    units = natural_unit(_unit_category(cu))
    data = get_points(v)

    return PiecewiseLinearData([
        (
            IS._strip_units(convert_units(base, x, units.x_unit, u.x_unit)),
            IS._strip_units(convert_units(base, y, units.y_unit, u.y_unit)),
        ) for (x, y) in data
    ])
end

function _convert_from_default_units(base, v::PiecewiseStepData, cu, u::ConversionUnits)
    units = natural_unit(_unit_category(cu))
    if cu == Val(:mmbtu_per_mwh)
        return PiecewiseStepData(
            [
                IS._strip_units(convert_units(base, x, units.x_unit, u.x_unit)) for
                x in v.x_coords
            ],
            [
                IS._strip_units(
                    convert_units(
                        base,
                        y,
                        units.y_unit / units.x_unit,
                        u.y_unit / u.x_unit,
                    ),
                ) for y in v.y_coords
            ],
        )
    end
end

# ---- ValueCurves ----
function _convert_from_default_units(base, v::InputOutputCurve, cu, u::ConversionUnits)
    if cu == Val(:mmbtu_per_mwh)
        y_unit = Val(:mmbtu)
    else
        y_unit = Val(:usd)
    end
    return InputOutputCurve(
        _convert_from_default_units(base, v.function_data, cu, u),
        IS._strip_units(
            _convert_from_default_units(base, v.input_at_zero, y_unit, u.y_unit),
        ),
    )
end

function _convert_from_default_units(base, v::IncrementalCurve, cu, u::ConversionUnits)
    if cu == Val(:mmbtu_per_mwh)
        y_unit = Val(:mmbtu)
    else
        y_unit = Val(:usd)
    end
    return IncrementalCurve(
        _convert_from_default_units(base, v.function_data, cu, u),
        IS._strip_units(
            _convert_from_default_units(base, v.initial_input, y_unit, u.y_unit),
        ),
        IS._strip_units(
            _convert_from_default_units(base, v.input_at_zero, y_unit, u.y_unit),
        ),
    )
end

function _convert_from_default_units(base, v::AverageRateCurve, cu, u::ConversionUnits)
    if cu == Val(:mmbtu_per_mwh)
        y_unit = Val(:mmbtu)
    else
        y_unit = Val(:usd)
    end
    return AverageRateCurve(
        _convert_from_default_units(base, v.function_data, cu, u),
        IS._strip_units(
            _convert_from_default_units(base, v.initial_input, y_unit, u.y_unit),
        ),
        IS._strip_units(
            _convert_from_default_units(base, v.input_at_zero, y_unit, u.y_unit),
        ),
    )
end

# ---- CostCurve ----
function _convert_from_default_units(base, v::CostCurve, cu, u::ConversionUnits)
    return CostCurve(
        _convert_from_default_units(base, v.value_curve, cu, u),
        _convert_from_default_units(base, v.vom_cost, cu, u),
    )
end

# ---- FuelCurve ----
function _convert_from_default_units(base, v::FuelCurve, cu, u::FuelCurveUnits)
    # Construct conversion units for fields of FuelCurve
    fuel_consumption_units = (x_unit=u.energy_unit, y_unit=u.fuel_unit)
    vom_cost_units = (x_unit=u.energy_unit, y_unit=u.currency_unit)

    default_fuel_cost = natural_unit(FuelCostCategory())
    default_fuel_cost_units = default_fuel_cost.y_unit / default_fuel_cost.x_unit
    fuel_cost_units = u.currency_unit / u.fuel_unit

    return FuelCurve(
        _convert_from_default_units(
            base,
            v.value_curve,
            Val(:mmbtu_per_mwh),
            fuel_consumption_units,
        ),
        isa(v.fuel_cost, Float64) ?
        IS._strip_units(
            convert_units(base, v.fuel_cost, default_fuel_cost_units, fuel_cost_units),
        ) : v.fuel_cost,
        _convert_from_default_units(
            base,
            v.startup_fuel_offtake,
            Val(:mmbtu_per_mwh),
            fuel_consumption_units,
        ),
        _convert_from_default_units(base, v.vom_cost, Val(:usd_per_mwh), vom_cost_units),
    )
end

#######################################################
# set_value: accept Unitful.Quantity or RelativeQuantity; return NU scalar
#######################################################

# ---- From Unitful.Quantity (natural units): inverse engine conversion ----
set_value(t::Technology, field, val::Quantity, cu::Val) =
    IS._strip_units(convert_units(t, val, _unit_category(cu), _unit_category(cu)))

# ---- From Number (assuming natural units). We may not want to support this? ----
set_value(t::Technology, field, val::Number, cu::Val) = val

# Physical category implied by a field's conversion unit.
_unit_category(::Val{:mw}) = POWER
_unit_category(::Val{:ohm}) = IMPEDANCE
_unit_category(::Val{:kV}) = VOLTAGE
_unit_category(::Val{:hr}) = OPS_TIME
_unit_category(::Val{:yr}) = INV_TIME
_unit_category(::Val{:usd_per_mw}) = POWER_COST
_unit_category(::Val{:usd_per_mwh}) = ENERGY_COST
_unit_category(::Val{:usd_per_mmbtu}) = FUEL_COST
_unit_category(::Val{:usd}) = COST
_unit_category(::Val{:mmbtu}) = FUEL
_unit_category(::Val{:mmbtu_per_mwh}) = FUEL_CONSUMPTION
_unit_category(::Val{:fuel_curve}) = FUEL_CURVE
