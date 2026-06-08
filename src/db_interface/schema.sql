-- DISCLAIMER
-- The current version of this schema only works for SQLITE >=3.45
-- When adding new functionality, think about the following:
--      1. Simplicity and ease of use over complexity,
--      2. Clear, consice and strict fields but allow for extensability,
--      3. User friendly over peformance, but consider performance always,
-- WARNING: This script should only be used while testing the schema and should not
-- be applied to existing dataset since it drops all the information it has.
DROP TABLE IF EXISTS thermal_generators;

DROP TABLE IF EXISTS renewable_generators;

DROP TABLE IF EXISTS hydro_generators;

DROP TABLE IF EXISTS storage_units;

DROP TABLE IF EXISTS prime_mover_types;

DROP TABLE IF EXISTS balancing_topologies;

DROP TABLE IF EXISTS supply_technologies;

DROP TABLE IF EXISTS storage_technology_types;

DROP TABLE IF EXISTS storage_technologies;

DROP TABLE IF EXISTS demand_technologies;

DROP TABLE IF EXISTS transmission_lines;

DROP TABLE IF EXISTS three_winding_transformers;

DROP TABLE IF EXISTS planning_regions;

DROP TABLE IF EXISTS transmission_interchanges;

DROP TABLE IF EXISTS entities;

DROP TABLE IF EXISTS time_series_associations;

DROP TABLE IF EXISTS attributes;

DROP TABLE IF EXISTS loads;

DROP TABLE IF EXISTS static_time_series;

DROP TABLE IF EXISTS entity_types;

DROP TABLE IF EXISTS supplemental_attributes;

DROP TABLE IF EXISTS arcs;

DROP TABLE IF EXISTS hydro_reservoirs;

DROP TABLE IF EXISTS hydro_reservoir_connections;

DROP TABLE IF EXISTS fuels;

DROP TABLE IF EXISTS supplemental_attributes_association;

DROP TABLE IF EXISTS transport_technologies;

PRAGMA foreign_keys = ON;

-- NOTE: This table should not be interacted directly since it gets populated
-- automatically.
-- Table of certain entities of griddb schema.
CREATE TABLE entities (
    id INTEGER PRIMARY KEY,
    entity_table TEXT NOT NULL,
    entity_type TEXT NOT NULL,
    FOREIGN KEY (entity_type) REFERENCES entity_types (name)
) strict;

-- Table of possible entity types
CREATE TABLE entity_types (
    name TEXT PRIMARY KEY,
    is_topology BOOLEAN NOT NULL DEFAULT FALSE
);

-- NOTE: Sienna-griddb follows the convention of the EIA prime mover where we
-- have a `prime_mover` and `fuel` to classify generators/storage units.
-- However, users could use any combination of `prime_mover` and `fuel` for
-- their own application. The only constraint is that the uniqueness is enforced
-- by the combination of (prime_mover, fuel)
-- Categories to classify generating units and supply technologies
CREATE TABLE prime_mover_types (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT NULL
) strict;

CREATE TABLE fuels (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT NULL
) strict;

CREATE TABLE storage_technology_types (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT NULL
) strict;

-- Investment regions
CREATE TABLE planning_regions (
    id INTEGER PRIMARY KEY REFERENCES entities (id) ON DELETE CASCADE,
    name TEXT NOT NULL UNIQUE,
    description TEXT NULL
) strict;

-- Balancing topologies for the system. Could be either buses, or larger
-- aggregated regions.
CREATE TABLE balancing_topologies (
    id INTEGER PRIMARY KEY REFERENCES entities (id) ON DELETE CASCADE,
    name TEXT NOT NULL UNIQUE,
    area INTEGER NULL REFERENCES planning_regions (id) ON DELETE
    SET NULL,
        description TEXT NULL
) strict;

-- NOTE: The purpose of this table is to provide links different entities that
-- naturally have a relantionship not model dependent (e.g., transmission lines,
-- transmission interchanges, etc.).
-- Physical connection between entities.
CREATE TABLE arcs (
    id INTEGER PRIMARY KEY REFERENCES entities (id) ON DELETE CASCADE,
    from_id INTEGER NOT NULL,
    to_id INTEGER NOT NULL,
    CHECK (from_id <> to_id),
    FOREIGN KEY (from_id) REFERENCES entities (id) ON DELETE CASCADE,
    FOREIGN KEY (to_id) REFERENCES entities (id) ON DELETE CASCADE
) strict;

-- Existing transmission lines
CREATE TABLE transmission_lines (
    id INTEGER PRIMARY KEY REFERENCES entities (id) ON DELETE CASCADE,
    name TEXT NOT NULL UNIQUE,
    arc_id INTEGER,
    continuous_rating REAL NULL CHECK (continuous_rating >= 0),
    ste_rating REAL NULL CHECK (ste_rating >= 0),
    lte_rating REAL NULL CHECK (lte_rating >= 0),
    line_length REAL NULL CHECK (line_length >= 0),
    FOREIGN KEY (arc_id) REFERENCES arcs (id) ON DELETE CASCADE
) strict;

-- NOTE: The purpose of this table is to provide physical limits to flows
-- between areas or balancing topologies. In contrast with the transmission
-- lines, this entities are used to enforce given physical limits of certain
-- markets.
-- Transmission interchanges between two balancing topologies or areas
CREATE TABLE transmission_interchanges (
    id INTEGER PRIMARY KEY REFERENCES entities (id) ON DELETE CASCADE,
    name TEXT NOT NULL UNIQUE,
    arc_id INTEGER REFERENCES arcs(id) ON DELETE CASCADE,
    max_flow_from REAL NOT NULL,
    max_flow_to REAL NOT NULL
) strict;

-- Three-winding transformers (Transformer3W, PhaseShiftingTransformer3W).
-- Type-specific fields (group numbers, alpha_*, phase_angle_limits) fall
-- through to the generic `attributes` table.
CREATE TABLE three_winding_transformers (
    id INTEGER PRIMARY KEY REFERENCES entities (id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    available INTEGER NOT NULL,
    -- strict tables: store Bool as 0/1
    star_bus INTEGER NOT NULL REFERENCES entities (id) ON DELETE CASCADE,
    primary_star_arc INTEGER NOT NULL REFERENCES entities (id) ON DELETE CASCADE,
    secondary_star_arc INTEGER NOT NULL REFERENCES entities (id) ON DELETE CASCADE,
    tertiary_star_arc INTEGER NOT NULL REFERENCES entities (id) ON DELETE CASCADE,
    active_power_flow_primary REAL NOT NULL,
    reactive_power_flow_primary REAL NOT NULL,
    active_power_flow_secondary REAL NOT NULL,
    reactive_power_flow_secondary REAL NOT NULL,
    active_power_flow_tertiary REAL NOT NULL,
    reactive_power_flow_tertiary REAL NOT NULL,
    r_primary REAL NOT NULL,
    x_primary REAL NOT NULL,
    r_secondary REAL NOT NULL,
    x_secondary REAL NOT NULL,
    r_tertiary REAL NOT NULL,
    x_tertiary REAL NOT NULL,
    r_12 REAL NOT NULL,
    x_12 REAL NOT NULL,
    r_23 REAL NOT NULL,
    x_23 REAL NOT NULL,
    r_13 REAL NOT NULL,
    x_13 REAL NOT NULL,
    base_power_12 REAL NOT NULL,
    base_power_23 REAL NOT NULL,
    base_power_13 REAL NOT NULL,
    -- optional below: not in either model's check_required (model defaults apply)
    rating REAL,
    base_voltage_primary REAL,
    base_voltage_secondary REAL,
    base_voltage_tertiary REAL,
    g REAL,
    b REAL,
    primary_turns_ratio REAL,
    secondary_turns_ratio REAL,
    tertiary_turns_ratio REAL,
    available_primary INTEGER,
    available_secondary INTEGER,
    available_tertiary INTEGER,
    rating_primary REAL,
    rating_secondary REAL,
    rating_tertiary REAL,
    control_objective_primary TEXT,
    control_objective_secondary TEXT,
    control_objective_tertiary TEXT
) strict;

-- NOTE: The purpose of these tables is to capture data of **existing units only**.
-- Table of thermal generation units (ThermalStandard, ThermalMultiStart)
CREATE TABLE thermal_generators (
    id INTEGER PRIMARY KEY REFERENCES entities (id) ON DELETE CASCADE,
    name TEXT NOT NULL UNIQUE,
    prime_mover_type TEXT NOT NULL REFERENCES prime_mover_types(name),
    fuel TEXT NOT NULL DEFAULT 'OTHER' REFERENCES fuels(name),
    balancing_topology INTEGER NOT NULL REFERENCES balancing_topologies (id) ON DELETE CASCADE,
    rating REAL NOT NULL CHECK (rating >= 0),
    base_power REAL NOT NULL CHECK (base_power > 0),
    -- Power limits (JSON: {"min": ..., "max": ...}):
    active_power_limits JSON NOT NULL,
    reactive_power_limits JSON NULL,
    -- Ramp limits (JSON: {"up": ..., "down": ...}, MW/min):
    ramp_limits JSON NULL,
    -- Time limits (JSON: {"up": ..., "down": ...}, hours):
    time_limits JSON NULL,
    -- Operational flags:
    must_run BOOLEAN NOT NULL DEFAULT FALSE,
    available BOOLEAN NOT NULL DEFAULT TRUE,
    "status" BOOLEAN NOT NULL DEFAULT FALSE,
    -- Initial setpoints:
    active_power REAL NOT NULL DEFAULT 0.0,
    reactive_power REAL NOT NULL DEFAULT 0.0,
    -- Cost (complex structure, stored as JSON):
    operation_cost JSON NOT NULL DEFAULT '{"cost_type": "THERMAL", "fixed": 0, "shut_down": 0, "start_up": 0, "variable": {"variable_cost_type": "COST", "power_units": "NATURAL_UNITS", "value_curve": {"curve_type": "INPUT_OUTPUT", "function_data": {"function_type": "LINEAR", "proportional_term": 0, "constant_term": 0}}, "vom_cost": {"curve_type": "INPUT_OUTPUT", "function_data": {"function_type": "LINEAR", "proportional_term": 0, "constant_term": 0}}}}'
);

-- Table of renewable generation units (RenewableDispatch, RenewableNonDispatch)
CREATE TABLE renewable_generators (
    id INTEGER PRIMARY KEY REFERENCES entities (id) ON DELETE CASCADE,
    name TEXT NOT NULL UNIQUE,
    prime_mover_type TEXT NOT NULL REFERENCES prime_mover_types(name),
    balancing_topology INTEGER NOT NULL REFERENCES balancing_topologies (id) ON DELETE CASCADE,
    rating REAL NOT NULL CHECK (rating >= 0),
    base_power REAL NOT NULL CHECK (base_power > 0),
    -- Renewable-specific:
    power_factor REAL NOT NULL DEFAULT 1.0 CHECK (
        power_factor > 0
        AND power_factor <= 1.0
    ),
    -- Power limits (JSON: {"min": ..., "max": ...}):
    reactive_power_limits JSON NULL,
    -- Operational flags:
    available BOOLEAN NOT NULL DEFAULT TRUE,
    -- Initial setpoints:
    active_power REAL NOT NULL DEFAULT 0.0,
    reactive_power REAL NOT NULL DEFAULT 0.0,
    -- Cost (NULL for RenewableNonDispatch):
    operation_cost JSON NULL DEFAULT '{"cost_type":"RENEWABLE","fixed":0,"variable":{"variable_cost_type":"COST","power_units":"NATURAL_UNITS","value_curve":{"curve_type":"INPUT_OUTPUT","function_data":{"function_type":"LINEAR","proportional_term":0,"constant_term":0}},"vom_cost":{"curve_type":"INPUT_OUTPUT","function_data":{"function_type":"LINEAR","proportional_term":0,"constant_term":0}}},"curtailment_cost":{"variable_cost_type":"COST","power_units":"NATURAL_UNITS","value_curve":{"curve_type":"INPUT_OUTPUT","function_data":{"function_type":"LINEAR","proportional_term":0,"constant_term":0}},"vom_cost":{"curve_type":"INPUT_OUTPUT","function_data":{"function_type":"LINEAR","proportional_term":0,"constant_term":0}}}}'
);

-- Table of hydro generation units (HydroDispatch, HydroTurbine, HydroPumpTurbine)
CREATE TABLE hydro_generators (
    id INTEGER PRIMARY KEY REFERENCES entities (id) ON DELETE CASCADE,
    name TEXT NOT NULL UNIQUE,
    prime_mover_type TEXT NOT NULL DEFAULT 'HY' REFERENCES prime_mover_types(name),
    balancing_topology INTEGER NOT NULL REFERENCES balancing_topologies (id) ON DELETE CASCADE,
    rating REAL NOT NULL CHECK (rating >= 0),
    base_power REAL NOT NULL CHECK (base_power > 0),
    -- Power limits (JSON: {"min": ..., "max": ...}):
    active_power_limits JSON NOT NULL,
    reactive_power_limits JSON NULL,
    -- Ramp limits (JSON: {"up": ..., "down": ...}, MW/min):
    ramp_limits JSON NULL,
    -- Time limits (JSON: {"up": ..., "down": ...}, hours):
    time_limits JSON NULL,
    -- Operational flags:
    available BOOLEAN NOT NULL DEFAULT TRUE,
    -- Initial setpoints:
    active_power REAL NOT NULL DEFAULT 0.0,
    reactive_power REAL NOT NULL DEFAULT 0.0,
    -- HydroTurbine/HydroPumpTurbine fields (nullable for HydroDispatch):
    powerhouse_elevation REAL NULL DEFAULT 0.0 CHECK (powerhouse_elevation >= 0),
    -- Outflow limits (JSON: {"min": ..., "max": ...}):
    outflow_limits JSON NULL,
    conversion_factor REAL NULL DEFAULT 1.0 CHECK (conversion_factor > 0),
    travel_time REAL NULL CHECK (travel_time >= 0),
    -- Cost:
    operation_cost JSON NOT NULL DEFAULT '{"cost_type": "HYDRO_GEN", "fixed": 0.0, "variable": {"variable_cost_type": "COST", "power_units": "NATURAL_UNITS", "value_curve": {"curve_type": "INPUT_OUTPUT", "function_data": {"function_type": "LINEAR", "proportional_term": 0, "constant_term": 0}}, "vom_cost": {"curve_type": "INPUT_OUTPUT", "function_data": {"function_type": "LINEAR", "proportional_term": 0, "constant_term": 0}}}}' -- Note: efficiency (varies by type), turbine_type, and HydroPumpTurbine-specific
    -- fields (active_power_limits_pump, etc.) are stored in the attributes table
);

-- NOTE: The purpose of this table is to capture data of **existing storage units only**.
-- Table of energy storage units (including PHES or other kinds),
CREATE TABLE storage_units (
    id INTEGER PRIMARY KEY REFERENCES entities (id) ON DELETE CASCADE,
    name TEXT NOT NULL UNIQUE,
    prime_mover_type TEXT NOT NULL REFERENCES prime_mover_types(name),
    storage_technology_type TEXT NOT NULL REFERENCES storage_technology_types(name),
    balancing_topology INTEGER NOT NULL REFERENCES balancing_topologies (id) ON DELETE CASCADE,
    rating REAL NOT NULL CHECK (rating >= 0),
    base_power REAL NOT NULL CHECK (base_power > 0),
    -- Storage capacity and limits (JSON: {"min": ..., "max": ...}):
    storage_capacity REAL NOT NULL CHECK (storage_capacity >= 0),
    storage_level_limits JSON NOT NULL,
    initial_storage_capacity_level REAL NOT NULL CHECK (initial_storage_capacity_level >= 0),
    -- Power limits (JSON: {"min": ..., "max": ...}, input = charging, output = discharging):
    input_active_power_limits JSON NOT NULL,
    output_active_power_limits JSON NOT NULL,
    -- Efficiency (JSON: {"in": ..., "out": ...}):
    efficiency JSON NOT NULL,
    -- Reactive power (JSON: {"min": ..., "max": ...}):
    reactive_power_limits JSON NULL,
    -- Initial setpoints:
    active_power REAL NOT NULL DEFAULT 0.0,
    reactive_power REAL NOT NULL DEFAULT 0.0,
    -- Status:
    available BOOLEAN NOT NULL DEFAULT TRUE,
    -- Storage-specific with defaults:
    conversion_factor REAL NOT NULL DEFAULT 1.0 CHECK (conversion_factor > 0),
    storage_target REAL NOT NULL DEFAULT 0.0,
    cycle_limits INTEGER NOT NULL DEFAULT 10000 CHECK (cycle_limits > 0),
    -- Cost:
    operation_cost JSON NULL
);

-- Topological hydro reservoirs
CREATE TABLE hydro_reservoirs (
    id INTEGER PRIMARY KEY REFERENCES entities (id) ON DELETE CASCADE,
    name TEXT NOT NULL UNIQUE,
    available BOOLEAN NOT NULL DEFAULT TRUE,
    -- Storage level limits (JSON: {"min": ..., "max": ...}):
    storage_level_limits JSON NOT NULL,
    initial_level REAL NOT NULL,
    -- Spillage limits (JSON: {"min": ..., "max": ...}, nullable):
    spillage_limits JSON NULL,
    inflow REAL NOT NULL DEFAULT 0.0,
    outflow REAL NOT NULL DEFAULT 0.0,
    level_targets REAL NULL,
    intake_elevation REAL NOT NULL DEFAULT 0.0,
    -- Head to volume relationship (JSON ValueCurve):
    head_to_volume_factor JSON NOT NULL,
    -- Cost (HydroReservoirCost):
    operation_cost JSON NOT NULL DEFAULT '{"cost_type": "HYDRO_RES", "level_shortage_cost": 0.0, "level_surplus_cost": 0.0, "spillage_cost": 0.0}',
    level_data_type TEXT NOT NULL DEFAULT 'USABLE_VOLUME'
);

CREATE TABLE hydro_reservoir_connections (
    source_id INTEGER NOT NULL REFERENCES entities(id) ON DELETE CASCADE,
    sink_id INTEGER NOT NULL REFERENCES entities(id) ON DELETE CASCADE,
    CHECK (source_id <> sink_id),
    PRIMARY KEY (source_id, sink_id)
) strict;
-- investment for expansion problems.
-- Investment technology options for expansion problems
CREATE TABLE supply_technologies (
    id INTEGER PRIMARY KEY REFERENCES entities (id) ON DELETE CASCADE,
    name TEXT NOT NULL UNIQUE,
    prime_mover_type TEXT NOT NULL REFERENCES prime_mover_types(name),
    region JSON NOT NULL,
    power_systems_type TEXT NOT NULL,
    lifetime INTEGER NULL,
    unit_size REAL NULL,
    -- Capacity limits (JSON: {"min": ..., "max": ...}, MW):
    capacity_limits JSON NULL,
    -- Fuel information:
    fuel TEXT NOT NULL DEFAULT '["OTHER"]',
    start_fuel_mmbtu_per_mwh REAL NULL,
    -- Fuel cofire limits (JSON: {"fuel1": {"min": ..., "max": ...}, "fuel2": {"min": ..., "max": ...}}):
    cofire_level_limits JSON NULL,
    -- Fuel cofire start limits (JSON: {"fuel1": ..., "fuel2": ...}):
    cofire_start_limits JSON NULL,
    -- CO2 emissions (JSON: {"fuel1": ..., "fuel2": ...}, tons per MMBTU):
    co2 JSON NULL,
    -- Operational information:
    available BOOLEAN NOT NULL DEFAULT TRUE,
    -- Ramp limits (JSON: {"up": ..., "down": ...}, MW/min):
    ramp_limits JSON NULL,
    -- Time limits (JSON: {"up": ..., "down": ...}, hours):
    time_limits JSON NULL,
    outage_factor REAL NULL,
    min_generation_fraction REAL NULL,
    -- Financial data:
    -- Capital cost (complex structure, stored as JSON):
    capital_costs JSON NOT NULL DEFAULT '{"curve_type": "INPUT_OUTPUT", "function_data": {"function_type": "LINEAR", "proportional_term": 0, "constant_term": 0}}',
    -- Cost (complex structure, stored as JSON):
    operation_costs JSON NOT NULL DEFAULT '{"cost_type": "THERMAL", "fixed": 0, "shut_down": 0, "start_up": 0, "variable": {"variable_cost_type": "COST", "power_units": "NATURAL_UNITS", "value_curve": {"curve_type": "INPUT_OUTPUT", "function_data": {"function_type": "LINEAR", "proportional_term": 0, "constant_term": 0}}, "vom_cost": {"curve_type": "INPUT_OUTPUT", "function_data": {"function_type": "LINEAR", "proportional_term": 0, "constant_term": 0}}}}',
    -- Other financial parameters (complex structure, stored as JSON):
    financial_data JSON NOT NULL
);

CREATE TABLE storage_technologies (
    id INTEGER PRIMARY KEY REFERENCES entities (id) ON DELETE CASCADE,
    name TEXT NOT NULL UNIQUE,
    prime_mover_type TEXT NOT NULL REFERENCES prime_mover_types(name),
    storage_tech TEXT NOT NULL DEFAULT '["OTHER"]',
    region JSON NOT NULL,
    power_systems_type TEXT NOT NULL,
    lifetime INTEGER NULL,
    unit_size_charge REAL NULL,
    unit_size_discharge REAL NULL,
    unit_size_energy REAL NULL,
    -- Capacity limits (JSON: {"min": ..., "max": ...}, MW):
    capacity_limits_charge JSON NULL,
    capacity_limits_discharge JSON NULL,
    capacity_limits_energy JSON NULL,
    -- Operational information:
    available BOOLEAN NOT NULL DEFAULT TRUE,
    -- Duration limits (JSON: {"min": ..., "max": ...}, hours):
    duration_limits JSON NULL,
    -- Efficiency (JSON: {"in": ..., "out": ...}, fraction):
    efficiency JSON NULL,
    min_discharge_fraction REAL NULL,
    losses REAL NULL,
    -- Financial data:
    -- Capital cost (complex structure, stored as JSON):
    capital_costs_charge JSON NULL,
    capital_costs_discharge JSON NOT NULL DEFAULT '{"curve_type": "INPUT_OUTPUT", "function_data": {"function_type": "LINEAR", "proportional_term": 0, "constant_term": 0}}',
    capital_costs_energy JSON NOT NULL DEFAULT '{"curve_type": "INPUT_OUTPUT", "function_data": {"function_type": "LINEAR", "proportional_term": 0, "constant_term": 0}}',
    -- Cost (complex structure, stored as JSON):
    operation_costs JSON NOT NULL DEFAULT '{"cost_type": "THERMAL", "fixed": 0, "shut_down": 0, "start_up": 0, "variable": {"variable_cost_type": "COST", "power_units": "NATURAL_UNITS", "value_curve": {"curve_type": "INPUT_OUTPUT", "function_data": {"function_type": "LINEAR", "proportional_term": 0, "constant_term": 0}}, "vom_cost": {"curve_type": "INPUT_OUTPUT", "function_data": {"function_type": "LINEAR", "proportional_term": 0, "constant_term": 0}}}}',
    -- Other financial parameters (complex structure, stored as JSON):
    financial_data JSON NOT NULL
);

CREATE TABLE transport_technologies (
    id INTEGER PRIMARY KEY REFERENCES entities (id) ON DELETE CASCADE,
    name TEXT NOT NULL UNIQUE,
    power_systems_type TEXT NOT NULL,
    available BOOLEAN NOT NULL DEFAULT TRUE,
    capital_costs JSON NOT NULL DEFAULT '{"curve_type": "INPUT_OUTPUT", "function_data": {"function_type": "LINEAR", "proportional_term": 0, "constant_term": 0}}',
    financial_data JSON NOT NULL,
    unit_size REAL NULL
);

CREATE TABLE demand_technologies (
    id INTEGER PRIMARY KEY REFERENCES entities (id) ON DELETE CASCADE,
    name TEXT NOT NULL UNIQUE,
    available BOOLEAN NOT NULL DEFAULT TRUE,
    region TEXT NOT NULL,
    power_systems_type TEXT NOT NULL
);

-- NOTE: Attributes are additional parameters that can be linked to entities.
-- The main purpose of this is when there is an important field that is not
-- capture on the entity table that should exist on the model. Example of this
-- fields are variable or fixed operation and maintenance cost or any other
-- field that its representation is hard to fit into a `integer`, `real` or
-- `text`. It must not be used for operational details since most of the should
-- be included in the `operational_data` table.
CREATE TABLE attributes (
    id INTEGER PRIMARY KEY,
    entity_id INTEGER NOT NULL,
    TYPE TEXT NOT NULL,
    name TEXT NOT NULL,
    value JSON NOT NULL,
    json_type TEXT generated always AS (json_type(value)) virtual,
    FOREIGN KEY (entity_id) REFERENCES entities (id) ON DELETE CASCADE,
    UNIQUE(entity_id, name)
);

-- NOTE: Supplemental are optional parameters that can be linked to entities.
-- The main purpose of this is to provide a way to save relevant information
-- but that could or could not be used for modeling. not `text`. Examples of
-- this field are geolocation (e.g., lat, long), outages, etc.)
CREATE TABLE supplemental_attributes (
    id INTEGER PRIMARY KEY REFERENCES entities (id) ON DELETE CASCADE,
    TYPE TEXT NOT NULL,
    value JSON NOT NULL,
    json_type TEXT generated always AS (json_type (value)) virtual
);

CREATE TABLE supplemental_attributes_association (
    attribute_id INTEGER NOT NULL,
    entity_id INTEGER NOT NULL,
    FOREIGN KEY (entity_id) REFERENCES entities (id) ON DELETE CASCADE,
    FOREIGN KEY (attribute_id) REFERENCES supplemental_attributes (id) ON DELETE CASCADE,
    PRIMARY KEY (attribute_id, entity_id)
) strict;

CREATE TABLE time_series_associations(
    id INTEGER PRIMARY KEY,
    time_series_uuid TEXT NOT NULL,
    time_series_type TEXT NOT NULL,
    initial_timestamp TEXT NOT NULL,
    resolution TEXT NOT NULL,
    horizon TEXT,
    "interval" TEXT,
    window_count INTEGER,
    length INTEGER,
    name TEXT NOT NULL,
    owner_id INTEGER NOT NULL REFERENCES entities(id) ON DELETE CASCADE,
    owner_type TEXT NOT NULL,
    owner_category TEXT NOT NULL,
    features TEXT NOT NULL,
    scaling_factor_multiplier TEXT NULL,
    metadata_uuid TEXT NOT NULL,
    units TEXT NULL
);
CREATE UNIQUE INDEX uq_time_series_assoc_owner_type_name_res_feat ON time_series_associations (
    owner_id,
    time_series_type,
    name,
    resolution,
    features
);
CREATE INDEX idx_time_series_assoc_uuid ON time_series_associations (time_series_uuid);


CREATE TABLE loads (
    id INTEGER PRIMARY KEY REFERENCES entities (id) ON DELETE CASCADE,
    name TEXT NOT NULL UNIQUE,
    balancing_topology INTEGER NOT NULL,
    base_power REAL,
    FOREIGN KEY(balancing_topology) REFERENCES balancing_topologies (id) ON DELETE CASCADE
);

CREATE TABLE static_time_series (
    id INTEGER PRIMARY KEY,
    uuid TEXT NOT NULL,
    idx INTEGER NOT NULL,
    value REAL NOT NULL
) strict;

CREATE INDEX idx_static_time_series_uuid_idx ON static_time_series (uuid, idx);
CREATE INDEX idx_arcs_from ON arcs (from_id);
CREATE INDEX idx_arcs_to ON arcs (to_id);
