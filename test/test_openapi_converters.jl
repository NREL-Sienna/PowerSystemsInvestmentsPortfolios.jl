@testset "value curve conversion round trip" begin
    for curve in (
        LinearCurve(3.0),
        LinearCurve(2.0, 5.0),
        PSY.QuadraticCurve(1.0, 2.0, 3.0),
        PSY.PiecewisePointCurve([(1.0, 10.0), (2.0, 25.0)]),
    )
        po = PSIP.convert_value_curve_to_openapi(curve)
        @test PSIP.convert_value_curve(po) == curve
    end
end

@testset "operational cost conversion round trip" begin
    # `ThermalGenerationCost`/`StorageCost`/`RenewableGenerationCost` are `@kwdef mutable
    # struct`s with no custom `Base.==`, so two field-identical instances are not `==`
    # (mutable structs fall back to identity). Compare the round-tripped cost's `variable`
    # value curve and scalar fields directly instead of `==`-ing the whole struct.
    thermal = PSY.ThermalGenerationCost(nothing)
    po = PSIP.convert_cost_to_openapi(thermal)
    round_tripped = PSIP.convert_cost(po)
    @test round_tripped isa PSY.ThermalGenerationCost
    @test get_variable(round_tripped) == get_variable(thermal)
    @test get_fixed(round_tripped) == get_fixed(thermal)
    @test get_start_up(round_tripped) == get_start_up(thermal)
    @test get_shut_down(round_tripped) == get_shut_down(thermal)

    storage = PSY.StorageCost(nothing)
    po = PSIP.convert_cost_to_openapi(storage)
    round_tripped = PSIP.convert_cost(po)
    @test round_tripped isa PSY.StorageCost
    @test get_charge_variable_cost(round_tripped) == get_charge_variable_cost(storage)
    @test get_discharge_variable_cost(round_tripped) == get_discharge_variable_cost(storage)
    @test get_fixed(round_tripped) == get_fixed(storage)
    @test get_start_up(round_tripped) == get_start_up(storage)
    @test get_shut_down(round_tripped) == get_shut_down(storage)
    @test get_energy_shortage_cost(round_tripped) == get_energy_shortage_cost(storage)
    @test get_energy_surplus_cost(round_tripped) == get_energy_surplus_cost(storage)

    renewable = PSY.RenewableGenerationCost(nothing)
    po = PSIP.convert_cost_to_openapi(renewable)
    round_tripped = PSIP.convert_cost(po)
    @test round_tripped isa PSY.RenewableGenerationCost
    @test get_variable(round_tripped) == get_variable(renewable)
    # `get_curtailment_cost` is ambiguous between PSY and PSIP's own
    # `DemandSideTechnology` getter of the same name — qualify it.
    @test PSY.get_curtailment_cost(round_tripped) == PSY.get_curtailment_cost(renewable)
    @test get_fixed(round_tripped) == get_fixed(renewable)
end

@testset "financial data conversion round trip" begin
    fd = TechnologyFinancialData(
        capital_recovery_period=20,
        technology_base_year=2024,
        debt_fraction=0.6,
        debt_rate=0.05,
        return_on_equity=0.1,
        tax_rate=0.21,
    )
    po = PSIP.convert_nested_data_to_openapi(fd)
    round_tripped = PSIP.convert_nested_data(po)
    # `TechnologyFinancialData`'s getters are not in the module's export list (pre-existing,
    # out of Task 3's scope), so they must be qualified here.
    @test PSIP.get_capital_recovery_period(round_tripped) == 20
    @test PSIP.get_technology_base_year(round_tripped) == 2024
    @test PSIP.get_debt_fraction(round_tripped) == 0.6
    @test PSIP.get_debt_rate(round_tripped) == 0.05
    @test PSIP.get_return_on_equity(round_tripped) == 0.1
    @test PSIP.get_tax_rate(round_tripped) == 0.21
end

@testset "compound PO constructors" begin
    @test PSIP._minmax_po((min=1.0, max=2.0)).min == 1.0
    @test PSIP._minmax_po((min=1.0, max=2.0)).max == 2.0
    @test PSIP._updown_po((up=3.0, down=4.0)).up == 3.0
    @test PSIP._inout_po((in=0.9, out=0.8)).out == 0.8
    # `OPENAPI_COMPOUND_CTORS` names an `_optional` constructor for all three compounds,
    # so all three are reachable the moment any compound field is made nullable; test all
    # three rather than leave two of the table's entries unexercised.
    @test isnothing(PSIP._minmax_po_optional(nothing))
    @test PSIP._minmax_po_optional((min=0.0, max=1.0)).max == 1.0
    @test isnothing(PSIP._updown_po_optional(nothing))
    @test PSIP._updown_po_optional((up=3.0, down=4.0)).down == 4.0
    @test isnothing(PSIP._inout_po_optional(nothing))
    @test PSIP._inout_po_optional((in=0.9, out=0.8)).in == 0.9
end

@testset "unmapped converter input errors loudly" begin
    @test_throws ErrorException PSIP.convert_cost("not a cost model")
    @test_throws ErrorException PSIP.convert_value_curve(42)
end

# ── generated from_openapi / to_openapi round trips (Task 4) ──────────────────
#
# `build_portfolio()` is unavailable in this environment (PSCB 2.4.0 calls a PSY API
# removed in psy6), so every fixture below is built inline.

"""
The reference targets every technology round trip needs, pre-registered.
"""
function _refs_fixture()
    refs = PSIP.OpenAPIRefs()
    zone = Zone(name="zone_a", id=1)
    node = Node(name="node_a", id=2)
    req = CarbonTax(name="tax", id=3, available=true)
    refs[1] = zone
    refs[2] = node
    refs[3] = req
    return refs, zone, node, req
end

@testset "Zone and Node round trip through OpenAPI" begin
    refs, zone, node, _ = _refs_fixture()

    po_zone = PSIP.to_openapi(zone, refs)
    @test po_zone.id == 1
    @test po_zone.name == "zone_a"
    @test PSIP.get_name(PSIP.from_openapi(po_zone, refs)) == "zone_a"

    # bus_type is an ACBusTypes enum: it crosses the wire as a string.
    po_node = PSIP.to_openapi(node, refs)
    @test po_node.bus_type == string(ACBusTypes.PQ)
    @test PSIP.get_bus_type(PSIP.from_openapi(po_node, refs)) == ACBusTypes.PQ
end

@testset "SupplyTechnology round trip through OpenAPI" begin
    refs, zone, _, req = _refs_fixture()
    tech = SupplyTechnology{ThermalStandard}(;
        name="cheap_thermal",
        id=10,
        available=true,
        power_systems_type="ThermalStandard",
        region=[zone],
        requirements=[req],
        prime_mover_type=PrimeMovers.CT,
        fuel=[ThermalFuels.NATURAL_GAS],
        co2=Dict(ThermalFuels.NATURAL_GAS => 0.05),
        cofire_level_limits=Dict(ThermalFuels.NATURAL_GAS => (min=0.0, max=1.0)),
        capacity_limits=(min=0.0, max=500.0),
        ramp_limits=(up=1.0, down=1.0),
        time_limits=(up=60.0, down=60.0),
        unit_size=100.0,
        capital_costs=LinearCurve(1000.0),
        financial_data=TechnologyFinancialData(
            capital_recovery_period=20,
            technology_base_year=2024,
            debt_fraction=0.6,
            debt_rate=0.05,
            return_on_equity=0.1,
            tax_rate=0.21,
        ),
    )
    refs[10] = tech

    po = PSIP.to_openapi(tech, refs)
    # references leave as ids, not objects
    @test po.region == [1]
    @test po.requirements == [3]
    # the type parameter is carried by power_systems_type, and by nothing else
    @test po.power_systems_type == "ThermalStandard"
    # enums, enum vectors and enum-keyed dicts all cross as strings
    @test po.prime_mover_type == string(PrimeMovers.CT)
    @test po.fuel == [string(ThermalFuels.NATURAL_GAS)]
    @test collect(keys(po.co2)) == [string(ThermalFuels.NATURAL_GAS)]
    # compounds become PC models
    @test po.capacity_limits.max == 500.0
    @test po.ramp_limits.up == 1.0
    # scalars are unscaled: PSIP stores natural units and the document states them
    @test po.unit_size == 100.0

    back = PSIP.from_openapi(po, refs)
    @test PSIP.get_parameter_type(back) === ThermalStandard
    @test PSIP.get_name(back) == "cheap_thermal"
    @test PSIP.get_region(back) == [zone]
    @test PSIP.get_requirements(back) == [req]
    @test PSIP.get_prime_mover_type(back) == PrimeMovers.CT
    @test PSIP.get_fuel(back) == [ThermalFuels.NATURAL_GAS]
    @test PSIP.get_co2(back, NU) == Dict(ThermalFuels.NATURAL_GAS => 0.05)
    @test PSIP.get_capacity_limits(back, NU) == (min=0.0, max=500.0)
    @test PSIP.get_unit_size(back, NU) == 100.0
end

@testset "abstract type parameters survive the round trip" begin
    refs, zone, _, _ = _refs_fixture()
    tech = AggregateTransportTechnology{ACBranch}(;
        name="test_branch",
        id=40,
        available=true,
        power_systems_type="ACBranch",
        start_region=zone,
        end_region=zone,
        financial_data=TechnologyFinancialData(
            capital_recovery_period=20,
            technology_base_year=2024,
            debt_fraction=0.6,
            debt_rate=0.05,
            return_on_equity=0.1,
            tax_rate=0.21,
        ),
    )
    refs[40] = tech

    po = PSIP.to_openapi(tech, refs)
    @test po.start_region == 1
    @test po.power_systems_type == "ACBranch"
    @test PSIP.get_parameter_type(PSIP.from_openapi(po, refs)) === ACBranch
end

@testset "supplemental attribute round trip through OpenAPI" begin
    refs = PSIP.OpenAPIRefs()
    attr = ExistingDevices(id=54, existing_devices=["gen_a", "gen_b"])
    refs[54] = attr
    po = PSIP.to_openapi(attr, refs)
    @test po.id == 54
    @test po.existing_devices == ["gen_a", "gen_b"]
    @test PSIP.get_existing_devices(PSIP.from_openapi(po, refs)) == ["gen_a", "gen_b"]
end

@testset "an unregistered reference errors rather than serializing garbage" begin
    refs = PSIP.OpenAPIRefs()
    orphan = Zone(name="orphan", id=77)
    tech = DemandRequirement{PowerLoad}(;
        name="demand",
        id=78,
        power_systems_type="PowerLoad",
        value_of_lost_load=1e5,
        region=[orphan],
    )
    refs[78] = tech
    @test_throws ErrorException PSIP.to_openapi(tech, refs)
end

@testset "nullable fields round trip through OpenAPI" begin
    # StorageTechnology is the only type with nullable scalar, compound and curve fields
    # (`unit_size_charge`, `capacity_limits_charge`, `capital_costs_charge`); all three
    # default to `nothing`, so an otherwise-default instance exercises every one.
    refs, zone, _, _ = _refs_fixture()
    tech = StorageTechnology{PSY.EnergyReservoirStorage}(;
        name="battery",
        id=20,
        available=true,
        power_systems_type="EnergyReservoirStorage",
        region=[zone],
        financial_data=TechnologyFinancialData(
            capital_recovery_period=20,
            technology_base_year=2024,
            debt_fraction=0.6,
            debt_rate=0.05,
            return_on_equity=0.1,
            tax_rate=0.21,
        ),
    )
    refs[20] = tech

    po = PSIP.to_openapi(tech, refs)
    @test isnothing(po.unit_size_charge)
    @test isnothing(po.capacity_limits_charge)
    @test isnothing(po.capital_costs_charge)
    @test po.storage_tech == string(StorageTech.OTHER_CHEM)
    @test po.efficiency.in == 1

    back = PSIP.from_openapi(po, refs)
    @test PSIP.get_parameter_type(back) === PSY.EnergyReservoirStorage
    @test isnothing(PSIP.get_unit_size_charge(back, NU))
    @test isnothing(PSIP.get_capacity_limits_charge(back, NU))
    @test isnothing(PSIP.get_capital_costs_charge(back, NU))
    @test PSIP.get_storage_tech(back) == StorageTech.OTHER_CHEM
end

@testset "duplicate component ids are rejected on addition" begin
    # A component's `id` is the identity `IS.SystemData` stores it under, so a region and a
    # requirement sharing one collide when the second is attached — before any document is
    # built. `_validate_unique_region_id` (src/validation.jl) only covers `RegionTopology`,
    # so this cross-family case is the container's check.
    portfolio = Portfolio()
    PSIP.add_region!(portfolio, Zone(name="zone_a", id=1))
    @test_throws ArgumentError PSIP.add_requirement!(
        portfolio,
        CarbonTax(name="tax", id=1, available=true),
    )
end

@testset "every generated type has both OpenAPI converters" begin
    descriptor =
        JSON3.read(joinpath(BASE_DIR, "src", "descriptors", "SiennaInvestSchema.json"))
    for component in descriptor["components"]
        type = getproperty(PSIP, Symbol(component["name"]))
        # `from_openapi` now dispatches on the OpenAPI wire type, not the target PSIP type.
        wire_type = PSIP._openapi_wire_type(type)
        @test hasmethod(PSIP.from_openapi, Tuple{wire_type, PSIP.OpenAPIRefs})
        @test !isempty(methods(PSIP.to_openapi, (type, PSIP.OpenAPIRefs)))
        # `methods` matches by signature INTERSECTION, so the check above still passes when
        # the emitted `where` bound names the wrong PSY supertype — the resulting
        # MethodError would only surface on a real save. Compare the bound the generator
        # actually wrote against the descriptor's `parametric` key.
        if haskey(component, :parametric)
            expected = Base.eval(PSIP, Meta.parse(String(component["parametric"])))
            signature = only(methods(PSIP.to_openapi, (type, PSIP.OpenAPIRefs))).sig
            @test signature.var.ub === expected
            # The method's bound and the struct's own bound are separate runtime facts
            # emitted from one descriptor key; a template that ever sourced them
            # differently would show up here and nowhere else.
            @test signature.var.ub === type.var.ub
        end
    end
end

@testset "available defaults to true when the kwarg is omitted" begin
    # The descriptor once defaulted `available` to the Python literal "True", which the
    # generator copied through verbatim into an UndefVarError at construction time.
    financials = TechnologyFinancialData(
        capital_recovery_period=20,
        technology_base_year=2024,
        debt_fraction=0.6,
        debt_rate=0.05,
        return_on_equity=0.1,
        tax_rate=0.21,
    )
    supply = SupplyTechnology{ThermalStandard}(;
        name="default_available_supply",
        id=90,
        power_systems_type="ThermalStandard",
        financial_data=financials,
    )
    @test PSIP.get_available(supply) === true

    colocated = ColocatedSupplyStorageTechnology{RenewableDispatch}(;
        name="default_available_colocated",
        id=91,
        power_systems_type="RenewableDispatch",
        financial_data=financials,
        capital_costs_inverter=LinearCurve(1000.0),
        operation_costs_inverter=CostCurve(LinearCurve(0.0)),
        inverter_efficiency=0.98,
        inverter_supply_ratio=1.2,
    )
    @test PSIP.get_available(colocated) === true
end

@testset "portfolio round trips through the OpenAPI serialization path" begin
    # Financial data is not optional on the read-back path: `from_dict` indexes into the
    # serialized `financial_data` object, so an empty `Portfolio()` cannot round trip.
    portfolio = Portfolio(2024, 0.07, 0.025, 0.05)
    zone = Zone(name="zone_a", id=1)
    zone_b = Zone(name="zone_b", id=2)
    req = CarbonTax(name="tax", id=3, available=true)
    PSIP.add_region!(portfolio, zone)
    PSIP.add_region!(portfolio, zone_b)
    PSIP.add_requirement!(portfolio, req)
    financial_data = TechnologyFinancialData(
        capital_recovery_period=20,
        technology_base_year=2024,
        debt_fraction=0.6,
        debt_rate=0.05,
        return_on_equity=0.1,
        tax_rate=0.21,
    )
    tech = SupplyTechnology{ThermalStandard}(;
        name="cheap_thermal",
        id=10,
        available=true,
        power_systems_type="ThermalStandard",
        region=[zone],
        requirements=[req],
        capacity_limits=(min=0.0, max=500.0),
        capital_costs=LinearCurve(1000.0),
        operation_costs=PSY.ThermalGenerationCost(nothing),
        fuel=[ThermalFuels.NATURAL_GAS],
        co2=Dict(ThermalFuels.NATURAL_GAS => 0.05),
        cofire_level_limits=Dict(ThermalFuels.NATURAL_GAS => (min=0.0, max=1.0)),
        financial_data=financial_data,
    )
    PSIP.add_technology!(portfolio, tech)

    # A transmission technology exercises the scalar `component_id`/`resolve_ref` path;
    # `SupplyTechnology` above only covers the `component_ids`/`resolve_refs` list form.
    line = AggregateTransportTechnology{PSY.ACBranch}(;
        name="test_branch",
        id=11,
        available=true,
        power_systems_type="ACBranch",
        start_region=zone,
        end_region=zone_b,
        capacity_limits=(min=0.0, max=900.0),
        line_loss=0.05,
        capital_costs=LinearCurve(5000.0),
        financial_data=financial_data,
    )
    PSIP.add_technology!(portfolio, line)

    # The only technology whose `operation_costs_*` fields span all three cost shapes the
    # converters emit: `RenewableGenerationCost` (solar/wind), `StorageCost`
    # (energy/power), and a bare `ProductionVariableCostCurve` (inverter). It could not be
    # read back at all while the descriptor typed the inverter field `PSY.OperationalCost`.
    colocated = ColocatedSupplyStorageTechnology{PSY.RenewableDispatch}(;
        name="colo",
        id=12,
        available=true,
        power_systems_type="RenewableDispatch",
        region=[zone],
        financial_data=financial_data,
        capital_costs_solar=LinearCurve(1300.0),
        operation_costs_solar=PSY.RenewableGenerationCost(
            CostCurve(LinearCurve(5.0)),
            CostCurve(LinearCurve(0.5)),
            10.0,
        ),
        operation_costs_wind=PSY.RenewableGenerationCost(nothing),
        operation_costs_energy=PSY.StorageCost(; fixed=4.0),
        operation_costs_power=PSY.StorageCost(; fixed=5.0),
        capital_costs_inverter=LinearCurve(700.0),
        operation_costs_inverter=CostCurve(LinearCurve(6.0)),
        inverter_efficiency=0.96,
        inverter_supply_ratio=1.0,
    )
    PSIP.add_technology!(portfolio, colocated)

    retirement = AggregateRetirementPotential(id=51, retirement_potential=100.0)
    existing = ExistingDevices(id=54, existing_devices=["Solitude", "Alta"])
    PSIP.add_supplemental_attribute!(portfolio, tech, retirement)
    PSIP.add_supplemental_attribute!(portfolio, line, existing)

    path = joinpath(mktempdir(), "portfolio.json")
    PSIP.to_json(portfolio, path; force=true)
    portfolio2 = Portfolio(path)

    @test PSIP.get_aggregation(portfolio2) === PSIP.get_aggregation(portfolio)

    tech2 =
        PSIP.get_technology(SupplyTechnology{ThermalStandard}, portfolio2, "cheap_thermal")
    @test !isnothing(tech2)
    @test PSIP.get_capacity_limits(tech2, IS.NU) == (min=0.0, max=500.0)
    # nested value curves and operational costs survive the JSON round trip
    @test PSIP.get_capital_costs(tech2, IS.NU) == LinearCurve(1000.0)
    @test get_variable(PSIP.get_operation_costs(tech2, IS.NU)) ==
          get_variable(PSY.ThermalGenerationCost(nothing))
    @test PSIP.get_co2(tech2, IS.NU) == Dict(ThermalFuels.NATURAL_GAS => 0.05)
    @test PSIP.get_cofire_level_limits(tech2) ==
          Dict(ThermalFuels.NATURAL_GAS => (min=0.0, max=1.0))
    # references resolve to the deserialized objects, not to copies
    zone2 = PSIP.get_region(Zone, portfolio2, "zone_a")
    @test PSIP.get_region(tech2) == [zone2]
    req2 = PSIP.get_requirement(CarbonTax, portfolio2, "tax")
    @test has_requirement(tech2, req2)
    # scalar references resolve too, not just the list form
    line2 = PSIP.get_technology(
        AggregateTransportTechnology{PSY.ACBranch},
        portfolio2,
        "test_branch",
    )
    @test !isnothing(line2)
    @test PSIP.get_start_region(line2) == zone2
    @test PSIP.get_end_region(line2) == PSIP.get_region(Zone, portfolio2, "zone_b")
    @test PSIP.get_capital_costs(line2, IS.NU) == LinearCurve(5000.0)

    # supplemental attributes take the same route as components in both directions
    retirement2 =
        only(PSIP.get_supplemental_attributes(AggregateRetirementPotential, portfolio2))
    @test PSIP.get_id(retirement2) == 51
    @test PSIP.get_retirement_potential(retirement2, IS.NU) == 100.0
    existing2 = only(PSIP.get_supplemental_attributes(ExistingDevices, portfolio2))
    @test PSIP.get_id(existing2) == 54
    @test PSIP.get_existing_devices(existing2) == ["Solitude", "Alta"]

    colocated2 = PSIP.get_technology(
        ColocatedSupplyStorageTechnology{PSY.RenewableDispatch},
        portfolio2,
        "colo",
    )
    @test !isnothing(colocated2)
    @test PSIP.get_capital_costs_inverter(colocated2, IS.NU) == LinearCurve(700.0)
    # a `ProductionVariableCostCurve` field comes back as the same concrete curve type,
    # value and `power_units` intact
    inverter_cost = PSIP.get_operation_costs_inverter(colocated2, IS.NU)
    @test inverter_cost isa CostCurve
    @test get_value_curve(inverter_cost) == LinearCurve(6.0)
    @test get_power_units(inverter_cost) == get_power_units(CostCurve(LinearCurve(6.0)))
    # solar/wind stay `RenewableGenerationCost` rather than silently becoming a different
    # cost type with `curtailment_cost` replaced by `start_up`/`shut_down`
    solar_cost = PSIP.get_operation_costs_solar(colocated2, IS.NU)
    @test solar_cost isa PSY.RenewableGenerationCost
    @test get_variable(solar_cost) == CostCurve(LinearCurve(5.0))
    @test PSY.get_curtailment_cost(solar_cost) == CostCurve(LinearCurve(0.5))
    @test get_fixed(solar_cost) == 10.0
    @test PSIP.get_operation_costs_wind(colocated2, IS.NU) isa PSY.RenewableGenerationCost
    energy_cost = PSIP.get_operation_costs_energy(colocated2, IS.NU)
    @test energy_cost isa PSY.StorageCost
    @test get_fixed(energy_cost) == 4.0
    @test get_fixed(PSIP.get_operation_costs_power(colocated2, IS.NU)) == 5.0

    @test only(PSIP.get_supplemental_attributes(AggregateRetirementPotential, tech2)) ==
          retirement2
    @test only(PSIP.get_supplemental_attributes(ExistingDevices, line2)) == existing2

    # The document id IS the component's id after the round trip, components and attributes
    # alike, so the reloaded objects carry the same identity the document stated.
    @test IS.get_id(tech2) == 10
    @test IS.get_id(line2) == 11
    @test IS.get_id(retirement2) == 51
end

@testset "serialized aggregation is a fully qualified type name" begin
    # `Portfolio.aggregation` is a `Type`, and `IS` has no `serialize(::Type)` method, so
    # without an explicit emission JSON3 stringifies it through `show` — which resolves the
    # name against `Base.active_module()`. A writing session with `using PowerSystems` in
    # scope (the normal Sienna workflow) would then write the bare `"ACBus"`, which
    # `_deserialize_type_name` rejects, and the same portfolio would serialize differently
    # depending on who wrote it.
    #
    # The assertion is on the DOCUMENT TEXT, not on a round trip: ReTest's `Main` has no
    # `using PowerSystems`, so the `show` path happens to produce the qualified form here
    # and a round-trip-only test would pass either way. That is exactly how this got through.
    @test PSIP._serialize_type_name(PSY.ACBus) == "PowerSystems.ACBus"
    @test PSIP._serialize_type_name(PSY.Area) == "PowerSystems.Area"

    for aggregation in (PSY.ACBus, PSY.Area)
        portfolio = Portfolio(
            aggregation;
            financial_data=PortfolioFinancialData(2024, 0.07, 0.025, 0.05),
        )
        PSIP.add_region!(portfolio, Zone(name="zone_a", id=1))
        path = joinpath(mktempdir(), "portfolio.json")
        PSIP.to_json(portfolio, path; force=true)

        raw = JSON3.read(read(path, String), Dict)
        @test raw["aggregation"] == "PowerSystems.$(nameof(aggregation))"
        @test PSIP.get_aggregation(Portfolio(path)) === aggregation
    end
end

@testset "serializing a lone component names the supported entry point" begin
    zone = Zone(name="orphan", id=1)
    # @test_logs captures the intentional `@error` from to_json so the harness
    # LogEventTracker does not count it as a real error.
    err = @test_logs(
        (:error, r"Failed to serialize"),
        min_level = Logging.Error,
        try
            PSIP.to_json(zone)
            nothing
        catch e
            e
        end,
    )
    @test err isa ErrorException
    @test occursin("no active OpenAPI export registry", err.msg)
    @test occursin("to_json(portfolio, filename)", err.msg)
end
