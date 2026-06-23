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
_unit_category(::Val{:siemens}) = ADMITTANCE
