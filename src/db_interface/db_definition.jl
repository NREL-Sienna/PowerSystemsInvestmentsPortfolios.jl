function _read_sql_statements(filepath::AbstractString)
    sql_content = read(filepath, String)
    statements = split(sql_content, ';')
    cleaned_statements = [strip(s) for s in statements if !isempty(strip(s))]
    return cleaned_statements
end

# Track the SQL files as precompilation dependencies so editing them (without
# touching any .jl) correctly invalidates the precompile cache.
include_dependency(joinpath(@__DIR__, "schema.sql"))
include_dependency(joinpath(@__DIR__, "triggers.sql"))

const SQLITE_CREATE_STR = _read_sql_statements(joinpath(@__DIR__, "schema.sql"))
const SQLITE_TRIGGERS_STR = [read(joinpath(@__DIR__, "triggers.sql"), String)]

const TABLE_SCHEMAS = Dict(
    "entities" =>
        Tables.Schema(["id", "entity_table", "entity_type"], [Int64, String, String]),
    "entity_types" => Tables.Schema(["name"], [String]),
    "prime_mover_types" => Tables.Schema(
        ["id", "name", "description"],
        [Int64, String, Union{String, Nothing}],
    ),
    "fuels" => Tables.Schema(
        ["id", "name", "description"],
        [Int64, String, Union{String, Nothing}],
    ),
    "planning_regions" => Tables.Schema(
        ["id", "name", "description"],
        [Int64, String, Union{String, Nothing}],
    ),
    "balancing_topologies" => Tables.Schema(
        ["id", "name", "area", "description"],
        [Int64, String, Union{Int64, Nothing}, Union{String, Nothing}],
    ),
    "arcs" => Tables.Schema(["id", "from_id", "to_id"], [Int64, Int64, Int64]),
    "transmission_lines" => Tables.Schema(
        [
            "id",
            "name",
            "arc_id",
            "continuous_rating",
            "ste_rating",
            "lte_rating",
            "line_length",
        ],
        [
            Int64,
            String,
            Int64,
            Float64,
            Union{Float64, Nothing},
            Union{Float64, Nothing},
            Union{Float64, Nothing},
        ],
    ),
    "transmission_interchanges" => Tables.Schema(
        ["id", "name", "arc_id", "max_flow_from", "max_flow_to"],
        [Int64, String, Int64, Float64, Float64],
    ),
    # Shared table for Transformer3W and PhaseShiftingTransformer3W: columns are
    # the 46 fields common to both types. Type-specific fields land in `attributes`.
    # Column order MUST match the CREATE TABLE in schema.sql (test-schema-sync.jl).
    "three_winding_transformers" => Tables.Schema(
        [
            "id",
            "name",
            "available",
            "star_bus",
            "primary_star_arc",
            "secondary_star_arc",
            "tertiary_star_arc",
            "active_power_flow_primary",
            "reactive_power_flow_primary",
            "active_power_flow_secondary",
            "reactive_power_flow_secondary",
            "active_power_flow_tertiary",
            "reactive_power_flow_tertiary",
            "r_primary",
            "x_primary",
            "r_secondary",
            "x_secondary",
            "r_tertiary",
            "x_tertiary",
            "r_12",
            "x_12",
            "r_23",
            "x_23",
            "r_13",
            "x_13",
            "base_power_12",
            "base_power_23",
            "base_power_13",
            "rating",
            "base_voltage_primary",
            "base_voltage_secondary",
            "base_voltage_tertiary",
            "g",
            "b",
            "primary_turns_ratio",
            "secondary_turns_ratio",
            "tertiary_turns_ratio",
            "available_primary",
            "available_secondary",
            "available_tertiary",
            "rating_primary",
            "rating_secondary",
            "rating_tertiary",
            "control_objective_primary",
            "control_objective_secondary",
            "control_objective_tertiary",
        ],
        [
            Int64,
            String,
            Bool,
            Int64,
            Int64,
            Int64,
            Int64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Union{Float64, Nothing},
            Union{Float64, Nothing},
            Union{Float64, Nothing},
            Union{Float64, Nothing},
            Union{Float64, Nothing},
            Union{Float64, Nothing},
            Union{Float64, Nothing},
            Union{Float64, Nothing},
            Union{Float64, Nothing},
            Union{Bool, Nothing},
            Union{Bool, Nothing},
            Union{Bool, Nothing},
            Union{Float64, Nothing},
            Union{Float64, Nothing},
            Union{Float64, Nothing},
            Union{String, Nothing},
            Union{String, Nothing},
            Union{String, Nothing},
        ],
    ),
    "thermal_generators" => Tables.Schema(
        [
            "id",
            "name",
            "prime_mover_type",
            "fuel",
            "balancing_topology",
            "rating",
            "base_power",
            "active_power_limits",
            "reactive_power_limits",
            "ramp_limits",
            "time_limits",
            "must_run",
            "available",
            "status",
            "active_power",
            "reactive_power",
            "operation_cost",
        ],
        [
            Int64,
            String,
            String,
            String,
            Int64,
            Float64,
            Float64,
            String,  # JSON: {"min": ..., "max": ...}
            Union{String, Nothing},  # JSON: {"min": ..., "max": ...}
            Union{String, Nothing},  # JSON: {"up": ..., "down": ...}
            Union{String, Nothing},  # JSON: {"up": ..., "down": ...}
            Bool,
            Bool,
            Bool,
            Float64,
            Float64,
            String,  # JSON stored as String
        ],
    ),
    "renewable_generators" => Tables.Schema(
        [
            "id",
            "name",
            "prime_mover_type",
            "balancing_topology",
            "rating",
            "base_power",
            "power_factor",
            "reactive_power_limits",
            "available",
            "active_power",
            "reactive_power",
            "operation_cost",
        ],
        [
            Int64,
            String,
            String,
            Int64,
            Float64,
            Float64,
            Float64,
            Union{String, Nothing},  # JSON: {"min": ..., "max": ...}
            Bool,
            Float64,
            Float64,
            Union{String, Nothing},  # JSON stored as String, NULL for RenewableNonDispatch
        ],
    ),
    "hydro_generators" => Tables.Schema(
        [
            "id",
            "name",
            "prime_mover_type",
            "balancing_topology",
            "rating",
            "base_power",
            "active_power_limits",
            "reactive_power_limits",
            "ramp_limits",
            "time_limits",
            "available",
            "active_power",
            "reactive_power",
            "powerhouse_elevation",
            "outflow_limits",
            "conversion_factor",
            "travel_time",
            "operation_cost",
        ],
        [
            Int64,
            String,
            String,
            Int64,
            Float64,
            Float64,
            String,  # JSON: {"min": ..., "max": ...}
            Union{String, Nothing},  # JSON: {"min": ..., "max": ...}
            Union{String, Nothing},  # JSON: {"up": ..., "down": ...}
            Union{String, Nothing},  # JSON: {"up": ..., "down": ...}
            Bool,
            Float64,
            Float64,
            Union{Float64, Nothing},
            Union{String, Nothing},  # JSON: {"min": ..., "max": ...}
            Union{Float64, Nothing},
            Union{Float64, Nothing},
            String,  # JSON stored as String
        ],
    ),
    "storage_units" => Tables.Schema(
        [
            "id",
            "name",
            "prime_mover_type",
            "storage_technology_type",
            "balancing_topology",
            "rating",
            "base_power",
            "storage_capacity",
            "storage_level_limits",
            "initial_storage_capacity_level",
            "input_active_power_limits",
            "output_active_power_limits",
            "efficiency",
            "reactive_power_limits",
            "active_power",
            "reactive_power",
            "available",
            "conversion_factor",
            "storage_target",
            "cycle_limits",
            "operation_cost",
        ],
        [
            Int64,
            String,
            String,
            String,
            Int64,
            Float64,
            Float64,
            Float64,
            String,  # JSON: {"min": ..., "max": ...}
            Float64,
            String,  # JSON: {"min": ..., "max": ...}
            String,  # JSON: {"min": ..., "max": ...}
            String,  # JSON: {"in": ..., "out": ...}
            Union{String, Nothing},  # JSON: {"min": ..., "max": ...}
            Float64,
            Float64,
            Bool,
            Float64,
            Float64,
            Int64,
            Union{String, Nothing},  # JSON stored as String, nullable
        ],
    ),
    "hydro_reservoirs" => Tables.Schema(
        [
            "id",
            "name",
            "available",
            "storage_level_limits",
            "initial_level",
            "spillage_limits",
            "inflow",
            "outflow",
            "level_targets",
            "intake_elevation",
            "head_to_volume_factor",
            "operation_cost",
            "level_data_type",
        ],
        [
            Int64,
            String,
            Bool,
            String,  # JSON
            Float64,
            Union{String, Nothing},  # JSON, nullable
            Float64,
            Float64,
            Union{Float64, Nothing},
            Float64,
            String,  # JSON
            String,  # JSON
            String,
        ],
    ),
    "hydro_reservoir_connections" =>
        Tables.Schema(["source_id", "sink_id"], [Int64, Int64]),
    "supply_technologies" => Tables.Schema(
        [
            "id",
            "name",
            "prime_mover_type",
            "region",
            "power_systems_type",
            "lifetime",
            "unit_size",
            "capacity_limits",
            "fuel",
            "start_fuel_mmbtu_per_mwh",
            "cofire_level_limits",
            "cofire_start_limits",
            "co2",
            "available",
            "ramp_limits",
            "time_limits",
            "outage_factor",
            "min_generation_fraction",
            "capital_costs",
            "operation_costs",
            "financial_data",
        ],
        [
            Int64,
            String,
            String,
            String,
            String,
            Union{Int64, Nothing},
            Union{Float64, Nothing},
            Union{String, Nothing},
            String,
            Union{Float64, Nothing},
            Union{String, Nothing},
            Union{String, Nothing},
            Union{String, Nothing},
            Bool,
            Union{String, Nothing},
            Union{String, Nothing},
            Union{Float64, Nothing},
            Union{Float64, Nothing},
            String,
            String,
            String,
        ],
    ),
    "storage_technologies" => Tables.Schema(
        [
            "id",
            "name",
            "prime_mover_type",
            "storage_tech",
            "region",
            "power_systems_type",
            "lifetime",
            "unit_size_charge",
            "unit_size_discharge",
            "unit_size_energy",
            "capacity_limits_charge",
            "capacity_limits_discharge",
            "capacity_limits_energy",
            "available",
            "duration_limits",
            "efficiency",
            "min_discharge_fraction",
            "losses",
            "capital_costs_charge",
            "capital_costs_discharge",
            "capital_costs_energy",
            "operation_costs",
            "financial_data",
        ],
        [
            Int64,
            String,
            String,
            String,
            String,
            String,
            Union{Int64, Nothing},
            Union{Float64, Nothing},
            Union{Float64, Nothing},
            Union{Float64, Nothing},
            Union{String, Nothing},
            Union{String, Nothing},
            Union{String, Nothing},
            Bool,
            Union{String, Nothing},
            Union{String, Nothing},
            Union{Float64, Nothing},
            Union{Float64, Nothing},
            Union{String, Nothing},
            String,
            String,
            String,
            String,
        ],
    ),
    "transport_technologies" => Tables.Schema(
        [
            "id",
            "name",
            "power_systems_type",
            "available",
            "capital_costs",
            "financial_data",
            "unit_size",
        ],
        [Int64, String, String, Bool, String, String, Union{Float64, Nothing}],
    ),
    "demand_technologies" => Tables.Schema(
        ["id", "name", "available", "region", "power_systems_type"],
        [Int64, String, Bool, String, String],
    ),
    "attributes" => Tables.Schema(
        ["id", "entity_id", "TYPE", "name", "value"],
        # Note: json_type is a generated column, not included here
        [Int64, Int64, String, String, String],
    ),
    "supplemental_attributes" => Tables.Schema(
        ["id", "TYPE", "value"],
        # Note: json_type is a generated column, not included here
        [Int64, String, String],
    ),
    "supplemental_attributes_association" =>
        Tables.Schema(["attribute_id", "entity_id"], [Int64, Int64]),
    "time_series_associations" => Tables.Schema(
        [
            "id",
            "time_series_uuid",
            "time_series_type",
            "initial_timestamp",
            "resolution",
            "horizon",
            "interval",
            "window_count",
            "length",
            "name",
            "owner_id",
            "owner_type",
            "owner_category",
            "features",
            "scaling_factor_multiplier",
            "metadata_uuid",
            "units",
        ],
        [
            Int64,
            String,
            String,
            String,
            Int64,
            Union{Int64, Nothing},
            Union{Int64, Nothing},
            Union{Int64, Nothing},
            Union{Int64, Nothing},
            Union{String, Nothing},
            String,
            Int64,
            Union{String, Nothing},
            Union{String, Nothing},
            Union{String, Nothing},
            Union{String, Nothing},
            Union{String, Nothing},
        ],
    ),
    "loads" => Tables.Schema(
        ["id", "name", "balancing_topology", "base_power"],
        [Int64, String, Int64, Union{Float64, Nothing}],
    ),
    "static_time_series" =>
        Tables.Schema(["id", "uuid", "idx", "value"], [Int64, String, Int64, Float64]),
)

function make_sqlite!(db)
    for table in SQLITE_CREATE_STR
        DBInterface.execute(db, table)
    end
    for table in SQLITE_TRIGGERS_STR
        DBInterface.execute(db, table)
    end

    entity_type_stmt = DBInterface.prepare(db, "INSERT INTO entity_types (name) VALUES (?)")
    for type_name in keys(TYPE_NAMES)
        DBInterface.execute(entity_type_stmt, (type_name,))
    end
    for type_name in keys(SA_TYPE_NAMES)
        DBInterface.execute(entity_type_stmt, (type_name,))
    end
    for type_name in keys(SA_TYPE_NAMES_PSIP)
        DBInterface.execute(entity_type_stmt, (type_name,))
    end

    # Insert default prime mover types based on PowerSystems.PrimeMovers
    pm_stmt = DBInterface.prepare(
        db,
        "INSERT INTO prime_mover_types (id, name, description) VALUES (?, ?, ?)",
    )
    # List derived from PowerSystems.PrimeMovers enums
    # Descriptions are set to the name for simplicity, adjust if needed.
    default_prime_movers = [
        (1, "BA", "Battery Energy Storage"), # Battery
        (2, "BT", "Binary Cycle Turbine"), # Binary Cycle Turbine (Geothermal)
        (3, "CA", "Compressed Air Energy Storage"), # Compressed Air
        (4, "CC", "Combined Cycle"), # Combined Cycle
        (5, "CE", "Reciprocating Engine"), # Combustion Engine (IC)
        (6, "CP", "Concentrated Solar Power"), # Concentrated Solar Power
        (7, "CS", "Combined Cycle Steam"), # Combined Cycle Steam part
        (8, "CT", "Combustion (Gas) Turbine"), # Combustion Turbine
        (9, "ES", "Energy Storage"), # Generic Energy Storage
        (10, "FC", "Fuel Cell"), # Fuel Cell
        (11, "FW", "Flywheel Energy Storage"), # Flywheel
        (12, "GT", "Gas Turbine"), # Gas Turbine (part of CC)
        (13, "HA", "Hydro Francis"), # Hydro Aggregated
        (14, "HB", "Hydro Bulb"), # Hydro Bulb
        (15, "HK", "Hydro Kaplan"), # Hydro Kaplan
        (16, "HY", "Hydro"), # Hydro Generic
        (17, "IC", "Internal Combustion Engine"), # Internal Combustion
        (18, "OT", "Other"), # Other
        (19, "PS", "Pumped Storage"), # Pumped Storage
        (20, "PVe", "Photovoltaic"), # Photovoltaic
        (21, "ST", "Steam Turbine"), # Steam Turbine
        (22, "WS", "Wind Offshore"), # Wind Offshore
        (23, "WT", "Wind Onshore"), # Wind Onshore
    ]
    for (id, name, desc) in default_prime_movers
        DBInterface.execute(pm_stmt, (id, name, desc))
    end

    # Insert default fuels based on PowerSystems.ThermalFuels and existing entries
    fuel_stmt = DBInterface.prepare(
        db,
        "INSERT INTO fuels (id, name, description) VALUES (?, ?, ?)",
    )
    default_fuels = [
        (1, "COAL", "Coal"),
        (2, "ANTHRACITE_COAL", "Anthracite Coal"),
        (3, "BITUMINOUS_COAL", "Bituminous Coal"),
        (4, "LIGNITE_COAL", "Lignite Coal"),
        (5, "SUBBITUMINOUS_COAL", "Subbituminous Coal"),
        (6, "WASTE_COAL", "Waste Coal"),
        (7, "REFINED_COAL", "Refined Coal"),
        (8, "SYNTHESIS_GAS_COAL", "Synthesis Gas Coal"),
        (9, "DISTILLATE_FUEL_OIL", "Distillate Fuel Oil"),
        (10, "JET_FUEL", "Jet Fuel"),
        (11, "KEROSENE", "Kerosene"),
        (12, "PETROLEUM_COKE", "Petroleum Coke"),
        (13, "RESIDUAL_FUEL_OIL", "Residual Fuel Oil"),
        (14, "PROPANE", "Propane"),
        (15, "SYNTHESIS_GAS_PETROLEUM_COKE", "Synthesis Gas Petroleum Coke"),
        (16, "WASTE_OIL", "Waste Oil"),
        (17, "BLASTE_FURNACE_GAS", "Blaste Furnace Gas"),
        (18, "NATURAL_GAS", "Natural Gas"),
        (19, "OTHER_GAS", "Other Gas"),
        (20, "NUCLEAR", "Nuclear"),
        (21, "AG_BYPRODUCT", "Ag Byproduct"),
        (22, "MUNICIPAL_WASTE", "Municipal Waste"),
        (23, "OTHER_BIOMASS_SOLIDS", "Other Biomass Solids"),
        (24, "WOOD_WASTE_SOLIDS", "Wood Waste Solids"),
        (26, "OTHER_BIOMASS_LIQUIDS", "Other Biomass Liquids"),
        (27, "SLUDGE_WASTE", "Sludge Waste"),
        (28, "BLACK_LIQUOR", "Black Liquor"),
        (29, "WOOD_WASTE_LIQUIDS", "Wood Waste Liquids"),
        (30, "LANDFILL_GAS", "Landfill Gas"),
        (31, "OTHEHR_BIOMASS_GAS", "Other Biomass Gas"),
        (32, "GEOTHERMAL", "Geothermal"),
        (33, "WASTE_HEAT", "Waste Heat"),
        (34, "TIREDERIVED_FUEL", "Tirederived Fuel"),
        (35, "OTHER", "Other"),
        (36, "WIND", "Wind"),
        (37, "SOLAR", "Solar"),
    ]
    for (id, name, desc) in default_fuels
        DBInterface.execute(fuel_stmt, (id, name, desc))
    end

    # Insert default storage technology types based on PowerSystems.StorageTech
    st_stmt = DBInterface.prepare(
        db,
        "INSERT INTO storage_technology_types (id, name, description) VALUES (?, ?, ?)",
    )
    default_storage_techs = [
        (1, "PTES", "Pumped Thermal Energy Storage"),
        (2, "LIB", "Lithium-Ion Battery"),
        (3, "LAB", "Lead Acid Battery"),
        (4, "FLWB", "Redox Flow Battery"),
        (5, "SIB", "Sodium Ion Battery"),
        (6, "ZIB", "Zinc Ion Battery"),
        (7, "HGS", "Hydrogen Gas Storage"),
        (8, "LAES", "Liquid Air Energy Storage"),
        (9, "OTHER_CHEM", "Chemical Storage"),
        (10, "OTHER_MECH", "Mechanical Storage"),
        (11, "OTHER_THERM", "Thermal Storage"),
    ]
    for (id, name, desc) in default_storage_techs
        DBInterface.execute(st_stmt, (id, name, desc))
    end
end
