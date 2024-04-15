const _ENCODE_AS_UUID_A = (
    Union{Nothing, PSY.Arc},
    Union{Nothing, PSY.Area},
    Union{Nothing, PSY.Bus},
    Union{Nothing, PSY.LoadZone},
    Union{Nothing, PSY.DynamicInjection},
    Union{Nothing, PSY.StaticInjection},
    Vector{PSY.Service},
    PSY.ThermalGen,
    PSY.Storage,
    PSY.StaticLoad,
    PSY.RenewableGen,
)

const _ENCODE_AS_UUID_B = (
    PSY.Arc,
    PSY.Area,
    PSY.Bus,
    PSY.LoadZone,
    PSY.DynamicInjection,
    PSY.StaticInjection,
    Vector{PSY.Service},
    PSY.ThermalGen,
    PSY.Storage,
    PSY.StaticLoad,
    PSY.RenewableGen,
)

@assert length(_ENCODE_AS_UUID_A) == length(_ENCODE_AS_UUID_B)

should_encode_as_uuid(val) = any(x -> val isa x, _ENCODE_AS_UUID_B)
# TODO: how does this work?
should_encode_as_uuid(::Type{T}) where {T} = any(x -> T <: x, _ENCODE_AS_UUID_A)

function IS.serialize(technology::T) where {T <: Technology}
    @debug "serialize" _group = IS.LOG_GROUP_SERIALIZATION technology T
    data = Dict{String, Any}()
    for name in fieldnames(T)
        val = serialize_uuid_handling(getfield(technology, name))
        if name == :ext
            if !IS.is_ext_valid_for_serialization(val)
                error(
                    "technology type=$T name=$(get_name(technology)) has a value in its " *
                    "ext field that cannot be serialized.",
                )
            end
        end
        data[string(name)] = val
    end

    IS.add_serialization_metadata!(data, T)

    # This is a temporary workaround until these types are not parameterized.
    data[IS.METADATA_KEY][IS.CONSTRUCT_WITH_PARAMETERS_KEY] = true

    return data
end

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

function IS.deserialize(::Type{T}, data::Dict, tech_cache::Dict) where {T <: Technology}
    @debug "deserialize Technology" _group = IS.LOG_GROUP_SERIALIZATION T data
    vals = Dict{Symbol, Any}()
    @show data, tech_cache
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
                tech_cache,
            )
        else
            @show val, field_name
            vals[name] = deserialize_uuid_handling(type, val, tech_cache)
        end
    end
    type = IS.get_type_from_serialization_metadata(data[IS.METADATA_KEY])
    return type(; vals...)
end

function IS.deserialize(::Type{Technology}, data::Dict)
    error("This form of IS.deserialize is not supported for Devices")
    return
end

"""
Deserialize the value, converting UUIDs to technologies where necessary.
"""
function deserialize_uuid_handling(field_type, val, tech_cache)
    @debug "deserialize_uuid_handling" _group = IS.LOG_GROUP_SERIALIZATION field_type val
    if val === nothing
        value = val
    elseif should_encode_as_uuid(field_type)
        if field_type <: Vector
            _vals = field_type()
            for _val in val
                uuid = deserialize(Base.UUID, _val)
                tech = tech_cache[uuid]
                push!(_vals, tech)
            end
            value = _vals
        else
            uuid = deserialize(Base.UUID, val)
            tech = tech_cache[uuid]
            value = tech
        end
    elseif field_type <: Technology
        value = IS.deserialize(field_type, val, tech_cache)
    elseif field_type <: Union{Nothing, Technology}
        value = IS.deserialize(field_type.b, val, tech_cache)
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
