include("portfolio_5bus.jl")

@testset "Test functionality of Portfolio" begin
    p_5bus = build_portfolio()

    technologies = collect(get_technologies(SupplyTechnology, p_5bus))
    technology = get_technology(SupplyTechnology, p_5bus, PSIP.get_name(technologies[1]))
    @test IS.get_uuid(technology) == IS.get_uuid(technologies[1])
    @test_throws(IS.ArgumentError, add_technology!(p_5bus, technology))
    @test get_available_technology(SupplyTechnology, p_5bus, PSIP.get_name(technologies[1])) ===
          technology
    PSIP.set_available!(technology, false)
    available_technologies = collect(get_available_technologies(SupplyTechnology, p_5bus))
    @test length(technologies) == length(available_technologies) + 1
    PSIP.set_available!(technology, true)

    technologies2 = get_technologies_by_name(SupplyTechnology, p_5bus, PSIP.get_name(technologies[1]))
    @test length(technologies2) == 1
    @test IS.get_uuid(technologies2[1]) == IS.get_uuid(technologies[1])
    @test has_time_series(technologies2[1])

    @test isnothing(get_technology(SupplyTechnology, p_5bus, "not-a-name"))
    @test isempty(get_technologies_by_name(SupplyTechnology, p_5bus, "not-a-name"))

    @test isempty(get_technologies(x -> (!PSIP.get_available(x)), SupplyTechnology, p_5bus))
    @test !isempty(get_available_technologies(SupplyTechnology, p_5bus))

    # Get time_series with a name and without.
    renewables = collect(get_technologies(SupplyTechnology{RenewableDispatch}, p_5bus))
    @test !isempty(renewables)
    renewable = renewables[1]
    ts = get_time_series(SingleTimeSeries, renewable, "ops_variable_cap_factor"; year="2024", rep_day=1)
    @test ts isa SingleTimeSeries

    # Test all versions of get_time_series_[array|timestamps|values]
    values1 = get_time_series_array(renewable, ts)
    values2 = get_time_series_array(SingleTimeSeries, renewable, "ops_variable_cap_factor"; year="2024", rep_day=1)
    @test values1 == values2
    values3 = get_time_series_array(SingleTimeSeries, renewable, "ops_variable_cap_factor"; year="2024", rep_day=1)
    @test values1 == values3

    val = get_time_series_array(SingleTimeSeries, renewable, "ops_variable_cap_factor"; year="2024", rep_day=1)
    @test val isa TimeSeries.TimeArray
    val = get_time_series_timestamps(SingleTimeSeries, renewable, "ops_variable_cap_factor"; year="2024", rep_day=1)
    @test val isa Array
    @test val[1] isa Dates.DateTime
    val = get_time_series_values(SingleTimeSeries, renewable, "ops_variable_cap_factor"; year="2024", rep_day=1)
    @test val isa Array
    @test val[1] isa AbstractFloat

    val = get_time_series_array(renewable, ts)
    @test val isa TimeSeries.TimeArray
    val = get_time_series_timestamps(renewable, ts)
    @test val isa Array
    @test val[1] isa Dates.DateTime
    val = get_time_series_values(renewable, ts)
    @test val isa Array
    @test val[1] isa AbstractFloat

    PSIP.clear_time_series!(p_5bus)
    @test length(collect(get_time_series_multiple(p_5bus))) == 0
    @test IS.get_internal(p_5bus) isa IS.InfrastructureSystemsInternal

end
