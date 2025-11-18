@testset "Test time mapping functions" begin
    investments = [
        (Date(Month(1), Year(2025)), Date(Month(1), Year(2026))),
        (Date(Month(1), Year(2026)), Date(Month(1), Year(2027))),
    ]

    operations = [
        [DateTime(Month(1), Day(25), Year(2025))],
        collect(
            DateTime(Day(1), Month(3), Year(2025)):Hour(1):DateTime(
                Day(7),
                Month(3),
                Year(2025),
            ),
        ),
        collect(
            DateTime(Day(1), Month(7), Year(2025)):Hour(1):DateTime(
                Day(7),
                Month(7),
                Year(2025),
            ),
        ),
        collect(
            DateTime(Day(1), Month(9), Year(2025)):Hour(1):DateTime(
                Day(7),
                Month(9),
                Year(2025),
            ),
        ),
        collect(
            DateTime(Day(1), Month(3), Year(2026)):Hour(1):DateTime(
                Day(7),
                Month(3),
                Year(2026),
            ),
        ),
        collect(
            DateTime(Day(1), Month(7), Year(2026)):Hour(1):DateTime(
                Day(7),
                Month(7),
                Year(2026),
            ),
        ),
        collect(
            DateTime(Day(1), Month(9), Year(2026)):Hour(1):DateTime(
                Day(7),
                Month(9),
                Year(2026),
            ),
        ),
    ]

    feasibility = [
        collect(
            DateTime(Day(1), Month(1), Year(2025)):Hour(1):DateTime(
                Day(7),
                Month(1),
                Year(2025),
            ),
        ),
        collect(
            DateTime(Day(1), Month(1), Year(2026)):Hour(1):DateTime(
                Day(7),
                Month(1),
                Year(2026),
            ),
        ),
    ]

    tm = TimeMapping(investments, operations, feasibility)

    @test PSIP.get_total_operation_period_count(tm) == 871
    @test PSIP.get_total_period_count(tm) == PSIP.get_total_feasibility_period_count(tm)
    @test PSIP.get_total_investment_period_count(tm) == 2
    @test length(PSIP.get_time_steps(tm)) == PSIP.get_total_period_count(tm)
    @test length(PSIP.get_operational_time_steps(tm)) ==
          PSIP.get_total_operation_period_count(tm)
    @test length(PSIP.get_feasibility_time_steps(tm)) ==
          PSIP.get_total_feasibility_period_count(tm) -
          PSIP.get_total_operation_period_count(tm)
    @test length(PSIP.get_investment_time_steps(tm)) ==
          PSIP.get_total_investment_period_count(tm)
    @test PSIP.is_feasibility_empty(tm) == false
end
