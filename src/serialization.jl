# These will get encoded into each dictionary when a struct is serialized.
const METADATA_KEY = "__metadata__"
const TYPE_KEY = "type"
const MODULE_KEY = "module"
const PARAMETERS_KEY = "parameters"
const CONSTRUCT_WITH_PARAMETERS_KEY = "construct_with_parameters"
const FUNCTION_KEY = "function"

function IS.serialize(portfolio::T) where {T <: Portfolio}
    data = Dict{String, Any}()
    data["data_format_version"] = DATA_FORMAT_VERSION
    for field in fieldnames(T)
        # Exclude bus_numbers because they will get rebuilt during deserialization.
        # Exclude time_series_directory because the portfolio may get deserialized on a
        # different portfolio.
        if field != :bus_numbers && field != :time_series_directory
            #@show getfield(portfolio, field)
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
    @debug "serialize_struct" _group = LOG_GROUP_SERIALIZATION val T
    data = Dict{String, Any}(
        string(name) => serialize(getproperty(val, name)) for name in fieldnames(T)
    )
    add_serialization_metadata!(data, T)
    return data
end

"""
Add type information to the dictionary that can be used to deserialize the value.
"""
function add_serialization_metadata!(data::Dict, ::Type{T}) where {T}
    #@show T
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
    #@show raw
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
        #@show component
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
                api_comp = deserialize(type, component, component_cache)
                comp = build_model_struct(api_comp, component["__metadata__"])
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

function build_model_struct(base_struct, metadata::Dict{String, Any})
    vals = Dict{Symbol, Any}()
    struct_type = typeof(base_struct)
    for (name, type) in zip(fieldnames(struct_type), fieldtypes(struct_type))
        vals[name] = getfield(base_struct, name)
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

const _CONTAINS_SHOULD_ENCODE = Technology  # PSIP types with fields that we should_encode_as_uuid

function IS.deserialize(
    ::Type{T},
    data::Dict,
    component_cache::Dict,
) where {T <: _CONTAINS_SHOULD_ENCODE}
    @debug "deserialize Component" _group = IS.LOG_GROUP_SERIALIZATION T data
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

    base_struct = build_openapi_struct(type, vals...)

    return base_struct
end
#=
function IS.get_type_from_serialization_metadata(metadata::Dict)
    _module = IS.get_module(metadata[MODULE_KEY])
    base_type = IS.getproperty(_module, Symbol(metadata[TYPE_KEY]))
    if !get(metadata, CONSTRUCT_WITH_PARAMETERS_KEY, false)
        return base_type
    end

    # This has several limitations and is only a workaround for PSY.Reserve subtypes.
    # - each parameter must be in _module
    # - does not support nested parametrics.
    # Reserves should be fixed and then we can remove this hack.
    parameters = [getproperty(_module, Symbol(x)) for x in metadata[PARAMETERS_KEY]]
    return base_type{parameters...}
end
=#
"""
Deserialize the value, converting UUIDs to components where necessary.
"""
function deserialize_uuid_handling(field_type, val, component_cache)
    @debug "deserialize_uuid_handling" _group = IS.LOG_GROUP_SERIALIZATION field_type val
    if val === nothing
        value = val
    elseif should_encode_as_uuid(field_type)
        if field_type <: Vector
            _vals = field_type()
            for _val in val
                uuid = deserialize(Base.UUID, _val)
                component = component_cache[uuid]
                push!(_vals, component)
            end
            value = _vals
        else
            #@show val
            uuid = deserialize(Base.UUID, val["internal"]["uuid"])
            component = component_cache[uuid]
            value = component
        end
    elseif field_type <: _CONTAINS_SHOULD_ENCODE
        value = IS.deserialize(field_type, val, component_cache)
    elseif field_type <: Union{Nothing, _CONTAINS_SHOULD_ENCODE}
        value = IS.deserialize(field_type.b, val, component_cache)
    elseif field_type <: InfrastructureSystemsType
        value = deserialize(field_type, val)
    elseif field_type isa Union && field_type.a <: Nothing && !(field_type.b <: Union)
        # Nothing has already been handled. Apply the second type as long as there isn't a
        # third. Julia appears to always put the Nothing in field a.
        value = deserialize(field_type.b, val)
    else
        value = deserialize(field_type, val)
    end

    return value
end

const _ENCODE_AS_UUID_A = (
    #    Union{Nothing, SupplyTechnology},
    #    Union{Nothing, StorageTechnology},
    #    Union{Nothing, DemandRequirement},
    Union{Nothing, Zone},
    Union{Nothing, ACTransportTechnology, HVDCTransportTechnology},
    Vector{Service},
)
const _ENCODE_AS_UUID_B = (Zone, ACTransportTechnology, HVDCTransportTechnology, Vector{Service})

should_encode_as_uuid(val) = any(x -> val isa x, _ENCODE_AS_UUID_B)
should_encode_as_uuid(::Type{T}) where {T} = any(x -> T <: x, _ENCODE_AS_UUID_A)

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
