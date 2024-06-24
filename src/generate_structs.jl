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

    for (struct_name, input) in data.data["\$defs"]
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

        item["parametric"] = input["parametric"]
        if haskey(item, "parametric")
            item["constructor_func"] *= "{T}"
            item["closing_constructor_text"] = " where T <: $(item["parametric"])"
        end

        parameters = Vector{Dict}()
        for (field, values) in properties
            param = Dict{String, Any}()

            param["struct_name"] = item["struct_name"]
            param["name"] = field
            param["data_type"] = values["type"]
            param["comment"] = values["description"]

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

            push!(
                accessors,
                Dict(
                    "name" => param["name"],
                    "accessor" => accessor_name,
                    "create_docstring" => create_docstring,
                    "needs_conversion" => get(param, "needs_conversion", false),
                ),
            )

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
                    ),
                )
            end

            if field != "internal" && accessor_module == ""
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
            write(io, strip(MU.render(IS.STRUCT_TEMPLATE, item)))
            write(io, "\n")
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


"""
The following function imports from the database and generates the structs for a portfolio
@input database_filepath::AbstractString: The path to the database file
@input schema_JSON_filepath::AbstractString: The path to the schema JSON file
"""
function db_to_portfolio_parser(
    database_filepath::AbstractString,
    output_directory::AbstractString,
    schema_JSON_filepath::AbstractString,
)
    # Import the database
    db = SQLite.DB(database_filepath)
    # Get the schema
    schema = read_json_data(schema_JSON_filepath)
    # Generate the structs
    generate_structs(schema, output_directory)
    #return

    ## Demand Requirements
    # db_to_dataframe, returns dataframe for demand requirements
    # dataframe_to_structs, returns structs for demand requirements

    ## SupplyTechnology
    # db_to_dataframe, returns dataframe for supply technology
    # dataframe_to_structs, returns structs for supply technology

    # Need to pull in the populating structs 
end

"""
The following function imports from the database and creates a dictionary
of DataFrames for each table in the database

# Example usage:
db_path = "/Users/prao/GitHub_Repos/SiennaInvest/PowerSystemsInvestmentsPortfoliosTestData/RTS_GMLC.db"
dataframes_all = db_to_dataframes(db_path)
    
# Access a specific DataFrame
supply_technologies_df = dataframes_all["supply_technologies"]
"""
function db_to_dataframes(db_path::String)
    # Connect to the SQLite database
    db = SQLite.DB(db_path)
    
    # Get a list of tables in the database
    tables = SQLite.tables(db)
    
    # Create a dictionary to store DataFrames for each table
    dfs = Dict{String, DataFrame}()
    
    for table in tables
        table_name = table.name
        # Read each table into a DataFrame
        query = "SELECT * FROM $table_name"
        df = DataFrame(DBInterface.execute(db, query))
        dfs[table_name] = df
    end
    
    # Close the database connection
    SQLite.close(db)
    
    return dfs
end

# TODO: Figure out more permanent solution for mapping prime movers
"""
Function to map prime mover types to PrimeMovers
"""
function map_prime_mover(prime_mover::String)
    mapping_dict = Dict(
    "CT" => PrimeMovers.CT,
    "STEAM" => PrimeMovers.ST,
    "CC" => PrimeMovers.CC,
    "SYNC_COND" => PrimeMovers.OT,
    "NUCLEAR" => PrimeMovers.ST,
    "HYDRO" => PrimeMovers.HA,
    "ROR" => PrimeMovers.OT,
    "PV" => PrimeMovers.PVe,
    "CSP" => PrimeMovers.PVe,
    "RTPV" => PrimeMovers.PVe,
    "WIND" => PrimeMovers.WT,
    "STORAGE" => PrimeMovers.BA
    )
    
    return mapping_dict[prime_mover]
end

function dataframe_to_structs(
    dataframe::DataFrame,
    schema_JSON_filepath::AbstractString,
)
    # Get the schema
    schema = read_json_data(schema_JSON_filepath)
    # Generate the structs
    generate_structs(schema, output_directory)
    #return
end