"""
Validate a technology using only information contained within the technology.

Return `true` if the technology is valid.
"""
validate_technology(::Technology) = true

function validate_technology(technology::StorageTechnology)
    duration_limits = get_duration_limits(technology)
    if !(duration_limits.min <= duration_limits.max)
        @error(
            "Storage duration limits must be in ascending order",
            technology=get_name(technology),
            minimum=duration_limits.min,
            maximum=duration_limits.max,
        )
        return false
    end
    return true
end

IS.validate_struct(technology::Technology) = validate_technology(technology)

"""
Check one technology using technology-only and portfolio-aware validation.

Throw [`IS.InvalidValue`](@ref) if the technology is invalid.
"""
function check_technology(portfolio::Portfolio, technology::Technology)
    if !validate_technology(technology) ||
       !validate_component_with_system(technology, portfolio)
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
