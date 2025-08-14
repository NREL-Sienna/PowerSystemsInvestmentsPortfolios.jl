"""
This PoC is if a dictionary of queries is maintained, then the database can be read in and the structs can be generated.
"""

"""
Set of queries to extract relevant data from the database. Need to be maintained to be consistent with the most recent version of the database
"""

#TODO: Support scenario handling
QUERIES = Dict(
    :zones => """
         SELECT * FROM planning_regions
       """,
    :zone => """
          SELECT name FROM planning_regions WHERE id = ?
        """,
    :zone_for_technology => """
          SELECT id FROM planning_regions WHERE name = ?
        """,
    :balancing_topologies => """
          SELECT * FROM balancing_topologies WHERE area >= 1
        """,
    :area_to_topology => """
          SELECT name FROM balancing_topologies WHERE area = ?
        """,
    :topology_to_area => """
          SELECT area FROM balancing_topologies WHERE id = ?
        """,
    :topology_for_unit => """
          SELECT name FROM balancing_topologies WHERE id = ?
        """,
    :arcs => """
          SELECT * FROM arcs
        """,
    :arc => """
          SELECT * FROM arcs WHERE id = ?
        """,
    :topology_from_arc => """
          SELECT * FROM balancing_topologies WHERE id = ?
        """,
    :aggregate_lines => """
          SELECT * FROM transmission_interchanges
        """,
    :transmission_lines => """
          SELECT * FROM transmission_lines
        """,
    :technologies => """
          SELECT * FROM supply_technologies
        """,
    :generation_units => """
        SELECT * FROM generation_units
      """,
    :storage_units => """
          SELECT * FROM storage_units
        """,
    :demand_requirements => """
          SELECT * FROM loads
        """,
    :entity_type => """
          SELECT entity_type FROM entities WHERE id = ?
        """,
    :investment_timeseries => """
          SELECT * FROM time_series_associations WHERE owner_type = ?
        """,
    :ts_data => """
          SELECT * FROM static_time_series WHERE uuid = ?
        """,
    # add additional queries here as needed
)

# Ported from SiennaGridDB
const DB_TO_OPENAPI_FIELDS = Dict(
    ("transmission_lines", "arc_id") => "arc_",
    ("generation_units", "balancing_topology") => "bus",
    ("storage_units", "balancing_topology") => "bus",
    ("supply_technologies", "balancing_topology") => "bus",
    ("loads", "balancing_topology") => "bus",
    ("generation_units", "prime_mover") => "prime_mover_type",
    ("storage_units", "prime_mover") => "prime_mover_type",
    ("arcs", "from_id") => "from",
    ("arcs", "to_id") => "to",
    ("transmission_lines", "continuous_rating") => "rating",
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
function database_to_portfolio(
    database_filepath::AbstractString,
    discount_rate::Float64,
    inflation_rate::Float64,
    interest_rate::Float64,
    base_year::Int64;
    aggregation::Type{<:Union{PSY.ACBus, PSY.AggregationTopology}}=DEFAULT_AGGREGATION,
    system::PSY.System=PSY.System(100.0),
)
    p = Portfolio(
        aggregation,
        discount_rate=discount_rate,
        inflation_rate=inflation_rate,
        interest_rate=interest_rate,
        base_year=base_year;
        base_system=system,
    )
    portfolio = database_to_structs(database_filepath, p)

    return portfolio
end

function database_to_structs(db_path::AbstractString, p::Portfolio)
    # Connect to the SQLite database
    db = SQLite.DB(db_path)
    attributes = get_entity_attributes(db)

    # Add zones and lines, shouldn't add both aggregate lines and nodal lines to the same DB
    # User can provide a desired aggregation level and then we can select based on that

    # Add zones to the portfolio
    if get_aggregation(p) == PSY.ACBus #Nodal aggregation
        add_nodes!(p, attributes, db)
        add_nodal_lines!(p, attributes, db)
    else #Zonal aggregation
        add_zones!(p, attributes, db)
        add_aggregate_lines!(p, attributes, db)
    end

    # Add technologies to Portfolio
    add_technologies!(p, attributes, db)

    # Add demands
    add_demand_requirements!(p, attributes, db)
    add_demand_technologies!(p, attributes, db)

    # Add data to base_systems
    add_buses!(p, attributes, db)
    add_system_lines!(p, attributes, db)
    add_generation_units!(p, attributes, db)
    add_storage_units!(p, attributes, db)
    add_loads!(p, attributes, db)

    # Deserialize timeseries
    deserialize_timeseries!(p.base_system, db)
    deserialize_portfolio_timeseries!(p, db)

    return p
end

# Ported from SiennaGridDB
function get_entity_attributes(db)
    # First, get all attributes for this entity type and group them by entity_id
    attributes_query = """
    SELECT entity_id,
           json_group_object(name, json(value)) AS attribute_json
    FROM attributes
    GROUP BY entity_id
    """

    attributes_result = DBInterface.execute(db, attributes_query, strict=true)

    # Create a dictionary of entity_id => attributes
    attributes_dict = Dict{Int64, Dict{String, Any}}()
    for row in attributes_result
        attributes_dict[row.entity_id] = JSON3.read(row.attribute_json, Dict{String, Any})
    end

    return attributes_dict
end

# Ported from SiennaGridDB
function make_dict(
    ::Type{T},
    table_name::AbstractString,
    row,
    extra_attributes::Dict{String, Any},
) where {T}
    return merge(
        Dict(
            get(DB_TO_OPENAPI_FIELDS, (table_name, string(k)), string(k)) =>
                coalesce(v, nothing) for (k, v) in zip(propertynames(row), row)
        ),
        extra_attributes,
    )
end

function parse_operational_cost(ops_cost::Dict{String, Any})

    # Build correct cost struct
    if ops_cost["cost_type"] == "THERMAL"
        start_up_dict = ops_cost["start_up"]
        variable_dict = ops_cost["variable"]
        operational_cost = ThermalGenerationCost(;
            start_up=(
                hot=Float64(start_up_dict["hot"]),
                warm=Float64(start_up_dict["warm"]),
                cold=Float64(start_up_dict["cold"]),
            ),
            shut_down=ops_cost["shut_down"],
            fixed=ops_cost["fixed"],
            variable=FuelCurve(;
                fuel_cost=variable_dict["fuel_cost"],
                value_curve=IncrementalCurve(
                    PiecewiseStepData(
                        variable_dict["value_curve"]["function_data"]["x_coords"],
                        variable_dict["value_curve"]["function_data"]["y_coords"],
                    ),
                    variable_dict["value_curve"]["initial_input"],
                ),
                vom_cost=InputOutputCurve(
                    LinearFunctionData(
                        constant_term=variable_dict["vom_cost"]["function_data"]["constant_term"],
                        proportional_term=variable_dict["vom_cost"]["function_data"]["proportional_term"],
                    ),
                ),
            ),
        )
    elseif ops_cost["cost_type"] == "RENEWABLE"
        curtailment_dict = ops_cost["curtailment_cost"]
        variable_dict = ops_cost["variable"]
        operational_cost = RenewableGenerationCost(;
            curtailment_cost=CostCurve(;
                value_curve=InputOutputCurve(
                    LinearFunctionData(
                        constant_term=curtailment_dict["value_curve"]["function_data"]["constant_term"],
                        proportional_term=curtailment_dict["value_curve"]["function_data"]["proportional_term"],
                    ),
                ),
                vom_cost=InputOutputCurve(
                    LinearFunctionData(
                        constant_term=curtailment_dict["vom_cost"]["function_data"]["constant_term"],
                        proportional_term=curtailment_dict["vom_cost"]["function_data"]["proportional_term"],
                    ),
                ),
            ),
            variable=CostCurve(;
                value_curve=InputOutputCurve(
                    LinearFunctionData(
                        constant_term=variable_dict["value_curve"]["function_data"]["constant_term"],
                        proportional_term=variable_dict["value_curve"]["function_data"]["proportional_term"],
                    ),
                ),
                vom_cost=InputOutputCurve(
                    LinearFunctionData(
                        constant_term=variable_dict["vom_cost"]["function_data"]["constant_term"],
                        proportional_term=variable_dict["vom_cost"]["function_data"]["proportional_term"],
                    ),
                ),
            ),
        )
    elseif ops_cost["cost_type"] == "STORAGE"
        charge_variable_dict = ops_cost["charge_variable_cost"]
        discharge_variable_dict = ops_cost["discharge_variable_cost"]
        operational_cost = StorageCost(;
            charge_variable_cost=CostCurve(;
                value_curve=InputOutputCurve(
                    LinearFunctionData(
                        constant_term=charge_variable_dict["value_curve"]["function_data"]["constant_term"],
                        proportional_term=charge_variable_dict["value_curve"]["function_data"]["proportional_term"],
                    ),
                ),
                vom_cost=InputOutputCurve(
                    LinearFunctionData(
                        constant_term=charge_variable_dict["vom_cost"]["function_data"]["constant_term"],
                        proportional_term=charge_variable_dict["vom_cost"]["function_data"]["proportional_term"],
                    ),
                ),
            ),
            discharge_variable_cost=CostCurve(;
                value_curve=InputOutputCurve(
                    LinearFunctionData(
                        constant_term=discharge_variable_dict["value_curve"]["function_data"]["constant_term"],
                        proportional_term=discharge_variable_dict["value_curve"]["function_data"]["proportional_term"],
                    ),
                ),
                vom_cost=InputOutputCurve(
                    LinearFunctionData(
                        constant_term=discharge_variable_dict["vom_cost"]["function_data"]["constant_term"],
                        proportional_term=discharge_variable_dict["vom_cost"]["function_data"]["proportional_term"],
                    ),
                ),
            ),
            start_up=Float64(ops_cost["start_up"]),
            shut_down=ops_cost["shut_down"],
            energy_shortage_cost=ops_cost["energy_shortage_cost"],
            energy_surplus_cost=ops_cost["energy_surplus_cost"],
            fixed=ops_cost["fixed"],
        )
    elseif ops_cost["cost_type"] == "HYDRO_GEN"
        variable_dict = ops_cost["variable"]
        operational_cost = HydroGenerationCost(;
            variable=CostCurve(;
                value_curve=InputOutputCurve(
                    LinearFunctionData(
                        constant_term=variable_dict["value_curve"]["function_data"]["constant_term"],
                        proportional_term=variable_dict["value_curve"]["function_data"]["proportional_term"],
                    ),
                ),
                vom_cost=InputOutputCurve(
                    LinearFunctionData(
                        constant_term=variable_dict["vom_cost"]["function_data"]["constant_term"],
                        proportional_term=variable_dict["vom_cost"]["function_data"]["proportional_term"],
                    ),
                ),
            ),
            fixed=ops_cost["fixed"],
        )
    end
    return operational_cost
end

"""
Function to map storage technology string to StorageTech
"""
function map_storage_tech(fuel::String)
    mapping_dict = Dict("Hydro" => StorageTech.PTES, "Solar" => StorageTech.OTHER_THERM)

    fuel_enum = haskey(mapping_dict, fuel) ? mapping_dict[fuel] : StorageTech.LIB

    return fuel_enum
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
        "CSP" => PrimeMovers.CP,
    )

    return mapping_dict[prime_mover]
end

function map_prime_mover_to_parametric(prime_mover::String)
    mapping_dict = Dict(
        "CT" => PSY.ThermalStandard,
        "STEAM" => PSY.ThermalStandard,
        "CC" => PSY.ThermalStandard,
        "ST" => PSY.ThermalStandard,
        "SYNC_COND" => PSY.ThermalStandard,
        "NUCLEAR" => PSY.ThermalStandard,
        "HYDRO" => PSY.ThermalStandard,
        "ROR" => PSY.RenewableDispatch,
        "PV" => PSY.RenewableDispatch,
        "PVe" => PSY.RenewableDispatch,
        "CSP" => PSY.RenewableDispatch,
        "RTPV" => PSY.RenewableDispatch,
        "WIND" => PSY.RenewableDispatch,
        "Wind" => PSY.RenewableDispatch,
        "WT" => PSY.RenewableDispatch,
        "BA" => PSY.EnergyReservoirStorage,
        "PS" => PSY.EnergyReservoirStorage,
        "STORAGE" => PSY.EnergyReservoirStorage,
        "CP" => PSY.RenewableDispatch,
    )

    return mapping_dict[prime_mover]
end

function map_prime_mover_to_timeseries(prime_mover::PSY.PrimeMovers, fuel::PSY.ThermalFuels)
    mapping_dict = Dict(
        [PrimeMovers.BA, ThermalFuels.OTHER] => "battery_li_cost_R1",
        [PrimeMovers.PVe, ThermalFuels.OTHER] => "csp1_cost_R1", #FIX THIS ONE
        [PrimeMovers.CP, ThermalFuels.OTHER] => "csp1_cost_R1",
        [PrimeMovers.WT, ThermalFuels.OTHER] => "115hh_170rd_cost_R1",
        [PrimeMovers.CT, ThermalFuels.NATURAL_GAS] => "Gas-CC_cost_R1",
        [PrimeMovers.CT, ThermalFuels.DISTILLATE_FUEL_OIL] => "o-g-s_cost_R1",
        [PrimeMovers.ST, ThermalFuels.COAL] => "Coal-new_cost_R1",
        [PrimeMovers.ST, ThermalFuels.DISTILLATE_FUEL_OIL] => "o-g-s_cost_R1",
        [PrimeMovers.ST, ThermalFuels.NUCLEAR] => "Nuclear_cost_R1",
        [PrimeMovers.CC, ThermalFuels.NATURAL_GAS] => "Gas-CC_cost_R1",
    )

    ts_name =
        haskey(mapping_dict, [prime_mover, fuel]) ? mapping_dict[[prime_mover, fuel]] :
        "None"

    return ts_name
end

function add_zones!(p::Portfolio, attributes::Dict{Int64, Dict{String, Any}}, db::SQLite.DB)
    for rec in DBInterface.execute(db, QUERIES[:zones])
        z = Zone(; name=rec.name, id=rec.id)
        add_region!(p, z)
    end
end

function add_nodes!(p::Portfolio, attributes::Dict{Int64, Dict{String, Any}}, db::SQLite.DB)
    for rec in DBInterface.execute(db, QUERIES[:balancing_topologies])
        z = Node(; name=rec.name, id=rec.id)
        add_region!(p, z)
    end
end

function add_buses!(p::Portfolio, attributes::Dict{Int64, Dict{String, Any}}, db::SQLite.DB)
    for rec in DBInterface.execute(db, QUERIES[:zones])
        component_attr = get(attributes, rec.id, Dict{String, Any}())
        a = Area(;
            name=rec.name,
            load_response=component_attr["load_response"],
            peak_active_power=component_attr["peak_active_power"],
            peak_reactive_power=component_attr["peak_reactive_power"],
        )
        if haskey(component_attr, "uuid")
            IS.set_uuid!(IS.get_internal(a), Base.UUID(component_attr["uuid"]))
        end
        PSY.add_component!(p.base_system, a)
    end
    for rec in DBInterface.execute(db, QUERIES[:balancing_topologies])
        component_attr = get(attributes, rec.id, Dict{String, Any}())
        area_name = first(DBInterface.execute(db, QUERIES[:zone], [rec.area])).name
        b = PSY.ACBus(;
            name=rec.name,
            number=rec.id,
            bustype=PSY.get_enum_value(PSY.ACBusTypes, component_attr["bustype"]),
            angle=component_attr["angle"],
            magnitude=component_attr["magnitude"],
            area=get_component(Area, p.base_system, area_name),
            voltage_limits=nothing,
            base_voltage=nothing,
            load_zone=nothing,
        )
        if haskey(component_attr, "uuid")
            IS.set_uuid!(IS.get_internal(b), Base.UUID(component_attr["uuid"]))
        end
        PSY.add_component!(p.base_system, b)
    end
end

function add_aggregate_lines!(
    p::Portfolio,
    attributes::Dict{Int64, Dict{String, Any}},
    db::SQLite.DB,
)
    for rec in DBInterface.execute(db, QUERIES[:aggregate_lines])
        component_attr = get(attributes, rec.id, Dict{String, Any}())
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

# Will be used for new candidate transmission options in the future if in database
function add_nodal_lines!(
    p::Portfolio,
    attributes::Dict{Int64, Dict{String, Any}},
    db::SQLite.DB,
) end

function add_technologies!(
    p::Portfolio,
    attributes::Dict{Int64, Dict{String, Any}},
    db::SQLite.DB,
)
    for rec in DBInterface.execute(db, QUERIES[:technologies])

        # Select appropriate parametric type
        parametric = map_prime_mover_to_parametric(rec.prime_mover)

        if get_aggregation(p) == PSY.ACBus
            area_id =
                first(DBInterface.execute(db, QUERIES[:zone_for_technology], [rec.area])).id
            regions = [
                get_region(Node, p, row.name) for
                row in DBInterface.execute(db, QUERIES[:area_to_topology], [area_id])
            ]
        else
            regions = [get_region(Zone, p, rec.area)]
        end

        if rec.prime_mover == "STORAGE"
            t = StorageTechnology{parametric}(;
                name=rec.prime_mover * string(rec.id),
                id=rec.id,
                capital_costs_discharge=LinearCurve(0.0),
                prime_mover_type=map_prime_mover(rec.prime_mover),
                storage_tech=map_storage_tech(rec.fuel),
                region=regions,
                financial_data=DEFAULT_FINANCIAL_DATA,
                available=true,
                power_systems_type=string(parametric),
                operation_costs=StorageCost(),
            )
        elseif rec.prime_mover in ["HYDRO", "ROR", "SYND_COND"]
            @warn "Technologies of type $(rec.prime_mover) are not currently supported in portfolios. Skipping serialization."
            continue
        else
            t = SupplyTechnology{parametric}(;
                name=rec.prime_mover * string(rec.id),
                id=rec.id,
                capital_costs=LinearCurve(0.0),
                prime_mover_type=map_prime_mover(rec.prime_mover),
                fuel=[map_fuel(rec.fuel)],
                co2=Dict(map_fuel(rec.fuel) => 0.0),
                region=regions,
                financial_data=DEFAULT_FINANCIAL_DATA,
                available=true,
                power_systems_type=string(parametric),
                operation_costs=ThermalGenerationCost(
                    variable=CostCurve(LinearCurve(0.0)),
                    fixed=0.0,
                    start_up=0.0,
                    shut_down=0.0,
                ),
            )
        end
        add_technology!(p, t)
    end
end

function add_generation_units!(
    p::Portfolio,
    attributes::Dict{Int64, Dict{String, Any}},
    db::SQLite.DB,
)
    for rec in DBInterface.execute(db, QUERIES[:generation_units])
        component_type = eval(
            Meta.parse(first(DBInterface.execute(db, QUERIES[:entity_type], [rec.id]))[1]),
        )
        component_attr = get(attributes, rec.id, Dict{String, Any}())

        bus_name = first(
            DBInterface.execute(db, QUERIES[:topology_for_unit], [rec.balancing_topology]),
        )[1]

        if component_type == PSY.ThermalStandard
            time_limits = (
                up=component_attr["time_limits"]["up"],
                down=component_attr["time_limits"]["down"],
            )
            ramp_limits = (
                up=component_attr["ramp_limits"]["up"],
                down=component_attr["ramp_limits"]["down"],
            )
            active_limits = (
                min=component_attr["active_power_limits"]["min"],
                max=component_attr["active_power_limits"]["max"],
            )
            reactive_limits = (
                min=component_attr["reactive_power_limits"]["min"],
                max=component_attr["reactive_power_limits"]["max"],
            )

            ops_cost = parse_operational_cost(component_attr["operation_cost"])
            g = component_type(;
                name=rec.name,
                rating=rec.rating,
                base_power=rec.base_power,
                available=true,
                status=true,
                bus=PSY.get_component(PSY.ACBus, p.base_system, bus_name),
                prime_mover_type=PSY.get_enum_value(PSY.PrimeMovers, rec.prime_mover),
                active_power_limits=active_limits,
                active_power=get(component_attr, "active_power", 0.0),
                reactive_power=get(component_attr, "reactive_power", 0.0),
                reactive_power_limits=reactive_limits,
                ramp_limits=ramp_limits,
                time_limits=time_limits,
                operation_cost=ops_cost,
            )

        elseif component_type == PSY.RenewableDispatch
            reactive_limits = (
                min=component_attr["reactive_power_limits"]["min"],
                max=component_attr["reactive_power_limits"]["max"],
            )
            ops_cost = parse_operational_cost(component_attr["operation_cost"])
            g = component_type(;
                name=rec.name,
                rating=rec.rating,
                base_power=rec.base_power,
                available=true,
                bus=PSY.get_component(PSY.ACBus, p.base_system, bus_name),
                prime_mover_type=PSY.get_enum_value(PSY.PrimeMovers, rec.prime_mover),
                active_power=get(component_attr, "active_power", 0.0),
                reactive_power=get(component_attr, "reactive_power", 0.0),
                reactive_power_limits=reactive_limits,
                power_factor=get(component_attr, "power factor", 0.0),
                operation_cost=ops_cost,
            )

        elseif component_type == PSY.RenewableNonDispatch
            ops_cost = RenewableGenerationCost(nothing)
            g = component_type(;
                name=rec.name,
                rating=rec.rating,
                base_power=rec.base_power,
                available=true,
                bus=PSY.get_component(PSY.ACBus, p.base_system, bus_name),
                prime_mover_type=PSY.get_enum_value(PSY.PrimeMovers, rec.prime_mover),
                active_power=get(component_attr, "active_power", 0.0),
                reactive_power=get(component_attr, "reactive_power", 0.0),
                power_factor=get(component_attr, "power factor", 0.0),
            )
        elseif component_type == PSY.HydroDispatch
            time_limits = (
                up=component_attr["time_limits"]["up"],
                down=component_attr["time_limits"]["down"],
            )
            ramp_limits = (
                up=component_attr["ramp_limits"]["up"],
                down=component_attr["ramp_limits"]["down"],
            )
            active_limits = (
                min=component_attr["active_power_limits"]["min"],
                max=component_attr["active_power_limits"]["max"],
            )
            reactive_limits = (
                min=component_attr["reactive_power_limits"]["min"],
                max=component_attr["reactive_power_limits"]["max"],
            )
            g = component_type(;
                name=rec.name,
                rating=rec.rating,
                base_power=rec.base_power,
                available=true,
                bus=PSY.get_component(PSY.ACBus, p.base_system, bus_name),
                prime_mover_type=PSY.get_enum_value(PSY.PrimeMovers, rec.prime_mover),
                active_power=get(component_attr, "active_power", 0.0),
                reactive_power=get(component_attr, "reactive_power", 0.0),
                active_power_limits=active_limits,
                reactive_power_limits=reactive_limits,
                ramp_limits=ramp_limits,
                time_limits=time_limits,
            )

        elseif component_type == PSY.HydroEnergyReservoir
            active_limits = (
                min=component_attr["active_power_limits"]["min"],
                max=component_attr["active_power_limits"]["max"],
            )
            reactive_limits = (
                min=component_attr["reactive_power_limits"]["min"],
                max=component_attr["reactive_power_limits"]["max"],
            )
            time_limits = (
                up=component_attr["time_limits"]["up"],
                down=component_attr["time_limits"]["down"],
            )
            ramp_limits = (
                up=component_attr["ramp_limits"]["up"],
                down=component_attr["ramp_limits"]["down"],
            )
            ops_cost = parse_operational_cost(component_attr["operation_cost"])

            g = component_type(;
                name=rec.name,
                rating=rec.rating,
                base_power=rec.base_power,
                available=component_attr["available"],
                status=component_attr["status"],
                inflow=component_attr["inflow"],
                bus=PSY.get_component(PSY.ACBus, p.base_system, bus_name),
                time_at_status=component_attr["time_at_status"],
                storage_target=component_attr["storage_target"],
                prime_mover_type=PSY.get_enum_value(PSY.PrimeMovers, rec.prime_mover),
                conversion_factor=component_attr["conversion_factor"],
                storage_capacity=component_attr["storage_capacity"],
                active_power_limits=active_limits,
                active_power=component_attr["active_power"],
                reactive_power=component_attr["reactive_power"],
                reactive_power_limits=reactive_limits,
                ramp_limits=ramp_limits,
                time_limits=time_limits,
                initial_storage=component_attr["initial_storage"],
                operation_cost=ops_cost, #Add later when data is in DB
            )
        end
        if haskey(component_attr, "uuid")
            IS.set_uuid!(IS.get_internal(g), Base.UUID(component_attr["uuid"]))
        end
        add_component!(p.base_system, g)

        if component_type in
           [PSY.ThermalStandard, PSY.RenewableDispatch, PSY.RenewableNonDispatch]
            # Add corresponding technology to portfolio-level data
            if get_aggregation(p) == PSY.ACBus
                regions = [get_region(Node, p, bus_name)]
            else
                area_id =
                    first(
                        DBInterface.execute(
                            db,
                            QUERIES[:topology_to_area],
                            [rec.balancing_topology],
                        ),
                    ).area
                regions = collect(
                    IS.get_components(x -> get_id(x) == area_id, RegionTopology, p.data),
                )
            end
            s = SupplyTechnology{component_type}(;
                name=rec.name,
                id=rec.id,
                capital_costs=LinearCurve(0.0),
                prime_mover_type=PSY.get_enum_value(PSY.PrimeMovers, rec.prime_mover),
                fuel=[map_fuel(rec.prime_mover)],
                region=regions,
                financial_data=DEFAULT_FINANCIAL_DATA,
                available=true,
                power_systems_type=string(component_type),
                operation_costs=ops_cost,
                ramp_limits=(@isdefined ramp_limits) ? ramp_limits : (up=1.0, down=1.0),
                time_limits=(@isdefined time_limits) ? time_limits : (up=1.0, down=1.0),
                capacity_limits=(min=0, max=rec.rating),
                co2=Dict(map_fuel(rec.prime_mover) => 0.0),
            )
            add_technology!(p, s)
            existing = ExistingCapacity(; existing_technologies=[rec.name])
            add_supplemental_attribute!(p, s, existing)
        end
    end
end

function add_storage_units!(
    p::Portfolio,
    attributes::Dict{Int64, Dict{String, Any}},
    db::SQLite.DB,
)
    for rec in DBInterface.execute(db, QUERIES[:storage_units])
        component_type = eval(
            Meta.parse(first(DBInterface.execute(db, QUERIES[:entity_type], [rec.id]))[1]),
        )
        component_attr = get(attributes, rec.id, Dict{String, Any}())

        level_limits = (
            min=component_attr["storage_level_limits"]["min"],
            max=component_attr["storage_level_limits"]["max"],
        )
        input_active_limits = (
            min=component_attr["input_active_power_limits"]["min"],
            max=component_attr["input_active_power_limits"]["max"],
        )
        output_active_limits = (
            min=component_attr["output_active_power_limits"]["min"],
            max=component_attr["output_active_power_limits"]["max"],
        )
        reactive_limits = (
            min=component_attr["reactive_power_limits"]["min"],
            max=component_attr["reactive_power_limits"]["max"],
        )

        # Get name of bus
        bus_name = first(
            DBInterface.execute(db, QUERIES[:topology_for_unit], [rec.balancing_topology]),
        )[1]

        ops_cost = parse_operational_cost(component_attr["operation_cost"])

        t = component_type(;
            #Data pulled from DB
            name=rec.name,
            rating=rec.rating,
            base_power=rec.base_power,
            available=component_attr["available"],
            bus=PSY.get_component(PSY.ACBus, p.base_system, bus_name),
            prime_mover_type=PSY.get_enum_value(PSY.PrimeMovers, rec.prime_mover),
            storage_technology_type=PSY.StorageTech(
                component_attr["storage_technology_type"],
            ),
            conversion_factor=component_attr["conversion_factor"],
            cycle_limits=component_attr["cycle_limits"],
            storage_capacity=component_attr["storage_capacity"],
            storage_level_limits=level_limits,
            storage_target=component_attr["storage_target"],
            initial_storage_capacity_level=component_attr["initial_storage_capacity_level"],
            input_active_power_limits=input_active_limits,
            output_active_power_limits=output_active_limits,
            active_power=component_attr["active_power"],
            reactive_power=component_attr["reactive_power"],
            reactive_power_limits=reactive_limits,
            efficiency=(in=rec.efficiency_up, out=rec.efficiency_down),
            operation_cost=ops_cost,
        )
        if haskey(component_attr, "uuid")
            IS.set_uuid!(IS.get_internal(t), Base.UUID(component_attr["uuid"]))
        end
        add_component!(p.base_system, t)

        # Add corresponding technology to portfolio-level data
        if get_aggregation(p) == PSY.ACBus
            regions = [get_region(Node, p, bus_name)]
        else
            area_id =
                first(
                    DBInterface.execute(
                        db,
                        QUERIES[:topology_to_area],
                        [rec.balancing_topology],
                    ),
                ).area
            regions = collect(
                IS.get_components(x -> get_id(x) == area_id, RegionTopology, p.data),
            )
        end
        s = StorageTechnology{component_type}(;
            name=rec.name,
            id=rec.id,
            capital_costs_discharge=LinearCurve(0.0),
            capital_costs_energy=LinearCurve(0.0),
            prime_mover_type=PSY.get_enum_value(PSY.PrimeMovers, rec.prime_mover),
            storage_tech=PSY.StorageTech(component_attr["storage_technology_type"]),
            region=regions,
            financial_data=DEFAULT_FINANCIAL_DATA,
            available=true,
            power_systems_type=string(component_type),
            operation_costs=ops_cost,
            capacity_limits_discharge=(min=0, max=rec.rating),
            capacity_limits_energy=(min=0, max=component_attr["storage_capacity"]),
        )
        add_technology!(p, s)
        existing = ExistingCapacity(; existing_technologies=[rec.name])
        add_supplemental_attribute!(p, s, existing)
    end
end

function add_demand_requirements!(
    p::Portfolio,
    attributes::Dict{Int64, Dict{String, Any}},
    db::SQLite.DB,
)
    # stream straight through the table
    for rec in DBInterface.execute(db, QUERIES[:demand_requirements])
        component_type = eval(
            Meta.parse(first(DBInterface.execute(db, QUERIES[:entity_type], [rec.id]))[1]),
        )
        component_attr = get(attributes, rec.id, Dict{String, Any}())

        # Determine area based on balancing topology if zonal
        if get_aggregation(p) == PSY.ACBus
            area = rec.balancing_topology
        else
            area =
                first(
                    DBInterface.execute(
                        db,
                        QUERIES[:topology_to_area],
                        [rec.balancing_topology],
                    ),
                ).area
        end

        # build and immediately insert
        d = DemandRequirement{component_type}(;
            name=rec.name,
            id=rec.id,
            region=collect(
                IS.get_components(x -> get_id(x) == area, RegionTopology, p.data),
            ),
            value_of_lost_load=1e8, #TODO: Assign a default value to this field
            power_systems_type=string(component_type),
        )
        add_technology!(p, d)
    end
end

function add_loads!(p::Portfolio, attributes::Dict{Int64, Dict{String, Any}}, db::SQLite.DB)
    # stream straight through the table
    for rec in DBInterface.execute(db, QUERIES[:demand_requirements])
        component_type = eval(
            Meta.parse(first(DBInterface.execute(db, QUERIES[:entity_type], [rec.id]))[1]),
        )
        component_attr = get(attributes, rec.id, Dict{String, Any}())

        # Determine area based on balancing topology if zonal
        bus_name = first(
            DBInterface.execute(db, QUERIES[:topology_for_unit], [rec.balancing_topology]),
        )[1]

        # build and immediately insert
        d = component_type(;
            name=rec.name,
            base_power=rec.base_power,
            bus=PSY.get_component(ACBus, p.base_system, bus_name),
            max_active_power=component_attr["max_active_power"],
            max_reactive_power=component_attr["max_reactive_power"],
            reactive_power=component_attr["reactive_power"],
            active_power=component_attr["active_power"],
            available=component_attr["available"],
        )
        if haskey(component_attr, "uuid")
            IS.set_uuid!(IS.get_internal(d), Base.UUID(component_attr["uuid"]))
        end
        add_component!(p.base_system, d)
    end
end

function add_system_lines!(
    p::Portfolio,
    attributes::Dict{Int64, Dict{String, Any}},
    db::SQLite.DB,
)
    arc_dict = Dict()
    for rec in DBInterface.execute(db, QUERIES[:arcs])
        component_attr = get(attributes, rec.id, Dict{String, Any}())
        from_bus =
            first(DBInterface.execute(db, QUERIES[:topology_from_arc], [rec.from_id])).name
        to_bus =
            first(DBInterface.execute(db, QUERIES[:topology_from_arc], [rec.to_id])).name
        arc = Arc(;
            from=PSY.get_component(ACBus, p.base_system, from_bus),
            to=PSY.get_component(ACBus, p.base_system, to_bus),
        )
        if haskey(component_attr, "uuid")
            IS.set_uuid!(IS.get_internal(arc), Base.UUID(component_attr["uuid"]))
        end
        add_component!(p.base_system, arc)
        arc_dict[rec.id] = arc
    end

    tx_dict = Dict()
    for rec in DBInterface.execute(db, QUERIES[:transmission_lines])
        component_type = eval(
            Meta.parse(first(DBInterface.execute(db, QUERIES[:entity_type], [rec.id]))[1]),
        )
        component_attr = get(attributes, rec.id, Dict{String, Any}())

        # Determine area based on balancing topology if zonal
        arc = first(DBInterface.execute(db, QUERIES[:arc], [rec.arc_id])).id

        if component_type == PSY.Line
            b = (from=component_attr["b"]["from"], to=component_attr["b"]["to"])
            g = (from=component_attr["g"]["from"], to=component_attr["g"]["to"])
            angle_limits = (
                min=component_attr["angle_limits"]["min"],
                max=component_attr["angle_limits"]["max"],
            )
            l = component_type(;
                name=rec.name,
                rating=rec.continuous_rating,
                arc=arc_dict[arc],
                reactive_power_flow=component_attr["reactive_power_flow"],
                active_power_flow=component_attr["active_power_flow"],
                available=component_attr["available"],
                angle_limits=angle_limits,
                x=component_attr["x"] / get_base_power(p.base_system),
                r=component_attr["r"] / get_base_power(p.base_system),
                b=b,
                g=g,
            )
        elseif component_type == PSY.Transformer2W
            l = component_type(;
                name=rec.name,
                rating=rec.continuous_rating,
                arc=arc_dict[arc],
                primary_shunt=component_attr["primary_shunt"]["real"],
                reactive_power_flow=component_attr["reactive_power_flow"],
                active_power_flow=component_attr["active_power_flow"],
                available=component_attr["available"],
                x=component_attr["x"] / get_base_power(p.base_system),
                r=component_attr["r"],
            )
        end
        if haskey(component_attr, "uuid")
            IS.set_uuid!(IS.get_internal(l), Base.UUID(component_attr["uuid"]))
        end
        add_component!(p.base_system, l)

        #If Line is between areas, add to dictionary
        from_area = PSY.get_name(get_area(get_from(get_arc(l))))
        to_area = PSY.get_name(get_area(get_to(get_arc(l))))
        if from_area != to_area
            areas = Set([from_area, to_area])
            if haskey(tx_dict, areas)
                push!(tx_dict[areas], PSY.get_name(l))
            else
                tx_dict[areas] = [PSY.get_name(l)]
            end
        end

        #Build Portfolio transmission based on existing transmission
        if get_aggregation(p) == PSY.ACBus
            component_attr = get(attributes, rec.id, Dict{String, Any}())
            arc = first(DBInterface.execute(db, QUERIES[:arc], [rec.arc_id]))
            balancing_topology_from =
                first(
                    DBInterface.execute(db, QUERIES[:topology_from_arc], [arc.from_id]),
                ).name
            balancing_topology_to =
                first(
                    DBInterface.execute(db, QUERIES[:topology_from_arc], [arc.to_id]),
                ).name
            t = NodalACTransportTechnology{ACBranch}(;
                name=rec.name,
                id=rec.id,
                available=true,
                power_systems_type=string(ACBranch),
                financial_data=DEFAULT_FINANCIAL_DATA,
                start_node=get_region(Node, p, balancing_topology_from),
                end_node=get_region(Node, p, balancing_topology_to),
                reactance=component_attr["x"],
                resistance=component_attr["r"],
                capital_costs=LinearCurve(1000.0),
            )
            add_technology!(p, t)
            existing = ExistingCapacity(; existing_technologies=[rec.name])
            add_supplemental_attribute!(p, t, existing)
        else
        end
    end

    if get_aggregation(p) != PSY.ACBus
        i = 1
        for (areas, lines) in tx_dict
            a = collect(areas)
            t = AggregateTransportTechnology{ACBranch}(;
                name=string(a[1]) * "_" * string(a[2]),
                id=i,
                available=true,
                power_systems_type=string(ACBranch),
                financial_data=DEFAULT_FINANCIAL_DATA,
                start_region=get_region(Zone, p, a[1]),
                end_region=get_region(Zone, p, a[2]),
            )
            i += 1
            add_technology!(p, t)
            existing = ExistingCapacity(; existing_technologies=lines)
            add_supplemental_attribute!(p, t, existing)
        end
    end
end

#TODO: Implement DemandSideTechnologies if/when they are in the database
function add_demand_technologies!(
    p::Portfolio,
    attributes::Dict{Int64, Dict{String, Any}},
    db::SQLite.DB,
) end

function deserialize_portfolio_timeseries!(p::Portfolio, db::SQLite.DB)
    supply_technologies = get_technologies(SupplyTechnology, p)
    for t in supply_technologies

        #Add cost projections to timeseries
        fuel = first(get_fuel(t))
        prime_mover = get_prime_mover_type(t)
        ts_type = map_prime_mover_to_timeseries(prime_mover, fuel)
        if ts_type != "None" && !has_supplemental_attributes(t)
            cost_data = Dict()
            for ts_association in
                DBInterface.execute(db, QUERIES[:investment_timeseries], [ts_type])
                timestamps = [
                    Dates.DateTime(row.idx, 1, 1) for row in DBInterface.execute(
                        db,
                        QUERIES[:ts_data],
                        [ts_association.time_series_uuid],
                    )
                ]
                if occursin("Overnight", ts_association.name) ||
                   occursin("Fixed", ts_association.name)
                    values = [
                        row.value / 1000 for row in DBInterface.execute(
                            db,
                            QUERIES[:ts_data],
                            [ts_association.time_series_uuid],
                        )
                    ]
                else
                    values = [
                        row.value for row in DBInterface.execute(
                            db,
                            QUERIES[:ts_data],
                            [ts_association.time_series_uuid],
                        )
                    ]
                end
                ts_data = TimeSeries.TimeArray(timestamps, values)

                ts =
                    SingleTimeSeries(ts_association.name, ts_data; resolution=Dates.Year(1))
                cost_data[ts_association.name] =
                    first(TimeSeries.values(ts_data[Dates.DateTime(2025, 1, 1)]))
                add_time_series!(p, t, ts)
            end

            #Setting cost data using data from timeseries
            if haskey(cost_data, "heatrate_R1")
                capex = LinearCurve(cost_data["capcost_R1"])
                opex = ThermalGenerationCost(
                    variable=FuelCurve(
                        LinearCurve(cost_data["heatrate_R1"]),
                        cost_data["vom_R1"],
                    ), #Using vom cost as fuel cost for now
                    fixed=cost_data["fom_R1"],
                    start_up=0.0,
                    shut_down=0.0,
                )
                set_operation_costs!(t, opex)
                set_capital_costs!(t, capex)
            elseif haskey(cost_data, "Var O&M \$/MWh_R1")
                capex = LinearCurve(cost_data["Overnight Cap Cost \$/kW_R1"])
                opex = RenewableGenerationCost(
                    variable=CostCurve(
                        LinearCurve(0.0),
                        LinearCurve(cost_data["Var O&M \$/MWh_R1"]),
                    ), #Using vom cost as fuel cost for now
                ) #Fixed cost should be added to this at some point
                set_operation_costs!(t, opex)
                set_capital_costs!(t, capex)
            else
                capex = LinearCurve(cost_data["capcost_R1"])
                opex = RenewableGenerationCost(
                    variable=CostCurve(LinearCurve(0.0), LinearCurve(cost_data["vom_R1"])), #Using vom cost as fuel cost for now
                )
                set_operation_costs!(t, opex)
                set_capital_costs!(t, capex)
            end
        end

        #Using capacity factor data from base system for capacity factors
        if typeof(t) in
           [SupplyTechnology{RenewableDispatch}, SupplyTechnology{RenewableNonDispatch}]
            prime_mover = get_prime_mover_type(t)
            unit = first(
                IS.get_components(
                    x -> PSY.get_prime_mover_type(x) == prime_mover,
                    typeof(t).parameters[1],
                    p.base_system,
                ),
            )
            ts_array = get_time_series_array(SingleTimeSeries, unit, "max_active_power")
            ts = SingleTimeSeries("capacity_factor", ts_array)
            add_time_series!(p, t, ts)
        end
    end

    #Duplicate hourly demand profile on the portfolio level
    demands = get_technologies(DemandRequirement, p)
    for d in demands
        unit = first(
            IS.get_components(
                x -> PSY.get_name(x) == get_name(d),
                typeof(d).parameters[1],
                p.base_system,
            ),
        )
        ts_array = get_time_series_array(SingleTimeSeries, unit, "max_active_power")
        ts = SingleTimeSeries("demand", ts_array)
        add_time_series!(p, d, ts)
    end
end

#############################################################################
# Code below is ported from SiennaGridDB. Can remove this and call these
# functions directly once there is an official release of SiennaGridDB
#############################################################################

function deserialize_timedata(
    db,
    sts_meta::IS.SingleTimeSeriesMetadata,
    time_series_uuid,
)
    stmt = DBInterface.prepare(
        db,
        """
        SELECT idx, value
        FROM static_time_series
        WHERE uuid = ?
        ORDER BY idx
        """,
    )
    rows = DBInterface.execute(stmt, (string(time_series_uuid),))
    column_table = Tables.columntable(rows)
    timestamps =
        range(sts_meta.initial_timestamp; length=sts_meta.length, step=sts_meta.resolution)
    return PowerSystems.TimeSeries.TimeArray(timestamps, column_table.value)
end

function deserialize_timedata(_, ts::IS.DeterministicMetadata, _)
    error("Cannot deserialize deterministic timeseries $ts")
end

function deserialize_time_series_row!(sys, db, row)
    metadata = deserialize_metadata(row)
    if isa(metadata, IS.DeterministicMetadata) &&
       metadata.time_series_type <: IS.DeterministicSingleTimeSeries
        component = PowerSystems.get_component(sys, row.owner_uuid)
        IS.add_metadata!(
            sys.data.time_series_manager.metadata_store,
            component,
            metadata,
        )
    else
        time_array = deserialize_timedata(db, metadata, row.time_series_uuid)
        ts = IS.time_series_metadata_to_data(metadata)(
            metadata,
            time_array,
        )
        PowerSystems.add_time_series!(
            sys,
            PowerSystems.get_component(sys, row.owner_uuid),
            ts,
        )
    end
end

# TODO: STOLEN FROM InfrastructureSystems. This should be made an IS functions.
function deserialize_metadata(row)
    exclude_keys = Set((:metadata_uuid, :owner_uuid, :time_series_type))
    time_series_type =
       IS.TIME_SERIES_STRING_TO_TYPE[row.time_series_type]
    metadata_type = IS.time_series_data_to_metadata(time_series_type)
    fields = Set(fieldnames(metadata_type))
    data = Dict{Symbol, Any}(
        :internal => IS.InfrastructureSystemsInternal(;
            uuid=Base.UUID(row.metadata_uuid),
        ),
    )
    if time_series_type <: IS.Forecast
        # Special case because the table column does not match the field name.
        data[:count] = row.window_count
    end
    if time_series_type <: IS.AbstractDeterministic
        data[:time_series_type] = time_series_type
    end
    for field in keys(row)
        if !in(field, fields) || field in exclude_keys
            continue
        end
        val = getproperty(row, field)
        if field == :initial_timestamp
            data[field] = Dates.DateTime(val)
        elseif field == :resolution
            data[field] = IS.from_iso_8601(val)
        elseif field == :horizon || field == :interval
            if !ismissing(val)
                data[field] = IS.from_iso_8601(val)
            end
        elseif field == :time_series_uuid
            data[field] = Base.UUID(val)
        elseif field == :features
            features_array = IS.JSON3.read(val, Array)
            features_dict = Dict{String, Union{Bool, Int, String}}()
            for obj in features_array
                length(obj) != 1 && error("Invalid features: $obj")
                key = first(keys(obj))
                key in keys(features_dict) && error("Duplicate features: $key")
                features_dict[key] = obj[key]
            end
            data[field] = features_dict
        elseif field == :scaling_factor_multiplier
            if !ismissing(val)
                val2 = IS.JSON3.read(val, Dict{String, Any})
                data[field] = IS.deserialize(Function, val2)
            end
        else
            data[field] = val
        end
    end
    metadata = metadata_type(; data...)
    return metadata
end

function get_example_metadata(db)
    time_series_uuid_rows = DBInterface.execute(
        db,
        "SELECT * FROM time_series_associations WHERE time_series_type != 'DeterministicSingleTimeSeries' GROUP BY time_series_uuid",
    )
    return time_series_uuid_rows
end

function deserialize_time_series_from_metadata!(sys::PowerSystems.System, db, metadata, row)
    time_array = deserialize_timedata(db, metadata, row.time_series_uuid)
    ts = IS.time_series_metadata_to_data(metadata)(metadata, time_array)
    PowerSystems.add_time_series!(sys, PowerSystems.get_component(sys, row.owner_uuid), ts)
end

function deserialize_timeseries!(sys::PowerSystems.System, db)
    DBInterface.transaction(db) do
        # For each time_series_uuid, we'll pick a "real" metadata_uuid (so no DeterministicSingleTimeSeries),
        # then we will deserialize and add them to the system. Finally, we'll go through and add_metadata!
        # for all others.
        serialized_metadata = Set{String}()
        for row in get_example_metadata(db)
            if row.metadata_uuid != "0" #Including this to skip over the temporary investment timeseries
                metadata = deserialize_metadata(row)
                deserialize_time_series_from_metadata!(sys, db, metadata, row)
                push!(serialized_metadata, row.metadata_uuid)
            end
        end

        associations = DBInterface.execute(db, "SELECT * FROM time_series_associations")

        for row in associations
            if row.metadata_uuid != "0"
                metadata = deserialize_metadata(row)
                if in(row.metadata_uuid, serialized_metadata)
                    continue
                end
                component = PowerSystems.get_component(sys, row.owner_uuid)
                IS.add_metadata!(
                    sys.data.time_series_manager.metadata_store,
                    component,
                    metadata,
                )
            end
        end
    end
end
