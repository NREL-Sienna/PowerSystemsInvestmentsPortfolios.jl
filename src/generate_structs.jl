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

    for (struct_name, input) in data.data["components"]["schemas"]
        properties = input["properties"]
        item = Dict{String,Any}()
        item["has_internal"] = false
        item["has_null_values"] = true
        item["supertype"] = input["supertype"]

        accessors = Vector{Dict}()
        setters = Vector{Dict}()

        item["has_non_default_values"] = false

        item["constructor_func"] = struct_name
        item["struct_name"] = struct_name
        item["closing_constructor_text"] = ""

        if haskey(input, "parametric")
            item["parametric"] = input["parametric"]
            item["constructor_func"] *= "{T}"
            item["closing_constructor_text"] = " where T <: $(item["parametric"])"
        end

        parameters = Vector{Dict}()
        for (field, values) in properties
            param = Dict{String,Any}()

            param["struct_name"] = item["struct_name"]
            param["name"] = field
            param["data_type"] = values["type"]
            param["comment"] = values["description"]

            if haskey(param, "valid_range")
                if typeof(param["valid_range"]) == Dict{String,Any}
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
function db_to_portfolio_parser(database_filepath::AbstractString)

    #Goal will be be able to read in database and populate structs simultaneously

    dfs = db_to_dataframes(database_filepath)

    portfolio = dataframe_to_structs(dfs)

    return portfolio
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
    dfs = Dict{String,DataFrame}()

    #Will adjust queries to only pull a subset of data
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
        "ROR" => PrimeMovers.IC,
        "PV" => PrimeMovers.PVe,
        "CSP" => PrimeMovers.CP,
        "RTPV" => PrimeMovers.PVe,
        "WIND" => PrimeMovers.WT,
        "Wind" => PrimeMovers.WT,
        "STORAGE" => PrimeMovers.BA,
    )

    return mapping_dict[prime_mover]
end

function map_prime_mover_to_parametric(prime_mover::String)
    mapping_dict = Dict(
        "CT" => PSY.ThermalStandard,
        "STEAM" => PSY.ThermalStandard,
        "CC" => PSY.ThermalStandard,
        "SYNC_COND" => PSY.ThermalStandard,
        "NUCLEAR" => PSY.ThermalStandard,
        "HYDRO" => PSY.ThermalStandard,
        "ROR" => PSY.ThermalStandard,
        "PV" => PSY.RenewableDispatch,
        "CSP" => PSY.RenewableDispatch,
        "RTPV" => PSY.RenewableDispatch,
        "WIND" => PSY.RenewableDispatch,
        "Wind" => PSY.RenewableDispatch,
    )

    return mapping_dict[prime_mover]
end

function parse_timestamps_and_values(json_str::String)
    # Parse the JSON string into a Julia object
    data = JSON3.read(json_str)

    # Initialize arrays to store timestamps and values
    timestamps = String[]
    values = Float64[]

    # Iterate over each dictionary in the parsed JSON data
    for item in data
        # Append the timestamp to the timestamps array
        push!(timestamps, item["timestamp"])

        # Append the value to the values array
        push!(values, item["value"])
    end

    return timestamps, values
end

function parse_timestamps_and_values(df::DataFrame)
    # Initialize arrays to store timestamps and values
    timestamps = String[]
    values = Float64[]
    type = ""

    # Check if the timestamps are within the hours of the day
    is_within_hours =
        all(row -> parse(Int, split(row["timestamp"], "-")[end]) in 1:24, eachrow(df))

    if is_within_hours
        type = "Real Time"
        # Iterate over each row in the DataFrame
        for row in eachrow(df)
            # Append the timestamp to the timestamps array
            push!(timestamps, row["timestamp"])

            # Append the value to the values array
            push!(values, row["value"])
        end
    else
        type = "Forecast"
        # Create a dictionary to store daily values
        daily_values = Dict{String,Vector{Float64}}()

        # Iterate over each row in the DataFrame
        for row in eachrow(df)
            # Extract the date part of the timestamp
            date_part = join(split(row["timestamp"], "-")[1:3], "-")

            # Initialize the daily values array if not already present
            if !haskey(daily_values, date_part)
                daily_values[date_part] = Float64[]
            end

            # Append the value to the daily values array
            push!(daily_values[date_part], row["value"])
        end

        # Calculate the average values for each day and create 24-hour profiles
        for (date, vals) in daily_values
            avg_value = sum(vals) / length(vals)
            for hour in 1:24
                push!(timestamps, "$date-$hour")
                push!(values, avg_value)
            end
        end
    end

    # Parse timestamps into DateTime objects
    parsed_timestamps = DateTime.(timestamps, "yyyy-m-d-H")

    # Sort the parsed timestamps and values
    sorted_indices = sortperm(parsed_timestamps)
    sorted_timestamps = parsed_timestamps[sorted_indices]
    sorted_values = values[sorted_indices]

    return sorted_timestamps, sorted_values, type
end

function parse_json_to_arrays(json_str::String)
    # Replace invalid JSON values
    cleaned_str = replace(json_str, "NaN" => "null")

    # Parse the cleaned JSON string into a Julia object
    data = JSON3.read(cleaned_str)

    # Initialize array to store x and y values
    xy_values = []

    # Initialize previous values
    prev_to_x = 0.0
    prev_to_y = 0.0

    # Iterate over each dictionary in the parsed JSON data
    for item in data
        # Handle from_x and from_y replacements
        from_x = isnothing(item["from_x"]) ? prev_to_x : Float64(item["from_x"])
        from_y = isnothing(item["from_y"]) ? prev_to_y : Float64(item["from_y"])

        # Handle to_x and to_y replacements
        to_x = isnothing(item["to_x"]) ? prev_to_x : Float64(item["to_x"])
        to_y = isnothing(item["to_y"]) ? prev_to_y : Float64(item["to_y"])

        # Append corrected values to the array
        push!(xy_values, IS.XY_COORDS((from_x, from_y)))
        push!(xy_values, IS.XY_COORDS((to_x, to_y)))

        # Update previous values
        prev_to_x = to_x
        prev_to_y = to_y
    end

    return unique(xy_values)
end

function parse_heatrate_to_array(json_str::String)
    xy_vector = parse_json_to_arrays(json_str)

    # Validation: Check if there are at least two distinct x-coordinates
    if length(unique(getfield.(xy_vector, :x))) < 2
        return 0.0
    end

    # If valid, return the InputOutputCurve
    return InputOutputCurve(function_data=PiecewiseLinearData(points=xy_vector))
end

function dataframe_to_structs(df_dict::Dict)

    #Initialize Portfolio
    p = Portfolio(0.07, 0.05, 2025)
    #initialize Zone structs
    zones = []
    for row_zone in eachrow(df_dict["areas"])
        z = Zone(name=string("zone_", row_zone["name"]), id=parse(Int64, row_zone["name"]))
        push!(zones, z)
        add_region!(p, z)
    end
    #Populate SupplyTechnology structs from database (new builds)
    topologies = df_dict["balancing_topologies"]
    supply_curves_full =
        filter("entity_type" => contains("supply_technologies"), df_dict["attributes"])
    supply_curves = filter("name" => contains("supply"), supply_curves_full)

    # TODO: Add fields for reinforcement distances
    reinforcement_distances =
        filter("name" => contains("reinforcement"), supply_curves_full)
    # for row_pw in eachrow(supply_curves)

    #     # Extract supply curves and IDs
    #     eaid = row_pw["entity_attribute_id"]
    #     supply_curve = row_pw["value"]
    #     supply_curve = decode(supply_curve, "UTF-8")

    #     id = eaid

    #     # Find corresponding supply technology for that supply curve
    #     # TODO: Add check to only do the rest of this is this returns a real (and not an empty dataframe)
    #     row = df_dict["supply_technologies"][
    #         df_dict["supply_technologies"][!, "technology_id"].==id,
    #         :,
    #     ]

    #     # @show eaid, row_pw, supply_curve, topologies[topologies.name .== row[!, "balancing_topology"][1], "area"][1]
    #     supply_curve_parsed = parse_json_to_arrays(supply_curve)
    #     #extract area
    #     if !isempty(row)
    #         area =
    #             topologies[topologies.name.==row[!, "balancing_topology"][1], "area"][1]
    #         area_int = parse(Int64, area)

    #     else
    #         continue
    #     end
    #     #extract supply curve, does every supply_technology have a supply curve?
    #     #id = row["technology_id"]
    #     #eaid = df_dict["attributes"][df_dict["attributes"] .== id, "entity_attribute_id"][1]
    #     #supply_curve = df_dict["time_series"][df_dict["entity_attribute_id"] .== eaid, "piecewise_linear_blob"][1]
    #     #Now just need to parse the blob

    #     parametric = map_prime_mover_to_parametric(row[!, "prime_mover"][1])
    #     t = SupplyTechnology{parametric}(;
    #         #Data pulled from DB
    #         name=string(parametric) * string(row[!, "technology_id"][1]),
    #         id=row[!, "technology_id"][1],
    #         capital_costs=InputOutputCurve(PiecewiseLinearData(supply_curve_parsed)),
    #         balancing_topology=string(row[!, "balancing_topology"][1]),
    #         prime_mover_type=map_prime_mover(row[!, "prime_mover"][1]),
    #         fuel=row[!, "fuel_type"][1],
    #         region=zones[area_int],

    #         #Problem ones, need to write functions to extract
    #         base_power=100.0,
    #         initial_capacity=0.0,

    #         # Data we should have but dont currently
    #         operation_costs=ThermalGenerationCost(
    #             variable=CostCurve(LinearCurve(0.0)),
    #             fixed=0.0,
    #             start_up=0.0,
    #             shut_down=0.0,
    #         ),
    #         start_fuel_mmbtu_per_mw=2.0,
    #         start_cost_per_mw=91.0,
    #         up_time=6.0,
    #         down_time=6.0,
    #         heat_rate_mmbtu_per_mwh=7.43,
    #         co2=0.05306,
    #         ramp_dn_percentage=0.64,
    #         ramp_up_percentage=0.64,

    #         #Placeholder or default values (modeling assumptions)
    #         available=true,
    #         minimum_required_capacity=0.0,
    #         min_generation_percentage=0.0,
    #         maximum_capacity=1e8,
    #         power_systems_type=string(parametric),
    #         cluster=1,
    #         reg_max=0.25,
    #         rsv_max=0.5,
    #     )
    #     add_technology!(p, t)
    # end

    # Get existing generation units
    for row in eachrow(df_dict["generation_units"])

        #extract area
        area = topologies[topologies.name.==row["balancing_topology"], "area"][1]
        area_int = parse(Int64, area)

        # This will return all rows where entity_id matches any value in the tech_id vector
        tech_id = row["unit_id"]
        result_all =
            isempty(
                filter(
                    row ->
                        row[:entity_id] == tech_id &&
                            row[:entity_type] == "generation_units",
                    df_dict["attributes"],
                ),
            ) ? 0 :
            filter(
                row ->
                    row[:entity_id] == tech_id && row[:entity_type] == "generation_units",
                df_dict["attributes"],
            )
        result = filter(row -> contains(row[:name], "Heat Rate"), result_all)
        # Check if result exists and contains the expected field
        if result != 0
            if !isempty(result[!, :value])
                first_value = result[!, :value][1]
                # Ensure it's decoded properly
                heat_rate_unparsed = decode(first_value, "UTF-8")
                heat_rate_piecewise_lin = parse_heatrate_to_array(heat_rate_unparsed)
            else
                @warn "Result value field is empty"
                heat_rate_piecewise_lin = 0.0
            end
        else
            @warn "Result DataFrame is empty or zero"
            heat_rate_piecewise_lin = 0.0
        end

        co2_data = filter(row -> contains(row[:name], "CO2"), result_all)
        co2_value = isempty(co2_data) ? 0.0 : Float64(co2_data[!, "value"][1])

        op_data = filter(row -> row[:unit_id] == tech_id, df_dict["operational_data"])
        variable_om = op_data[!, "vom_cost"][1]

        parametric = map_prime_mover_to_parametric(row["prime_mover"])
        @show string(parametric) * row["name"], row["name"], row["prime_mover"]
        t = SupplyTechnology{parametric}(;
            # Data pulled from DB
            name=string(parametric) * row["name"],
            id=row["unit_id"],
            capital_costs=LinearCurve(0.0), #just assume zero since pre-existing?
            balancing_topology=string(row["balancing_topology"]),
            prime_mover_type=map_prime_mover(row["prime_mover"]),
            fuel=row["fuel_type"],
            region=zones[area_int],
            base_power=row["base_power"],
            initial_capacity=row["rating"],

            # Data we should have but dont currently
            operation_costs=ThermalGenerationCost(
                variable=CostCurve(LinearCurve(variable_om)),
                fixed=op_data[!, "fom_cost"][1],
                start_up=0.0,
                shut_down=0.0,
            ),
            start_fuel_mmbtu_per_mw=op_data[!, "startup_fuel_mmbtu_per_mw"][1],
            start_cost_per_mw=op_data[!, "startup_cost"][1],
            up_time=op_data[!, "uptime"][1],
            down_time=op_data[!, "downtime"][1],
            heat_rate_mmbtu_per_mwh=heat_rate_piecewise_lin,
            co2=co2_value,

            ## TODO: Need to add ramping capabilities to the schema
            ramp_dn_percentage=0.64,
            ramp_up_percentage=0.64,

            #Placeholder or default values (modeling assumptions)
            available=true,
            minimum_required_capacity=0.0,
            min_generation_percentage=op_data[!, "min_stable_level"][1] / row["rating"],
            maximum_capacity=1e8,
            power_systems_type=string(parametric),
            cluster=1,
            reg_max=0.25,
            rsv_max=0.5,
            #new_build =  0#0 for existing builds
        )

        temp_ts = DataFrame()
        if row["fuel_type"] == "Solar" || row["fuel_type"] == "Wind"
            # Put in time series for the solar and Wind
            eaid = row["unit_id"]
            ts_index =
                filter("entity_id" => isequal(eaid), df_dict["entities"])[!, "entity_id"]
            println("ts_index", ts_index)

            # if ts_index[1] == 5
            #     for time_series in ts_index
            #         temp_ts = filter("entity_id" => isequal(time_series), df_dict["time_series"])
            #     end
            # end

            if length(ts_index) == 0
                @error "no time_series $(row["name"])"
                continue
            else
                for time_series in ts_index
                    ts = filter("entity_id" => isequal(time_series), df_dict["time_series"])

                    # if size(ts)[1] == 0
                    #     println(size(temp_ts))
                    #     ts = temp_ts
                    # end
                    # TODO: Remove this hacky fix once database has been corrected to have unique timestamps
                    # ts = unique(ts,:timestamp)

                    timestamps, values, type = parse_timestamps_and_values(ts)
                    # dates = DateTime.(timestamps, "yyyy-m-d-H")
                    time_series_array = TimeArray(timestamps, values)
                    if type == "Forecast" && size(ts)[1] > 0
                        # ts = SingleTimeSeries(string(eaid), time_series_array)
                        ts = SingleTimeSeries(data=time_series_array,
                            name="ops_variable_cap_factor",
                            scaling_factor_multiplier=nothing
                        )

                        add_technology!(p, t)
                        IS.add_time_series!(p.data, t, ts; year="2020", rep_day=1)

                        # TODO: Remove once we have decided real time data handling
                        break
                    elseif type == "Real Time"
                        # TODO: For now, skipping this. But need to add later for real-time data
                        # ts = SingleTimeSeries(string(time_series), time_series_array)
                        # IS.add_time_series!(p.data, t, ts)
                    end
                    # ts = SingleTimeSeries(string(time_series), time_series_array)
                    # IS.add_time_series!(p.data, t, ts)

                end
                # @warn "Only day ahead added for unit_id: $eaid"
            end
        else
            add_technology!(p, t)
        end
    end

    # Get storage units
    for row in eachrow(df_dict["storage_units"])

        #extract area
        area = topologies[topologies.name.==row["balancing_topology"], "area"][1]
        area_int = parse(Int64, area)

        s = StorageTechnology{Storage}(;
            #Data pulled from DB
            name="Storage" * row["name"],
            base_power=row["base_power"], # Natural Units
            id=row["storage_unit_id"],
            region=zones[area_int],
            prime_mover_type=map_prime_mover(row["prime_mover"]),
            balancing_topology=row["balancing_topology"],
            existing_cap_power=row["rating"],
            existing_cap_energy=row["max_capacity"],

            #stuff we dont have but probably should
            om_costs_energy=StorageCost(
                charge_variable_cost=CostCurve(LinearCurve(0.0)),
                discharge_variable_cost=CostCurve(LinearCurve(0.0)),
                fixed=0.0,
                start_up=0.0,
                shut_down=0.0,
            ),
            om_costs_power=StorageCost(
                charge_variable_cost=CostCurve(LinearCurve(0.0)),
                discharge_variable_cost=CostCurve(LinearCurve(0.0)),
                fixed=0.0,
                start_up=0.0,
                shut_down=0.0,
            ),
            eff_up=row["charging_efficiency"],
            eff_down=row["discharge_efficiency"],
            storage_tech=StorageTech.LIB,

            #Default or placeholder values
            capital_costs_power=LinearCurve(0.0),
            capital_costs_energy=LinearCurve(0.0),
            available=true,
            losses=0.0,
            min_duration=1.0,
            max_duration=10.0,
            min_cap_energy=0.0,
            min_cap_power=0.0,
            max_cap_energy=1e8,
            max_cap_power=1e8,
            power_systems_type="Test",
        )
        add_technology!(p, s)
    end

    #Populate DemandRequirement structs from database
    for row in eachrow(df_dict["demand_requirements"])
        #start in time_series
        eaid = row["entity_attribute_id"]
        # ts_index = filter("entity_id" => isequal(eaid), df_dict["entities"])[!, "entity_id"]
        ts_index = filter(
            row ->
                row["entity_id"] == eaid && row["entity_type"] == "demand_requirements",
            df_dict["entities"],
        )[
            !,
            "entity_id",
        ]

        # Collect all rows in the time_series table that match the entity_id
        ts = filter("entity_id" => isequal(ts_index[1]), df_dict["time_series"])
        ts_parsed = collect(ts[:, :value])

        # Parsing the timestamps into Dates
        timestamps = DateTime.(ts[!, :timestamp], "yyyy-m-d-H")

        dates = timestamps[1]:Hour(1):timestamps[end]
        demand = ts_parsed
        demand_array = TimeArray(dates, demand)
        ts = SingleTimeSeries(string(row["entity_attribute_id"]), demand_array)

        area_int = parse(Int64, row["area"])

        #How to parse this timestamp stuff??

        d = DemandRequirement{ElectricLoad}(
            #Data pulled from DB
            name="Demand" * string(row["entity_attribute_id"]),
            region=zones[area_int],#parse(Int64, row["area"]),

            #Placeholder/default values
            available=true,
            power_systems_type="ElectricLoad",
        )
        add_technology!(p, d)
        IS.add_time_series!(p.data, d, ts; year=2020, rep_day=1)
    end

    #Transmission Lines
    lines = df_dict["transmission_lines"]
    for row in eachrow(df_dict["transmission_interchange"])

        # get list of balancing topologies that correspond to the areas for line tx
        topologies_from = filter("area" => isequal(row["area_from"]), topologies)[!, "name"]
        topologies_to = filter("area" => isequal(row["area_to"]), topologies)[!, "name"]

        existing_capacity = 0.0
        for from in topologies_from
            for to in topologies_to
                line_cap = lines[
                    (lines[
                        !,
                        "balancing_topology_from",
                    ].==from).&(lines[!, "balancing_topology_to"].==to),
                    "continuous_rating",
                ]
                if length(line_cap) == 1
                    existing_capacity += line_cap[1]
                end
            end
        end

        tx = ExistingTransportTechnology{Branch}(;
            name="Branch" * string(rownumber(row)),
            network_id=rownumber(row),
            base_power=100.0,
            available=true,
            start_region=zones[parse(Int64, row["area_from"])],
            end_region=zones[parse(Int64, row["area_to"])],
            maximum_new_capacity=row["max_flow_from"],
            existing_line_capacity=existing_capacity,

            #stuff we don't have, but probably should
            capital_cost=LinearCurve(19261),
            line_loss=0.019653847,
            power_systems_type="Branch",
        )
        add_technology!(p, tx)
    end

    return p
end
