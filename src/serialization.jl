# These will get encoded into each dictionary when a struct is serialized.
const METADATA_KEY = "__metadata__"
const TYPE_KEY = "type"
const MODULE_KEY = "module"
const PARAMETERS_KEY = "parameters"
const CONSTRUCT_WITH_PARAMETERS_KEY = "construct_with_parameters"
const FUNCTION_KEY = "function"
const SYSTEM_KWARGS = Set((
    :internal,
    :runchecks,
    :time_series_directory,
    :time_series_in_memory,
    :time_series_read_only,
    :timeseries_metadata_file,
    :name,
    :description,
))

"""Constructs a Portfolio from a file path ending with .json

If the file is JSON, then `assign_new_uuids = true` will generate new UUIDs for the system
and all components.
"""
function Portfolio(
    file_path::AbstractString;
    assign_new_uuids = false,
    try_reimport = true,
    kwargs...,
)
    ext = lowercase(splitext(file_path)[2])
    if ext == ".json"
        unsupported = setdiff(keys(kwargs), SYSTEM_KWARGS)
        !isempty(unsupported) && error("Unsupported kwargs = $unsupported")
        # runchecks = get(kwargs, :runchecks, true)
        time_series_read_only = get(kwargs, :time_series_read_only, false)
        time_series_directory = get(kwargs, :time_series_directory, nothing)
        portfolio = deserialize(
            Portfolio,
            file_path;
            time_series_read_only = time_series_read_only,
            # runchecks = runchecks,
            time_series_directory = time_series_directory,
        )
        _post_deserialize_handling(
            portfolio;
            # runchecks = runchecks,
            assign_new_uuids = assign_new_uuids,
        )
        return portfolio
    else
        throw(DataFormatError("$file_path is not a supported file type"))
    end
end

function IS.serialize(portfolio::T) where {T <: Portfolio}
    data = Dict{String, Any}()
    data["data_format_version"] = DATA_FORMAT_VERSION
    for field in fieldnames(T)
        # Exclude time_series_directory because the portfolio may get deserialized on a
        # different portfolio.
        if field != :time_series_directory
            data[string(field)] = serialize(getfield(portfolio, field))
        end
    end
    return data
end

function IS.deserialize(::Type{Portfolio}, filename::AbstractString; kwargs...)
    raw = open(filename) do io
        JSON3.read(io, Dict)
    end

    if raw["data_format_version"] != DATA_FORMAT_VERSION
        pre_read_conversion!(raw)
    end

    # These file paths are relative to the portfolio file.
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
Serialize the value, encoding as UUIDs where necessary.
"""
function serialize_uuid_handling(val)
    if should_encode_as_uuid(val)
        if val isa Array
            value = IS.get_uuid.(val)
        elseif val === nothing
            value = nothing
        else
            value = IS.get_uuid(val)
        end
    else
        value = val
    end

    return serialize(value)
end

function serialize_struct(val::T) where {T}
    data = Dict{String, Any}(
        string(name) => serialize(getproperty(val, name)) for name in fieldnames(T)
    )
    add_serialization_metadata!(data, T)
    return data
end

function serialize(technology::Technology)
    api_struct = serialize_openapi_struct(technology)

    struct_type = typeof(technology)
    api_type = typeof(api_struct)

    # Build OpenAPI struct from modeling struct
    for field in fieldnames(api_type)

        #For fields with references to other structs, serialize with
        #the name of that struct
        if field == :region || field == :financial_data || field == :start_region || field == :end_region
            value = get_name(getfield(technology, field))

        #convert enums to strings
        elseif field == :prime_mover_type || field == :fuel || field == :storage_tech
            value = string(getfield(technology, field))

        else
            value = getfield(technology, field)
        end

        setfield!(api_struct, field, value)

    end

    data = Dict{String, Any}(
        string(name) => serialize(getproperty(api_struct, name)) for name in fieldnames(typeof(api_struct))
    )

    add_serialization_metadata!(data, struct_type)
    if !isempty(struct_type.parameters)
        data[IS.METADATA_KEY][IS.CONSTRUCT_WITH_PARAMETERS_KEY] = true
    end

    return data

end

"""
Add type information to the dictionary that can be used to deserialize the value.
"""
function add_serialization_metadata!(data::Dict, ::Type{T}) where {T}
    data[METADATA_KEY] = Dict{String, Any}(
        TYPE_KEY => string(nameof(T)),
        MODULE_KEY => string(parentmodule(T)),
    )
    if !isempty(T.parameters)
        data[METADATA_KEY][PARAMETERS_KEY] = [string(nameof(x)) for x in T.parameters]
    end

    return
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
        "base_system",
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

    # Initialize empty portfolio without component data
    metadata = get(raw, "metadata", Dict())
    name = get(metadata, "name", nothing)
    description = get(metadata, "description", nothing)
    internal = IS.deserialize(InfrastructureSystemsInternal, raw["internal"])
    aggregation = PSY.ACBus
    investment_schedule = raw["investment_schedule"]
    data = IS.deserialize(
        IS.SystemData,
        raw["data"];
        time_series_read_only=time_series_read_only,
        time_series_directory=time_series_directory,
        validation_descriptor_file=config_path,
    )

    portfolio = Portfolio(;
        data=data,
        aggregation=aggregation,
        investment_schedule=investment_schedule,
        internal=internal,
        name = name,
        description = description,
        parsed_kwargs...,
    )

    # units = IS.deserialize(SystemUnitsSettings, raw["units_settings"])
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

# Function copied over from IS. This version of the function is modified to not use the internal field for components,
# since the internal field is not stored in the JSON when serializing with OpenAPI structs
function IS.deserialize(
    ::Type{IS.SystemData},
    raw::Dict;
    time_series_read_only = false,
    time_series_directory = nothing,
    validation_descriptor_file = nothing,
    kwargs...,
)
    if haskey(raw, "time_series_storage_file")
        if !isfile(raw["time_series_storage_file"])
            error("time series file $(raw["time_series_storage_file"]) does not exist")
        end
        # TODO: need to address this limitation
        if IS.strip_module_name(raw["time_series_storage_type"]) == "InMemoryTimeSeriesStorage"
            @info "Deserializing with InMemoryTimeSeriesStorage is currently not supported. Using HDF"
            #hdf5_storage = Hdf5TimeSeriesStorage(raw["time_series_storage_file"], true)
            #time_series_storage = InMemoryTimeSeriesStorage(hdf5_storage)
        end
        time_series_storage = IS.from_file(
            IS.Hdf5TimeSeriesStorage,
            raw["time_series_storage_file"];
            directory = time_series_directory,
            read_only = time_series_read_only,
        )
        time_series_metadata_store = IS.from_h5_file(
            IS.TimeSeriesMetadataStore,
            time_series_storage.file_path,
            time_series_directory,
        )
    else
        time_series_storage = IS.make_time_series_storage(;
            compression = CompressionSettings(;
                enabled = get(raw, "time_series_compression_enabled", DEFAULT_COMPRESSION),
            ),
            directory = time_series_directory,
        )
        time_series_metadata_store = nothing
    end

    time_series_manager = IS.TimeSeriesManager(;
        data_store = time_series_storage,
        read_only = time_series_read_only,
        metadata_store = time_series_metadata_store,
    )
    @show time_series_metadata_store
    subsystems = Dict(k => Set(Base.UUID.(v)) for (k, v) in raw["subsystems"])
    supplemental_attribute_manager = IS.deserialize(
        IS.SupplementalAttributeManager,
        get(
            raw,
            "supplemental_attribute_manager",
            Dict("attributes" => [], "associations" => []),
        ),
        time_series_manager,
    )
    internal = IS.deserialize(IS.InfrastructureSystemsInternal, raw["internal"])
    validation_descriptors = if isnothing(validation_descriptor_file)
        []
    else
        IS.read_validation_descriptor(validation_descriptor_file)
    end

    sys = IS.SystemData(
        validation_descriptors,
        time_series_manager,
        subsystems,
        supplemental_attribute_manager,
        internal,
    )
    attributes_by_uuid = Dict{Base.UUID, SupplementalAttribute}()
    for attr_dict in values(supplemental_attribute_manager.data)
        for attr in values(attr_dict)
            uuid = IS.get_uuid(attr)
            if haskey(attributes_by_uuid, uuid)
                error("Bug: Found duplicate supplemental attribute UUID: $uuid")
            end
            attributes_by_uuid[uuid] = attr
        end
    end

    # Note: components need to be deserialized by the parent so that they can go through
    # the proper checks.
    return sys
end


function deserialize_components!(portfolio::Portfolio, raw)
    # Convert the array of components into type-specific arrays to allow addition by type.
    # Need to maintain an order here. Deserialize regions and financials first so they can
    # be referenced when deserializing technologies
    technologies = OrderedDict{Any, Vector{Dict}}()
    regions = OrderedDict{Any, Vector{Dict}}()
    for component in raw["components"]
        type = IS.get_type_from_serialization_data(component)
        if type <: Region || type <: Financials
            components = get(regions, type, nothing)
            if components === nothing
                components = Vector{Dict}()
                regions[type] = components
            end
        else
            components = get(technologies, type, nothing)
            if components === nothing
                components = Vector{Dict}()
                technologies[type] = components
            end
        end
        push!(components, component)
    end
    data=merge(regions, technologies)

    # Maintain a lookup of UUID to component because some component types encode
    # composed types as UUIDs instead of actual types.
    # Can remove this I think since we aren't using UUIDs anymore to encode
    component_cache = Dict{Base.UUID, InfrastructureSystemsComponent}()

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
                #TODO: See if component cache is needed
                api_component = deserialize_openapi_struct(type, component)
                model_component = build_model_struct(api_component, portfolio, component["__metadata__"])
                IS.add_component!(portfolio.data, model_component)
                component_cache[IS.get_uuid(model_component)] = model_component
                if !isnothing(post_add_func)
                    post_add_func(model_component)
                end
            end
            push!(parsed_types, type)
            
        end
    end

    deserialize_and_add!()
end

function build_model_struct(base_struct, portfolio::Portfolio, metadata::Dict{String, Any})
    vals = Dict{Symbol, Any}()
    struct_type = typeof(base_struct)
    for (name, type) in zip(fieldnames(struct_type), fieldtypes(struct_type))
        vals[name] = getfield(base_struct, name)
        if name == :region || name == :start_region || name == :end_region
            vals[name] = get_region(Region, portfolio, getfield(base_struct, name))
        elseif name==:financial_data
            vals[name] = get_financial(TechnologyFinancialData, portfolio, getfield(base_struct, name))
        elseif name==:prime_mover_type
            vals[name] = PrimeMovers(getfield(base_struct, name))
        elseif name==:fuel
            vals[name] = ThermalFuels(getfield(base_struct, name))
        elseif name==:storage_tech
            vals[name] = StorageTech(getfield(base_struct, name))
        end
    end

    struct_type_string = metadata["type"]
    struct_type = getproperty(PowerSystemsInvestmentsPortfolios, Symbol(struct_type_string))
    if haskey(metadata, "parameters")
        # = [getproperty(_module, Symbol(x)) for x in metadata[PARAMETERS_KEY]]
        parameter_string = metadata["parameters"][1]
        #TODO: Generalize this later. Will all future parameterizing be with PSY structs?
        parameter = getproperty(PowerSystems, Symbol(parameter_string))
        model_struct = struct_type{parameter}(; vals...)
    else
        model_struct = struct_type(; vals...)
    end

    return model_struct
end

# PSIP types with fields that we should_encode_as_uuid
# Okay this probably shouldn't exist anymore since we aren't doing that but run with it for now
const _CONTAINS_SHOULD_ENCODE = Union{Technology, Region, Financials, Requirements}

function IS.deserialize(
    ::Type{T},
    data::Dict,
    component_cache::Dict,
) where {T <: _CONTAINS_SHOULD_ENCODE}
    vals = Dict{Symbol, Any}()
    for (name, type) in zip(fieldnames(T), fieldtypes(T))
        field_name = string(name)
        if haskey(data, field_name)
            val = data[field_name]
        else
            continue
        end
        if val isa Dict && haskey(val, IS.METADATA_KEY)
            vals[name] = deserialize_uuid_handling(
                IS.get_type_from_serialization_metadata(IS.get_serialization_metadata(val)),
                val,
                component_cache,
            )
        else
            vals[name] = deserialize_uuid_handling(type, val, component_cache)
        end
    end

    type = IS.get_type_from_serialization_metadata(data[IS.METADATA_KEY])

    base_struct = deserialize_openapi_struct(type, vals...)

    return base_struct
end

const _ENCODE_AS_UUID_A = (
    #    Union{Nothing, SupplyTechnology},
    #    Union{Nothing, StorageTechnology},
    #    Union{Nothing, DemandRequirement},
    Union{Nothing, Zone},
    Union{Nothing, ACTransportTechnology, HVDCTransportTechnology},
    Vector{Requirements},
)
const _ENCODE_AS_UUID_B =
    (Zone, ACTransportTechnology, HVDCTransportTechnology, Vector{Requirements})

should_encode_as_uuid(val) = any(x -> val isa x, _ENCODE_AS_UUID_B)
should_encode_as_uuid(::Type{T}) where {T} = any(x -> T <: x, _ENCODE_AS_UUID_A)

"""
Allow types to implement handling of special cases during deserialization.

# Arguments

  - `component::Dict`: The component serialized as a dictionary.
  - `::Type`: The type of the technology.
"""
handle_deserialization_special_cases!(component::Dict, ::Type{<:InfrastructureSystemsComponent}) = nothing

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
  - `runchecks::Bool = false`: whether to run portfolio validation checks

Refer to [`check_component`](@ref) for exceptions thrown if `check = true`.
"""
function to_json(
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

"""
Serializes a InfrastructureSystemsType to a JSON string.
"""
function to_json(obj::T; pretty = false, indent = 2) where {T <: InfrastructureSystemsType}
    try
        if pretty
            io = IOBuffer()
            JSON3.pretty(io, serialize(obj), JSON3.AlignmentContext(; indent = indent))
            return take!(io)
        else
            return JSON3.write(serialize(obj))
        end
    catch e
        @error "Failed to serialize $(summary(obj))"
        rethrow(e)
    end
end

function _serialize_portfolio_metadata_to_file(portfolio::Portfolio, filename, user_data)
    name = get_name(portfolio)
    description = get_description(portfolio)
    resolution = get_time_series_resolution(portfolio)[1]
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
