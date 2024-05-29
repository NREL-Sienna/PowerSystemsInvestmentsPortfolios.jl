const PORTFOLIO_KWARGS =
    Set((:name, :description, :data_source, :run_checks, :unit_portfolio))

const DEFAULT_DISCOUNT_RATE = 0.07
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
struct Portfolio <: IS.InfrastructureSystemsType
    aggregation::Type{<:Union{PSY.ACBus, PSY.AggregationTopology}}
    discount_rate::Float64
    data::IS.SystemData # Inputs to the model
    investment_schedule::Dict # Investment decisions container i.e., model outputs. Container TBD
    #units_settings::IS.SystemUnitsSettings
    time_series_directory::Union{Nothing, String}
    metadata::PortfolioMetadata
    internal::IS.InfrastructureSystemsInternal

    function Portfolio(
        aggregation,
        discount_rate::Float64,
        data,
        investment_schedule::Dict,
        #units_settings::IS.SystemUnitsSettings,
        internal::IS.InfrastructureSystemsInternal,
        time_series_directory=nothing,
        name=nothing,
        description=nothing,
        data_source=nothing,
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
            discount_rate,
            data,
            investment_schedule,
            #units_settings,
            time_series_directory,
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
function Portfolio(discount_rate; kwargs...)
    data = PSY._create_system_data_from_kwargs(; kwargs...)
    return Portfolio(
        DEFAULT_AGGREGATION,
        discount_rate,
        data,
        Dict(),
        IS.InfrastructureSystemsInternal(),
    )
end

"""
Construct an empty `Portfolio` specifying aggregation. Useful for building a Portfolio from scratch.
"""
function Portfolio(aggregation, discount_rate; kwargs...)
    data = _create_system_data_from_kwargs(; kwargs...)
    return Portfolio(
        aggregation,
        discount_rate,
        data,
        Dict(),
        IS.InfrastructureSystemsInternal(),
    )
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
Add a technology to the portfoliotem.

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
    deserialization_in_progress = _is_deserialization_in_progress(portfolio)
    IS.add_component!(
        portfolio.data,
        technology;
        allow_existing_time_series=deserialization_in_progress,
        skip_validation=skip_validation,
        kwargs...,
    )

    return
end

"""
Add many technologies to the portfoliotem at once.

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

function IS.serialize(portfolio::T) where {T <: Portfolio}
    data = Dict{String, Any}()
    data["data_format_version"] = DATA_FORMAT_VERSION
    for field in fieldnames(T)
        # Exclude bus_numbers because they will get rebuilt during deserialization.
        # Exclude time_series_directory because the portfolio may get deserialized on a
        # different portfolio.
        if field != :bus_numbers && field != :time_series_directory
            data[string(field)] = serialize(getfield(portfolio, field))
        end
    end

    return data
end

function IS.deserialize(::Type{Portfolio}, filename::AbstractString, kwargs...)
    raw = open(filename) do io
        JSON3.read(io, Dict)
    end

    if raw["data_format_version"] != DATA_FORMAT_VERSION
        pre_read_conversion!(raw)
    end

    # These file paths are relative to the system file.
    directory = dirname(filename)
    for file_key in ("time_series_storage_file",)
        if haskey(raw["data"], file_key) && !isabspath(raw["data"][file_key])
            raw["data"][file_key] = joinpath(directory, raw["data"][file_key])
        end
    end
    # return raw
    return from_dict(Portfolio, raw; kwargs...)
end

"""
Clear any value stored in ext.
"""
clear_ext!(sys::Portfolio) = IS.clear_ext!(sys.internal)

function from_dict(
    ::Type{Portfolio},
    raw::Dict{String, Any};
    time_series_read_only=false,
    time_series_directory=nothing,
    config_path=PORTFOLIO_STRUCT_DESCRIPTOR_FILE,
    kwargs...,
)
    # Read any field that is defined in Portfolio but optional for the constructors and not
    # already handled here.

    handled = (
        "aggregation",
        "discount_rate",
        "data",
        "investment_schedule",
        "time_series_directory",
        "time_series_container",
        "metadata",
        "internal",
    )
    parsed_kwargs = Dict{Symbol, Any}()
    for field in setdiff(keys(raw), handled)
        parsed_kwargs[Symbol(field)] = raw[field]
    end

    # The user can override the serialized runchecks value by passing a kwarg here.
    if haskey(kwargs, :runchecks)
        parsed_kwargs[:runchecks] = kwargs[:runchecks]
    end

    # units = IS.deserialize(SystemUnitsSettings, raw["units_settings"])
    data = IS.deserialize(
        IS.SystemData,
        raw["data"];
        time_series_read_only=time_series_read_only,
        time_series_directory=time_series_directory,
        validation_descriptor_file=config_path,
    )
    metadata = get(raw, "metadata", Dict())
    name = get(metadata, "name", nothing)
    description = get(metadata, "description", nothing)
    internal = IS.deserialize(InfrastructureSystemsInternal, raw["internal"])
    aggregation = PSY.ACBus
    discount_rate = raw["discount_rate"]
    investment_schedule = raw["investment_schedule"]
    portfolio = Portfolio(
        aggregation,
        discount_rate,
        data,
        investment_schedule,
        internal,
        # name = name,
        # description = description,
        # parsed_kwargs...,
    )

    if raw["data_format_version"] != DATA_FORMAT_VERSION
        pre_deserialize_conversion!(raw, portfolio)
    end

    ext = get_ext(portfolio)
    ext["deserialization_in_progress"] = true
    try
        deserialize_components!(portfolio, raw["data"])
    finally
        pop!(ext, "deserialization_in_progress")
        isempty(ext) && clear_ext!(portfolio)
    end

    # if !get_runchecks(portfolio)
    #     @warn "The System was deserialized with checks disabled, and so was not validated."
    # end

    if raw["data_format_version"] != DATA_FORMAT_VERSION
        post_deserialize_conversion!(portfolio, raw)
    end

    return portfolio
end

function deserialize_components!(sys::Portfolio, raw)
    # Convert the array of components into type-specific arrays to allow addition by type.
    data = Dict{Any, Vector{Dict}}()

    for component in raw["components"]
        type = IS.get_type_from_serialization_data(component)
        components = get(data, type, nothing)
        if components === nothing
            components = Vector{Dict}()
            data[type] = components
        end
        push!(components, component)
    end

    # Maintain a lookup of UUID to component because some component types encode
    # composed types as UUIDs instead of actual types.
    component_cache = Dict{Base.UUID, Technology}()

    # Add each type to this as we parse.
    parsed_types = Set()

    function is_matching_type(type, types)
        return any(x -> type <: x, types)
    end

    function deserialize_and_add!(;
        skip_types=nothing,
        include_types=nothing,
        post_add_func=nothing,
    )
        for (type, components) in data
            type in parsed_types && continue
            if !isnothing(skip_types) && is_matching_type(type, skip_types)
                continue
            end
            if !isnothing(include_types) && !is_matching_type(type, include_types)
                continue
            end
            for component in components
                handle_deserialization_special_cases!(component, type)
                comp = deserialize(type, component, component_cache)
                add_technology!(sys, comp)
                component_cache[IS.get_uuid(comp)] = comp
                if !isnothing(post_add_func)
                    post_add_func(comp)
                end
            end
            push!(parsed_types, type)
        end
    end

    deserialize_and_add!()
end

"""
Allow types to implement handling of special cases during deserialization.

# Arguments

  - `component::Dict`: The component serialized as a dictionary.
  - `::Type`: The type of the technology.
"""
handle_deserialization_special_cases!(component::Dict, ::Type{<:Technology}) = nothing

function _is_deserialization_in_progress(portfolio::Portfolio)
    ext = get_ext(portfolio)
    return get(ext, "deserialization_in_progress", false)
end

"""
Serializes a portfolio to a JSON file and saves time series to an HDF5 file.

# Arguments

  - `portfolio::Portfolio`: portfolio
  - `filename::AbstractString`: filename to write

# Keyword arguments

  - `user_data::Union{Nothing, Dict} = nothing`: optional metadata to record
  - `pretty::Bool = false`: whether to pretty-print the JSON
  - `force::Bool = false`: whether to overwrite existing files
  - `check::Bool = false`: whether to run portfolio validation checks

Refer to [`check_component`](@ref) for exceptions thrown if `check = true`.
"""
function IS.to_json(
    portfolio::Portfolio,
    filename::AbstractString;
    user_data=nothing,
    pretty=false,
    force=false,
    runchecks=false,
)
    # TODO: add checks for portfolio and technology
    # if runchecks
    #     check(portfolio)
    #     check_technologies(portfolio)
    # end

    IS.prepare_for_serialization_to_file!(portfolio.data, filename; force=force)
    data = to_json(portfolio; pretty=pretty)
    open(filename, "w") do io
        write(io, data)
    end

    mfile = joinpath(dirname(filename), splitext(basename(filename))[1] * "_metadata.json")
    _serialize_portfolio_metadata_to_file(portfolio, mfile, user_data)
    @info "Serialized Portfolio to $filename"

    return
end

function _serialize_portfolio_metadata_to_file(portfolio::Portfolio, filename, user_data)
    name = get_name(portfolio)
    description = get_description(portfolio)
    resolution = get_time_series_resolution(portfolio).value
    metadata = OrderedDict(
        "name" => isnothing(name) ? "" : name,
        "description" => isnothing(description) ? "" : description,
        "time_series_resolution_milliseconds" => resolution,
        "component_counts" => IS.get_component_counts_by_type(portfolio.data),
        "time_series_counts" => IS.get_time_series_counts_by_type(portfolio.data),
    )
    if !isnothing(user_data)
        metadata["user_data"] = user_data
    end

    open(filename, "w") do io
        JSON3.pretty(io, metadata)
    end

    @info "Serialized Portfolio metadata to $filename"
end

"""
If assign_new_uuids = true, generate new UUIDs for the portfolio and all components.

Warning: time series data is not restored by this method. If that is needed, use the normal
process to construct the portfolio from a serialized JSON file instead, such as with
`Portfolio("portfolio.json")`.
"""
function IS.from_json(
    io::Union{IO, String},
    ::Type{Portfolio};
    runchecks=true,
    assign_new_uuids=false,
    kwargs...,
)
    data = JSON3.read(io, Dict)
    # These objects could be removed in to_json(portfolio). Doing it here will allow us to
    # keep that JSON string fully consistent with time series and potentially use it in the
    # future.
    for component in data["data"]["components"]
        if haskey(component, "time_series_container")
            empty!(component["time_series_container"])
        end
    end

    portfolio = from_dict(Portfolio, data; kwargs...)
    _post_deserialize_handling(
        portfolio;
        runchecks=runchecks,
        assign_new_uuids=assign_new_uuids,
    )
    return portfolio
end

function _post_deserialize_handling(
    portfolio::Portfolio;
    runchecks=true,
    assign_new_uuids=false,
)
    # runchecks && check(portfolio)
    if assign_new_uuids
        IS.assign_new_uuid!(portfolio)
        for component in get_components(Technology, portfolio)
            assign_new_uuid!(portfolio, component)
        end
        for component in
            IS.get_masked_components(InfrastructureSystemsComponent, portfolio.data)
            assign_new_uuid!(portfolio, component)
        end
        # Note: this does not change UUIDs for time series data because they are
        # shared with components.
    end
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
