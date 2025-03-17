include("portfolio_5bus.jl")

@testset "Test functionality of Portfolio" begin
    port = build_portfolio()

    technologies = collect(get_technologies(SupplyTechnology, port))
    technology = get_technology(SupplyTechnology, port, PSIP.get_name(technologies[1]))
    @test IS.get_uuid(technology) == IS.get_uuid(technologies[1])
    @test_throws(IS.ArgumentError, add_technology!(port, technology))
    @test get_available_technology(
        SupplyTechnology,
        port,
        PSIP.get_name(technologies[1]),
    ) === technology
    PSIP.set_available!(technology, false)
    available_technologies = collect(get_available_technologies(SupplyTechnology, port))
    @test length(technologies) == length(available_technologies) + 1
    PSIP.set_available!(technology, true)

    technologies2 =
        get_technologies_by_name(SupplyTechnology, port, PSIP.get_name(technologies[1]))
    @test length(technologies2) == 1
    @test IS.get_uuid(technologies2[1]) == IS.get_uuid(technologies[1])
    @test has_time_series(technologies2[1])

    @test isnothing(get_technology(SupplyTechnology, port, "not-a-name"))
    @test isempty(get_technologies_by_name(SupplyTechnology, port, "not-a-name"))

    @test isempty(get_technologies(x -> (!PSIP.get_available(x)), SupplyTechnology, port))
    @test !isempty(get_available_technologies(SupplyTechnology, port))

    # Get time_series with a name and without.
    renewables = collect(get_technologies(SupplyTechnology{RenewableDispatch}, port))
    @test !isempty(renewables)
    renewable = renewables[1]
    ts = get_time_series(
        SingleTimeSeries,
        renewable,
        "ops_variable_cap_factor";
        year="2024",
        rep_day=1,
    )
    @test ts isa SingleTimeSeries

    # Test all versions of get_time_series_[array|timestamps|values]
    values1 = get_time_series_array(renewable, ts)
    values2 = get_time_series_array(
        SingleTimeSeries,
        renewable,
        "ops_variable_cap_factor";
        year="2024",
        rep_day=1,
    )
    @test values1 == values2
    values3 = get_time_series_array(
        SingleTimeSeries,
        renewable,
        "ops_variable_cap_factor";
        year="2024",
        rep_day=1,
    )
    @test values1 == values3

    val = get_time_series_array(
        SingleTimeSeries,
        renewable,
        "ops_variable_cap_factor";
        year="2024",
        rep_day=1,
    )
    @test val isa TimeSeries.TimeArray
    val = get_time_series_timestamps(
        SingleTimeSeries,
        renewable,
        "ops_variable_cap_factor";
        year="2024",
        rep_day=1,
    )
    @test val isa Array
    @test val[1] isa Dates.DateTime
    val = get_time_series_values(
        SingleTimeSeries,
        renewable,
        "ops_variable_cap_factor";
        year="2024",
        rep_day=1,
    )
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

    PSIP.clear_time_series!(port)
    @test length(collect(get_time_series_multiple(port))) == 0
    @test IS.get_internal(port) isa IS.InfrastructureSystemsInternal
end

@testset "Test get_technologies filter_func" begin
    port = build_portfolio()
    tech = first(get_technologies(SupplyTechnology{ThermalStandard}, port))
    name = PSIP.get_name(tech)
    technologies = get_technologies(SupplyTechnology{ThermalStandard}, port) do tech
        PSIP.get_name(tech) == name && PSIP.get_available(tech)
    end

    @test length(technologies) == 1 && PSIP.get_name(first(technologies)) == name
end

@testset "Test time series counts" begin
    port = build_portfolio()
    counts = PSIP.get_time_series_counts(port)

    # TODO: Verify timeseries counts before clear, should be 45 but counts says 23?
    @test counts.static_time_series_count == 45

    PSIP.clear_time_series!(port)
    counts = PSIP.get_time_series_counts(port)
    @test counts.static_time_series_count == 0
end

@testset "Test portfolio name and description" begin
    name = "test_portfolio"
    description = "a system description"
    port = Portfolio()
    @test PSIP.get_name(port) === nothing
    @test PSIP.get_description(port) === nothing
    PSIP.set_name!(port, name)
    PSIP.set_description!(port, description)

    port = Portfolio(; name=name, description=description)
    @test PSIP.get_name(port) == name
    @test PSIP.get_description(port) == description
end
