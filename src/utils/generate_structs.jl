import Mustache

const STRUCT_TEMPLATE = """
#=
This file is auto-generated. Do not edit.
=#

#! format: off

\"\"\"
    mutable struct {{struct_name}}{{#parametric}}{T <: {{parametric}}}{{/parametric}} <: {{supertype}}
        {{#parameters}}
        {{name}}::{{{data_type}}}
        {{/parameters}}
    end

{{#docstring}}{{{docstring}}}{{/docstring}}

# Arguments
{{#parameters}}
- `{{name}}::{{{data_type}}}`:{{#default}} (default: `{{{default}}}`){{/default}}{{#comment}} {{{comment}}}{{/comment}}{{#valid_range}}, validation range: `{{{valid_range}}}`{{/valid_range}}
{{/parameters}}
\"\"\"
mutable struct {{struct_name}}{{#parametric}}{T <: {{parametric}}}{{/parametric}} <: {{supertype}}
    {{#parameters}}
    {{#comment}}"{{{comment}}}"\n    {{/comment}}{{name}}::{{{data_type}}}
    {{/parameters}}
    {{#inner_constructor_check}}

    function {{struct_name}}({{#parameters}}{{name}}, {{/parameters}})
        ({{#parameters}}{{name}}, {{/parameters}}) = {{inner_constructor_check}}(
            {{#parameters}}
            {{name}},
            {{/parameters}}
        )
        new({{#parameters}}{{name}}, {{/parameters}})
    end
    {{/inner_constructor_check}}
end

{{#needs_positional_constructor}}
function {{constructor_func}}({{#parameters}}{{^internal_default}}{{name}}{{#default}}={{default}}{{/default}}, {{/internal_default}}{{/parameters}}){{{closing_constructor_text}}}
    {{constructor_func}}({{#parameters}}{{^internal_default}}{{name}}, {{/internal_default}}{{/parameters}}{{#parameters}}{{#internal_default}}{{{internal_default}}}, {{/internal_default}}{{/parameters}})
end
{{/needs_positional_constructor}}

function {{constructor_func}}(; {{#parameters}}{{name}}{{#kwarg_value}}{{{kwarg_value}}}{{/kwarg_value}}, {{/parameters}}){{{closing_constructor_text}}}
    {{constructor_func}}({{#parameters}}{{name}}, {{/parameters}})
end

{{#has_null_values}}
# Constructor for demo purposes; non-functional.
function {{constructor_func}}(::Nothing){{{closing_constructor_text}}}
    {{constructor_func}}(;
        {{#parameters}}
        {{^internal_default}}
        {{name}}={{#quotes}}"{{null_value}}"{{/quotes}}{{^quotes}}{{null_value}}{{/quotes}},
        {{/internal_default}}
        {{/parameters}}
    )
end

{{/has_null_values}}
{{#accessors}}
{{#needs_conversion}}
{{#create_docstring}}\"\"\"Get [`{{struct_name}}`](@ref) `{{name}}` as a bare number in the requested `units` (e.g. `SU`, `DU`; domain-provided units such as `MW` are also accepted when the owning domain package has registered a `_strip_units` method for the returned quantity type). Returns a bare number only when such a method is registered; otherwise returns the quantity wrapper. For the unit-bearing value see [`{{accessor}}_unitful`](@ref).\"\"\"{{/create_docstring}}
{{accessor}}(value::{{struct_name}}, units) = InfrastructureSystems._strip_units(get_value(value, Val(:{{name}}), Val({{conversion_unit}}), units))
{{#create_docstring}}\"\"\"Get [`{{struct_name}}`](@ref) `{{name}}` as a unit-bearing quantity in the requested `units` (e.g. `SU`, `DU`, `MW`). For a bare number see [`{{accessor}}`](@ref).\"\"\"{{/create_docstring}}
{{accessor}}_unitful(value::{{struct_name}}, units) = get_value(value, Val(:{{name}}), Val({{conversion_unit}}), units)
InfrastructureSystems.display_units_arg(::typeof({{accessor}}), ::{{units_type_sig}}){{#units_bound}} where {T <: {{units_bound}}}{{/units_bound}} = InfrastructureSystems.{{display_units}}
InfrastructureSystems.display_units_arg(::typeof({{accessor}}_unitful), ::{{units_type_sig}}){{#units_bound}} where {T <: {{units_bound}}}{{/units_bound}} = InfrastructureSystems.{{display_units}}
{{/needs_conversion}}
{{^needs_conversion}}
{{#create_docstring}}\"\"\"Get [`{{struct_name}}`](@ref) `{{name}}`.\"\"\"{{/create_docstring}}
{{accessor}}(value::{{struct_name}}) = value.{{name}}
{{/needs_conversion}}
{{/accessors}}

{{#setters}}
{{#needs_conversion}}
{{#create_docstring}}\"\"\"Set [`{{struct_name}}`](@ref) `{{name}}`.\"\"\"{{/create_docstring}}
{{setter}}(value::{{struct_name}}, val, unit) = value.{{name}} = set_value(value, Val(:{{name}}), val, unit, Val({{conversion_unit}}))
{{/needs_conversion}}
{{^needs_conversion}}
{{#create_docstring}}\"\"\"Set [`{{struct_name}}`](@ref) `{{name}}`.\"\"\"{{/create_docstring}}
{{setter}}(value::{{struct_name}}, val) = value.{{name}} = val
{{/needs_conversion}}
{{/setters}}

{{#custom_code}}
{{{custom_code}}}
{{/custom_code}}

{{#has_parametric}}
function serialize_openapi_struct(technology::{{struct_name}}{T}, vals...) where T <: {{parametric}}
    base_struct = APIServer.{{struct_name}}(; vals...)
    return base_struct
end
{{/has_parametric}}

{{^has_parametric}}
function serialize_openapi_struct(technology::{{struct_name}}, vals...)
    base_struct = APIServer.{{struct_name}}(; vals...)
    return base_struct
end
{{/has_parametric}}

function deserialize_openapi_struct(::Type{<:{{struct_name}}}, vals::Dict)
    return IS.deserialize_struct(APIServer.{{struct_name}}, vals)
end

"""

#=
=#
function read_json_data(filename::String)
    try
        return JSONSchema.Schema(JSON3.read(filename))
    catch
        throw(DataFormatError("$filename has invalid format"))
    end
end

function generate_invest_structs(directory, data::JSONSchema.Schema; print_results=true)
    struct_names = Vector{String}()
    unique_accessor_functions = Set{String}()
    unique_setter_functions = Set{String}()

    for input in data.data["components"]
        struct_name = input["name"]
        properties = input["properties"]
        item = Dict{String, Any}()
        item["has_internal"] = false
        item["has_null_values"] = true
        item["supertype"] = input["supertype"]

        accessors = Vector{Dict}()
        setters = Vector{Dict}()

        item["has_non_default_values"] = false

        item["constructor_func"] = struct_name
        item["struct_name"] = struct_name
        item["closing_constructor_text"] = ""

        item["has_parametric"] = false
        if haskey(input, "parametric")
            item["parametric"] = input["parametric"]
            item["constructor_func"] *= "{T}"
            item["closing_constructor_text"] = " where T <: $(item["parametric"])"
            item["has_parametric"] = true
        end

        if haskey(input, "docstring")
            item["docstring"] = input["docstring"]
        end

        parameters = Vector{Dict}()
        for values in properties
            param = Dict{String, Any}()

            param["struct_name"] = item["struct_name"]
            param["name"] = values["name"]
            param["data_type"] = values["type"]
            param["comment"] = get(values, "description", "")
            param["exlude_getter"] = get(values, "exclude_getter", false)
            param["conversion_unit"] = get(values, "conversion_unit", "nothing")
            param["needs_conversion"] = get(values, "needs_conversion", false)

            if haskey(param, "valid_range")
                if typeof(param["valid_range"]) == Dict{String, Any}
                    min = param["valid_range"]["min"]
                    max = param["valid_range"]["max"]
                    param["valid_range"] = "($min, $max)"
                elseif typeof(param["valid_range"]) == String
                    param["valid_range"] = param["valid_range"]
                end
            end
            push!(parameters, param)

            # Allow accessor functions to be re-implemented from another module.
            # If this key is defined then the accessor function will not be exported.
            # Example:  get_name is defined in InfrastructureSystems and re-implemented in
            # PowerSystems.
            if haskey(param, "accessor_module")
                accessor_module = param["accessor_module"] * "."
                create_docstring = false
            else
                accessor_module = ""
                create_docstring = true
            end

            accessor_name = accessor_module * "get_" * param["name"]
            setter_name = accessor_module * "set_" * param["name"] * "!"

            conversion_unit = get(param, "conversion_unit", "nothing")
            include_getter = !get(param, "exclude_getter", false)
            if include_getter
                push!(
                    accessors,
                    Dict(
                        "name" => param["name"],
                        "accessor" => accessor_name,
                        "create_docstring" => create_docstring,
                        "needs_conversion" => get(param, "needs_conversion", false),
                        "conversion_unit" => conversion_unit,
                        "display_units" => get(param, "display_units", "NU"),
                        # The units trait dispatches on the component's concrete
                        # type, so parametric structs need the `Type{Name{T}} where`
                        # form (`Type{Name}` is the UnionAll and never matches a
                        # concrete `Name{...}`); concrete structs use the exact form.
                        "units_type_sig" => if haskey(item, "parametric")
                            "Type{$(item["struct_name"]){T}}"
                        else
                            "Type{$(item["struct_name"])}"
                        end,
                        # The bound is substituted inside a literal `where {T <: …}`
                        # template fragment (values get HTML-escaped; literals don't).
                        "units_bound" => get(item, "parametric", false),
                    ),
                )
            end

            include_setter = !get(param, "exclude_setter", false)
            if include_setter
                push!(
                    setters,
                    Dict(
                        "name" => param["name"],
                        "setter" => setter_name,
                        "data_type" => param["data_type"],
                        "create_docstring" => create_docstring,
                        "needs_conversion" => get(param, "needs_conversion", false),
                        "conversion_unit" => conversion_unit,
                    ),
                )
            end

            if param["name"] != "internal" && accessor_module == ""
                push!(unique_accessor_functions, accessor_name)
                push!(unique_setter_functions, setter_name)
            end

            param["kwarg_value"] = ""
            if !isnothing(get(values, "default", nothing))
                param["default"] = values["default"]
                param["kwarg_value"] = "=" * param["default"]
            elseif !isnothing(get(param, "internal_default", nothing))
                param["kwarg_value"] = "=" * string(param["internal_default"])
                item["has_internal"] = true
                continue
            else
                item["has_non_default_values"] = true
            end

            # This controls whether a demo constructor will be generated.
            if isnothing(get(param, "null_value", nothing)) &&
               isnothing(get(param, "default", nothing))
                item["has_null_values"] = false
            else
                if isnothing(get(param, "null_value", nothing))
                    item["null_value"] = param["default"]
                end
                if param["data_type"] == "String"
                    param["quotes"] = true
                end
            end
        end

        item["parameters"] = parameters
        item["accessors"] = accessors
        item["setters"] = setters

        # If all parameters have defaults then the positional constructor will
        # collide with the kwarg constructor.
        item["needs_positional_constructor"] =
            item["has_internal"] && item["has_non_default_values"]

        filename = joinpath(directory, item["struct_name"] * ".jl")

        open(filename, "w") do io
            write(io, strip(MU.render(STRUCT_TEMPLATE, item)))
            write(io, "\n\n")

            push!(struct_names, item["struct_name"])
        end

        if print_results
            println("Wrote $filename")
        end
    end

    accessors = sort!(collect(unique_accessor_functions))
    setters = sort!(collect(unique_setter_functions))
    filename = joinpath(directory, "includes.jl")
    open(filename, "w") do io
        for name in struct_names
            write(io, "include(\"$name.jl\")\n")
        end
        write(io, "\n")

        for accessor in accessors
            write(io, "export $accessor\n")
        end
        for setter in setters
            write(io, "export $setter\n")
        end
        if print_results
            println("Wrote $filename")
        end
    end
end

function generate_structs(
    input_file::AbstractString,
    output_directory::AbstractString;
    print_results=true,
)
    # Include each generated file.
    if !isdir(output_directory)
        mkdir(output_directory)
    end

    data = read_json_data(input_file)
    generate_invest_structs(output_directory, data; print_results=print_results)
    return
end
