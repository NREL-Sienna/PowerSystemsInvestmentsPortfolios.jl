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
    get_value(t::Technology, field::Val, conversion_unit::Val, units) -> value

Get `t`'s field value, converting from our default natural units to `units`.
Returns a `Unitful.Quantity`. Public getters can wrap this in `_strip_units` 
for the bare-number form, with `_unitful` companions returning the wrapped value.
"""
function get_value(t::Technology, field::Val{T}, from, to) where {T}
    value = Base.getproperty(t, T)
    return _natural_unit_conversions(t, value, natural_unit(_unit_category(from)), to)
end

"""
    set_value(t::Technology, field::Val, val, conversion_unit::Val) -> value

Set `t`'s field value, converting from `val`'s units to our default natural units.
Returns the value in natural units.
"""
# ---- From Unitful.Quantity (natural units): inverse conversion ----
function set_value(t::Technology, field, value::Quantity, to)
    return _natural_unit_conversions(t, ustrip(value), unit(value), to)
end

# ---- From Number (assuming natural units) ----
function set_value(t::Technology, field, value, to::Val)
    units = natural_unit(_unit_category(to))
    @warn "Setting a field with a bare number. Assuming units of $units."
    return _natural_unit_conversions(t, value, units, units)
end 

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
supports_requirements(::Technology) = true

"""
Return true if a specific requirement is attached to the Technology.
"""
function has_requirement(technology::Technology, requirement::Requirement)
    if !supports_requirements(technology)
        return false
    end
    for _requirement in get_requirements(technology)
        if IS.get_uuid(_requirement) == IS.get_uuid(requirement)
            return true
        end
    end

    return false
end

"""
Return true if a technology has any requirements of type T attached to it.
"""
function has_requirement(technology::Technology, ::Type{T}) where {T <: Requirement}
    if !supports_requirements(technology)
        return false
    end
    for _requirement in get_requirements(technology)
        if isa(_requirement, T)
            return true
        end
    end

    return false
end
