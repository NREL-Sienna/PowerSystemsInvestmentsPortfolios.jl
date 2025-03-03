@testset "Test JSON serialization" begin
    portfolio = build_portfolio()

    #port2, result = validate_serialization(portfolio; time_series_read_only = true)
    #@test result

end

@testset "Test serialization of Portfolio fields" begin
    financial_data = PortfolioFinancialData(2020, 0.07, 0.03, 0.05)
    name = "my_system"
    description = "test"
    port = Portfolio(; financial_data=financial_data, name=name, description=description)
    zone = Zone(; name="zone1", id=1)

    add_region!(port, zone)
    gen = SupplyTechnology{ThermalStandard}(;
        name="gen1",
        region=[zone],
        id=1,
        available=true,
        base_power=100.0,
        financial_data=TechnologyFinancialData(;
            interest_rate=30,
            capital_recovery_period=30,
            technology_base_year=2020,
        ),
        power_systems_type="test",
        balancing_topology="test",
        operation_costs=ThermalGenerationCost(;
            variable=zero(CostCurve),
            fixed=0.0,
            start_up=0.0,
            shut_down=0.0,
        ),
    )
    add_technology!(port, gen)

    #port2, result = validate_serialization(port)
    port2 = validate_serialization(port)
    #@test result
    @test port2.financial_data == financial_data
    @test port2.metadata.name == name
    @test port2.metadata.description == description
end
