# These will get encoded into each dictionary when a struct is serialized.
const METADATA_KEY = "__metadata__"
const TYPE_KEY = "type"
const MODULE_KEY = "module"
const PARAMETERS_KEY = "parameters"
const CONSTRUCT_WITH_PARAMETERS_KEY = "construct_with_parameters"
const FUNCTION_KEY = "function"
const _CONTAINS_SHOULD_ENCODE = Union{
    ResourceTechnology,
    DemandTechnology,
    TransmissionTechnology,
    Requirement,
    ExistingCapacity,
    RegionTopology,
}
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

"""
Constructs a Portfolio from a file path ending with .json

If the file is JSON, then `assign_new_uuids = true` will generate new UUIDs for the system
and all components.
"""
function Portfolio(
    file_path::AbstractString;
    assign_new_uuids=false,
    try_reimport=true,
    kwargs...,
)
    ext = lowercase(splitext(file_path)[2])
    if ext == ".json"
        unsupported = setdiff(keys(kwargs), SYSTEM_KWARGS)
        !isempty(unsupported) && error("Unsupported kwargs = $unsupported")
        runchecks = get(kwargs, :runchecks, false)
        time_series_read_only = get(kwargs, :time_series_read_only, false)
        time_series_directory = get(kwargs, :time_series_directory, nothing)
        portfolio = deserialize(
            Portfolio,
            file_path;
            time_series_read_only=time_series_read_only,
            # runchecks = runchecks,
            time_series_directory=time_series_directory,
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

function deserialize(::Type{Portfolio}, filename::AbstractString; kwargs...)
    raw = open(filename) do io
        JSON3.read(io, Dict)
    end

    if raw["data_format_version"] != DATA_FORMAT_VERSION
        pre_read_conversion!(raw)
    end

    # These file paths are relative to the portfolio file.
    directory = dirname(filename)
    for file_key in ("time_series_storage_file",)
        if haskey(raw, file_key) && !isabspath(raw[file_key])
            raw[file_key] = joinpath(directory, raw[file_key])
        end
    end

    return from_dict(Portfolio, raw, filename; kwargs...)
end

function IS.serialize(schedule::InvestmentScheduleResults)
    start_dates = Vector{String}()
    end_dates = Vector{String}()
    capacity_data = Vector{Vector{Dict{String, Any}}}()
    for (period, investments) in schedule.results
        push!(start_dates, string(period[1]))
        push!(end_dates, string(period[2]))

        installation_list = Vector{Dict{String, Any}}()
        for (technology, capacity) in investments
            installation = Dict{String, Any}(
                "technology" => string(nameof(technology[1])),
                "parameter" => string(nameof((only(technology[1].parameters)))),
                "name" => technology[2],
                "installations" => capacity,
            )
            push!(installation_list, installation)
        end
        push!(capacity_data, installation_list)
    end
    openapi_schedule = PowerOpenAPIModels.InvestmentScheduleResults(
        start_dates=start_dates,
        end_dates=end_dates,
        results=capacity_data,
    )
    data = Dict{String, Any}(
        string(name) => serialize(getproperty(openapi_schedule, name)) for
        name in fieldnames(typeof(openapi_schedule))
    )

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
clear_ext!(port::Portfolio) = IS.clear_ext!(port.internal)

function from_dict(
    ::Type{Portfolio},
    raw::Dict{String, Any},
    filename::AbstractString;
    base_system=false,
    time_series_read_only=false,
    time_series_directory=nothing,
    kwargs...,
)
    # Read any field that is defined in Portfolio but optional for the constructors and not
    # already handled here.
    handled = (
        "aggregation",
        "discount_rate",
        "data",
        "base_system",
        "financial_data",
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

    # Metadata
    metadata = get(raw, "metadata", Dict())
    name = get(metadata, "name", nothing)
    description = get(metadata, "description", nothing)

    #Financial Data
    financial_data = get(raw, "financial_data", Dict())
    base_year = get(financial_data, "base_year", nothing)
    inflation_rate = get(financial_data, "inflation_rate", nothing)
    discount_rate = get(financial_data, "discount_rate", nothing)
    interest_rate = get(financial_data, "interest_rate", nothing)

    #Base system
    if base_system
        base_system_file = joinpath(
            dirname(filename),
            splitext(basename(filename))[1] * "_base_system.json",
        )
        base_system = PSY.System(base_system_file)
    else
        base_system = System(100.0)
    end

    internal = IS.InfrastructureSystemsInternal()
    aggregation = get(raw, "aggregation", nothing)
    if !isnothing(aggregation)
        aggregation = getproperty(PowerSystems, Symbol(aggregation))
    end
    investment_schedule = get(raw, "investment_schedule", nothing)
    if !isnothing(investment_schedule)
        investment_schedule = deserialize(InvestmentScheduleResults, investment_schedule)
    end
    data = deserialize(
        IS.SystemData,
        raw["data"];
        time_series_read_only=time_series_read_only,
        time_series_directory=time_series_directory,
    )
    portfolio = Portfolio(
        aggregation,
        data,
        base_system,
        investment_schedule,
        internal;
        financial_data=PortfolioFinancialData(
            base_year,
            discount_rate,
            inflation_rate,
            interest_rate,
        ),
        name=name,
        description=description,
        parsed_kwargs...,
    )
    portfolio.data.supplemental_attribute_manager = deserialize_attributes(
        portfolio,
        IS.SupplementalAttributeManager,
        get(
            raw["data"],
            "supplemental_attribute_manager",
            Dict("attributes" => [], "associations" => []),
        ),
        raw["data"]["id2uuid"],
        portfolio.data.time_series_manager,
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

    if raw["data_format_version"] != DATA_FORMAT_VERSION
        post_deserialize_conversion!(portfolio, raw)
    end

    return portfolio
end

# Function copied over from IS. This version of the function is modified to not use the internal field  and UUIDs for components,
# since the internal field is not stored in the JSON when serializing with OpenAPI structs
function deserialize(
    ::Type{IS.SystemData},
    raw::Dict;
    time_series_read_only=false,
    time_series_directory=nothing,
    validation_descriptor_file=nothing,
    kwargs...,
)
    if haskey(raw, "time_series_storage_file")
        if !isfile(raw["time_series_storage_file"])
            error("time series file $(raw["time_series_storage_file"]) does not exist")
        end

        # TODO: need to address this limitation
        if IS.strip_module_name(raw["time_series_storage_type"]) ==
           "InMemoryTimeSeriesStorage"
            @info "Deserializing with InMemoryTimeSeriesStorage is currently not supported. Using HDF"
            #hdf5_storage = Hdf5TimeSeriesStorage(raw["time_series_storage_file"], true)
            #time_series_storage = InMemoryTimeSeriesStorage(hdf5_storage)
        end
        time_series_storage = IS.from_file(
            IS.Hdf5TimeSeriesStorage,
            raw["time_series_storage_file"];
            directory=time_series_directory,
            read_only=time_series_read_only,
        )
        time_series_metadata_store = IS.from_h5_file(
            IS.TimeSeriesMetadataStore,
            time_series_storage.file_path,
            time_series_directory,
        )
    else
        time_series_storage = IS.make_time_series_storage(;
            compression=CompressionSettings(;
                enabled=get(raw, "time_series_compression_enabled", false),
            ),
            directory=time_series_directory,
        )
        time_series_metadata_store = nothing
    end

    time_series_manager = IS.TimeSeriesManager(;
        data_store=time_series_storage,
        read_only=time_series_read_only,
        metadata_store=time_series_metadata_store,
    )
    subsystems = Dict(k => Set(Base.UUID.(v)) for (k, v) in raw["subsystems"])

    # Deserialize with empty supplemental_attribute_manager to start, will be
    # deserialized later after Portfolio is initialized
    supplemental_attribute_manager = IS.SupplementalAttributeManager(
        IS.SupplementalAttributesByType(IS.SupplementalAttributesByType()),
        IS.from_records(IS.SupplementalAttributeAssociations, []),
    )
    internal = IS.InfrastructureSystemsInternal()
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
    attributes_by_uuid = Dict{Base.UUID, IS.SupplementalAttribute}()
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

function deserialize(::Type{InvestmentScheduleResults}, raw::Dict)
    openapi_schedule = OpenAPI.from_json(PowerOpenAPIModels.InvestmentScheduleResults, raw)

    schedule = Dict()
    for (i, start_date) in enumerate(openapi_schedule.start_dates)
        end_date = openapi_schedule.end_dates[i]
        period_tuple = (Dates.Date(start_date), Dates.Date(end_date))

        schedule[period_tuple] = Dict()
        for capacity in openapi_schedule.results[i]
            technology_type = getproperty(
                PowerSystemsInvestmentsPortfolios,
                Symbol(capacity["technology"]),
            )
            parameter = getproperty(PowerSystems, Symbol(capacity["parameter"]))
            technology_tuple = (technology_type{parameter}, capacity["name"])

            if capacity["installations"] isa Dict
                capacity_tuple = NamedTuple(
                    (Symbol(key), value) for (key, value) in capacity["installations"]
                )
                schedule[period_tuple][technology_tuple] = capacity_tuple
            else
                schedule[period_tuple][technology_tuple] = capacity["installations"]
            end
        end
    end

    return InvestmentScheduleResults(schedule)
end

# Function copied over from IS. This version of the function is modified to deserialize using openAPI structs for PSIP supplemental attributes
# This is necessary since the openAPI structs do not have an internal field by default, so new UUIDs are given to supplemental attributes
# when deserialized with the IS version and the associations with PSIP components are broken
function deserialize_attributes(
    portfolio::Portfolio,
    ::Type{IS.SupplementalAttributeManager},
    data::Dict,
    uuids::Dict,
    time_series_manager::IS.TimeSeriesManager,
)
    mgr = IS.SupplementalAttributeManager(
        IS.SupplementalAttributesByType(IS.SupplementalAttributesByType()),
        IS.from_records(IS.SupplementalAttributeAssociations, data["associations"]),
    )
    refs = IS.SharedSystemReferences(;
        supplemental_attribute_manager=mgr,
        time_series_manager=time_series_manager,
    )

    for (type, attr_dicts) in data["attributes"]
        api_type = getproperty(PowerOpenAPIModels, Symbol(type))
        sienna_type = getproperty(PowerSystemsInvestmentsPortfolios, Symbol(type))
        if !haskey(mgr.data, sienna_type)
            mgr.data[sienna_type] = Dict{Base.UUID, SupplementalAttribute}()
        end

        for attr_dict in attr_dicts
            api_attr = OpenAPI.from_json(api_type, attr_dict)
            attr = openapi2sienna(api_attr)

            #UUID not preserved by OpenAPI, need to restore from another dict
            id = string(attr_dict["id"])
            uuid = Base.UUID(uuids[id])
            internal = get_internal(attr)
            IS.set_uuid!(internal, uuid)

            if haskey(mgr.data[sienna_type], uuid)
                error(
                    "Bug: duplicate UUID in attributes container: type=$sienna_type uuid=$uuid",
                )
            end
            mgr.data[sienna_type][uuid] = attr
            IS.set_shared_system_references!(attr, refs)
        end
    end

    return mgr
end

function deserialize_components!(portfolio::Portfolio, raw)
    resolver = Resolver(portfolio, Dict{Int64, UUID}())
    for type in ALL_PSIP_TYPES
        component_list = get(raw["components"], string(type), [])
        api_type = getproperty(PowerOpenAPIModels, Symbol(type))
        sienna_type = getproperty(PowerSystemsInvestmentsPortfolios, Symbol(type))
        for component_dict in component_list
            api_component = OpenAPI.from_json(api_type, component_dict)
            component = openapi2psip(api_component, resolver)

            #UUID not preserved by OpenAPI, need to restore from another dict
            id = component_dict["id"]
            uuid = Base.UUID(raw["id2uuid"][string(id)])
            internal = get_internal(component)

            resolver.id2uuid[id] = uuid
            IS.set_uuid!(internal, uuid)

            #TODO: skip_validation currently set to true, review the IS validation
            IS.add_component!(portfolio.data, component; skip_validation=true)
        end
    end

    # function deserialize_and_add!(;
    #     skip_types=nothing,
    #     include_types=nothing,
    #     post_add_func=nothing,
    # )
    #     for (type, components) in data
    #         type in parsed_types && continue
    #         if !isnothing(skip_types) && is_matching_type(type, skip_types)
    #             continue
    #         end
    #         if !isnothing(include_types) && !is_matching_type(type, include_types)
    #             continue
    #         end
    #         for component in components
    #             handle_deserialization_special_cases!(component, type)
    #             #TODO: See if component cache is needed
    #             api_component = deserialize_openapi_struct(type, component)
    #             model_component =
    #                 build_model_struct(api_component, portfolio, component["__metadata__"])

    #             #TODO: skip_validation currently set to true, review the IS validation
    #             IS.add_component!(portfolio.data, model_component; skip_validation=true)

    #             if !isnothing(post_add_func)
    #                 post_add_func(model_component)
    #             end
    #         end
    #         push!(parsed_types, type)
    #     end
    # end

    # deserialize_and_add!()
end

function IS.deserialize(
    ::Type{T},
    data::Dict,
    component_cache::Dict,
) where {T <: IS.InfrastructureSystemsComponent}
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

"""
Allow types to implement handling of special cases during deserialization.

# Arguments

  - `component::Dict`: The component serialized as a dictionary.
  - `::Type`: The type of the technology.
"""
handle_deserialization_special_cases!(
    component::Dict,
    ::Type{<:InfrastructureSystemsComponent},
) = nothing

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
    base_system=false,
    time_series=false,
    user_data=nothing,
    pretty=false,
    force=false,
    runchecks=false,
)
    # IS.prepare_for_serialization_to_file!(portfolio.data, filename; force=force)
    # data = to_json(portfolio; pretty=pretty)

    # data["metadata"] = _serialize_portfolio_metadata(portfolio, user_data)

    # Storing UUID mapping in the JSON to ensure compatibility with supplemental attributes
    # and timeseries. My understanding is that we want to phase out UUIDs anyway so this
    # will be a temporary fix
    output = Dict{String, Any}(
        "data_format_version" => DATA_FORMAT_VERSION,
        "aggregation" => string(get_aggregation(portfolio)),
        "metadata" => OrderedDict(
            "name" => isnothing(get_name(portfolio)) ? "" : get_name(portfolio),
            "description" => isnothing(get_description(portfolio)) ? "" : get_description(portfolio),
            "data_source" => isnothing(get_data_source(portfolio)) ? "" : get_data_source(portfolio),
            "component_counts" => IS.get_component_counts_by_type(portfolio.data),
            "time_series_counts" => IS.get_time_series_counts_by_type(portfolio.data),
        ),
        "financial_data" => IS.serialize(get_financial_data(portfolio)),
        "investment_schedule" => IS.serialize(get_investment_schedule(portfolio)),
    )

    serialize!(portfolio.data, output, filename; time_series=time_series)

    if base_system
        base_system_file = joinpath(
            dirname(filename),
            splitext(basename(filename))[1] * "_base_system.json",
        )
        system2openapi_json(
            get_base_system(portfolio),
            base_system_file;
            time_series=time_series,
        )
        output["base_system"] = base_system_file
    end

    if pretty
        open(filename, "w") do io
            JSON3.pretty(io, output)
        end
    else
        open(filename, "w") do io
            JSON3.write(io, output)
        end
    end
    @info "Serialized Portfolio to $filename"

    return
end

# Similar to existing functions in IS. Updated to use OpenAPI.
function serialize!(
    data::IS.SystemData,
    output::Dict{String, Any},
    output_path::AbstractString;
    time_series=false
)

    components_dict = Dict{String, Vector{Dict{String, Any}}}()

    id = IDGenerator()
    for OPENAPI_T in PSIP_DESERIALIZABLE_TYPES
        type_name = string(nameof(OPENAPI_T))
        psip_type = OPENAPI_TYPE_TO_PSIP[OPENAPI_T]
        if !haskey(components_dict, type_name)
            components_dict[type_name] = Vector{Dict{String, Any}}()
        end

        components = IS.get_components(psip_type, data)
        for component in components
            openapi_obj = sienna2openapi(component, id)
            dict = JSON.parse(OpenAPI.to_json(openapi_obj))
            push!(components_dict[type_name], dict)
        end
    end

    sa_dict = Dict{String, Vector{Dict{String, Any}}}()
    for OPENAPI_T in ALL_SA_PSIP_OPENAPI_TYPES
        type_name = string(nameof(OPENAPI_T))
        psip_type = SA_OPENAPI_TO_PSIP[OPENAPI_T]
        if !haskey(sa_dict, type_name)
            sa_dict[type_name] = Vector{Dict{String, Any}}()
        end
        attributes = IS.get_supplemental_attributes(psip_type, data)
        for attribute in attributes
            openapi_obj = sienna2openapi(attribute, id)
            dict = JSON.parse(OpenAPI.to_json(openapi_obj))
            push!(sa_dict[type_name], dict)
        end
    end

    associations = data.supplemental_attribute_manager.associations
    sa_assocs = IS.to_records(associations)

    output["data"] = Dict{String, Any}(
            "subsystems" => Dict{String, Any}(),
            "components" => components_dict,
            "supplemental_attribute_manager" => Dict{String, Any}(
                "attributes" => sa_dict,
                "associations" => sa_assocs,
            ),
            "id2uuid" => Dict(v => string(k) for (k, v) in id.uuid2int),
        )

    if time_series
        if isempty(data.time_series_manager.data_store)
            output["data"]["time_series_compression_enabled"] =
                IS.get_compression_settings(data.time_series_manager.data_store).enabled
            output["data"]["time_series_in_memory"] =
                data.time_series_manager.data_store isa IS.InMemoryTimeSeriesStorage
        else
            base = splitext(basename(output_path))[1]
            time_series_base_name =
                IS._get_secondary_basename(base, IS.TIME_SERIES_STORAGE_FILE)
            time_series_storage_file = joinpath(dirname(output_path), time_series_base_name)
            IS.serialize(data.time_series_manager.data_store, time_series_storage_file)
            IS.to_h5_file(data.time_series_manager.metadata_store, time_series_storage_file)
            output["data"]["time_series_storage_file"] = time_series_storage_file
            output["data"]["time_series_storage_type"] =
                string(typeof(data.time_series_manager.data_store))
        end
    end
end


"""
Serializes a InfrastructureSystemsType to a JSON string.
"""
function to_json(obj::T; pretty=false, indent=2) where {T <: InfrastructureSystemsType}
    try
        if pretty
            io = IOBuffer()
            JSON3.pretty(io, serialize(obj), JSON3.AlignmentContext(; indent=indent))
            return take!(io)
        else
            return JSON3.write(serialize(obj))
        end
    catch e
        @error "Failed to serialize $(summary(obj))"
        rethrow(e)
    end
end

function _serialize_portfolio_metadata(portfolio::Portfolio, user_data)
    name = get_name(portfolio)
    description = get_description(portfolio)
    data_source = get_data_source(portfolio),
    metadata = OrderedDict(
        "name" => isnothing(name) ? "" : name,
        "description" => isnothing(description) ? "" : description,
        "data_source" => isnothing(data_source) ? "" : data_source,
        "component_counts" => IS.get_component_counts_by_type(portfolio.data),
        "time_series_counts" => IS.get_time_series_counts_by_type(portfolio.data),
    )
    if !isnothing(user_data)
        metadata["user_data"] = user_data
    end

    return metadata
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
