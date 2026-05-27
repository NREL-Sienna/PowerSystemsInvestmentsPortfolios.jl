CREATE TRIGGER IF NOT EXISTS check_arcs_entity_exists BEFORE
INSERT ON arcs
    WHEN NOT EXISTS (
        SELECT 1
        FROM entities
        WHERE id = NEW.id
            AND entity_table = 'arcs'
    ) BEGIN
SELECT RAISE(
        ABORT,
        'Entity ID must exist in entities table with entity_table arcs before insertion'
    );
END;

CREATE TRIGGER IF NOT EXISTS check_transmission_lines_entity_exists BEFORE
INSERT ON transmission_lines
    WHEN NOT EXISTS (
        SELECT 1
        FROM entities
        WHERE id = NEW.id
            AND entity_table = 'transmission_lines'
    ) BEGIN
SELECT RAISE(
        ABORT,
        'Entity ID must exist in entities table with entity_table transmission_lines before insertion'
    );
END;

CREATE TRIGGER IF NOT EXISTS check_transmission_interchanges_entity_exists BEFORE
INSERT ON transmission_interchanges
    WHEN NOT EXISTS (
        SELECT 1
        FROM entities
        WHERE id = NEW.id
            AND entity_table = 'transmission_interchanges'
    ) BEGIN
SELECT RAISE(
        ABORT,
        'Entity ID must exist in entities table with entity_table transmission_interchanges before insertion'
    );
END;

CREATE TRIGGER IF NOT EXISTS check_thermal_generators_entity_exists BEFORE
INSERT ON thermal_generators
    WHEN NOT EXISTS (
        SELECT 1
        FROM entities
        WHERE id = NEW.id
            AND entity_table = 'thermal_generators'
    ) BEGIN
SELECT RAISE(
        ABORT,
        'Entity ID must exist in entities table with type thermal_generators before insertion'
    );
END;

CREATE TRIGGER IF NOT EXISTS check_renewable_generators_entity_exists BEFORE
INSERT ON renewable_generators
    WHEN NOT EXISTS (
        SELECT 1
        FROM entities
        WHERE id = NEW.id
            AND entity_table = 'renewable_generators'
    ) BEGIN
SELECT RAISE(
        ABORT,
        'Entity ID must exist in entities table with type renewable_generators before insertion'
    );
END;

CREATE TRIGGER IF NOT EXISTS check_hydro_generators_entity_exists BEFORE
INSERT ON hydro_generators
    WHEN NOT EXISTS (
        SELECT 1
        FROM entities
        WHERE id = NEW.id
            AND entity_table = 'hydro_generators'
    ) BEGIN
SELECT RAISE(
        ABORT,
        'Entity ID must exist in entities table with type hydro_generators before insertion'
    );
END;

CREATE TRIGGER IF NOT EXISTS check_storage_units_entity_exists BEFORE
INSERT ON storage_units
    WHEN NOT EXISTS (
        SELECT 1
        FROM entities
        WHERE id = NEW.id
            AND entity_table = 'storage_units'
    ) BEGIN
SELECT RAISE(
        ABORT,
        'Entity ID must exist in entities table with entity_table storage_units before insertion'
    );
END;

CREATE TRIGGER IF NOT EXISTS check_hydro_reservoir_entity_exists BEFORE
INSERT ON hydro_reservoir
    WHEN NOT EXISTS (
        SELECT 1
        FROM entities
        WHERE id = NEW.id
            AND entity_table = 'hydro_reservoir'
    ) BEGIN
SELECT RAISE(
        ABORT,
        'Entity ID must exist in entities table with entity_table hydro_reservoir before insertion'
    );
END;

CREATE TRIGGER IF NOT EXISTS check_supply_technologies_entity_exists BEFORE
INSERT ON supply_technologies
    WHEN NOT EXISTS (
        SELECT 1
        FROM entities
        WHERE id = NEW.id
            AND entity_table = 'supply_technologies'
    ) BEGIN
SELECT RAISE(
        ABORT,
        'Entity ID must exist in entities table with entity_table supply_technologies before insertion'
    );
END;

CREATE TRIGGER IF NOT EXISTS check_transport_technologies_entity_exists BEFORE
INSERT ON transport_technologies
    WHEN NOT EXISTS (
        SELECT 1
        FROM entities
        WHERE id = NEW.id
            AND entity_table = 'transport_technologies'
    ) BEGIN
SELECT RAISE(
        ABORT,
        'Entity ID must exist in entities table with entity_table transport_technologies before insertion'
    );
END;

CREATE TRIGGER IF NOT EXISTS check_supplemental_attributes_entity_exists BEFORE
INSERT ON supplemental_attributes
    WHEN NOT EXISTS (
        SELECT 1
        FROM entities
        WHERE id = NEW.id
            AND entity_table = 'supplemental_attributes'
    ) BEGIN
SELECT RAISE(
        ABORT,
        'Entity ID must exist in entities table with entity_table supplemental_attributes before insertion'
    );
END;

CREATE TRIGGER IF NOT EXISTS check_loads_entity_exists BEFORE
INSERT ON loads
    WHEN NOT EXISTS (
        SELECT 1
        FROM entities
        WHERE id = NEW.id
            AND entity_table = 'loads'
    ) BEGIN
SELECT RAISE(
        ABORT,
        'Entity ID must exist in entities table with entity_table loads before insertion'
    );
END;


-- Business Logic Validation Triggers
CREATE TRIGGER enforce_arc_entity_types_insert
AFTER
INSERT ON arcs BEGIN
SELECT CASE
        WHEN NOT EXISTS (
            SELECT 1
            FROM entities
            WHERE id = NEW.from_id
        ) THEN RAISE(ABORT, 'from_id entity does not exist')
        WHEN NOT EXISTS (
            SELECT 1
            FROM entities
            WHERE id = NEW.to_id
        ) THEN RAISE(ABORT, 'to_id entity does not exist')
        WHEN (
            SELECT entity_type
            FROM entities
            WHERE id = NEW.from_id
        ) NOT IN (
            'balancing_topologies',
            'planning_regions',
            'LoadZone',
            'ACBus',
            'Area'
        ) THEN RAISE(
            ABORT,
            'Invalid from_id entity type: must be balancing topology or planning region'
        )
        WHEN (
            SELECT entity_type
            FROM entities
            WHERE id = NEW.to_id
        ) NOT IN (
            'balancing_topologies',
            'planning_regions',
            'LoadZone',
            'ACBus',
            'Area'
        ) THEN RAISE(
            ABORT,
            'Invalid to_id entity type: must be balancing topology or planning region'
        )
    END;
END;

-- Validate entity categories for consistency
CREATE TRIGGER validate_entity_category_consistency BEFORE
INSERT ON entities BEGIN
SELECT CASE
        WHEN NOT EXISTS (
            SELECT 1
            FROM entity_types
            WHERE name = NEW.entity_type
        ) THEN RAISE(
            ABORT,
            'Invalid entity_type not found in entity_types'
        )
    END;
END;

-- Enforce that a turbine can have at most 1 upstream reservoir
-- (i.e., at most 1 row where sink is a turbine and source is a reservoir)
CREATE TRIGGER IF NOT EXISTS enforce_turbine_single_upstream_reservoir BEFORE
INSERT ON hydro_reservoir_connections
    WHEN (
        -- Check if sink is a turbine (hydro_generators or storage_units)
        SELECT entity_table
        FROM entities
        WHERE id = NEW.sink_id
    ) IN ('hydro_generators', 'storage_units')
    AND (
        -- Check if source is a reservoir
        SELECT entity_table
        FROM entities
        WHERE id = NEW.source_id
    ) = 'hydro_reservoir' BEGIN
SELECT CASE
        WHEN EXISTS (
            SELECT 1
            FROM hydro_reservoir_connections hrc
                JOIN entities e_source ON hrc.source_id = e_source.id
            WHERE hrc.sink_id = NEW.sink_id
                AND e_source.entity_table = 'hydro_reservoir'
        ) THEN RAISE(
            ABORT,
            'Turbine already has an upstream reservoir. Each turbine can have at most 1 upstream reservoir.'
        )
    END;
END;

-- Enforce that a turbine can have at most 1 downstream reservoir
-- (i.e., at most 1 row where source is a turbine and sink is a reservoir)
CREATE TRIGGER IF NOT EXISTS enforce_turbine_single_downstream_reservoir BEFORE
INSERT ON hydro_reservoir_connections
    WHEN (
        -- Check if source is a turbine (hydro_generators or storage_units)
        SELECT entity_table
        FROM entities
        WHERE id = NEW.source_id
    ) IN ('hydro_generators', 'storage_units')
    AND (
        -- Check if sink is a reservoir
        SELECT entity_table
        FROM entities
        WHERE id = NEW.sink_id
    ) = 'hydro_reservoir' BEGIN
SELECT CASE
        WHEN EXISTS (
            SELECT 1
            FROM hydro_reservoir_connections hrc
                JOIN entities e_sink ON hrc.sink_id = e_sink.id
            WHERE hrc.source_id = NEW.source_id
                AND e_sink.entity_table = 'hydro_reservoir'
        ) THEN RAISE(
            ABORT,
            'Turbine already has a downstream reservoir. Each turbine can have at most 1 downstream reservoir.'
        )
    END;
END;

-- Reverse cascade triggers: delete from entities when child table row is deleted
CREATE TRIGGER IF NOT EXISTS delete_planning_regions_entity
AFTER DELETE ON planning_regions
FOR EACH ROW
BEGIN
    DELETE FROM entities WHERE id = OLD.id;
END;

CREATE TRIGGER IF NOT EXISTS delete_balancing_topologies_entity
AFTER DELETE ON balancing_topologies
FOR EACH ROW
BEGIN
    DELETE FROM entities WHERE id = OLD.id;
END;

CREATE TRIGGER IF NOT EXISTS delete_arcs_entity
AFTER DELETE ON arcs
FOR EACH ROW
BEGIN
    DELETE FROM entities WHERE id = OLD.id;
END;

CREATE TRIGGER IF NOT EXISTS delete_transmission_lines_entity
AFTER DELETE ON transmission_lines
FOR EACH ROW
BEGIN
    DELETE FROM entities WHERE id = OLD.id;
END;

CREATE TRIGGER IF NOT EXISTS delete_transmission_interchanges_entity
AFTER DELETE ON transmission_interchanges
FOR EACH ROW
BEGIN
    DELETE FROM entities WHERE id = OLD.id;
END;

CREATE TRIGGER IF NOT EXISTS delete_thermal_generators_entity
AFTER DELETE ON thermal_generators
FOR EACH ROW
BEGIN
    DELETE FROM entities WHERE id = OLD.id;
END;

CREATE TRIGGER IF NOT EXISTS delete_renewable_generators_entity
AFTER DELETE ON renewable_generators
FOR EACH ROW
BEGIN
    DELETE FROM entities WHERE id = OLD.id;
END;

CREATE TRIGGER IF NOT EXISTS delete_hydro_generators_entity
AFTER DELETE ON hydro_generators
FOR EACH ROW
BEGIN
    DELETE FROM entities WHERE id = OLD.id;
END;

CREATE TRIGGER IF NOT EXISTS delete_storage_units_entity
AFTER DELETE ON storage_units
FOR EACH ROW
BEGIN
    DELETE FROM entities WHERE id = OLD.id;
END;

CREATE TRIGGER IF NOT EXISTS delete_hydro_reservoir_entity
AFTER DELETE ON hydro_reservoir
FOR EACH ROW
BEGIN
    DELETE FROM entities WHERE id = OLD.id;
END;

CREATE TRIGGER IF NOT EXISTS delete_supply_technologies_entity
AFTER DELETE ON supply_technologies
FOR EACH ROW
BEGIN
    DELETE FROM entities WHERE id = OLD.id;
END;

CREATE TRIGGER IF NOT EXISTS delete_transport_technologies_entity
AFTER DELETE ON transport_technologies
FOR EACH ROW
BEGIN
    DELETE FROM entities WHERE id = OLD.id;
END;

CREATE TRIGGER IF NOT EXISTS delete_storage_technologies_entity
AFTER DELETE ON storage_technologies
FOR EACH ROW
BEGIN
    DELETE FROM entities WHERE id = OLD.id;
END;

CREATE TRIGGER IF NOT EXISTS delete_demand_technologies_entity
AFTER DELETE ON demand_technologies
FOR EACH ROW
BEGIN
    DELETE FROM entities WHERE id = OLD.id;
END;

CREATE TRIGGER IF NOT EXISTS delete_supplemental_attributes_entity
AFTER DELETE ON supplemental_attributes
FOR EACH ROW
BEGIN
    DELETE FROM entities WHERE id = OLD.id;
END;

CREATE TRIGGER IF NOT EXISTS delete_loads_entity
AFTER DELETE ON loads
FOR EACH ROW
BEGIN
    DELETE FROM entities WHERE id = OLD.id;
END;
