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
            IS.get_masked_components(IS.InfrastructureSystemsComponent, portfolio.data)
            assign_new_uuid!(portfolio, component)
        end
        # Note: this does not change UUIDs for time series data because they are
        # shared with components.
    end
end
