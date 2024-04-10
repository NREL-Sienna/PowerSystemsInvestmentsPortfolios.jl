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
    PSY.RenewableGen
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
    PSY.RenewableGen
)

@assert length(_ENCODE_AS_UUID_A) == length(_ENCODE_AS_UUID_B)

should_encode_as_uuid(val) = any(x -> val isa x, _ENCODE_AS_UUID_B)
# TODO: how does this work?
should_encode_as_uuid(::Type{T}) where {T} = !any(x -> T <: x, _ENCODE_AS_UUID_A)


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
