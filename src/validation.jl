"""
Validate a technology using only information contained within the technology.

Return `true` if the technology is valid.
"""
validate_technology(::Technology) = true

function _validate_nonnegative_limits(technology, limits, field_name)
    is_valid = true
    if !isfinite(limits.min) || !isfinite(limits.max)
        @error(
            "$field_name must be finite",
            technology=get_name(technology),
            minimum=limits.min,
            maximum=limits.max,
        )
        is_valid = false
    end
    if limits.min < 0.0 || limits.max < 0.0
        @error(
            "$field_name must be nonnegative",
            technology=get_name(technology),
            minimum=limits.min,
            maximum=limits.max,
        )
        is_valid = false
    end
    if limits.min > limits.max
        @error(
            "$field_name must be in ascending order",
            technology=get_name(technology),
            minimum=limits.min,
            maximum=limits.max,
        )
        is_valid = false
    end
    return is_valid
end

function _validate_nonnegative_value(technology, value, field_name)
    if !isfinite(value) || value < 0.0
        @error(
            "$field_name must be finite and nonnegative",
            technology=get_name(technology),
            value,
        )
        return false
    end
    return true
end

function _validate_fraction(technology, value, field_name; strictly_positive=false)
    lower_bound_is_valid = strictly_positive ? value > 0.0 : value >= 0.0
    if !isfinite(value) || !lower_bound_is_valid || value > 1.0
        interval = strictly_positive ? "(0, 1]" : "[0, 1]"
        @error(
            "$field_name must be in $interval",
            technology=get_name(technology),
            value,
        )
        return false
    end
    return true
end

function validate_technology(technology::StorageTechnology)
    is_valid = true

    is_valid &= _validate_nonnegative_limits(
        technology,
        get_duration_limits(technology),
        "Storage duration limits",
    )
    is_valid &= _validate_nonnegative_limits(
        technology,
        get_capacity_limits_energy(technology),
        "Storage energy capacity limits",
    )
    is_valid &= _validate_nonnegative_limits(
        technology,
        get_capacity_limits_discharge(technology),
        "Storage discharge capacity limits",
    )

    charge_capacity_limits = get_capacity_limits_charge(technology)
    if !isnothing(charge_capacity_limits)
        is_valid &= _validate_nonnegative_limits(
            technology,
            charge_capacity_limits,
            "Storage charge capacity limits",
        )
    end

    is_valid &= _validate_nonnegative_value(
        technology,
        get_unit_size_energy(technology),
        "Storage energy unit size",
    )
    is_valid &= _validate_nonnegative_value(
        technology,
        get_unit_size_discharge(technology),
        "Storage discharge unit size",
    )

    charge_unit_size = get_unit_size_charge(technology)
    if !isnothing(charge_unit_size)
        is_valid &= _validate_nonnegative_value(
            technology,
            charge_unit_size,
            "Storage charge unit size",
        )
    end

    is_valid &= _validate_fraction(
        technology,
        get_min_discharge_fraction(technology),
        "Storage minimum discharge fraction",
    )
    is_valid &= _validate_fraction(
        technology,
        get_losses(technology),
        "Storage losses",
    )

    efficiency = get_efficiency(technology)
    is_valid &= _validate_fraction(
        technology,
        efficiency.in,
        "Storage charging efficiency";
        strictly_positive=true,
    )
    is_valid &= _validate_fraction(
        technology,
        efficiency.out,
        "Storage discharging efficiency";
        strictly_positive=true,
    )

    if get_lifetime(technology) <= 0
        @error(
            "Storage lifetime must be positive",
            technology=get_name(technology),
            lifetime=get_lifetime(technology),
        )
        is_valid = false
    end

    return is_valid
end

IS.validate_struct(technology::Technology) = validate_technology(technology)

"""
Validate a technology using data from the portfolio.

Use [`validate_technology`](@ref) when validation only requires data contained within the
technology itself.

Return `true` if the technology is valid.
"""
validate_technology_with_portfolio(::Technology, ::Portfolio) = true

function _validate_unique_references(technology, references, reference_type)
    uuids = IS.get_uuid.(references)
    if !allunique(uuids)
        @error(
            "Storage technology contains duplicate $reference_type references",
            technology=get_name(technology),
        )
        return false
    end
    return true
end

function _validate_attached_references(
    technology,
    references,
    portfolio,
    reference_type,
)
    is_valid = true
    for reference in references
        if !IS.has_component(portfolio.data, reference)
            @error(
                "Storage technology references a $reference_type that is not attached to the portfolio",
                technology=get_name(technology),
                reference=summary(reference),
            )
            is_valid = false
        end
    end
    return is_valid
end

function validate_technology_with_portfolio(
    technology::StorageTechnology,
    portfolio::Portfolio,
)
    is_valid = true
    regions = get_region(technology)
    if isempty(regions)
        @error(
            "Storage technology must reference at least one region",
            technology=get_name(technology),
        )
        is_valid = false
    else
        is_valid &= _validate_unique_references(technology, regions, "region")
        is_valid &=
            _validate_attached_references(technology, regions, portfolio, "region")
    end

    requirements = get_requirements(technology)
    is_valid &= _validate_unique_references(technology, requirements, "requirement")
    is_valid &= _validate_attached_references(
        technology,
        requirements,
        portfolio,
        "requirement",
    )

    return is_valid
end

"""
Check one technology using technology-only and portfolio-aware validation.

Throw [`IS.InvalidValue`](@ref) if the technology is invalid.
"""
function check_technology(portfolio::Portfolio, technology::Technology)
    if !validate_technology(technology) ||
       !validate_technology_with_portfolio(technology, portfolio)
        throw(IS.InvalidValue("Invalid value for $(summary(technology))"))
    end
    return
end

"""
Check every technology in an iterable.

Throw [`IS.InvalidValue`](@ref) when a technology is invalid.
"""
function check_technologies(portfolio::Portfolio, technologies)
    for technology in technologies
        check_technology(portfolio, technology)
    end
    return
end
