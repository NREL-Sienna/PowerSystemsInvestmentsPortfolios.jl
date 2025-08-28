@testset "Test JSON serialization" begin
    portfolio = build_portfolio()

    #TODO: Build this test, the IS.compare_values function does not appear to be
    #working correctly with the openAPI serialization method

    #port2, result = validate_serialization(portfolio; time_series_read_only = true)
    #@test result

end

@testset "Test serialization of Portfolio fields" begin
    financial_data = PortfolioFinancialData(2020, 0.07, 0.03, 0.05)
    name = "my_portfolio"
    description = "test"
    port = Portfolio(; financial_data=financial_data, name=name, description=description)
    zone = Zone(; name="zone1", id=1)

    add_region!(port, zone)
    gen = SupplyTechnology{ThermalStandard}(;
        name="gen1",
        region=[zone],
        id=1,
        available=true,
        financial_data=TechnologyFinancialData(;
            interest_rate=30,
            capital_recovery_period=30,
            technology_base_year=2020,
        ),
        power_systems_type="test",
        operation_costs=ThermalGenerationCost(;
            variable=zero(CostCurve),
            fixed=0.0,
            start_up=0.0,
            shut_down=0.0,
        ),
    )
    add_technology!(port, gen)

    #TODO: Fix validate_serialization function and compare_values
    #port2, result = validate_serialization(port)
    port2 = validate_serialization(port)
    #@test result
    @test port2.financial_data.discount_rate == financial_data.discount_rate
    @test port2.financial_data.inflation_rate == financial_data.inflation_rate
    @test port2.financial_data.interest_rate == financial_data.interest_rate
    @test port2.metadata.name == name
    @test port2.metadata.description == description
end

@testset "Test serialization/deserialization of investment schedule" begin
    portfolio = build_portfolio()

    dict_2030 = Dict(
        (SupplyTechnology{ThermalStandard}, "expensive_thermal") => 0.0,
        (StorageTechnology{EnergyReservoirStorage}, "test_storage") =>
            (build_p=0.0, build_e=0.0),
        (ColocatedSupplyStorageTechnology{RenewableDispatch}, "colocated_test") => (
            build_p=1400.6,
            build_solar=0.0,
            build_e=10176.7,
            build_inverter=1592.22,
            build_wind=1722.66,
        ),
        (SupplyTechnology{RenewableDispatch}, "wind") => 975.015,
        (AggregateTransportTechnology{ACBranch}, "test_branch") => 934.992,
        (SupplyTechnology{ThermalStandard}, "cheap_thermal") => 0.0,
    )
    dict_2035 = Dict(
        (SupplyTechnology{ThermalStandard}, "expensive_thermal") => 0.0,
        (StorageTechnology{EnergyReservoirStorage}, "test_storage") =>
            (build_p=0.0, build_e=0.0),
        (ColocatedSupplyStorageTechnology{RenewableDispatch}, "colocated_test") => (
            build_p=185.437,
            build_solar=0.0,
            build_e=1283.1,
            build_inverter=313.05,
            build_wind=0.0,
        ),
        (SupplyTechnology{RenewableDispatch}, "wind") => 135.609,
        (AggregateTransportTechnology{ACBranch}, "test_branch") => 508.671,
        (SupplyTechnology{ThermalStandard}, "cheap_thermal") => 0.0,
    )
    manual_schedule = Dict(
        (Date("2030-01-01"), Date("2034-12-01")) => dict_2030,
        (Date("2035-01-01"), Date("2039-12-01")) => dict_2035,
    )
    schedule = InvestmentScheduleResults(manual_schedule)

    set_investment_schedule!(portfolio, schedule)

    @test schedule == get_investment_schedule(portfolio)

    portfolio2 = validate_serialization(portfolio)
    schedule2 = get_investment_schedule(portfolio2)
    for key in keys(schedule.results)
        @test haskey(schedule2.results, key)
        for key2 in keys(schedule.results[key])
            @test haskey(schedule2.results[key], key2)
            if schedule.results[key][key2] isa NamedTuple
                caps = schedule.results[key][key2]
                caps2 = schedule2.results[key][key2]
                for key3 in keys(caps)
                    @test caps[key3] == caps2[key3]
                end
            else
                @test schedule.results[key][key2] == schedule2.results[key][key2]
            end
        end
    end
end
