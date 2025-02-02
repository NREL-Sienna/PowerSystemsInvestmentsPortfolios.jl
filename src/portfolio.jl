const PORTFOLIO_KWARGS =
    Set((:name, :description, :data_source, :run_checks, :unit_portfolio))

const DEFAULT_AGGREGATION = PSY.ACBus

const PORTFOLIO_STRUCT_DESCRIPTOR_FILE = joinpath(
    dirname(pathof(PowerSystemsInvestmentsPortfolios)),
    "descriptors",
    "portfolio_structs.json",
)

mutable struct PortfolioMetadata <: IS.InfrastructureSystemsType
    name::Union{Nothing, String}
    description::Union{Nothing, String}
    data_source::Union{Nothing, String}
end

#TODO: Define if we are going to support unit systems
#TODO: Make immutable
mutable struct Portfolio <: IS.InfrastructureSystemsType
    aggregation::Type{<:Union{PSY.ACBus, PSY.AggregationTopology}}
    data::IS.SystemData # Inputs to the model
    investment_schedule::Dict # Investment decisions container i.e., model outputs. Container TBD
    #units_settings::IS.SystemUnitsSettings
    time_series_directory::Union{Nothing, String}
    base_system::Union{Nothing, System}
    metadata::PortfolioMetadata
    internal::IS.InfrastructureSystemsInternal

    function Portfolio(
        aggregation,
        data,
        investment_schedule::Dict,
        #units_settings::IS.SystemUnitsSettings,
        internal::IS.InfrastructureSystemsInternal,
        time_series_directory=nothing,
        name=nothing,
        description=nothing,
        data_source=nothing,
        base_system=nothing,
        kwargs...,
    )
        #TODO: Provide support to kwargs
        #=
        unsupported = setdiff(keys(kwargs), PORTFOLIO_KWARGS)
        !isempty(unsupported) && error("Unsupported kwargs = $unsupported")
        if !isnothing(get(kwargs, :unit_system, nothing))
            @warn(
                "unit_system kwarg ignored. The value in SystemUnitsSetting takes precedence"
            )
        end
        =#
        return new(
            aggregation,
            data,
            investment_schedule,
            #units_settings,
            time_series_directory,
            base_system,
            PortfolioMetadata(name, description, data_source),
            internal,
        )
    end
end

#= #TODO: Check how to handle unit settings
function Portfolio(aggregation, discount_rate::Number, data, investment_schedule, internal; kwargs...)
    unit_portfolio_ = get(kwargs, "unit_system", "NATURAL_UNITS")
    unit_portfolio = PSY.UNIT_SYSTEM_MAPPING[unit_portfolio_]
    unit_settings = IS.SystemUnitsSettings(base_power, unit_portfolio)
    return Portfolio(aggregation, data, discount_rate, investment_schedule, unit_settings, internal; kwargs...)
end
=#

"""
Construct an empty `Portfolio`. Useful for building a Portfolio from scratch.
"""
function Portfolio(; kwargs...)
    data = PSY._create_system_data_from_kwargs(; kwargs...)
    return Portfolio(DEFAULT_AGGREGATION, data, Dict(), IS.InfrastructureSystemsInternal())
end

"""
Construct an empty `Portfolio` specifying aggregation. Useful for building a Portfolio from scratch.
"""
function Portfolio(aggregation; kwargs...)
    data = _create_system_data_from_kwargs(; kwargs...)
    return Portfolio(aggregation, data, Dict(), IS.InfrastructureSystemsInternal())
end

"""
Return the internal of the portfolio
"""
IS.get_internal(val::Portfolio) = val.internal

"""
Return a user-modifiable dictionary to store extra information.
"""
get_ext(val::Portfolio) = IS.get_ext(val.internal)

"""
Set the name of the portfolio.
"""
set_name!(val::Portfolio, name::AbstractString) = val.metadata.name = name

"""
Get the name of the portfolio.
"""
get_name(val::Portfolio) = val.metadata.name

"""
Set the description of the portfolio.
"""
set_description!(val::Portfolio, description::AbstractString) =
    val.metadata.description = description

"""
Get the description of the portfolio.
"""
get_description(val::Portfolio) = val.metadata.description

"""
Add a technology to the portfolio.

Throws ArgumentError if the technology's name is already stored for its concrete type.
Throws ArgumentError if any Technology-specific rule is violated.
Throws InvalidValue if any of the technology's field values are outside of defined valid
range.

# Examples

```julia
portfolio = Portfolio(...)

# Add a single technology.
add_technology!(portfolio, bus)

# Add many at once.
foreach(x -> add_technology!(portfolio, x), Iterators.flatten((buses, generators)))
```
"""
function add_technology!(
    portfolio::Portfolio,
    technology::T;
    skip_validation=false,
    kwargs...,
) where {T <: Technology}
    #deserialization_in_progress = _is_deserialization_in_progress(portfolio)
    IS.add_component!(
        portfolio.data,
        technology;
        #allow_existing_time_series=deserialization_in_progress,
        skip_validation=skip_validation,
        kwargs...,
    )

    return
end

"""
Add many technologies to the portfolio at once.

Throws ArgumentError if the technology's name is already stored for its concrete type.
Throws ArgumentError if any Technology-specific rule is violated.
Throws InvalidValue if any of the technology's field values are outside of defined valid
range.

# Examples

```julia
portfolio = Portfolio(100.0)

buses = [bus1, bus2, bus3]
generators = [gen1, gen2, gen3]
foreach(x -> add_technologies!(portfolio, x), Iterators.flatten((buses, generators)))
```
"""
function add_technologies!(::Portfolio, technologies)
    foreach(x -> add_technology!(portfolio, x), technologies)
    return
end

"""
Get the technology of type T with name. Returns nothing if no technology matches. If T is an abstract
type then the names of technologies across all subtypes of T must be unique.

See [`get_technologies_by_name`](@ref) for abstract types with non-unique names across subtypes.

Throws ArgumentError if T is not a concrete type and there is more than one technology with
requested name
"""
function get_technology(
    ::Type{T},
    portfolio::Portfolio,
    name::AbstractString,
) where {T <: Technology}
    return IS.get_component(T, portfolio.data, name)
end

"""
Returns an iterator of technologies. T can be concrete or abstract.
Call collect on the result if an array is desired.

# Examples

```julia
iter = Portfolio.get_technologies(ThermalStandard, portfolio)
iter = Portfolio.get_technologies(Generator, portfolio)
iter = Portfolio.get_technologies(x -> Portfolio.get_available(x), Generator, portfolio)
thermal_gens = get_technologies(ThermalStandard, portfolio) do gen
    get_available(gen)
end
generators = collect(Portfolio.get_technologies(Generator, portfolio))
```

See also: [`iterate_technologies`](@ref)
"""
function get_technologies(::Type{T}, portfolio::Portfolio;) where {T <: Technology}
    return IS.get_components(T, portfolio.data)
end

function get_technologies(
    filter_func::Function,
    ::Type{T},
    portfolio::Portfolio,
) where {T <: Technology}
    return IS.get_components(filter_func, T, portfolio.data)
end

# These are helper functions for debugging problems.
# Searches components linearly, and so is slow compared to the other get_component functions
get_technology(portfolio::Portfolio, uuid::Base.UUID) =
    IS.get_component(portfolio.data, uuid)
get_technology(portfolio::Portfolio, uuid::String) =
    IS.get_component(portfolio.data, Base.UUID(uuid))

function _get_technologies_by_name(
    abstract_types,
    data::IS.SystemData,
    name::AbstractString,
)
    _components = []
    for subtype in abstract_types
        component = IS.get_component(subtype, data, name)
        if !isnothing(component)
            push!(_components, component)
        end
    end

    return _components
end

"""
Get the technologies of abstract type T with name. Note that PowerSystems enforces unique
names on each concrete type but not across concrete types.

See [`get_technology`](@ref) if the concrete type is known.

Throws ArgumentError if T is not an abstract type.
"""
function get_technologies_by_name(
    ::Type{T},
    portfolio::Portfolio,
    name::AbstractString,
) where {T <: Technology}
    return IS.get_components_by_name(T, portfolio.data, name)
end

"""
Gets components availability. Requires type T to have the method get_available implemented.
"""

function get_available_technologies(::Type{T}, portfolio::Portfolio) where {T <: Technology}
    return get_technologies(x -> get_available(x), T, portfolio)
end

"""
Return true if the component is attached to the system.
"""
function is_attached(technology::T, portfolio::Portfolio) where {T <: Technology}
    return is_attached(T, get_name(technology), portfolio)
end

function is_attached(::Type{T}, name, portfolio::Portfolio) where {T <: Technology}
    return !isnothing(get_technology(T, portfolio, name))
end

"""
Throws ArgumentError if the component is not attached to the system.
"""
function throw_if_not_attached(technology::Technology, portfolio::Portfolio)
    if !is_attached(technology, portfolio)
        throw(ArgumentError("$(summary(technology)) is not attached to the system"))
    end
end

"""
Iterates over all techonologies.

# Examples

```julia
for tech in iterate_technologies(portfolio)
    @show tech
end
```

See also: [`get_technologies`](@ref)
"""
function iterate_technologies(portfolio::Portfolio)
    return IS.iterate_components(portfolio.data)
end

"""
Remove all technologies from the portfolio.
"""
function clear_technologies!(portfolio::Portfolio)
    return IS.clear_components!(portfolio.data)
end

"""
Remove all technologies of type T from the portfolio.

Throws ArgumentError if the type is not stored.
"""
function remove_technologies!(portfolio::Portfolio, ::Type{T}) where {T <: Technology}
    components = IS.remove_components!(T, portfolio.data)
    for component in components
        handle_component_removal!(portfolio, component)
    end
    return components
end

function remove_technologies!(
    filter_func::Function,
    portfolio::Portfolio,
    ::Type{T},
) where {T <: Technology}
    components = collect(get_technologies(filter_func, T, portfolio))
    for component in components
        remove_technology!(portfolio, component)
    end
    return components
end

handle_technology_removal!(::Portfolio, technology::Technology) = nothing

function handle_component_removal!(portfolio::Portfolio, technology::Technology)
    _handle_technology_removal_common!(technology)
    # This may have to be refactored if handle_component_removal! needs to be implemented
    # for a subtype.
    # TODO: Check if clear_services makes sense for technologies
    # clear_services!(technology)
    return
end

function _handle_technology_removal_common!(technology)
    clear_units!(technology)
end

###################################
########### Time Series ###########
###################################

"""
Add time series data to a component.

Throws ArgumentError if the component is not stored in the system.
"""
function add_time_series!(
    portfolio::Portfolio,
    component::Technology,
    time_series::PSY.TimeSeriesData,
)
    return IS.add_time_series!(portfolio.data, component, time_series)
end

"""
Add the same time series data to multiple components.

This is significantly more efficent than calling `add_time_series!` for each component
individually with the same data because in this case, only one time series array is stored.

Throws ArgumentError if a component is not stored in the system.
"""
function add_time_series!(
    portfolio::Portfolio,
    technologies,
    time_series::PSY.TimeSeriesData,
)
    return IS.add_time_series!(portfolio.data, technologies, time_series)
end

"""
Return the compression settings used for system data such as time series arrays.
"""
get_compression_settings(portfolio::Portfolio) = IS.get_compression_settings(portfolio.data)

"""
Return the resolution for all time series.
"""
get_time_series_resolution(portfolio::Portfolio) =
    IS.get_time_series_resolution(portfolio.data)

"""
Remove all time series data from the system.
"""
function clear_time_series!(portfolio::Portfolio)
    return IS.clear_time_series!(portfolio.data)
end

"""
Remove the time series data for a component and time series type.
"""
function remove_time_series!(
    portfolio::Portfolio,
    ::Type{T},
    component::PSY.Component,
    name::String,
) where {T <: PSY.TimeSeriesData}
    return IS.remove_time_series!(portfolio.data, T, component, name)
end

"""
Remove all the time series data for a time series type.
"""
function remove_time_series!(
    portfolio::Portfolio,
    ::Type{T},
) where {T <: PSY.TimeSeriesData}
    return IS.remove_time_series!(portfolio.data, T)
end

#=
### Not sure if these methods make sense for technologies
"""
Set the name for a technology that is attached to the Portfolio.
"""
set_name!(portfolio::Portfolio, technology::Technology, name::AbstractString) =
    set_name!(portfolio.data, technology, name)

"""
Set the name of a technology.

Throws an exception if the technology is attached to a system.
TODO: Check if this method makes sense here
"""
function set_name!(technology::Technology, name::AbstractString)
    # The units setting is nothing until the component is attached to the system.
    if get_units_setting(technology) !== nothing
        # This is not allowed because components are stored in the system in a Dict
        # keyed by name.
        error(
            "The component is attached to a system. " *
            "Call set_name!(system, component, name) instead.",
        )
    end

    technology.name = name
end

"""
Check system consistency and validity.
"""
function check(sys::System)
    buses = get_components(ACBus, sys)
    slack_bus_check(buses)
    buscheck(buses)
    critical_components_check(sys)
    adequacy_check(sys)
    return
end

=#

function clear_units!(technology::Technology)
    get_internal(technology).units_info = nothing
    return
end

"""
Remove a technology from the portfolio by its value.

Throws ArgumentError if the technology is not stored.
"""
function remove_technology!(portfolio::Portfolio, technology::T) where {T <: Technology}
    check_technology_removal(portfolio, technology)
    IS.remove_component!(portfolio.data, technology)
    handle_technology_removal!(portfolio, technology)
    return
end

"""
Remove a technology from the portfolio by its name.

Throws ArgumentError if the component is not stored.
"""
function remove_technology!(
    ::Type{T},
    portfolio::Portfolio,
    name::AbstractString,
) where {T <: Technology}
    tech = IS.remove_component!(T, portfolio.data, name)
    handle_technology_removal!(portfolio, tech)
    return
end

"""
Throws ArgumentError if a PowerSystemsInvestmentPorfol rule blocks removal from the system.
"""
function check_technology_removal(
    portfolio::Portfolio,
    technology::T,
) where {T <: Technology}
    # TODO: Implement checks if needed
    if 1 == 2
        throw(
            ArgumentError(
                "Tech $(get_name(technology)) cannot be removed for a specific logic",
            ),
        )
        return
    end
end

"""
Check to see if the technology of type T with name exists.
"""
function has_technology(
    ::Type{T},
    portfolio::Portfolio,
    name::AbstractString,
) where {T <: Portfolio}
    return IS.has_component(T, portfolio.data.components, name)
end

function Portfolio(file_path::AbstractString; assign_new_uuids=false, kwargs...)
    ext = splitext(file_path)[2]
    if lowercase(ext) in [".m", ".raw"]
        pm_kwargs = Dict(k => v for (k, v) in kwargs if !in(k, PORTFOLIO_KWARGS))
        sys_kwargs = Dict(k => v for (k, v) in kwargs if in(k, PORTFOLIO_KWARGS))
        return System(PowerModelsData(file_path; pm_kwargs...); sys_kwargs...)
    elseif lowercase(ext) == ".json"
        unsupported = setdiff(keys(kwargs), PORTFOLIO_KWARGS)
        !isempty(unsupported) && error("Unsupported kwargs = $unsupported")
        runchecks = get(kwargs, :runchecks, true)
        time_series_read_only = get(kwargs, :time_series_read_only, false)
        time_series_directory = get(kwargs, :time_series_directory, nothing)
        config_path = get(kwargs, :config_path, PORTFOLIO_STRUCT_DESCRIPTOR_FILE)
        portfolio = deserialize(
            Portfolio,
            file_path;
            # time_series_read_only = time_series_read_only,
            # runchecks = runchecks,
            # time_series_directory = time_series_directory,
            # config_path = config_path,
        )
        _post_deserialize_handling(
            portfolio;
            runchecks=runchecks,
            assign_new_uuids=assign_new_uuids,
        )
        return portfolio
    else
        throw(DataFormatError("$file_path is not a supported file type"))
    end
end

################################
######### Regions #########
################################

"""
Add a region to the portfolio.

Throws ArgumentError if the region's name is already stored for its concrete type.
Throws ArgumentError if any region-specific rule is violated.
Throws InvalidValue if any of the region's field values are outside of defined valid
range.

# Examples

```julia
portfolio = Portfolio(...)

# Add a single technology.
add_region!(portfolio, zone)

# Add many at once.
foreach(x -> add_region!(portfolio, x), Iterators.flatten((buses, generators)))
```
"""

function add_region!(
    portfolio::Portfolio,
    zone::T;
    skip_validation=false,
    kwargs...,
) where {T <: Region}
    #deserialization_in_progress = _is_deserialization_in_progress(portfolio)
    IS.add_component!(
        portfolio.data,
        zone;
        #allow_existing_time_series=deserialization_in_progress,
        skip_validation=skip_validation,
        kwargs...,
    )

    return
end

"""
Returns an iterator of regions. T can be concrete or abstract.
Call collect on the result if an array is desired.

# Examples

```julia
iter = Portfolio.get_regions(Zone, portfolio)
iter = Portfolio.get_regions(Region, portfolio)
regions = collect(Portfolio.get_regions(Region, portfolio))
```

"""

function get_regions(::Type{T}, portfolio::Portfolio;) where {T <: Region}
    return IS.get_components(T, portfolio.data)
end

################################
######### Requirements #########
################################

"""
Add policy requirement to portfolio
"""
function add_requirement!(portfolio::Portfolio, req::Requirements)
    #return PSY.add_service!(portfolio.data, req)
    #skip_validation = false
    #skip_validation = _validate_or_skip!(sys, service, skip_validation)
    return IS.add_component!(portfolio.data, req, skip_validation=false)
end

function get_requirements(::Type{T}, portfolio::Portfolio;) where {T <: Requirements}
    return IS.get_components(T, portfolio.data)
end

################################
######### Financials #########
################################

"""
Add financial data to portfolio
"""
function add_financials!(portfolio::Portfolio, fin::Financials)
    #return PSY.add_service!(portfolio.data, req)
    #skip_validation = false
    #skip_validation = _validate_or_skip!(sys, service, skip_validation)
    return IS.add_component!(portfolio.data, fin, skip_validation=false)
end

function get_financials(::Type{T}, portfolio::Portfolio;) where {T <: Financials}
    return IS.get_components(T, portfolio.data)
end

###########################################
######### Supplemental Attributes #########
###########################################

"""
Add a supplemental attribute to a technology. The attribute may already be attached to a
different component.
"""
function add_supplemental_attribute!(
    p::Portfolio,
    component::IS.InfrastructureSystemsComponent,
    attribute::IS.SupplementalAttribute,
)
    return IS.add_supplemental_attribute!(p.data, component, attribute)
end

"""
Remove the supplemental attribute from the component. The attribute will be removed from the
system if it is not attached to any other component.
"""
function remove_supplemental_attribute!(
    p::Portfolio,
    component::IS.InfrastructureSystemsComponent,
    attribute::IS.SupplementalAttribute,
)
    return IS.remove_supplemental_attribute!(p.data, component, attribute)
end

"""
Remove the supplemental attribute from the system and all attached components.
"""
function remove_supplemental_attribute!(p::Portfolio, attribute::IS.SupplementalAttribute)
    return IS.remove_supplemental_attribute!(p.data, attribute)
end

"""
Remove all supplemental attributes with the given type from the system.
"""
function remove_supplemental_attributes!(
    ::Type{T},
    p::Portfolio,
) where {T <: IS.SupplementalAttribute}
    return IS.remove_supplemental_attributes!(T, p.data)
end

"""
Return the supplemental attribute with the given uuid.

Throws ArgumentError if the attribute is not stored.
"""
function get_supplemental_attribute(p::Portfolio, uuid::Base.UUID)
    return IS.get_supplemental_attribute(p.data, uuid)
end

"""
Return the internal of a supplemental attribute, required to add to IS for SupplementalAttributes to work
"""
IS.get_internal(val::IS.SupplementalAttribute) = val.internal
