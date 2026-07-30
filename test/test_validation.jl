function make_storage_for_validation(name, duration_limits)
    financial_data = TechnologyFinancialData(;
        capital_recovery_period=20,
        technology_base_year=2030,
        debt_fraction=0.4,
        debt_rate=0.05,
        return_on_equity=0.12,
        tax_rate=0.21,
    )
    return StorageTechnology{PSY.EnergyReservoirStorage}(;
        name,
        id=1,
        available=true,
        region=RegionTopology[],
        power_systems_type="EnergyReservoirStorage",
        storage_tech=StorageTech.LIB,
        duration_limits,
        financial_data,
    )
end

@testset "Technology validation" begin
    portfolio = Portfolio()
    ranged_duration = make_storage_for_validation(
        "ranged_duration",
        (min=2.0, max=4.0),
    )
    fixed_duration = make_storage_for_validation(
        "fixed_duration",
        (min=4.0, max=4.0),
    )
    reversed_duration = make_storage_for_validation(
        "reversed_duration",
        (min=4.0, max=2.0),
    )

    @test validate_technology(ranged_duration)
    @test validate_technology(fixed_duration)
    @test IS.validate_struct(ranged_duration)

    @test_logs(
        (:error, r"Storage duration limits must be in ascending order"),
        @test !validate_technology(reversed_duration)
    )
    @test_logs(
        (:error, r"Storage duration limits must be in ascending order"),
        @test !IS.validate_struct(reversed_duration)
    )

    @test isnothing(check_technology(portfolio, ranged_duration))
    @test isnothing(check_technologies(portfolio, [ranged_duration, fixed_duration]))
    @test_logs(
        (:error, r"Storage duration limits must be in ascending order"),
        @test_throws IS.InvalidValue check_technology(portfolio, reversed_duration)
    )
    @test_logs(
        (:error, r"Storage duration limits must be in ascending order"),
        @test_throws IS.InvalidValue check_technologies(
            portfolio,
            [ranged_duration, reversed_duration],
        )
    )
end
