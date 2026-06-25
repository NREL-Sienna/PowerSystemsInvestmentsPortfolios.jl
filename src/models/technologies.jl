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

# ----Function Data----
function _convert_from_default_units(base, v::LinearFunctionData, cu, u)
    units = natural_unit(_unit_category(cu))

    proportional_units = units[2] / units[1]
    constant_units = units[2]

    new_proportional_units = u[2] / u[1]
    new_constant_units = u[2]

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

function _convert_from_default_units(base, v::QuadraticFunctionData, cu, u)
    units = natural_unit(_unit_category(cu))
    quadratic_units = units[2] / (units[1]^2)
    proportional_units = units[2] / units[1]
    constant_units = units[2]

    new_quadratic_units = u[2] / (u[1]^2)
    new_proportional_units = u[2] / u[1]
    new_constant_units = u[2]
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

function _convert_from_default_units(base, v::PiecewiseLinearData, cu, u)
    units = natural_unit(_unit_category(cu))
    data = get_points(v)

    return PiecewiseLinearData([
        (
            IS._strip_units(convert_units(base, x, units[1], u[1])),
            IS._strip_units(convert_units(base, y, units[2], u[2])),
        ) for (x, y) in data
    ])
end

function _convert_from_default_units(base, v::PiecewiseStepData, cu, u)
    units = natural_unit(_unit_category(cu))
    y_units = units[2] / units[1]
    new_y_units = u[2] / u[1]

    return PiecewiseStepData(
        [IS._strip_units(convert_units(base, x, units[1], u[1])) for x in v.x_coords],
        [IS._strip_units(convert_units(base, y, y_units, new_y_units)) for y in v.y_coords],
    )
end

# ---- ValueCurves ----
function _convert_from_default_units(base, v::InputOutputCurve, cu, u)
    if cu == Val(:usd_per_mw)
        y_unit = Val(:usd)
    else
        y_unit = Val(:mmbtu)
    end
    return InputOutputCurve(
        _convert_from_default_units(base, v.function_data, cu, u),
        IS._strip_units(_convert_from_default_units(base, v.input_at_zero, y_unit, u[2])),
    )
end

function _convert_from_default_units(base, v::IncrementalCurve, cu, u)
    if cu == Val(:usd_per_mw)
        y_unit = Val(:usd)
    else
        y_unit = Val(:mmbtu)
    end
    return IncrementalCurve(
        _convert_from_default_units(base, v.function_data, cu, u),
        IS._strip_units(_convert_from_default_units(base, v.initial_input, y_unit, u[2])),
        IS._strip_units(_convert_from_default_units(base, v.input_at_zero, y_unit, u[2])),
    )
end

function _convert_from_default_units(base, v::AverageRateCurve, cu, u)
    if cu == Val(:usd_per_mw)
        y_unit = Val(:usd)
    else
        y_unit = Val(:mmbtu)
    end
    return AverageRateCurve(
        _convert_from_default_units(base, v.function_data, cu, u),
        IS._strip_units(_convert_from_default_units(base, v.initial_input, y_unit, u[2])),
        IS._strip_units(_convert_from_default_units(base, v.input_at_zero, y_unit, u[2])),
    )
end

# ---- CostCurve ----
function _convert_from_default_units(base, v::CostCurve, cu, u)
    return CostCurve(
        _convert_from_default_units(base, v.value_curve, cu, u),
        _convert_from_default_units(base, v.vom_cost, cu, u),
    )
end

# ---- FuelCurve ----
# FuelCurve is a special case because it has fields for energy cost, fuel consumption, and fuel cost. 
# The conversion unit is used to determine which of these fields is being converted. 
# The function will convert the value_curve, startup_fuel_offtake, and vom_cost fields using the appropriate conversion unit. 
# The fuel_cost field is only converted if it is a Float64, otherwise it is returned as is.
# To resolve this we require a tuple of three units: (energy_unit, fuel_unit, currency unit). 
function _convert_from_default_units(base, v::FuelCurve, cu, u)
    # Skip conversion if fuel_cost is not a float
    return FuelCurve(
        _convert_from_default_units(base, v.value_curve, _unit_category(Val(:mmbtu_per_mwh)), (u[1], u[2])),
        isa(v.fuel_cost, Float64) ? _convert_from_default_units(base, v.fuel_cost, _unit_category(Val(:usd_per_mmbtu)), u[3]/u[2]) : v.fuel_cost,
        _convert_from_default_units(base, v.startup_fuel_offtake, _unit_category(Val(:mmbtu_per_mwh)), (u[1], u[2])),
        _convert_from_default_units(base, v.vom_cost, _unit_category(Val(:usd_per_mwh)), (u[1], u[3])),
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
