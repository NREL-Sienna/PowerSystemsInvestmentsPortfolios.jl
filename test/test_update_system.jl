@testset "update_system_with_nodal_results!" begin
    p = build_portfolio()
    sys = get_base_system(p)

    thermals = collect(get_components(PSY.ThermalStandard, sys))
    renewables = collect(get_components(PSY.RenewableDispatch, sys))
    @test !isempty(thermals)
    @test !isempty(renewables)

    # ----- ThermalStandard: update existing generator -----
    g = first(thermals)
    gname = PSY.get_name(g)
    gbus_name = PSY.get_name(PSY.get_bus(g))
    rating_before = PSY.get_rating(g, u"MW")
    _, maxp_before = PSY.get_active_power_limits(g, u"MW")
    add_cap = 40.0
    PSIP.update_or_create_new_generator!(
        PSY.ThermalStandard, sys, p, gbus_name, "cheap_thermal", gname, add_cap,
    )
    @test PSY.get_rating(g, u"MW") ≈ rating_before + add_cap
    _, maxp_after = PSY.get_active_power_limits(g, u"MW")
    @test maxp_after ≈ maxp_before + add_cap

    # ----- ThermalStandard: create new generator -----
    @test isnothing(PSY.get_component(PSY.ThermalStandard, sys, "new_thermal_unit"))
    PSIP.update_or_create_new_generator!(
        PSY.ThermalStandard, sys, p, gbus_name, "cheap_thermal", "new_thermal_unit", 120.0,
    )
    newg = PSY.get_component(PSY.ThermalStandard, sys, "new_thermal_unit")
    @test !isnothing(newg)
    @test PSY.get_rating(newg, u"MW") ≈ 120.0
    _, newg_max = PSY.get_active_power_limits(newg, u"MW")
    @test newg_max ≈ 120.0

    # ----- RenewableDispatch: update existing generator -----
    r = first(renewables)
    rname = PSY.get_name(r)
    rbus_name = PSY.get_name(PSY.get_bus(r))
    rrating_before = PSY.get_rating(r, u"MW")
    PSIP.update_or_create_new_generator!(
        PSY.RenewableDispatch, sys, p, rbus_name, "wind", rname, 25.0,
    )
    @test PSY.get_rating(r, u"MW") ≈ rrating_before + 25.0

    # ----- RenewableDispatch: create new (exercises add_renewable_timeseries!) -----
    wind_tech = get_technology(SupplyTechnology{PSY.RenewableDispatch}, p, "wind")
    # The create path reads a "capacity_factor" time series off the technology.
    tstamps = collect(DateTime(2024, 1, 1):Hour(1):DateTime(2024, 1, 1, 23))
    cf_ts = SingleTimeSeries("capacity_factor", TimeArray(tstamps, fill(0.5, 24)))
    PSIP.add_time_series!(p, wind_tech, cf_ts)

    @test isnothing(PSY.get_component(PSY.RenewableDispatch, sys, "new_wind_unit"))
    PSIP.update_or_create_new_generator!(
        PSY.RenewableDispatch, sys, p, rbus_name, "wind", "new_wind_unit", 80.0,
    )
    newr = PSY.get_component(PSY.RenewableDispatch, sys, "new_wind_unit")
    @test !isnothing(newr)
    @test PSY.get_rating(newr, u"MW") ≈ 80.0
    @test PSY.has_time_series(newr)
    @test PSY.get_time_series_array(SingleTimeSeries, newr, "max_active_power") !== nothing

    # ----- top-level wrapper over a solutions Dict -----
    # key = (tech_type, node, tech_name, unit_name); only node.name is used.
    node = (name=gbus_name,)
    solutions = Dict(
        (SupplyTechnology{PSY.ThermalStandard}, node, "cheap_thermal", "wrapper_thermal") =>
            60.0,
    )
    PSIP.update_system_with_nodal_results!(sys, p, solutions)
    wrapped = PSY.get_component(PSY.ThermalStandard, sys, "wrapper_thermal")
    @test !isnothing(wrapped)
    @test PSY.get_rating(wrapped, u"MW") ≈ 60.0
end
