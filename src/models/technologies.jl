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

    @show proportional_units, new_proportional_units
    @show constant_units, new_constant_units

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

#######################################################
# set_value: accept Unitful.Quantity or RelativeQuantity; return DU scalar
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
