"""
This PoC is if a dictionary of queries is maintained, then the database can be read in and the structs can be generated.
"""

"""
Set of queries to extract relevant data from the database. Need to be maintained to be consistent with the most recent version of the database
"""

"""
Relevant info:
entity_id is the IDs within a table (equivalent to unit_id, technology_id, etc.)
id in entities table across *all* generation, storage, and reserve entries

Can access an attribute for a specific generator using their entity ID and entity_type
    - If value is a single entry, can be pulled from table. Otherwise we need to take entity_attribute_id and get JSON blob from time_series or piecewise_linear table

Linkages appears to be mapping individual generators to what reserves they can contribute to
"""

QUERIES = Dict(
    #some uncertainty about the zone id
    :zones => """
         SELECT name, description FROM areas
       """,
    :balancing_topologies => """
          SELECT name, description FROM balancing_topologies
        """,
    :topology_to_area => """
          SELECT area FROM balancing_topologies WHERE name = ?
        """,
    :aggregate_lines => """
          SELECT ROWID, area_from, area_to, max_flow_from, max_flow_to FROM transmission_interchange
        """,
    :transmission_lines => """
          SELECT ROWID, balancing_topology_from, balancing_topology_to, continuous_rating FROM transmission_lines
        """,
    :supply_technologies => """
          SELECT technology_id, prime_mover, fuel_type, technology_class, scenario, area, balancing_topology FROM supply_technologies
        """,
    :generation_units => """
        SELECT unit_id, name, prime_mover, fuel_type, balancing_topology, rating, base_power FROM generation_units
      """,
    :storage_technologies => """
          SELECT storage_unit_id, name, prime_mover, fuel_type, scenario, area, balancing_topology FROM storage_technologies
        """,
    :storage_units => """
          SELECT storage_unit_id, name, prime_mover, fuel_type, max_capacity, balancing_topology, charging_efficiency, discharge_efficiency, rating, base_power FROM storage_units
        """,
    :demand_requirements => """
          SELECT entity_attribute_id, peak_load, area, balancing_topology FROM demand_requirements
        """,
    :entities => """
          SELECT id FROM entities WHERE entity_id = ? AND entity_type = ?
        """,
    :time_series => """
          SELECT time_series_blob FROM time_series WHERE entity_attribute_id = ?
        """,
    :piecewise_linear => """
          SELECT piecewise_linear_blob FROM piecewise_linear WHERE entity_attribute_id = ? AND description LIKE ?
        """,
    :attributes => """
          SELECT * FROM attributes WHERE entity_id = ? AND entity_type = ? AND data_type = ?
        """,
    :float_attributes => """
          SELECT * FROM attributes WHERE entity_id = ? AND entity_type = ? AND name LIKE ?
        """,
    :operational_data => """
        SELECT * FROM operational_data WHERE unit_id = ? 
      """,
    # add additional queries here as needed

)

# Remove later, or make this optional later depending on what is in the dataset
const DEFAULT_FINANCIAL_DATA = TechnologyFinancialData(;
    capital_recovery_period=30,
    interest_rate=0.06,
    technology_base_year=2025,
)

"""
The following function imports from the database and generates the structs for a portfolio
@input database_filepath::AbstractString: The path to the database file
"""
function db_to_portfolio_parser(
    database_filepath::AbstractString;
    aggregation::Type{<:Union{PSY.ACBus, PSY.AggregationTopology}}=DEFAULT_AGGREGATION,
    discount_rate=0.07,
    inflation_rate=0.05,
    interest_rate=0.02,
    base_year=2025,
    system::PSY.System=PSY.System(100.0),
)

    #Goal will be be able to read in database and populate structs simultaneously

    p = initialize_portfolio(
        aggregation,
        discount_rate,
        inflation_rate,
        interest_rate,
        base_year,
        system,
    )
    portfolio = database_to_structs(database_filepath, p)

    return portfolio
end

function initialize_portfolio(
    aggregation,
    discount_rate::Float64,
    inflation_rate::Float64,
    interest_rate::Float64,
    base_year::Int64,
    system::PSY.System,
)
    #Initialize Portfolio
    p = Portfolio(
        aggregation,
        discount_rate=discount_rate,
        inflation_rate=inflation_rate,
        interest_rate=interest_rate,
        base_year=base_year;
        base_system=system,
    )

    return p
end

function database_to_structs(db_path::AbstractString, p::Portfolio)
    # Connect to the SQLite database
    db = SQLite.DB(db_path)

    # Add zones and lines, shouldn't add both aggregate lines and nodal lines to the same DB
    # User can provide a desired aggregation level and then we can select based on that

    # Add zones to the portfolio
    if get_aggregation(p) == PSY.Area
        add_zones!(p, db)
        add_aggregate_lines!(p, db)
    elseif get_aggregation(p) == PSY.ACBus
        add_nodes!(p, db)
        add_nodal_lines!(p, db)
    end

    # Add technologies to Portfolio

    add_supply_technologies!(p, db)
    add_storage_technologies!(p, db)

    add_demand_technologies!(p, db)
    add_demand_requirements!(p, db)

    # Add units to base_systems
    add_buses!(p, db)
    add_generation_units!(p, db)
    add_storage_units!(p, db)


    return p
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

function parse_json_to_heatrate(json_str::String)
    xy_vector = parse_json_to_arrays(json_str)

    # Validation: Check if there are at least two distinct x-coordinates
    if length(unique(getfield.(xy_vector, :x))) < 2
        return 0.0
    end

    # If valid, return the InputOutputCurve
    return InputOutputCurve(function_data=PiecewiseLinearData(points=xy_vector))
end

# TODO: Split timeseries up into representative days
function parse_json_to_time_array(json_str::String)
    # Replace invalid JSON values
    cleaned_str = replace(json_str, "NaN" => "null")

    # Parse the cleaned JSON string into a Julia object
    data = JSON3.read(cleaned_str)

    # Initialize arrays to store timestamps and values
    timestamps = String[]
    values = Float64[]
    type = ""

    # Check if the timestamps are within the hours of the day
    is_within_hours =
        all(row -> parse(Int, split(row["timestamp"], "-")[end]) in 1:24, data)

    if is_within_hours
        type = "Real Time"
        # Iterate over each row in the DataFrame
        for row in data
            # Append the timestamp to the timestamps array
            push!(timestamps, row["timestamp"])

            # Append the value to the values array
            push!(values, row["value"])
        end
    else
        type = "Forecast"
        # Create a dictionary to store daily values
        daily_values = Dict{String, Vector{Float64}}()

        # Iterate over each row in the DataFrame
        for row in data
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
    parsed_timestamps = Dates.DateTime.(timestamps, "yyyy-m-d-H")

    # Sort the parsed timestamps and values
    sorted_indices = sortperm(parsed_timestamps)
    sorted_timestamps = parsed_timestamps[sorted_indices]
    sorted_values = values[sorted_indices]

    return sorted_timestamps, sorted_values, type
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
        "HYDRO" => PrimeMovers.PS,
        "ROR" => PrimeMovers.IC,
        "PV" => PrimeMovers.PVe,
        "CSP" => PrimeMovers.CP,
        "RTPV" => PrimeMovers.PVe,
        "WIND" => PrimeMovers.WT,
        "Wind" => PrimeMovers.WT,
        "STORAGE" => PrimeMovers.BA,
        "CSP" => PrimeMovers.CP
    )

    return mapping_dict[prime_mover]
end

"""
Function to map fuel string to ThermalFuels
"""
function map_fuel(fuel::String)
    mapping_dict = Dict(
        "NG" => ThermalFuels.NATURAL_GAS,
        "Nuclear" => ThermalFuels.NUCLEAR,
        "Coal" => ThermalFuels.COAL,
        "Oil" => ThermalFuels.DISTILLATE_FUEL_OIL,
    )

    fuel_enum = haskey(mapping_dict, fuel) ? mapping_dict[fuel] : ThermalFuels.OTHER

    return fuel_enum
end

"""
Function to map storage technology string to StorageTech
"""
function map_storage_tech(fuel::String)
    mapping_dict = Dict(
        "Hydro" => StorageTech.PTES,
        "Solar" => StorageTech.OTHER_THERM,
    )

    fuel_enum = haskey(mapping_dict, fuel) ? mapping_dict[fuel] : StorageTech.LIB

    return fuel_enum
end

function map_prime_mover_to_parametric(prime_mover::String)
    mapping_dict = Dict(
        "CT" => PSY.ThermalStandard,
        "STEAM" => PSY.ThermalStandard,
        "CC" => PSY.ThermalStandard,
        "SYNC_COND" => PSY.ThermalStandard,
        "NUCLEAR" => PSY.ThermalStandard,
        "HYDRO" => PSY.ThermalStandard,
        "ROR" => PSY.RenewableDispatch,
        "PV" => PSY.RenewableDispatch,
        "CSP" => PSY.RenewableDispatch,
        "RTPV" => PSY.RenewableDispatch,
        "WIND" => PSY.RenewableDispatch,
        "Wind" => PSY.RenewableDispatch,
        "BA" => PSY.EnergyReservoirStorage,
        "PS" =>  PSY.EnergyReservoirStorage
    )

    return mapping_dict[prime_mover]
end

function add_zones!(p::Portfolio, db::SQLite.DB)

    # Confirm if we should be using balancing_topologies or areas for Zones

    # stream straight through the table
    for rec in DBInterface.execute(db, QUERIES[:zones])
        # only build an ext‐dict if we actually have extras
        ext =
            rec.description !== nothing ? Dict(:description => rec.description) :
            Dict{Symbol, Any}()

        # build and immediately insert
        z = Zone(; name=rec.name, id=parse(Int64, rec.name), ext=ext)
        add_region!(p, z)
    end
end

function add_nodes!(p::Portfolio, db::SQLite.DB)
end

function add_buses!(p::Portfolio, db::SQLite.DB)
    # stream straight through the table
    for rec in DBInterface.execute(db, QUERIES[:balancing_topologies])
        # only build an ext‐dict if we actually have extras
        ext =
            rec.description !== nothing ? Dict("Description" => rec.description) :
            Dict{String, Any}()

        # build and immediately insert
        b = PSY.ACBus(; 
            name=rec.name, 
            number=parse(Int64, rec.name), 
            bustype=nothing,
            angle=nothing,
            magnitude=nothing,
            voltage_limits=nothing,
            base_voltage=nothing,
            area=nothing,
            load_zone=nothing,
            ext=ext)
        PSY.add_component!(p.base_system, b)
    end
end

function add_aggregate_lines!(p::Portfolio, db::SQLite.DB)

    # Are max_flows only indicative of existing line capacity, or is it an overall limit? Double check this
    # How are we handling parametric typing

    # Add in optional parameters later when needed

    for rec in DBInterface.execute(db, QUERIES[:aggregate_lines])

        # build and immediately insert
        t = AggregateTransportTechnology{ACBranch}(;
            name=string(rec.rowid),
            id=rec.rowid,
            available=true,
            base_power=100.0,
            power_systems_type=string(ACBranch),
            financial_data=DEFAULT_FINANCIAL_DATA,
            start_region=collect(
                IS.get_components(
                    x -> get_id(x) == parse(Int64, rec.area_from),
                    RegionTopology,
                    p.data,
                ),
            )[1],
            end_region=collect(
                IS.get_components(
                    x -> get_id(x) == parse(Int64, rec.area_to),
                    RegionTopology,
                    p.data,
                ),
            )[1],
            capacity_limits=(min=0.0, max=max(rec.max_flow_from, rec.max_flow_to)),
        )
        add_technology!(p, t)
    end
end

function add_nodal_lines!(p::Portfolio, db::SQLite.DB)
end

function add_supply_technologies!(p::Portfolio, db::SQLite.DB)
    # stream straight through the table
    for rec in DBInterface.execute(db, QUERIES[:supply_technologies])

        # build and immediately insert

        # Select appropriate parametric type
        parametric = map_prime_mover_to_parametric(rec.prime_mover)

        # Determine area based on balancing topology
        # Generalize in the future if the database later supports technologies in multiple areas
        area =
            first(
                DBInterface.execute(
                    db,
                    QUERIES[:topology_to_area],
                    [rec.balancing_topology],
                ),
            ).area

        # Get Entity Attribute ID for supply curve
        # Where is the reinforcement curve used?
        supply_curve_eaid =
            first(
                DBInterface.execute(
                    db,
                    QUERIES[:attributes],
                    [rec.technology_id, "supply_technologies", "piecewise_linear"],
                ),
            ).entity_attribute_id

        # Get supply curve for capital costs
        supply_curve =
            first(
                DBInterface.execute(
                    db,
                    QUERIES[:piecewise_linear],
                    [supply_curve_eaid, "Supply curve%"],
                ),
            ).piecewise_linear_blob
        supply_curve_parsed = parse_json_to_arrays(supply_curve)
        t = SupplyTechnology{parametric}(;
            #Data pulled from DB
            name=rec.prime_mover * string(rec.technology_id),
            id=rec.technology_id,
            capital_costs=InputOutputCurve(PiecewiseLinearData(supply_curve_parsed)),
            prime_mover_type=map_prime_mover(rec.prime_mover),
            fuel=[map_fuel(rec.fuel_type)],
            region=collect(
                IS.get_components(
                    x -> get_id(x) == parse(Int64, area),
                    RegionTopology,
                    p.data,
                ),
            ),
            financial_data=DEFAULT_FINANCIAL_DATA,
            available=true,
            base_power=100.0,
            power_systems_type=string(parametric),

            #TODO: Get operational data for SupplyTechnologies, only for generation units right now
            # Need to map between them?
            operation_costs=ThermalGenerationCost(
                variable=CostCurve(LinearCurve(0.0)),
                fixed=0.0,
                start_up=0.0,
                shut_down=0.0,
            ),
            start_fuel_mmbtu_per_mw=2.0,
            co2=Dict(map_fuel(rec.fuel_type) => 0.0),
        )
        add_technology!(p, t)

        # Pull relevant TimeSeriesData
        # Currently no timeseries in the database for SupplyTechnologies
        for attr in DBInterface.execute(
            db,
            QUERIES[:attributes],
            [rec.technology_id, "supply_technologies", "time_series"],
        )
            for ts_data in
                DBInterface.execute(db, QUERIES[:time_series], [attr.entity_attribute_id])
                timestamps, values, type =
                    parse_json_to_time_array(ts_data.time_series_blob)
                time_series_array = TimeSeries.TimeArray(timestamps, values)
                ts = SingleTimeSeries(
                    attr.name * string(rec.entity_attribute_id),
                    time_series_array,
                )
                add_time_series!(p, d, ts)
            end
        end
    end
end

function add_generation_units!(p::Portfolio, db::SQLite.DB)
    for rec in DBInterface.execute(db, QUERIES[:generation_units])
        # build and immediately insert
        op_data = first(DBInterface.execute(db, QUERIES[:operational_data], [rec.unit_id]))

        if map_prime_mover_to_parametric(rec.prime_mover) == PSY.ThermalStandard

            # Get Entity Attribute ID for supply curve
            heat_rate_eaid =
            first(
                DBInterface.execute(
                    db,
                    QUERIES[:attributes],
                    [rec.unit_id, "generation_units", "piecewise_linear"],
                ),
            ).entity_attribute_id

            # Get supply curve for capital costs
            heat_rate =
                first(
                    DBInterface.execute(
                        db,
                        QUERIES[:piecewise_linear],
                        [heat_rate_eaid, "Heat Rate%"],
                    ),
                ).piecewise_linear_blob
            heat_rate_parsed = parse_json_to_heatrate(heat_rate)
            ramps = first(DBInterface.execute(db, QUERIES[:float_attributes], [rec.unit_id, "generation_units", "Ramp%"]))
            
            g = ThermalStandard(;
                name=rec.name,
                rating=rec.rating,
                base_power=rec.base_power,
                available=true,
                status=true,
                bus=PSY.get_component(PSY.ACBus, p.base_system, string(rec.balancing_topology)),
                prime_mover_type=map_prime_mover(rec.prime_mover),
                fuel=map_fuel(rec.fuel_type),
                active_power_limits=(min=0, max=rec.rating),
                active_power = rec.rating,
                reactive_power = 0.0,
                reactive_power_limits = (min=0, max=rec.rating),
                ramp_limits = (up=ramps.value, down=ramps.value),
                time_limits = (up=op_data.plant_uptime, down=op_data.plant_downtime),
                operation_cost = ThermalGenerationCost(;
                    variable=FuelCurve(;
                        value_curve=heat_rate_parsed,
                        fuel_cost=0.0, 
                        vom_cost=LinearCurve(op_data.vom_cost)
                    ),
                    fixed=op_data.fom_cost,
                    start_up=op_data.startup_cost,
                    shut_down=0.0,
                )
            )
            add_component!(p.base_system, g)

            # Pull relevant TimeSeriesData
            for attr in DBInterface.execute(
                db,
                QUERIES[:attributes],
                [rec.unit_id, "generation_units", "time_series"],
            )
                for ts_data in
                    DBInterface.execute(db, QUERIES[:time_series], [attr.entity_attribute_id])
                    timestamps, values, type =
                        parse_json_to_time_array(ts_data.time_series_blob)
                    time_series_array = TimeSeries.TimeArray(timestamps, values)
                    ts = SingleTimeSeries(
                        attr.name * string(attr.entity_attribute_id),
                        time_series_array,
                    )
                    #TODO: Debug duplicate timeseries?
                    #PSY.add_time_series!(p.base_system, g, ts)
                end
            end
        elseif map_prime_mover_to_parametric(rec.prime_mover) == PSY.RenewableDispatch

            g = RenewableDispatch(;
                name=rec.name,
                rating=rec.rating,
                base_power=rec.base_power,
                available=true,
                bus=PSY.get_component(PSY.ACBus, p.base_system, string(rec.balancing_topology)),
                prime_mover_type=map_prime_mover(rec.prime_mover),
                active_power = rec.rating,
                reactive_power = 0.0,
                reactive_power_limits = (min=0, max=rec.rating),
                power_factor = 0.5,
                operation_cost = RenewableGenerationCost(;
                    variable=CostCurve(;
                        value_curve=LinearCurve(op_data.vom_cost),
                    )
                )
            )
            add_component!(p.base_system, g)

            # Pull relevant TimeSeriesData
            for attr in DBInterface.execute(
                db,
                QUERIES[:attributes],
                [rec.unit_id, "generation_units", "time_series"],
            )
                for ts_data in
                    DBInterface.execute(db, QUERIES[:time_series], [attr.entity_attribute_id])
                    timestamps, values, type =
                        parse_json_to_time_array(ts_data.time_series_blob)
                    time_series_array = TimeSeries.TimeArray(timestamps, values)
                    ts = SingleTimeSeries(
                        attr.name * string(attr.entity_attribute_id),
                        time_series_array,
                    )
                    #TODO: Debug duplicate timeseries?
                    #PSY.add_time_series!(p.base_system, g, ts)
                end
            end

        end

    end

end

function add_storage_technologies!(p::Portfolio, db::SQLite.DB)
    # stream straight through the table
    for rec in DBInterface.execute(db, QUERIES[:storage_technologies])

        # build and immediately insert

        # Select appropriate parametric type
        parametric = map_prime_mover_to_parametric(rec.prime_mover)

        # Determine area based on balancing topology
        # Generalize in the future if the database later supports technologies in multiple areas
        area =
            first(
                DBInterface.execute(
                    db,
                    QUERIES[:topology_to_area],
                    [rec.balancing_topology],
                ),
            ).area

        # Get Entity Attribute ID for supply curve
        # Where is the reinforcement curve used?
        supply_curve_eaid =
            first(
                DBInterface.execute(
                    db,
                    QUERIES[:attributes],
                    [rec.technology_id, "storage_technologies", "piecewise_linear"],
                ),
            ).entity_attribute_id

        # Get supply curve for capital costs
        supply_curve =
            first(
                DBInterface.execute(
                    db,
                    QUERIES[:piecewise_linear],
                    [supply_curve_eaid, "Supply curve%"],
                ),
            ).piecewise_linear_blob
        supply_curve_parsed = parse_json_to_arrays(supply_curve)
        t = StorageTechnology{parametric}(;
            #Data pulled from DB
            name=rec.name,
            id=rec.storage_unit_id,
            capital_costs_discharge=InputOutputCurve(PiecewiseLinearData(supply_curve_parsed)),
            prime_mover_type=map_prime_mover(rec.prime_mover),
            storage_tech=map_storage_tech(rec.fuel_type),
            region=collect(
                IS.get_components(
                    x -> get_id(x) == parse(Int64, area),
                    RegionTopology,
                    p.data,
                ),
            ),
            financial_data=DEFAULT_FINANCIAL_DATA,
            available=true,
            base_power=100.0,
            power_systems_type=string(parametric),

            #TODO: Get operational data for StorageTechnologies, only for storage units right now
            # Need to map between them?
            operation_costs=StorageCost(),

        )
        add_technology!(p, t)

        # Pull relevant TimeSeriesData
        # Currently no timeseries in the database for SupplyTechnologies
        for attr in DBInterface.execute(
            db,
            QUERIES[:attributes],
            [rec.technology_id, "storage_technologies", "time_series"],
        )
            for ts_data in
                DBInterface.execute(db, QUERIES[:time_series], [attr.entity_attribute_id])
                timestamps, values, type =
                    parse_json_to_time_array(ts_data.time_series_blob)
                time_series_array = TimeSeries.TimeArray(timestamps, values)
                ts = SingleTimeSeries(
                    attr.name * string(rec.entity_attribute_id),
                    time_series_array,
                )
                add_time_series!(p, d, ts)
            end
        end
    end
end

function add_storage_units!(p::Portfolio, db::SQLite.DB)
        # stream straight through the table
        for rec in DBInterface.execute(db, QUERIES[:storage_units])

            # build and immediately insert

            #What is max_capacity column in DB used for?
            # Some of this data still missing from DB
            t = EnergyReservoirStorage(;
                #Data pulled from DB
                name=rec.name,
                rating=rec.rating,
                base_power=rec.base_power,
                available=true,
                bus=PSY.get_component(PSY.ACBus, p.base_system, string(rec.balancing_topology)),
                prime_mover_type=map_prime_mover(rec.prime_mover),
                storage_technology_type=map_storage_tech(rec.fuel_type),
                storage_capacity = rec.max_capacity*rec.base_power,
                storage_level_limits = (min=0, max=1.0),
                initial_storage_capacity_level = 0,
                input_active_power_limits=(min=0, max=rec.rating),
                output_active_power_limits=(min=0, max=rec.rating),
                active_power = rec.rating,
                reactive_power = 0.0,
                reactive_power_limits = (min=0, max=rec.rating),
                efficiency = (in=rec.charging_efficiency, out=rec.discharge_efficiency),
                operation_cost=StorageCost(
                    charge_variable_cost = CostCurve(LinearCurve(0.0)),
                    discharge_variable_cost = CostCurve(LinearCurve(0.0))
                ), #Add later when data is in DB
            )
            add_component!(p.base_system, t)
    
            # Pull relevant TimeSeriesData
            for attr in DBInterface.execute(
                db,
                QUERIES[:attributes],
                [rec.storage_unit_id, "storage_units", "time_series"],
            )
                for ts_data in
                    DBInterface.execute(db, QUERIES[:time_series], [attr.entity_attribute_id])
                    timestamps, values, type =
                        parse_json_to_time_array(ts_data.time_series_blob)
                    time_series_array = TimeSeries.TimeArray(timestamps, values)
                    ts = SingleTimeSeries(
                        attr.name * string(attr.entity_attribute_id),
                        time_series_array,
                    )
                    #TODO: Debug duplicate timeseries?
                    #PSY.add_time_series!(p.base_system, t, ts)
                end
            end
        end
end

function add_demand_requirements!(p::Portfolio, db::SQLite.DB)
    # stream straight through the table
    for rec in DBInterface.execute(db, QUERIES[:demand_requirements])

        # build and immediately insert
        d = DemandRequirement{StaticLoad}(;
            name="demand_" * string(rec.entity_attribute_id),
            id=rec.entity_attribute_id,
            peak_demand_mw=rec.peak_load,
            region=collect(
                IS.get_components(
                    x -> get_id(x) == parse(Int64, rec.area),
                    RegionTopology,
                    p.data,
                ),
            ),
            value_of_lost_load=1e8,
            power_systems_type="StaticLoad",
        )
        add_technology!(p, d)

        # Pull relevant TimeSeriesData
        for ts_data in
            DBInterface.execute(db, QUERIES[:time_series], [rec.entity_attribute_id])
            timestamps, values, type = parse_json_to_time_array(ts_data.time_series_blob)
            time_series_array = TimeSeries.TimeArray(timestamps, values)
            ts = SingleTimeSeries(string(rec.entity_attribute_id), time_series_array)
            add_time_series!(p, d, ts)
        end
    end
end

function add_demand_technologies!(p::Portfolio, db::SQLite.DB)
end
