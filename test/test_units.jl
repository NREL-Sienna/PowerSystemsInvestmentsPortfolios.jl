# Tests for the unit-conversion system introduced on this branch.
#
# Two layers are covered:
#   1. The internal converter `PSIP._natural_unit_conversions` (and the
#      `convert_units` / `natural_unit` primitives it builds on).
#   2. The generated, units-aware public getters/setters (`get_*(x, units)`,
#      `get_*_unitful`, `set_*!(x, val, unit)`) for every unit-aware field on
#      every technology.
#
# Getters/setters are qualified with `PSIP.` because several names
# (e.g. `get_voltage`, `set_time_limits!`, `get_name`, `natural_unit`) are also
# exported by PowerSystems and are therefore ambiguous when unqualified inside
# the test module.

# ---------------------------------------------------------------------------
# Builders (fresh instances so setter mutations stay isolated per testset)
# ---------------------------------------------------------------------------
tech_financials() = TechnologyFinancialData(;
    capital_recovery_period=30,
    technology_base_year=2025,
    debt_fraction=0.5,
    debt_rate=0.07,
    return_on_equity=0.1,
    tax_rate=0.257,
)

supply() = SupplyTechnology{PSY.ThermalStandard}(;
    name="ut_supply",
    id=1,
    available=true,
    power_systems_type=string(PSY.ThermalStandard),
    financial_data=tech_financials(),
    capital_costs=LinearCurve(10000.0),
    operation_costs=ThermalGenerationCost(CostCurve(LinearCurve(10.0)), 100.0, 0.0, 0.0),
    unit_size=100.0,
    capacity_limits=(min=0.0, max=500.0),
    ramp_limits=(up=1.0, down=2.0),
    time_limits=(up=10.0, down=20.0),
    start_fuel_mmbtu_per_mw=5.0,
    lifetime=30,
)

storage() = StorageTechnology{PSY.EnergyReservoirStorage}(;
    name="ut_storage",
    id=2,
    available=true,
    power_systems_type=string(PSY.EnergyReservoirStorage),
    financial_data=tech_financials(),
    unit_size_charge=10.0,
    unit_size_discharge=20.0,
    unit_size_energy=200.0,
    capacity_limits_charge=(min=0.0, max=100.0),
    capacity_limits_discharge=(min=0.0, max=200.0),
    capacity_limits_energy=(min=0.0, max=1000.0),
    duration_limits=(min=1.0, max=10.0),
    capital_costs_energy=LinearCurve(3000.0),
    capital_costs_charge=LinearCurve(1000.0),
    capital_costs_discharge=LinearCurve(2000.0),
    operation_costs=StorageCost(),
    lifetime=15,
)

agg_transport() = AggregateTransportTechnology{PSY.ACBranch}(;
    name="ut_agg",
    id=3,
    available=true,
    power_systems_type=string(PSY.Line),
    start_region=Zone(; name="ut_z1", id=201),
    end_region=Zone(; name="ut_z2", id=202),
    financial_data=tech_financials(),
    capacity_limits=(min=0.0, max=800.0),
    unit_size=40.0,
    capital_costs=LinearCurve(500.0),
)

acline() = NodalACTransportTechnology{PSY.ACBranch}(;
    name="ut_ac",
    id=4,
    available=true,
    power_systems_type=string(PSY.Line),
    start_node=Node(; name="ut_n1", id=101),
    end_node=Node(; name="ut_n2", id=102),
    financial_data=tech_financials(),
    capacity_limits=(min=0.0, max=600.0),
    unit_size=50.0,
    capital_costs=LinearCurve(1000.0),
    resistance=2.0,
    reactance=3.0,
    voltage=230.0,
)

hvdc() = NodalHVDCTransportTechnology{PSY.ACBranch}(;
    name="ut_hvdc",
    id=5,
    available=true,
    power_systems_type=string(PSY.Line),
    start_node=Node(; name="ut_n3", id=103),
    end_node=Node(; name="ut_n4", id=104),
    financial_data=tech_financials(),
    capacity_limits=(min=0.0, max=700.0),
    unit_size=60.0,
    capital_costs=LinearCurve(1500.0),
)

demand_req() = DemandRequirement{PSY.PowerLoad}(;
    name="ut_dreq",
    id=6,
    available=true,
    power_systems_type=string(PSY.PowerLoad),
    new_demand_mw=300.0,
    value_of_lost_load=LinearCurve(1e5),
    unserved_demand_curve=LinearCurve(50.0),
)

demand_side() = DemandSideTechnology{PSY.PowerLoad}(;
    name="ut_demand_side",
    id=7,
    available=true,
    power_systems_type=string(PSY.PowerLoad),
    peak_demand_mw=250.0,
    price_per_unit=LinearCurve(8.0),
    curtailment_cost=LinearCurve(30.0),
    shift_variable_cost=LinearCurve(12.0),
    max_demand_advance=4.0,
    max_demand_delay=6.0,
)

retro() = AggregateRetrofitPotential(;
    retrofit_id=1,
    retrofit_potential=150.0,
    retrofit_fraction=0.5,
)

carbon_caps() = CarbonCaps(;
    name="ut_carbon_caps",
    available=true,
    id=8,
    max_tons_mwh=2.0,
    max_mtons=50.0,
)

carbon_tax() =
    CarbonTax(; name="ut_carbon_tax", available=true, id=9, tax_dollars_per_ton=50.0)

max_capacity_req() = MaximumCapacityRequirements(;
    name="ut_max_cap",
    available=true,
    id=10,
    max_capacity_mw=400.0,
)

min_capacity_req() = MinimumCapacityRequirements(;
    name="ut_min_cap",
    available=true,
    id=11,
    min_capacity_mw=100.0,
)

colocated() = ColocatedSupplyStorageTechnology{PSY.ThermalStandard}(;
    name="ut_colocated",
    power_systems_type=string(PSY.ThermalStandard),
    id=12,
    available=true,
    financial_data=tech_financials(),
    capital_costs_solar=LinearCurve(1000.0),
    capital_costs_wind=LinearCurve(1100.0),
    capital_costs_energy=LinearCurve(3000.0),
    capital_costs_power=LinearCurve(1200.0),
    capital_costs_inverter=LinearCurve(1300.0),
    operation_costs_solar=ThermalGenerationCost(
        CostCurve(LinearCurve(5.0)),
        10.0,
        0.0,
        0.0,
    ),
    operation_costs_wind=ThermalGenerationCost(CostCurve(LinearCurve(6.0)), 11.0, 0.0, 0.0),
    operation_costs_energy=StorageCost(; fixed=4.0),
    operation_costs_power=StorageCost(; fixed=5.0),
    operation_costs_inverter=StorageCost(; fixed=6.0),
    capacity_limits_solar=(min=0.0, max=300.0),
    capacity_limits_wind=(min=0.0, max=400.0),
    capacity_power_limits=(min=0.0, max=500.0),
    capacity_energy_limits=(min=0.0, max=2000.0),
    duration_limits=(min=1.0, max=8.0),
    max_inverter_capacity=600.0,
    min_inverter_capacity=50.0,
    lifetime_solar=25,
    lifetime_wind=20,
    lifetime_storage=15,
    inverter_efficiency=0.95,
    inverter_supply_ratio=1.2,
)

# ---------------------------------------------------------------------------
# Reusable field-check helpers. `get` / `set` are closures over the component.
# ---------------------------------------------------------------------------
conversion_unit(x, y) = (x_unit=x, y_unit=y)
get_proportional(vc) = vc.function_data.proportional_term

# Scalar field: value stored in `nat`, retrievable in `alt` scaled by `ratio`.
function check_scalar(get, set, nat, alt; base, ratio)
    @test get(nat) ≈ base
    @test get(alt) ≈ base * ratio
    set(base * ratio, alt)          # round trip: provide in alt units
    @test get(nat) ≈ base
end

function check_minmax(get, set, nat, alt; mn, mx, ratio)
    r = get(nat)
    @test r.min ≈ mn && r.max ≈ mx
    r2 = get(alt)
    @test r2.min ≈ mn * ratio && r2.max ≈ mx * ratio
    set((min=mn * ratio, max=mx * ratio), alt)
    r3 = get(nat)
    @test r3.min ≈ mn && r3.max ≈ mx
end

function check_updown(get, set, nat, alt; up, down, ratio)
    r = get(nat)
    @test r.up ≈ up && r.down ≈ down
    r2 = get(alt)
    @test r2.up ≈ up * ratio && r2.down ≈ down * ratio
    set((up=up * ratio, down=down * ratio), alt)
    r3 = get(nat)
    @test r3.up ≈ up && r3.down ≈ down
end

# ValueCurve field: proportional term scales by `ratio` from `nat` to `alt`.
function check_valuecurve(get, set, nat, alt; prop, ratio)
    @test get_proportional(get(nat)) ≈ prop
    @test get_proportional(get(alt)) ≈ prop * ratio
    set(LinearCurve(prop * ratio), alt)
    @test get_proportional(get(nat)) ≈ prop
end

# ThermalGenerationCost field: variable (CostCurve) proportional term and the
# scalar `fixed` term both scale by `ratio`.
function check_thermal_cost(get, set, nat, alt; var_prop, fixed, ratio)
    o = get(nat)
    @test o.variable.value_curve.function_data.proportional_term ≈ var_prop
    @test o.fixed ≈ fixed
    o2 = get(alt)
    @test o2.variable.value_curve.function_data.proportional_term ≈ var_prop * ratio
    @test o2.fixed ≈ fixed * ratio
    set(get(alt), alt)              # round trip: feed the alt-unit cost back
    o3 = get(nat)
    @test o3.variable.value_curve.function_data.proportional_term ≈ var_prop
    @test o3.fixed ≈ fixed
end

# StorageCost field: the scalar `fixed` term scales by `ratio`.
function check_storage_cost(get, set, nat, alt; fixed, ratio)
    @test get(nat).fixed ≈ fixed
    @test get(alt).fixed ≈ fixed * ratio
    set(get(alt), alt)
    @test get(nat).fixed ≈ fixed
end

# ===========================================================================
# PART 1 — internal conversion engine
# ===========================================================================

@testset "natural_unit definitions" begin
    @test PSIP.natural_unit(PSIP.POWER) == u"MW"
    @test PSIP.natural_unit(PSIP.ENERGY) == u"MW" * u"hr"
    @test PSIP.natural_unit(PSIP.VOLTAGE) == u"kV"
    @test PSIP.natural_unit(PSIP.IMPEDANCE) == u"Ω"
    @test PSIP.natural_unit(PSIP.OPS_TIME) == u"hr"
    @test PSIP.natural_unit(PSIP.INV_TIME) == u"yr"
    @test PSIP.natural_unit(PSIP.COST) == USD
    @test PSIP.natural_unit(PSIP.FUEL) == MMBtu
    # Custom composite units added on this branch.
    @test PSIP.natural_unit(PSIP.EMISSIONS_MASS) == tonne
    @test PSIP.natural_unit(PSIP.EMISSIONS_COST) == USD / tonne
    @test PSIP.natural_unit(PSIP.EMISSIONS_FUEL) == tonne / MMBtu
    @test PSIP.natural_unit(PSIP.EMISSIONS_ENERGY) == tonne / (u"MW" * u"hr")
    @test PSIP.natural_unit(PSIP.RAMPING) == u"MW" / u"minute"
    @test PSIP.natural_unit(PSIP.FUEL_CONSUMPTION_POWER) == MMBtu / u"MW"

    # Compound (x_unit, y_unit) categories.
    @test PSIP.natural_unit(PSIP.POWER_COST) == (x_unit=u"MW", y_unit=USD)
    @test PSIP.natural_unit(PSIP.ENERGY_COST) == (x_unit=u"MW" * u"hr", y_unit=USD)
    @test PSIP.natural_unit(PSIP.FUEL_COST) == (x_unit=MMBtu, y_unit=USD)
    @test PSIP.natural_unit(PSIP.FUEL_CURVE) ==
          (energy_unit=u"MW" * u"hr", fuel_unit=MMBtu, currency_unit=USD)

    # _unit_category resolves the schema tokens used by the generated code.
    @test PSIP._unit_category(Val(:mw)) === PSIP.POWER
    @test PSIP._unit_category(Val(:mwh)) === PSIP.ENERGY
    @test PSIP._unit_category(Val(:kv)) === PSIP.VOLTAGE
    @test PSIP._unit_category(Val(:ohm)) === PSIP.IMPEDANCE
    @test PSIP._unit_category(Val(:hr)) === PSIP.OPS_TIME
    @test PSIP._unit_category(Val(:yr)) === PSIP.INV_TIME
    @test PSIP._unit_category(Val(:mw_per_min)) === PSIP.RAMPING
    @test PSIP._unit_category(Val(:mmbtu_per_mw)) === PSIP.FUEL_CONSUMPTION_POWER
    @test PSIP._unit_category(Val(:usd_per_mw)) === PSIP.POWER_COST
    @test PSIP._unit_category(Val(:usd_per_mwh)) === PSIP.ENERGY_COST
    @test PSIP._unit_category(Val(:usd_per_mmbtu)) === PSIP.FUEL_COST
    @test PSIP._unit_category(Val(:t)) === PSIP.EMISSIONS_MASS
    @test PSIP._unit_category(Val(:usd_per_t)) === PSIP.EMISSIONS_COST
    @test PSIP._unit_category(Val(:t_per_mmbtu)) === PSIP.EMISSIONS_FUEL
    @test PSIP._unit_category(Val(:t_per_mwh)) === PSIP.EMISSIONS_ENERGY
end

@testset "scalar conversions" begin
    t = supply()
    @test ustrip(PSIP._natural_unit_conversions(t, 1.0, u"MW", u"kW")) ≈ 1000.0
    @test ustrip(PSIP._natural_unit_conversions(t, 2.5, u"MW", u"MW")) ≈ 2.5
    @test PSIP._natural_unit_conversions(t, nothing, Val(:mw), USD) === nothing

    mm = PSIP._natural_unit_conversions(t, (min=0.0, max=1.0), u"MW", u"kW")
    @test ustrip(mm.min) ≈ 0.0 && ustrip(mm.max) ≈ 1000.0

    ud = PSIP._natural_unit_conversions(t, (up=1.0, down=2.0), u"hr", u"minute")
    @test ustrip(ud.up) ≈ 60.0 && ustrip(ud.down) ≈ 120.0
end

@testset "FunctionData conversions" begin
    t = supply()
    cu_kw = conversion_unit(u"kW", USD)
    cu_mw = conversion_unit(u"MW", USD)

    lin = LinearFunctionData(0.5, 10.0)
    nl = PSIP._natural_unit_conversions(t, lin, cu_kw, cu_mw)
    @test nl isa LinearFunctionData
    @test nl.proportional_term ≈ 500.0
    @test nl.constant_term ≈ 10.0

    quad = QuadraticFunctionData(1.0, 0.5, 10.0)
    nq = PSIP._natural_unit_conversions(t, quad, cu_kw, cu_mw)
    @test nq.quadratic_term ≈ 1.0e6
    @test nq.proportional_term ≈ 500.0
    @test nq.constant_term ≈ 10.0

    pcl = PiecewiseLinearData([(x=0.0, y=10.0), (x=1.0, y=20.0), (x=2.0, y=30.0)])
    npcl = PSIP._natural_unit_conversions(t, pcl, cu_mw, cu_kw)
    pts = PSY.get_points(npcl)
    @test [p.x for p in pts] ≈ [0.0, 1000.0, 2000.0]
    @test [p.y for p in pts] ≈ [10.0, 20.0, 30.0]

    pcs = PiecewiseStepData([0.0, 1.0, 2.0], [10.0, 20.0])
    npcs = PSIP._natural_unit_conversions(t, pcs, cu_kw, cu_mw)
    @test npcs.x_coords ≈ [0.0, 0.001, 0.002]
    @test npcs.y_coords ≈ [10000.0, 20000.0]
end

@testset "ValueCurve conversions" begin
    t = supply()
    lin = LinearFunctionData(0.5, 10.0)
    cu_kw = conversion_unit(u"kW", USD)
    cu_mw = conversion_unit(u"MW", USD)

    io = InputOutputCurve(lin, 1.0)
    nio = PSIP._natural_unit_conversions(t, io, cu_kw, cu_mw)
    @test nio isa InputOutputCurve
    @test nio.function_data.proportional_term ≈ 500.0
    @test nio.input_at_zero ≈ 1.0

    inc = IncrementalCurve(lin, 1.0, 2.0)
    ninc = PSIP._natural_unit_conversions(t, inc, cu_kw, cu_mw)
    @test ninc isa IncrementalCurve
    @test ninc.function_data.proportional_term ≈ 500.0
    @test ninc.initial_input ≈ 1.0
    @test ninc.input_at_zero ≈ 2.0

    avg = AverageRateCurve(lin, 1.0, 2.0)
    navg = PSIP._natural_unit_conversions(
        t,
        avg,
        conversion_unit(u"MW" * u"hr", MMBtu),
        conversion_unit(u"MW" * u"hr", u"btu"),
    )
    @test navg isa AverageRateCurve
    @test navg.function_data.proportional_term ≈ 5.0e5
    @test navg.function_data.constant_term ≈ 1.0e7
    @test navg.initial_input ≈ 1.0e6
    @test navg.input_at_zero ≈ 2.0e6
end

@testset "CostCurve / FuelCurve conversions" begin
    t = supply()
    io = InputOutputCurve(LinearFunctionData(0.5, 10.0), 1.0)

    cc = CostCurve(io, LinearCurve(1.0))
    ncc = PSIP._natural_unit_conversions(
        t,
        cc,
        conversion_unit(u"MW", USD),
        conversion_unit(u"MW", USD),
    )
    @test ncc isa CostCurve
    @test ncc.value_curve.function_data.proportional_term ≈ 0.5

    fc = FuelCurve(io, 100.0, LinearCurve(1.0), LinearCurve(1.0))
    nfc = PSIP._natural_unit_conversions(
        t,
        fc,
        (energy_unit=u"MW" * u"hr", fuel_unit=MMBtu, currency_unit=USD),
        (energy_unit=u"MW" * u"hr", fuel_unit=u"btu", currency_unit=USD),
    )
    @test nfc isa FuelCurve
    @test nfc.value_curve.function_data.proportional_term ≈ 5.0e5
    @test nfc.fuel_cost ≈ 1.0e-4
end

@testset "OperationalCost conversions" begin
    t = supply()
    cu_kw = conversion_unit(u"kW", USD)
    cu_mw = conversion_unit(u"MW", USD)

    gc = ThermalGenerationCost(
        CostCurve(InputOutputCurve(LinearFunctionData(0.5, 10.0))),
        100.0,
        0.0,
        0.0,
    )
    ngc = PSIP._natural_unit_conversions(t, gc, cu_kw, cu_mw)
    @test ngc isa ThermalGenerationCost
    @test ngc.variable.value_curve.function_data.proportional_term ≈ 500.0
    @test ngc.fixed ≈ 1.0e5

    io = InputOutputCurve(LinearFunctionData(0.5, 10.0), 1.0)
    fc = FuelCurve(io, 100.0, LinearCurve(1.0), LinearCurve(1.0))
    gfc = ThermalGenerationCost(fc, 100.0, (hot=100.0, warm=50.0, cold=10.0), 0.0)
    ngfc = PSIP._natural_unit_conversions(
        t,
        gfc,
        (energy_unit=u"MW" * u"hr", fuel_unit=MMBtu, currency_unit=USD),
        (energy_unit=u"MW" * u"hr", fuel_unit=u"btu", currency_unit=USD),
    )
    @test ngfc isa ThermalGenerationCost
    @test ngfc.variable.fuel_cost ≈ 1.0e-4
    @test ngfc.start_up == (hot=100.0, warm=50.0, cold=10.0)

    sc = StorageCost(;
        charge_variable_cost=CostCurve(LinearCurve(1.0)),
        discharge_variable_cost=CostCurve(LinearCurve(1.0)),
        fixed=2.0,
    )
    nsc = PSIP._natural_unit_conversions(t, sc, cu_kw, cu_mw)
    @test nsc isa StorageCost
    @test nsc.fixed ≈ 2000.0

    # RenewableGenerationCost: `curtailment_cost` field (bug fixed on this branch).
    rc = RenewableGenerationCost(
        CostCurve(LinearCurve(1.0)),
        CostCurve(LinearCurve(0.0)),
        1.0,
    )
    nrc = PSIP._natural_unit_conversions(t, rc, cu_kw, cu_mw)
    @test nrc isa RenewableGenerationCost
    @test nrc.fixed ≈ 1000.0
    @test nrc.variable.value_curve.function_data.proportional_term ≈ 1000.0
end

# ===========================================================================
# PART 2 — units-aware getters/setters, per technology
# ===========================================================================

@testset "SupplyTechnology getters/setters" begin
    t = supply()
    # unit_size (mw)
    check_scalar(
        u -> PSIP.get_unit_size(t, u),
        (v, u) -> PSIP.set_unit_size!(t, v, u),
        u"MW",
        u"kW";
        base=100.0,
        ratio=1000.0,
    )
    # start_fuel_mmbtu_per_mw (mmbtu_per_mw) — bug fixed on this branch
    check_scalar(
        u -> PSIP.get_start_fuel_mmbtu_per_mw(t, u),
        (v, u) -> PSIP.set_start_fuel_mmbtu_per_mw!(t, v, u),
        u"MMBtu/MW",
        u"MMBtu/kW";
        base=5.0,
        ratio=0.001,
    )
    # capacity_limits (mw, MinMax)
    check_minmax(
        u -> PSIP.get_capacity_limits(t, u),
        (v, u) -> PSIP.set_capacity_limits!(t, v, u),
        u"MW",
        u"kW";
        mn=0.0,
        mx=500.0,
        ratio=1000.0,
    )
    # ramp_limits (mw_per_min, UpDown)
    check_updown(
        u -> PSIP.get_ramp_limits(t, u),
        (v, u) -> PSIP.set_ramp_limits!(t, v, u),
        u"MW/minute",
        u"MW/s";
        up=1.0,
        down=2.0,
        ratio=1 / 60,
    )
    # time_limits (hr, UpDown)
    check_updown(
        u -> PSIP.get_time_limits(t, u),
        (v, u) -> PSIP.set_time_limits!(t, v, u),
        u"hr",
        u"minute";
        up=10.0,
        down=20.0,
        ratio=60.0,
    )
    # capital_costs (usd_per_mw, ValueCurve)
    check_valuecurve(
        u -> PSIP.get_capital_costs(t, u),
        (v, u) -> PSIP.set_capital_costs!(t, v, u),
        conversion_unit(u"MW", USD),
        conversion_unit(u"kW", USD);
        prop=10000.0,
        ratio=1e-3,
    )
    # operation_costs (usd_per_mwh, OperationalCost)
    oc = PSIP.get_operation_costs(t, conversion_unit(u"MW" * u"hr", USD))
    @test oc.variable.value_curve.function_data.proportional_term ≈ 10.0
    @test oc.fixed ≈ 100.0
    oc2 = PSIP.get_operation_costs(t, conversion_unit(u"kW" * u"hr", USD))
    @test oc2.variable.value_curve.function_data.proportional_term ≈ 0.01
    # lifetime (yr, Int)
    @test PSIP.get_lifetime(t, u"yr") == 30
    PSIP.set_lifetime!(t, 20, u"yr")
    @test PSIP.get_lifetime(t, u"yr") == 20
    # _unitful companion returns a Quantity
    @test PSIP.get_unit_size_unitful(t, u"MW") == 100.0u"MW"
end

@testset "StorageTechnology getters/setters" begin
    t = storage()
    check_scalar(
        u -> PSIP.get_unit_size_charge(t, u),
        (v, u) -> PSIP.set_unit_size_charge!(t, v, u),
        u"MW",
        u"kW";
        base=10.0,
        ratio=1000.0,
    )
    check_scalar(
        u -> PSIP.get_unit_size_discharge(t, u),
        (v, u) -> PSIP.set_unit_size_discharge!(t, v, u),
        u"MW",
        u"kW";
        base=20.0,
        ratio=1000.0,
    )
    check_scalar(
        u -> PSIP.get_unit_size_energy(t, u),
        (v, u) -> PSIP.set_unit_size_energy!(t, v, u),
        u"MW" * u"hr",
        u"kW" * u"hr";
        base=200.0,
        ratio=1000.0,
    )
    check_minmax(
        u -> PSIP.get_capacity_limits_charge(t, u),
        (v, u) -> PSIP.set_capacity_limits_charge!(t, v, u),
        u"MW",
        u"kW";
        mn=0.0,
        mx=100.0,
        ratio=1000.0,
    )
    check_minmax(
        u -> PSIP.get_capacity_limits_discharge(t, u),
        (v, u) -> PSIP.set_capacity_limits_discharge!(t, v, u),
        u"MW",
        u"kW";
        mn=0.0,
        mx=200.0,
        ratio=1000.0,
    )
    check_minmax(
        u -> PSIP.get_capacity_limits_energy(t, u),
        (v, u) -> PSIP.set_capacity_limits_energy!(t, v, u),
        u"MW" * u"hr",
        u"kW" * u"hr";
        mn=0.0,
        mx=1000.0,
        ratio=1000.0,
    )
    check_minmax(
        u -> PSIP.get_duration_limits(t, u),
        (v, u) -> PSIP.set_duration_limits!(t, v, u),
        u"hr",
        u"minute";
        mn=1.0,
        mx=10.0,
        ratio=60.0,
    )
    check_valuecurve(
        u -> PSIP.get_capital_costs_energy(t, u),
        (v, u) -> PSIP.set_capital_costs_energy!(t, v, u),
        conversion_unit(u"MW" * u"hr", USD),
        conversion_unit(u"kW" * u"hr", USD);
        prop=3000.0,
        ratio=1e-3,
    )
    check_valuecurve(
        u -> PSIP.get_capital_costs_charge(t, u),
        (v, u) -> PSIP.set_capital_costs_charge!(t, v, u),
        conversion_unit(u"MW", USD),
        conversion_unit(u"kW", USD);
        prop=1000.0,
        ratio=1e-3,
    )
    check_valuecurve(
        u -> PSIP.get_capital_costs_discharge(t, u),
        (v, u) -> PSIP.set_capital_costs_discharge!(t, v, u),
        conversion_unit(u"MW", USD),
        conversion_unit(u"kW", USD);
        prop=2000.0,
        ratio=1e-3,
    )
    @test PSIP.get_lifetime(t, u"yr") == 15
    PSIP.set_lifetime!(t, 25, u"yr")
    @test PSIP.get_lifetime(t, u"yr") == 25
end

@testset "AggregateTransportTechnology getters/setters" begin
    t = agg_transport()
    check_scalar(
        u -> PSIP.get_unit_size(t, u),
        (v, u) -> PSIP.set_unit_size!(t, v, u),
        u"MW",
        u"kW";
        base=40.0,
        ratio=1000.0,
    )
    check_minmax(
        u -> PSIP.get_capacity_limits(t, u),
        (v, u) -> PSIP.set_capacity_limits!(t, v, u),
        u"MW",
        u"kW";
        mn=0.0,
        mx=800.0,
        ratio=1000.0,
    )
    check_valuecurve(
        u -> PSIP.get_capital_costs(t, u),
        (v, u) -> PSIP.set_capital_costs!(t, v, u),
        conversion_unit(u"MW", USD),
        conversion_unit(u"kW", USD);
        prop=500.0,
        ratio=1e-3,
    )
end

@testset "NodalACTransportTechnology getters/setters" begin
    t = acline()
    check_scalar(
        u -> PSIP.get_unit_size(t, u),
        (v, u) -> PSIP.set_unit_size!(t, v, u),
        u"MW",
        u"kW";
        base=50.0,
        ratio=1000.0,
    )
    check_minmax(
        u -> PSIP.get_capacity_limits(t, u),
        (v, u) -> PSIP.set_capacity_limits!(t, v, u),
        u"MW",
        u"kW";
        mn=0.0,
        mx=600.0,
        ratio=1000.0,
    )
    check_valuecurve(
        u -> PSIP.get_capital_costs(t, u),
        (v, u) -> PSIP.set_capital_costs!(t, v, u),
        conversion_unit(u"MW", USD),
        conversion_unit(u"kW", USD);
        prop=1000.0,
        ratio=1e-3,
    )
    check_scalar(
        u -> PSIP.get_resistance(t, u),
        (v, u) -> PSIP.set_resistance!(t, v, u),
        u"Ω",
        u"mΩ";
        base=2.0,
        ratio=1000.0,
    )
    check_scalar(
        u -> PSIP.get_reactance(t, u),
        (v, u) -> PSIP.set_reactance!(t, v, u),
        u"Ω",
        u"mΩ";
        base=3.0,
        ratio=1000.0,
    )
    check_scalar(
        u -> PSIP.get_voltage(t, u),
        (v, u) -> PSIP.set_voltage!(t, v, u),
        u"kV",
        u"V";
        base=230.0,
        ratio=1000.0,
    )
end

@testset "NodalHVDCTransportTechnology getters/setters" begin
    t = hvdc()
    check_scalar(
        u -> PSIP.get_unit_size(t, u),
        (v, u) -> PSIP.set_unit_size!(t, v, u),
        u"MW",
        u"kW";
        base=60.0,
        ratio=1000.0,
    )
    check_minmax(
        u -> PSIP.get_capacity_limits(t, u),
        (v, u) -> PSIP.set_capacity_limits!(t, v, u),
        u"MW",
        u"kW";
        mn=0.0,
        mx=700.0,
        ratio=1000.0,
    )
    check_valuecurve(
        u -> PSIP.get_capital_costs(t, u),
        (v, u) -> PSIP.set_capital_costs!(t, v, u),
        conversion_unit(u"MW", USD),
        conversion_unit(u"kW", USD);
        prop=1500.0,
        ratio=1e-3,
    )
end

@testset "DemandRequirement getters/setters" begin
    t = demand_req()
    check_scalar(
        u -> PSIP.get_new_demand_mw(t, u),
        (v, u) -> PSIP.set_new_demand_mw!(t, v, u),
        u"MW",
        u"kW";
        base=300.0,
        ratio=1000.0,
    )
    check_valuecurve(
        u -> PSIP.get_unserved_demand_curve(t, u),
        (v, u) -> PSIP.set_unserved_demand_curve!(t, v, u),
        conversion_unit(u"MW" * u"hr", USD),
        conversion_unit(u"kW" * u"hr", USD);
        prop=50.0,
        ratio=1e-3,
    )

    # value_of_lost_load is now a ValueCurve (usd_per_mwh); bug fixed on this branch.
    check_valuecurve(
        u -> PSIP.get_value_of_lost_load(t, u),
        (v, u) -> PSIP.set_value_of_lost_load!(t, v, u),
        conversion_unit(u"MW" * u"hr", USD),
        conversion_unit(u"kW" * u"hr", USD);
        prop=1e5,
        ratio=1e-3,
    )
end

@testset "DemandSideTechnology getters/setters" begin
    t = demand_side()
    check_scalar(
        u -> PSIP.get_peak_demand_mw(t, u),
        (v, u) -> PSIP.set_peak_demand_mw!(t, v, u),
        u"MW",
        u"kW";
        base=250.0,
        ratio=1000.0,
    )
    check_scalar(
        u -> PSIP.get_max_demand_advance(t, u),
        (v, u) -> PSIP.set_max_demand_advance!(t, v, u),
        u"hr",
        u"minute";
        base=4.0,
        ratio=60.0,
    )
    check_scalar(
        u -> PSIP.get_max_demand_delay(t, u),
        (v, u) -> PSIP.set_max_demand_delay!(t, v, u),
        u"hr",
        u"minute";
        base=6.0,
        ratio=60.0,
    )
    check_valuecurve(
        u -> PSIP.get_price_per_unit(t, u),
        (v, u) -> PSIP.set_price_per_unit!(t, v, u),
        conversion_unit(MMBtu, USD),
        conversion_unit(u"btu", USD);
        prop=8.0,
        ratio=1e-6,
    )
    check_valuecurve(
        u -> PSIP.get_curtailment_cost(t, u),
        (v, u) -> PSIP.set_curtailment_cost!(t, v, u),
        conversion_unit(u"MW" * u"hr", USD),
        conversion_unit(u"kW" * u"hr", USD);
        prop=30.0,
        ratio=1e-3,
    )
    check_valuecurve(
        u -> PSIP.get_shift_variable_cost(t, u),
        (v, u) -> PSIP.set_shift_variable_cost!(t, v, u),
        conversion_unit(u"MW" * u"hr", USD),
        conversion_unit(u"kW" * u"hr", USD);
        prop=12.0,
        ratio=1e-3,
    )
end

@testset "AggregateRetrofitPotential getters/setters" begin
    t = retro()
    # AggregateRetrofitPotential <: SupplementalAttribute; unit-aware dispatch now
    # covers it via the `_UNIT_AWARE` union (bug fixed on this branch).
    check_scalar(
        u -> PSIP.get_retrofit_potential(t, u),
        (v, u) -> PSIP.set_retrofit_potential!(t, v, u),
        u"MW",
        u"kW";
        base=150.0,
        ratio=1000.0,
    )
end

@testset "CarbonCaps getters/setters" begin
    t = carbon_caps()
    # max_mtons (t) — emissions mass
    check_scalar(
        u -> PSIP.get_max_mtons(t, u),
        (v, u) -> PSIP.set_max_mtons!(t, v, u),
        tonne,
        u"kg";
        base=50.0,
        ratio=1000.0,
    )
    # max_tons_mwh (t_per_mwh) — emissions rate per energy
    check_scalar(
        u -> PSIP.get_max_tons_mwh(t, u),
        (v, u) -> PSIP.set_max_tons_mwh!(t, v, u),
        tonne / (u"MW" * u"hr"),
        tonne / (u"kW" * u"hr");
        base=2.0,
        ratio=1e-3,
    )
end

@testset "CarbonTax getters/setters" begin
    t = carbon_tax()
    # tax_dollars_per_ton (usd_per_t) — emissions cost
    check_scalar(
        u -> PSIP.get_tax_dollars_per_ton(t, u),
        (v, u) -> PSIP.set_tax_dollars_per_ton!(t, v, u),
        USD / tonne,
        USD / u"kg";
        base=50.0,
        ratio=1e-3,
    )
end

@testset "MaximumCapacityRequirements getters/setters" begin
    t = max_capacity_req()
    check_scalar(
        u -> PSIP.get_max_capacity_mw(t, u),
        (v, u) -> PSIP.set_max_capacity_mw!(t, v, u),
        u"MW",
        u"kW";
        base=400.0,
        ratio=1000.0,
    )
end

@testset "MinimumCapacityRequirements getters/setters" begin
    t = min_capacity_req()
    check_scalar(
        u -> PSIP.get_min_capacity_mw(t, u),
        (v, u) -> PSIP.set_min_capacity_mw!(t, v, u),
        u"MW",
        u"kW";
        base=100.0,
        ratio=1000.0,
    )
end

@testset "ColocatedSupplyStorageTechnology getters/setters" begin
    t = colocated()
    # --- MinMax power/energy limits ---
    check_minmax(
        u -> PSIP.get_capacity_limits_solar(t, u),
        (v, u) -> PSIP.set_capacity_limits_solar!(t, v, u),
        u"MW",
        u"kW";
        mn=0.0,
        mx=300.0,
        ratio=1000.0,
    )
    check_minmax(
        u -> PSIP.get_capacity_limits_wind(t, u),
        (v, u) -> PSIP.set_capacity_limits_wind!(t, v, u),
        u"MW",
        u"kW";
        mn=0.0,
        mx=400.0,
        ratio=1000.0,
    )
    check_minmax(
        u -> PSIP.get_capacity_power_limits(t, u),
        (v, u) -> PSIP.set_capacity_power_limits!(t, v, u),
        u"MW",
        u"kW";
        mn=0.0,
        mx=500.0,
        ratio=1000.0,
    )
    check_minmax(
        u -> PSIP.get_capacity_energy_limits(t, u),
        (v, u) -> PSIP.set_capacity_energy_limits!(t, v, u),
        u"MW" * u"hr",
        u"kW" * u"hr";
        mn=0.0,
        mx=2000.0,
        ratio=1000.0,
    )
    check_minmax(
        u -> PSIP.get_duration_limits(t, u),
        (v, u) -> PSIP.set_duration_limits!(t, v, u),
        u"hr",
        u"minute";
        mn=1.0,
        mx=8.0,
        ratio=60.0,
    )
    # --- scalar power (inverter) ---
    check_scalar(
        u -> PSIP.get_max_inverter_capacity(t, u),
        (v, u) -> PSIP.set_max_inverter_capacity!(t, v, u),
        u"MW",
        u"kW";
        base=600.0,
        ratio=1000.0,
    )
    check_scalar(
        u -> PSIP.get_min_inverter_capacity(t, u),
        (v, u) -> PSIP.set_min_inverter_capacity!(t, v, u),
        u"MW",
        u"kW";
        base=50.0,
        ratio=1000.0,
    )
    # --- ValueCurve capital costs ---
    check_valuecurve(
        u -> PSIP.get_capital_costs_solar(t, u),
        (v, u) -> PSIP.set_capital_costs_solar!(t, v, u),
        conversion_unit(u"MW", USD),
        conversion_unit(u"kW", USD);
        prop=1000.0,
        ratio=1e-3,
    )
    check_valuecurve(
        u -> PSIP.get_capital_costs_wind(t, u),
        (v, u) -> PSIP.set_capital_costs_wind!(t, v, u),
        conversion_unit(u"MW", USD),
        conversion_unit(u"kW", USD);
        prop=1100.0,
        ratio=1e-3,
    )
    check_valuecurve(
        u -> PSIP.get_capital_costs_power(t, u),
        (v, u) -> PSIP.set_capital_costs_power!(t, v, u),
        conversion_unit(u"MW", USD),
        conversion_unit(u"kW", USD);
        prop=1200.0,
        ratio=1e-3,
    )
    check_valuecurve(
        u -> PSIP.get_capital_costs_inverter(t, u),
        (v, u) -> PSIP.set_capital_costs_inverter!(t, v, u),
        conversion_unit(u"MW", USD),
        conversion_unit(u"kW", USD);
        prop=1300.0,
        ratio=1e-3,
    )
    check_valuecurve(
        u -> PSIP.get_capital_costs_energy(t, u),
        (v, u) -> PSIP.set_capital_costs_energy!(t, v, u),
        conversion_unit(u"MW" * u"hr", USD),
        conversion_unit(u"kW" * u"hr", USD);
        prop=3000.0,
        ratio=1e-3,
    )
    # --- OperationalCost: ThermalGenerationCost (solar/wind, usd_per_mwh) ---
    check_thermal_cost(
        u -> PSIP.get_operation_costs_solar(t, u),
        (v, u) -> PSIP.set_operation_costs_solar!(t, v, u),
        conversion_unit(u"MW" * u"hr", USD),
        conversion_unit(u"kW" * u"hr", USD);
        var_prop=5.0,
        fixed=10.0,
        ratio=1e-3,
    )
    check_thermal_cost(
        u -> PSIP.get_operation_costs_wind(t, u),
        (v, u) -> PSIP.set_operation_costs_wind!(t, v, u),
        conversion_unit(u"MW" * u"hr", USD),
        conversion_unit(u"kW" * u"hr", USD);
        var_prop=6.0,
        fixed=11.0,
        ratio=1e-3,
    )
    # --- OperationalCost: StorageCost (energy/inverter usd_per_mwh, power usd_per_mw) ---
    check_storage_cost(
        u -> PSIP.get_operation_costs_energy(t, u),
        (v, u) -> PSIP.set_operation_costs_energy!(t, v, u),
        conversion_unit(u"MW" * u"hr", USD),
        conversion_unit(u"kW" * u"hr", USD);
        fixed=4.0,
        ratio=1e-3,
    )
    check_storage_cost(
        u -> PSIP.get_operation_costs_power(t, u),
        (v, u) -> PSIP.set_operation_costs_power!(t, v, u),
        conversion_unit(u"MW", USD),
        conversion_unit(u"kW", USD);
        fixed=5.0,
        ratio=1e-3,
    )
    check_storage_cost(
        u -> PSIP.get_operation_costs_inverter(t, u),
        (v, u) -> PSIP.set_operation_costs_inverter!(t, v, u),
        conversion_unit(u"MW" * u"hr", USD),
        conversion_unit(u"kW" * u"hr", USD);
        fixed=6.0,
        ratio=1e-3,
    )
    # --- lifetimes (yr, Int) ---
    for (get, set, base) in (
        (PSIP.get_lifetime_solar, PSIP.set_lifetime_solar!, 25),
        (PSIP.get_lifetime_wind, PSIP.set_lifetime_wind!, 20),
        (PSIP.get_lifetime_storage, PSIP.set_lifetime_storage!, 15),
    )
        @test get(t, u"yr") == base
        set(t, base + 5, u"yr")
        @test get(t, u"yr") == base + 5
    end
end

# ===========================================================================
# PART 3 — display_units_arg dispatch (drives Base.show for unit fields)
# ===========================================================================

@testset "display_units_arg" begin
    t = supply()
    @test IS.display_units_arg(PSIP.get_unit_size, typeof(t)) === IS.NU
    @test IS.display_units_arg(PSIP.get_capacity_limits, typeof(t)) === IS.NU
    @test IS.display_units_arg(PSIP.get_unit_size_unitful, typeof(t)) === IS.NU
    # Fields without units have no display_units_arg method -> default `missing`.
    @test ismissing(IS.display_units_arg(PSIP.get_name, typeof(t)))
    @test ismissing(IS.display_units_arg(PSIP.get_available, typeof(t)))
end
