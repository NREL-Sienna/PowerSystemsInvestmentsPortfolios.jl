function build_portfolio()
    sys = build_system(PSITestSystems, "c_sys5_re")
    set_units_base_system!(sys, "NATURAL_UNITS")

    ###################
    ### Zones ###
    ###################

    z1 = Zone(name="Zone_1", id=1)

    z2 = Zone(name="Zone_2", id=2)

    ###################
    ### Time Series ###
    ###################

    tstamp_2024_ops = collect(
        DateTime("1/1/2024  0:00:00", "d/m/y  H:M:S"):Hour(1):DateTime(
            "1/1/2024  23:00:00",
            "d/m/y  H:M:S",
        ),
    )
    tstamp_2028_ops = collect(
        DateTime("1/1/2028  0:00:00", "d/m/y  H:M:S"):Hour(1):DateTime(
            "1/1/2028  23:00:00",
            "d/m/y  H:M:S",
        ),
    )

    tstamp_ops = vcat(tstamp_2024_ops, tstamp_2028_ops)
    tstamp_inv = [
        DateTime("1/1/2024  0:00:00", "d/m/y  H:M:S"),
        DateTime("1/1/2028  0:00:00", "d/m/y  H:M:S"),
    ]

    ####################
    ##### Thermals #####
    ####################

    tech_financials =
        TechnologyFinancialData(; capital_recovery_period=30, technology_base_year=2025)

    thermals = collect(get_components(ThermalStandard, sys))
    var_cost = PSY.get_variable.((get_operation_cost.((thermals))))
    op_cost = get_proportional_term.(get_value_curve.(var_cost))

    cheap_th_ixs = 2:4
    exp_th_ixs = [1, 5]
    cheap_th_var_cost = mean(op_cost[cheap_th_ixs])
    exp_th_var_cost = mean(op_cost[exp_th_ixs])

    # initial_cap_cheap = sum(get_max_active_power.(thermals[cheap_th_ixs]))
    # initial_cap_exp = sum(get_max_active_power.(thermals[exp_th_ixs]))
    initial_cap_cheap = 100.0
    initial_cap_exp = 100.0
    # From Conservative 2024-ABT CAPEX: year 2024
    coal_igcc_capex = 6937.377 # $/kW
    coal_new_capex = 3823.56 # $/kW

    coal_igcc_capex_2028 = 6869.263 # $/kW
    coal_new_capex_2028 = 3664.307 # $/kW

    ts_th_cheap_inv_capex = SingleTimeSeries(
        "inv_capex",
        TimeArray(tstamp_inv, [1.0, coal_igcc_capex / coal_igcc_capex_2028]),
    )
    #
    ts_th_exp_inv_capex = SingleTimeSeries(
        "inv_capex",
        TimeArray(tstamp_inv, [1.0, coal_new_capex / coal_new_capex_2028]),
    )
    #, coal_new_capex / coal_new_capex_2028
    t_th = SupplyTechnology{ThermalStandard}(;
        base_power=1.0, # Natural Units
        prime_mover_type=PrimeMovers.ST,
        capital_costs=LinearCurve(coal_igcc_capex * 1000.0),
        id=1,
        available=true,
        name="cheap_thermal",
        initial_capacity=initial_cap_cheap,
        fuel=[ThermalFuels.COAL],
        power_systems_type="ThermalStandard",
        balancing_topology="Region",
        operation_costs=ThermalGenerationCost(
            variable=CostCurve(LinearCurve(cheap_th_var_cost)),
            fixed=0.0,
            start_up=0.0,
            shut_down=0.0,
        ),#LinearCurve(0.0),
        capacity_limits=(0.0, 3000.0),
        outage_factor=0.92,
        region=[z1],
        unit_size=250.0,
        financial_data=tech_financials,
    )

    t_th_exp = SupplyTechnology{ThermalStandard}(;
        base_power=1.0, # Natural Units
        prime_mover_type=PrimeMovers.ST,
        capital_costs=LinearCurve(coal_new_capex * 1000.0),
        id=2,
        available=true,
        name="expensive_thermal",
        initial_capacity=initial_cap_exp,
        fuel=[ThermalFuels.COAL],
        power_systems_type="ThermalStandard",
        balancing_topology="Region",
        operation_costs=ThermalGenerationCost(
            variable=CostCurve(LinearCurve(exp_th_var_cost)),
            fixed=0.0,
            start_up=0.0,
            shut_down=0.0,
        ),
        capacity_limits=(0.0, 3000.0),
        outage_factor=0.95,
        region=[z2],
        unit_size=75.0,
        financial_data=tech_financials,
    )

    ts_thermal_2024 = SingleTimeSeries(;
        data=TimeArray(tstamp_2024_ops, ones(24)),
        name="ops_variable_cap_factor",
        scaling_factor_multiplier=get_initial_capacity,
    )
    ts_thermal_2028 = SingleTimeSeries(;
        data=TimeArray(tstamp_2028_ops, ones(24)),
        name="ops_variable_cap_factor",
        scaling_factor_multiplier=get_initial_capacity,
    )
    #####################
    ##### Renewable #####
    #####################

    #### Wind ####
    wind_ts = CSV.read(
        "./data_utils/wind_ts_LDES.csv",
        DataFrame,
    )
    wind_ts_vec = wind_ts[!, "Wind"] ./ 451.0
    renewables = collect(get_components(RenewableDispatch, sys))
    wind_op_costs =
        get_proportional_term.(
            get_value_curve.(PSY.get_variable.((get_operation_cost.((renewables)))))
        )
    wind_op_cost = mean(wind_op_costs)
    # initial_cap_wind = sum(get_max_active_power.(renewables))
    initial_cap_wind = 0.0
    # From Conservative 2024-ABT CAPEX: year 2024 for Wind Class 4 Technology 1
    wind_capex = 1577.392 # $/kW
    wind_capex_2028 = 1522.152 #

    ts_wind_2024_data = wind_ts_vec[1:24]
    ts_wind_2028_data = wind_ts_vec[1:24]

    #ts_wind = SingleTimeSeries("ops_variable_cap_factor", TimeArray(tstamp_ops, vcat(ts_wind_2024, ts_wind_2028)))
    ts_wind_2024 = SingleTimeSeries(;
        data=TimeArray(tstamp_2024_ops, ts_wind_2024_data),
        name="ops_variable_cap_factor",
        scaling_factor_multiplier=get_initial_capacity,
    )
    ts_wind_2028 = SingleTimeSeries(;
        data=TimeArray(tstamp_2028_ops, ts_wind_2028_data),
        name="ops_variable_cap_factor",
        scaling_factor_multiplier=get_initial_capacity,
    )

    ts_wind_inv_capex = SingleTimeSeries(
        "inv_capex",
        TimeArray(tstamp_inv, [1.0, wind_capex / wind_capex_2028]),
    )

    t_wind = SupplyTechnology{RenewableDispatch}(;
        base_power=1.0, # Natural Units
        prime_mover_type=PrimeMovers.WT,
        capital_costs=LinearCurve(wind_capex * 1000.0), # to $/MW
        id=3,
        available=true,
        name="wind",
        initial_capacity=initial_cap_wind,
        fuel=[ThermalFuels.OTHER],
        power_systems_type="RenewableDispatch",
        balancing_topology="Region",
        operation_costs=ThermalGenerationCost(
            variable=CostCurve(LinearCurve(0.0)),
            fixed=wind_op_cost,
            start_up=0.0,
            shut_down=0.0,
        ),
        capacity_limits=(0.0, 300.0),
        outage_factor=0.92,
        region=[z2],
        financial_data=tech_financials,
    )

    #### Solar ####
    pv_ts = CSV.read(
        "./data_utils/solar_ts_LDES.csv",
        DataFrame,
    )
    pv1_ts = pv_ts[!, "SolarPV1"] ./ 384.0
    pv2_ts = pv_ts[!, "SolarPV2"] ./ 384.0

    pv1_op_costs = 0.0
    pv2_op_costs = 000
    initial_cap_pv1 = 0.0
    initial_cap_pv2 = 0.0
    # From Conservative 2024-ABT CAPEX: year 2024 for Utility PV Class 4 
    pv_capex = 1575.766 # $/kW
    pv_capex_2028 = 1189.247 #

    ts_pv1_2024_data = pv1_ts[1:24]
    ts_pv1_2028_data = pv1_ts[1:24]
    ts_pv2_2024_data = pv2_ts[1:24]
    ts_pv2_2028_data = pv2_ts[1:24]

    #ts_wind = SingleTimeSeries("ops_variable_cap_factor", TimeArray(tstamp_ops, vcat(ts_wind_2024, ts_wind_2028)))
    ts_pv1_2024 = SingleTimeSeries(;
        data=TimeArray(tstamp_2024_ops, ts_pv1_2024_data),
        name="ops_variable_cap_factor",
        scaling_factor_multiplier=get_initial_capacity,
    )
    ts_pv1_2028 = SingleTimeSeries(;
        data=TimeArray(tstamp_2028_ops, ts_pv1_2028_data),
        name="ops_variable_cap_factor",
        scaling_factor_multiplier=get_initial_capacity,
    )

    ts_pv2_2024 = SingleTimeSeries(;
        data=TimeArray(tstamp_2024_ops, ts_pv2_2024_data),
        name="ops_variable_cap_factor",
        scaling_factor_multiplier=get_initial_capacity,
    )
    ts_pv2_2028 = SingleTimeSeries(;
        data=TimeArray(tstamp_2028_ops, ts_pv2_2028_data),
        name="ops_variable_cap_factor",
        scaling_factor_multiplier=get_initial_capacity,
    )

    ts_pv1_inv_capex = SingleTimeSeries(
        "inv_capex",
        TimeArray(tstamp_inv, [1.0, pv_capex / pv_capex_2028]),
    )
    ts_pv2_inv_capex = SingleTimeSeries(
        "inv_capex",
        TimeArray(tstamp_inv, [1.0, pv_capex / pv_capex_2028]),
    )

    t_pv1 = SupplyTechnology{RenewableDispatch}(;
        base_power=1.0, # Natural Units
        prime_mover_type=PrimeMovers.PVe,
        capital_costs=LinearCurve(pv_capex * 1000.0), # to $/MW
        id=4,
        available=true,
        name="PV1",
        initial_capacity=initial_cap_pv1,
        fuel=[ThermalFuels.OTHER],
        power_systems_type="RenewableDispatch",
        balancing_topology="Region",
        operation_costs=ThermalGenerationCost(
            variable=CostCurve(LinearCurve(0.0)),
            fixed=0.0,
            start_up=0.0,
            shut_down=0.0,
        ),
        capacity_limits=(0.0, 1e8),
        outage_factor=0.92,
        region=[z1],
        financial_data=tech_financials,
    )

    t_pv2 = SupplyTechnology{RenewableDispatch}(;
        base_power=1.0, # Natural Units
        prime_mover_type=PrimeMovers.PVe,
        capital_costs=LinearCurve(pv_capex * 1000.0), # to $/MW
        id=5,
        available=true,
        name="PV2",
        initial_capacity=initial_cap_pv2,
        fuel=[ThermalFuels.OTHER],
        power_systems_type="RenewableDispatch",
        balancing_topology="Region",
        operation_costs=ThermalGenerationCost(
            variable=CostCurve(LinearCurve(0.0)),
            fixed=0.0,
            start_up=0.0,
            shut_down=0.0,
        ),
        capacity_limits=(0.0, 1e8),
        outage_factor=0.92,
        region=[z2],
        financial_data=tech_financials,
    )

    ########################
    ######## Storage #######
    ########################
    stor_kw_capex = 1343.15 #$/kW
    stor_kwh_capex = 745.25 #$/kW
    t_stor = StorageTechnology{EnergyReservoirStorage}(;
        name="test_storage",
        base_power=1.0,
        id=1,
        region=[z1],
        storage_tech=StorageTech.LIB,
        existing_capacity_energy=0.0,
        existing_capacity_power=0.0,
        capacity_power_limits=(0.0, 300.0),
        capacity_energy_limits=(0.0, 1000.0),
        power_systems_type="EnergyReservoirStorage",
        balancing_topology="Region",
        prime_mover_type=PrimeMovers.BT,
        available=true,
        capital_costs_power=LinearCurve(stor_kw_capex * 1000),
        capital_costs_energy=LinearCurve(stor_kwh_capex * 1000),
        operations_costs_energy=StorageCost(
            charge_variable_cost=CostCurve(LinearCurve(0.0)),
            discharge_variable_cost=CostCurve(LinearCurve(0.0)),
            fixed=0.0,
        ),
        operations_costs_power=StorageCost(
            charge_variable_cost=CostCurve(LinearCurve(0.0)),
            discharge_variable_cost=CostCurve(LinearCurve(0.0)),
            fixed=0.0,
        ),
        unit_size_power=10.0,
        unit_size_energy=10.0,
        financial_data=tech_financials,
    )
    ts_sto_2024 = SingleTimeSeries(;
        data=TimeArray(tstamp_2024_ops, ts_wind_2024_data),
        name="ops_variable_cap_factor",
        scaling_factor_multiplier=get_initial_capacity,
    )
    ts_sto_2028 = SingleTimeSeries(;
        data=TimeArray(tstamp_2028_ops, ts_wind_2028_data),
        name="ops_variable_cap_factor",
        scaling_factor_multiplier=get_initial_capacity,
    )

    #####################
    ######## Load #######
    #####################

    loads = collect(get_components(PowerLoad, sys))

    load_ts = CSV.read(
        "./data_utils/load_ts_LDES.csv",
        DataFrame,
    )
    load_b_ts = load_ts[!, "node_b"]
    load_c_ts = load_ts[!, "node_c"]
    load_d_ts = load_ts[!, "node_d"]

    ts_load_b_2024 = load_b_ts[1:24]
    ts_load_b_2028 = load_b_ts[1:24]

    ts_load_c_2024 = load_c_ts[1:24]
    ts_load_c_2028 = load_c_ts[1:24]

    ts_load_d_2024 = load_d_ts[1:24]
    ts_load_d_2028 = load_d_ts[1:24]

    ts_demand_b_2024 = SingleTimeSeries(
        "ops_peak_load",
        TimeArray(tstamp_2024_ops, ts_load_b_2024),
        #scaling_factor_multiplier=get_peak_load,
    )
    ts_demand_b_2028 = SingleTimeSeries(
        "ops_peak_load",
        TimeArray(tstamp_2028_ops, ts_load_b_2028),
        #scaling_factor_multiplier=get_peak_load,
    )

    t_demand_b = DemandRequirement{PowerLoad}(
        #load_growth=0.05,
        name="demand_b",
        id=1,
        available=true,
        power_systems_type="PowerLoad",
        region=[z1],
        value_of_lost_load=0.0,
        #peak_load=peak_load,
    )

    ts_demand_c_2024 = SingleTimeSeries(
        "ops_peak_load",
        TimeArray(tstamp_2024_ops, ts_load_c_2024),
        #scaling_factor_multiplier=get_peak_load,
    )
    ts_demand_c_2028 = SingleTimeSeries(
        "ops_peak_load",
        TimeArray(tstamp_2028_ops, ts_load_c_2028),
        #scaling_factor_multiplier=get_peak_load,
    )

    t_demand_c = DemandRequirement{PowerLoad}(
        #load_growth=0.05,
        name="demand_c",
        id=2,
        available=true,
        power_systems_type="PowerLoad",
        region=[z1],
        value_of_lost_load=0.0,

        #peak_load=peak_load,
    )

    ts_demand_d_2024 = SingleTimeSeries(
        "ops_peak_load",
        TimeArray(tstamp_2024_ops, ts_load_d_2024),
        #scaling_factor_multiplier=get_peak_load,
    )
    ts_demand_d_2028 = SingleTimeSeries(
        "ops_peak_load",
        TimeArray(tstamp_2028_ops, ts_load_d_2028),
        #scaling_factor_multiplier=get_peak_load,
    )

    t_demand_d = DemandRequirement{PowerLoad}(
        #load_growth=0.05,
        name="demand_d",
        id=3,
        available=true,
        power_systems_type="PowerLoad",
        region=[z2],
        value_of_lost_load=0.0,

        #peak_load=peak_load,
    )

    ####################
    ##### Transmission #####
    #####################

    line = ACTransportTechnology{ACBranch}(
        name="test_branch",
        start_region=z1,
        end_region=z2,
        existing_line_capacity=100,
        maximum_new_capacity=900,
        line_loss=0.05,
        capital_cost=LinearCurve(5000.0),
        available=true,
        power_systems_type="TransportTechnology",
        id=1,
        base_power=1.0,
        financial_data=tech_financials,
    )

    ts_line_2024 = SingleTimeSeries(;
        data=TimeArray(tstamp_2024_ops, ts_wind_2024_data),
        name="ops_variable_cap_factor",
        scaling_factor_multiplier=get_initial_capacity,
    )
    ts_line_2028 = SingleTimeSeries(;
        data=TimeArray(tstamp_2028_ops, ts_wind_2028_data),
        name="ops_variable_cap_factor",
        scaling_factor_multiplier=get_initial_capacity,
    )

    finances = PortfolioFinancialData(2025, 0.07, 0.05, 0.03)

    #####################
    ##### Portfolio #####
    #####################

    p_5bus = Portfolio(2025, 0.07, 0.05, 0.03)

    PSIP.set_name!(p_5bus, "test")
    #PSIP.add_financials!(p_5bus, finances)
    #PSIP.add_financials!(p_5bus, tech_financials)
    PSIP.add_region!(p_5bus, z1)
    PSIP.add_region!(p_5bus, z2)
    PSIP.add_technology!(p_5bus, t_th)
    PSIP.add_technology!(p_5bus, t_wind)
    PSIP.add_technology!(p_5bus, t_pv1)
    PSIP.add_technology!(p_5bus, t_pv2)
    PSIP.add_technology!(p_5bus, t_th_exp)
    PSIP.add_technology!(p_5bus, t_demand_b)
    PSIP.add_technology!(p_5bus, t_demand_c)
    PSIP.add_technology!(p_5bus, t_demand_d)
    PSIP.add_technology!(p_5bus, t_stor)
    PSIP.add_technology!(p_5bus, line)

    PSIP.add_time_series!(p_5bus, t_th, ts_th_cheap_inv_capex)
    PSIP.add_time_series!(p_5bus, t_th_exp, ts_th_exp_inv_capex)
    PSIP.add_time_series!(p_5bus, t_th, ts_thermal_2024; year="2024", rep_day=1)
    PSIP.add_time_series!(p_5bus, t_th, ts_thermal_2028; year="2028", rep_day=2)
    PSIP.add_time_series!(p_5bus, t_th_exp, ts_thermal_2024; year="2024", rep_day=1)
    PSIP.add_time_series!(p_5bus, t_th_exp, ts_thermal_2028; year="2028", rep_day=2)

    PSIP.add_time_series!(p_5bus, t_wind, ts_wind_2024; year="2024", rep_day=1)
    PSIP.add_time_series!(p_5bus, t_wind, ts_wind_2028; year="2028", rep_day=2)
    PSIP.add_time_series!(p_5bus, t_wind, ts_wind_inv_capex)

    PSIP.add_time_series!(p_5bus, t_pv1, ts_pv1_2024; year="2024", rep_day=1)
    PSIP.add_time_series!(p_5bus, t_pv1, ts_pv1_2028; year="2028", rep_day=2)
    PSIP.add_time_series!(p_5bus, t_pv1, ts_pv1_inv_capex)
    PSIP.add_time_series!(p_5bus, t_pv2, ts_pv2_2024; year="2024", rep_day=1)
    PSIP.add_time_series!(p_5bus, t_pv2, ts_pv2_2028; year="2028", rep_day=2)
    PSIP.add_time_series!(p_5bus, t_pv2, ts_pv2_inv_capex)

    PSIP.add_time_series!(p_5bus, t_stor, ts_sto_2024; year="2024", rep_day=1)
    PSIP.add_time_series!(p_5bus, t_stor, ts_sto_2028; year="2028", rep_day=2)

    PSIP.add_time_series!(p_5bus, line, ts_line_2024; year="2024", rep_day=1)
    PSIP.add_time_series!(p_5bus, line, ts_line_2028; year="2028", rep_day=2)

    PSIP.add_time_series!(p_5bus, t_demand_b, ts_demand_b_2024; year="2024", rep_day=1)
    PSIP.add_time_series!(p_5bus, t_demand_b, ts_demand_b_2028; year="2028", rep_day=2)
    PSIP.add_time_series!(p_5bus, t_demand_c, ts_demand_c_2024; year="2024", rep_day=1)
    PSIP.add_time_series!(p_5bus, t_demand_c, ts_demand_c_2028; year="2028", rep_day=2)
    PSIP.add_time_series!(p_5bus, t_demand_d, ts_demand_d_2024; year="2024", rep_day=1)
    PSIP.add_time_series!(p_5bus, t_demand_d, ts_demand_d_2028; year="2028", rep_day=2)

    PSIP.add_time_series!(p_5bus, t_th, ts_thermal_2024; year="2024", rep_day=3)
    PSIP.add_time_series!(p_5bus, t_th, ts_thermal_2028; year="2028", rep_day=4)
    PSIP.add_time_series!(p_5bus, t_th_exp, ts_thermal_2024; year="2024", rep_day=3)
    PSIP.add_time_series!(p_5bus, t_th_exp, ts_thermal_2028; year="2028", rep_day=4)

    PSIP.add_time_series!(p_5bus, t_wind, ts_wind_2024; year="2024", rep_day=3)
    PSIP.add_time_series!(p_5bus, t_wind, ts_wind_2028; year="2028", rep_day=4)

    PSIP.add_time_series!(p_5bus, t_pv1, ts_pv1_2024; year="2024", rep_day=3)
    PSIP.add_time_series!(p_5bus, t_pv1, ts_pv1_2028; year="2028", rep_day=4)
    PSIP.add_time_series!(p_5bus, t_pv2, ts_pv2_2024; year="2024", rep_day=3)
    PSIP.add_time_series!(p_5bus, t_pv2, ts_pv2_2028; year="2028", rep_day=4)

    PSIP.add_time_series!(p_5bus, t_stor, ts_sto_2024; year="2024", rep_day=3)
    PSIP.add_time_series!(p_5bus, t_stor, ts_sto_2028; year="2028", rep_day=4)

    PSIP.add_time_series!(p_5bus, line, ts_line_2024; year="2024", rep_day=3)
    PSIP.add_time_series!(p_5bus, line, ts_line_2028; year="2028", rep_day=4)

    PSIP.add_time_series!(p_5bus, t_demand_b, ts_demand_b_2024; year="2024", rep_day=3)
    PSIP.add_time_series!(p_5bus, t_demand_b, ts_demand_b_2028; year="2028", rep_day=4)
    PSIP.add_time_series!(p_5bus, t_demand_c, ts_demand_c_2024; year="2024", rep_day=3)
    PSIP.add_time_series!(p_5bus, t_demand_c, ts_demand_c_2028; year="2028", rep_day=4)
    PSIP.add_time_series!(p_5bus, t_demand_d, ts_demand_d_2024; year="2024", rep_day=3)
    PSIP.add_time_series!(p_5bus, t_demand_d, ts_demand_d_2028; year="2028", rep_day=4)

    return p_5bus
end
