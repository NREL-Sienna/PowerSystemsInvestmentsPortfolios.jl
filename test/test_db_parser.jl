custom_isequivalent(x, y) = isequal(x, y) || (x == y)
custom_isequivalent(x::AbstractFloat, y::AbstractFloat) = isequal(x, y) || (x == y) || x ≈ y

const DEFAULT_FINANCIAL_DATA = PSIP.TechnologyFinancialData(;
    capital_recovery_period=30,
    technology_base_year=2025,
    debt_fraction=0.5,
    debt_rate=0.07,
    return_on_equity=0.1,
    tax_rate=0.257,
)

function _db_count(db, table)
    return first(first(DBInterface.execute(db, "SELECT COUNT(*) FROM $table")))
end

function build_base_system()
    sys = PSY.System(100.0)

    area1 = PSY.Area(; name="area1", peak_active_power=0.0, peak_reactive_power=0.0)
    area2 = PSY.Area(; name="area2", peak_active_power=0.0, peak_reactive_power=0.0)
    PSY.add_component!(sys, area1)
    PSY.add_component!(sys, area2)

    lz1 = PSY.LoadZone(; name="lz1", peak_active_power=0.0, peak_reactive_power=0.0)
    lz2 = PSY.LoadZone(; name="lz2", peak_active_power=0.0, peak_reactive_power=0.0)
    PSY.add_component!(sys, lz1)
    PSY.add_component!(sys, lz2)

    bus1 = PSY.ACBus(;
        number=1,
        name="bus1",
        available=true,
        bustype=PSY.ACBusTypes.REF,
        angle=0.0,
        magnitude=1.0,
        voltage_limits=(min=0.9, max=1.1),
        base_voltage=230.0,
        area=area1,
        load_zone=lz1,
    )
    bus2 = PSY.ACBus(;
        number=2,
        name="bus2",
        available=true,
        bustype=PSY.ACBusTypes.PQ,
        angle=0.0,
        magnitude=1.0,
        voltage_limits=(min=0.9, max=1.1),
        base_voltage=230.0,
        area=area2,
        load_zone=lz2,
    )
    PSY.add_component!(sys, bus1)
    PSY.add_component!(sys, bus2)

    arc = PSY.Arc(; from=bus1, to=bus2)
    PSY.add_component!(sys, arc)

    line = PSY.Line(;
        name="line1",
        available=true,
        active_power_flow=0.0,
        reactive_power_flow=0.0,
        arc=arc,
        r=0.01,
        x=0.1,
        b=(from=0.0, to=0.0),
        rating=100.0,
        angle_limits=(min=-0.5, max=0.5),
    )
    PSY.add_component!(sys, line)

    thermal = PSY.ThermalStandard(;
        name="th1",
        available=true,
        status=true,
        bus=bus1,
        active_power=10.0,
        reactive_power=0.0,
        rating=100.0,
        active_power_limits=(min=0.0, max=100.0),
        reactive_power_limits=nothing,
        ramp_limits=nothing,
        operation_cost=PSY.ThermalGenerationCost(nothing),
        base_power=100.0,
    )
    PSY.add_component!(sys, thermal)

    renewable = PSY.RenewableDispatch(;
        name="ren1",
        available=true,
        bus=bus2,
        active_power=20.0,
        reactive_power=0.0,
        rating=80.0,
        prime_mover_type=PSY.PrimeMovers.WT,
        reactive_power_limits=nothing,
        power_factor=1.0,
        operation_cost=PSY.RenewableGenerationCost(nothing),
        base_power=100.0,
    )
    PSY.add_component!(sys, renewable)

    load = PSY.PowerLoad(;
        name="load1",
        available=true,
        bus=bus2,
        active_power=15.0,
        reactive_power=5.0,
        base_power=100.0,
        max_active_power=30.0,
        max_reactive_power=10.0,
    )
    PSY.add_component!(sys, load)

    interchange = PSY.AreaInterchange(;
        name="interchange1",
        available=true,
        active_power_flow=0.0,
        from_area=area1,
        to_area=area2,
        flow_limits=(from_to=70.0, to_from=60.0),
    )
    PSY.add_component!(sys, interchange)

    hydro = PSY.HydroReservoir(;
        name="res1",
        available=true,
        storage_level_limits=(min=0.0, max=100.0),
        initial_level=50.0,
        spillage_limits=nothing,
        inflow=1.0,
        outflow=1.0,
        level_targets=nothing,
        intake_elevation=100.0,
        head_to_volume_factor=IS.LinearFunctionData(0.0, 1.0),
    )
    PSY.add_component!(sys, hydro)

    return sys
end

function build_portfolio(; include_base_system=false)
    port = if include_base_system
        PSIP.Portfolio(
            build_base_system();
            financial_data=PSIP.PortfolioFinancialData(2025, 0.07, 0.04, 0.03),
        )
    else
        PSIP.Portfolio(2025, 0.07, 0.04, 0.03)
    end

    zone1 = PSIP.Zone(; name="zone1", id=1)
    zone2 = PSIP.Zone(; name="zone2", id=2)
    node1 = PSIP.Node(; name="node1", id=3)
    node2 = PSIP.Node(; name="node2", id=4)
    PSIP.add_region!(port, zone1)
    PSIP.add_region!(port, zone2)
    PSIP.add_region!(port, node1)
    PSIP.add_region!(port, node2)

    supply = PSIP.SupplyTechnology{PSY.ThermalStandard}(;
        name="sup1",
        power_systems_type="ThermalStandard",
        region=[zone1],
        id=10,
        available=true,
        prime_mover_type=PSY.PrimeMovers.CT,
        fuel=[PSY.ThermalFuels.NATURAL_GAS],
        co2=Dict(PSY.ThermalFuels.NATURAL_GAS => 0.05),
        cofire_start_limits=Dict(PSY.ThermalFuels.NATURAL_GAS => (min=0.0, max=1.0)),
        cofire_level_limits=Dict(PSY.ThermalFuels.NATURAL_GAS => (min=0.0, max=1.0)),
        capital_costs=IS.LinearCurve(1_000.0),
        operation_costs=PSY.ThermalGenerationCost(nothing),
        unit_size=50.0,
        capacity_limits=(min=0.0, max=1000.0),
        outage_factor=0.95,
        min_generation_fraction=0.1,
        ramp_limits=(up=1.0, down=1.0),
        time_limits=(up=60.0, down=60.0),
        start_fuel_mmbtu_per_mw=0.1,
        lifetime=30,
        financial_data=DEFAULT_FINANCIAL_DATA,
    )
    PSIP.add_technology!(port, supply)

    storage = PSIP.StorageTechnology{PSY.EnergyReservoirStorage}(;
        name="sto1",
        region=[node1],
        id=11,
        available=true,
        power_systems_type="EnergyReservoirStorage",
        prime_mover_type=PSY.PrimeMovers.BA,
        storage_tech=PSY.StorageTech.LIB,
        capital_costs_energy=IS.LinearCurve(200.0),
        capital_costs_charge=IS.LinearCurve(50.0),
        capital_costs_discharge=IS.LinearCurve(75.0),
        operation_costs=PSY.StorageCost(nothing),
        min_discharge_fraction=0.0,
        unit_size_charge=10.0,
        unit_size_discharge=10.0,
        unit_size_energy=40.0,
        capacity_limits_charge=(min=0.0, max=500.0),
        capacity_limits_discharge=(min=0.0, max=500.0),
        capacity_limits_energy=(min=0.0, max=2000.0),
        duration_limits=(min=0.0, max=6000.0),
        efficiency=(in=0.9, out=0.9),
        losses=0.01,
        lifetime=25,
        financial_data=DEFAULT_FINANCIAL_DATA,
    )
    PSIP.add_technology!(port, storage)

    dside = PSIP.DemandSideTechnology{PSY.PowerLoad}(;
        name="dst1",
        id=12,
        available=true,
        power_systems_type="PowerLoad",
        region=[node1],
        technology_efficiency=0.9,
        price_per_unit=IS.LinearCurve(50.0),
        min_power=0.1,
        peak_demand_mw=100.0,
        curtailment_cost=IS.LinearCurve(100.0),
        max_demand_curtailment=0.5,
        max_demand_delay=60.0,
        max_demand_advance=60.0,
        demand_energy_efficiency=0.95,
        shift_variable_cost=IS.LinearCurve(5.0),
    )
    PSIP.add_technology!(port, dside)

    dreq = PSIP.DemandRequirement{PSY.PowerLoad}(;
        name="dr1",
        available=true,
        id=13,
        power_systems_type="PowerLoad",
        new_demand_mw=10.0,
        new_construction_year=2030,
        growth_rate=0.01,
        conformity=PSY.LoadConformity.UNDEFINED,
        value_of_lost_load=1000.0,
        unserved_demand_curve=IS.LinearCurve(1000.0),
        region=[zone2],
    )
    PSIP.add_technology!(port, dreq)

    agg_tx = PSIP.AggregateTransportTechnology{PSY.Line}(;
        name="agg_tx1",
        id=14,
        available=true,
        power_systems_type="Line",
        start_region=zone1,
        end_region=zone2,
        capacity_limits=(min=0.0, max=400.0),
        unit_size=100.0,
        capital_costs=IS.LinearCurve(300.0),
        line_loss=0.02,
        financial_data=DEFAULT_FINANCIAL_DATA,
    )
    PSIP.add_technology!(port, agg_tx)

    ac_tx = PSIP.NodalACTransportTechnology{PSY.Line}(;
        name="ac_tx1",
        id=15,
        available=true,
        power_systems_type="Line",
        start_node=node1,
        end_node=node2,
        capacity_limits=(min=0.0, max=500.0),
        unit_size=120.0,
        capital_costs=IS.LinearCurve(400.0),
        resistance=0.01,
        voltage=230.0,
        reactance=0.1,
        financial_data=DEFAULT_FINANCIAL_DATA,
    )
    PSIP.add_technology!(port, ac_tx)

    hvdc_tx = PSIP.NodalHVDCTransportTechnology{PSY.TwoTerminalGenericHVDCLine}(;
        name="hvdc_tx1",
        id=16,
        available=true,
        power_systems_type="TwoTerminalGenericHVDCLine",
        start_node=node1,
        end_node=node2,
        capacity_limits=(min=0.0, max=500.0),
        unit_size=80.0,
        capital_costs=IS.LinearCurve(350.0),
        line_loss=IS.LinearCurve(0.01),
        financial_data=DEFAULT_FINANCIAL_DATA,
    )
    PSIP.add_technology!(port, hvdc_tx)

    sa_existing =
        PSIP.ExistingDevices(; id=101, existing_devices=["old_gen_1", "old_gen_2"])
    sa_agg_ret = PSIP.AggregateRetirementPotential(; id=102, retirement_potential=50.0)
    sa_ret = PSIP.RetirementPotential(;
        id=103,
        eligible_generators=["old_gen_1"],
        planned_retirement_year=Dict("old_gen_1" => 2035),
        build_year=Dict("old_gen_1" => 2015),
    )
    sa_agg_ref = PSIP.AggregateRetrofitPotential(;
        id=104,
        retrofit_id=1,
        retrofit_potential=20.0,
        retrofit_fraction=0.5,
    )
    sa_ref = PSIP.RetrofitPotential(; id=105, eligible_generators=["old_gen_2"])
    sa_top = PSIP.TopologyMapping(; id=106, buses=["bus1", "bus2"])

    PSIP.add_supplemental_attribute!(port, supply, sa_existing)
    PSIP.add_supplemental_attribute!(port, supply, sa_agg_ret)
    PSIP.add_supplemental_attribute!(port, supply, sa_ret)
    PSIP.add_supplemental_attribute!(port, supply, sa_agg_ref)
    PSIP.add_supplemental_attribute!(port, supply, sa_ref)
    PSIP.add_supplemental_attribute!(port, zone1, sa_top)

    return port
end

function assert_psip_roundtrip_equal(p1::PSIP.Portfolio, p2::PSIP.Portfolio)
    for T in DBP.ALL_PSIP_TYPES
        @test length(IS.get_components(T, p1.data)) == length(IS.get_components(T, p2.data))
        for c1 in IS.get_components(T, p1.data)
            c2 = IS.get_component(typeof(c1), p2.data, PSIP.get_name(c1))
            @test c2 !== nothing
            @test IS.compare_values(
                custom_isequivalent,
                c1,
                c2;
                exclude=Set([:internal, :ext]),
            )
        end
    end

    for SA_T in DBP.ALL_SA_PSIP_TYPES
        @test length(IS.get_supplemental_attributes(SA_T, p1.data)) ==
              length(IS.get_supplemental_attributes(SA_T, p2.data))
    end
end

function assert_base_system_roundtrip_equal(sys1::PSY.System, sys2::PSY.System)
    for T in DBP.ALL_PSY_TYPES
        @test length(PSY.get_components(T, sys1)) == length(PSY.get_components(T, sys2))
        if T == PSY.Arc
            arcs1 = sort([
                (c.from.number, c.to.number) for c in PSY.get_components(PSY.Arc, sys1)
            ])
            arcs2 = sort([
                (c.from.number, c.to.number) for c in PSY.get_components(PSY.Arc, sys2)
            ])
            @test arcs1 == arcs2
            continue
        end
        for c1 in PSY.get_components(T, sys1)
            c2 = PSY.get_component(T, sys2, PSY.get_name(c1))
            @test c2 !== nothing
            @test IS.compare_values(
                custom_isequivalent,
                c1,
                c2;
                exclude=Set([:internal, :ext, :services, :units_info]),
            )
        end
    end
end

@testset "DBParser make_sqlite!" begin
    db = SQLite.DB()
    DBP.make_sqlite!(db)

    existing_tables = Set(
        row.name for row in
        DBInterface.execute(db, "SELECT name FROM sqlite_master WHERE type='table'")
    )

    for table in (
        "entities",
        "attributes",
        "planning_regions",
        "balancing_topologies",
        "supplemental_attributes",
    )
        @test table in existing_tables
    end
    @test _db_count(db, "entities") == 0
    @test _db_count(db, "attributes") == 0
end

@testset "DBParser helper/unit tests" begin
    counter = DBP.DBIdCounter(5)
    @test DBP._next_id!(counter) == 5
    @test DBP._next_id!(counter) == 6

    refs = PSIP.OpenAPIRefs()
    z = PSIP.Zone(; name="z", id=1)
    n = PSIP.Node(; name="n", id=2)
    refs[1] = z
    refs[2] = n

    uuid_to_id = DBP._db_uuid_to_id(refs)
    @test uuid_to_id[IS.get_uuid(z)] == 1
    @test uuid_to_id[IS.get_uuid(n)] == 2
    @test DBP._db_resolve_owner(refs, 2) === n

    p = PSIP.Portfolio(2025, 0.07, 0.04, 0.03)
    PSIP.add_region!(p, PSIP.Zone(; name="z1", id=9))
    PSIP.add_region!(p, PSIP.Node(; name="n1", id=12))
    @test DBP._max_psip_entity_id(p) == 12

    @test DBP._convert_sqlite_value(1, Bool) == true
    @test DBP._convert_sqlite_value(0, Union{Bool, Nothing}) == false
    @test DBP._convert_sqlite_value(missing, Union{Int, Nothing}) === nothing
    @test DBP._convert_sqlite_value(nothing, Union{Int, Nothing}) === nothing

    @test DBP._get_column_type("planning_regions", :id) == Int64
    @test DBP._get_column_type("planning_regions", :does_not_exist) == Any
    @test DBP._get_column_type("not_a_table", :id) == Any

    @test DBP.get_query_for_table_name("arcs") == DBP.ARC_QUERY
    @test DBP.get_query_for_table_name("transmission_interchanges") ==
          DBP.TRANSMISSION_INTERCHANGE_QUERY
    @test occursin(
        "FROM planning_regions",
        DBP.get_query_for_table_name("planning_regions"),
    )
end

@testset "DBParser translation constants" begin
    @test length(DBP.TYPE_TO_TABLE) == length(DBP.ALL_TYPES)
    @test length(DBP.PSIP_TYPE_TO_TABLE) == length(DBP.PSIP_TYPES)

    @test DBP.TYPE_TO_TABLE[DBP.PO.Arc] == "arcs"
    @test DBP.TYPE_TO_TABLE[DBP.PO.ThermalStandard] == "thermal_generators"
    @test DBP.PSIP_TYPE_TO_TABLE[DBP.PI.StorageTechnology] == "storage_technologies"
    @test DBP.PSIP_TYPE_TO_TABLE[DBP.PI.Zone] == "planning_regions"

    @test DBP.OPENAPI_TYPE_TO_PSY[DBP.PO.RenewableDispatch] == PSY.RenewableDispatch
    @test DBP.OPENAPI_TYPE_TO_PSY[DBP.PO.PowerLoad] == PSY.PowerLoad

    @test !haskey(DBP.OPENAPI_FIELDS_TO_DB, ("arcs", "from"))
    @test !haskey(DBP.OPENAPI_FIELDS_TO_DB, ("arcs", "to"))
    @test !haskey(DBP.DB_TO_OPENAPI_FIELDS, ("arcs", "from_id"))
    @test DBP.DB_TO_PSIP_OPENAPI_FIELDS[("transport_technologies", "from_node_id")] ==
          "from_node"
    @test DBP.PSIP_OPENAPI_FIELDS_TO_DB[("transport_technologies", "from_node")] ==
          "from_node_id"
end

@testset "DBParser portfolio round-trip" begin
    p1 = build_portfolio()
    db = SQLite.DB()
    DBP.make_sqlite!(db)
    DBP.portfolio2db!(db, p1)

    p2 = DBP.db2portfolio(db)
    assert_psip_roundtrip_equal(p1, p2)

    sup2 = IS.get_component(PSIP.SupplyTechnology{PSY.ThermalStandard}, p2.data, "sup1")
    @test length(PSIP.get_supplemental_attributes(PSIP.ExistingDevices, sup2)) == 1
    @test length(PSIP.get_supplemental_attributes(PSIP.RetirementPotential, sup2)) == 1
end

@testset "DBParser base-system round-trip and id disjointness" begin
    sys1 = build_base_system()

    db_sys = SQLite.DB()
    DBP.make_sqlite!(db_sys)
    DBP.sys2db!(db_sys, sys1, 1)
    sys2 = DBP.db2sys(db_sys)
    assert_base_system_roundtrip_equal(sys1, sys2)

    p = build_portfolio(; include_base_system=true)
    db = SQLite.DB()
    DBP.make_sqlite!(db)
    DBP.portfolio2db!(db, p)

    rows = [
        NamedTuple(r) for
        r in DBInterface.execute(db, "SELECT id, entity_type FROM entities")
    ]
    base_type_names = Set(string.(keys(DBP.PSY_TYPE_NAMES)))
    psip_type_names = Set(string.(keys(DBP.PSIP_TYPE_NAMES)))
    base_ids = Set(Int(r.id) for r in rows if r.entity_type in base_type_names)
    psip_ids = Set(Int(r.id) for r in rows if r.entity_type in psip_type_names)

    @test !isempty(base_ids)
    @test !isempty(psip_ids)
    @test isempty(intersect(base_ids, psip_ids))
    @test minimum(base_ids) > DBP._max_psip_entity_id(p)
end

@testset "DBParser openapi JSON exports" begin
    p = build_portfolio(; include_base_system=true)
    db = SQLite.DB()
    DBP.make_sqlite!(db)
    DBP.portfolio2db!(db, p)

    mktempdir() do d
        db_json = joinpath(d, "db_export.json")
        DBP.db2openapi_json(
            db,
            db_json;
            system_name="fixture-system",
            base_power=100.0,
            description="fixture",
        )
        parsed = JSON3.read(read(db_json, String), Dict{String, Any})
        @test haskey(parsed, "system")
        @test haskey(parsed, "components")
        @test haskey(parsed, "supplemental_attributes")
        @test parsed["system"]["name"] == "fixture-system"

        sys_json = joinpath(d, "sys_export.json")
        DBP.system2openapi_json(PSIP.get_base_system(p), sys_json)
        sys_parsed = JSON3.read(read(sys_json, String), Dict{String, Any})
        @test haskey(sys_parsed, "data")
        @test haskey(sys_parsed["data"], "components")
        @test haskey(sys_parsed["data"], "supplemental_attributes")
    end
end

@testset "DBParser time-series utility coverage" begin
    db = SQLite.DB()
    DBP.make_sqlite!(db)

    ts_uuid = string(UUIDs.uuid4())
    meta_uuid = string(UUIDs.uuid4())
    DBInterface.execute(
        db,
        "INSERT INTO entities (id, entity_table, entity_type) VALUES (?, ?, ?)",
        (1, "loads", "PowerLoad"),
    )
    DBInterface.execute(
        db,
        """
        INSERT INTO time_series_associations
        (id, time_series_uuid, time_series_type, initial_timestamp, resolution, horizon,
         interval, window_count, length, name, owner_id, owner_type, owner_category,
         features, scaling_factor_multiplier, metadata_uuid, units)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, json(?), ?, ?, ?)
        """,
        (
            1,
            ts_uuid,
            "SingleTimeSeries",
            "2025-01-01T00:00:00",
            "P0DT1H",
            missing,
            missing,
            missing,
            3,
            "ts1",
            1,
            "PowerLoad",
            "PowerLoad",
            JSON3.write([Dict("scenario" => "base")]),
            nothing,
            meta_uuid,
            "MW",
        ),
    )
    DBInterface.execute(
        db,
        "INSERT INTO static_time_series (uuid, idx, value) VALUES (?, ?, ?)",
        (ts_uuid, 1, 1.0),
    )
    DBInterface.execute(
        db,
        "INSERT INTO static_time_series (uuid, idx, value) VALUES (?, ?, ?)",
        (ts_uuid, 2, 2.0),
    )

    exported = DBP.export_time_series_dict(db; include_data=true)
    @test haskey(exported, "associations")
    @test haskey(exported, "data")
    @test length(exported["associations"]) == 1
    @test exported["data"][ts_uuid] == [1.0, 2.0]

    row = (
        time_series_uuid=ts_uuid,
        time_series_type="SingleTimeSeries",
        initial_timestamp="2025-01-01T00:00:00",
        resolution="P0DT1H",
        horizon=missing,
        interval=missing,
        window_count=missing,
        length=3,
        name="ts1",
        features=JSON3.write([Dict("scenario" => "base")]),
        scaling_factor_multiplier=missing,
        metadata_uuid=meta_uuid,
        owner_uuid=string(UUIDs.uuid4()),
    )
    metadata = DBP.deserialize_metadata(row)
    @test metadata.name == "ts1"
    @test metadata.length == 3
end

@testset "DBParser edge cases" begin
    db = SQLite.DB()
    DBP.make_sqlite!(db)
    empty_port = PSIP.Portfolio(2025, 0.07, 0.04, 0.03)
    DBP.portfolio2db!(db, empty_port)

    @test _db_count(db, "planning_regions") == 0
    @test _db_count(db, "transport_technologies") == 0
    @test _db_count(db, "storage_technologies") == 0
    @test _db_count(db, "supply_technologies") == 0
    @test _db_count(db, "demand_technologies") == 0

    p = build_portfolio()
    db2 = SQLite.DB()
    DBP.make_sqlite!(db2)
    DBP.portfolio2db!(db2, p)

    rows = collect(
        DBInterface.execute(
            db2,
            "SELECT unit_size_charge, capacity_limits_charge FROM storage_technologies",
        ),
    )
    @test length(rows) == 1
    @test rows[1].unit_size_charge !== nothing
    @test rows[1].capacity_limits_charge !== nothing
end
