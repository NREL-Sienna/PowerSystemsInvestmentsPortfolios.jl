@testset "Test functionality of Portfolio" begin
    ThermalTech = SupplyTechnology{ThermalStandard}
    p = Portfolio(0.07) # Empty portfolio
    @test length(collect(get_technologies(Technology, p))) == 0

    tech1 = SupplyTechnology{ThermalStandard}(
        name="thermal_tech",
        available=true,
        fuel=PSY.ThermalFuels.COAL,
        prime_mover=PSY.PrimeMovers.ST,
        capacity_factor=0.98, # cap factor
        capital_cost=nothing,
        operational_cost=nothing,
    )

    # Test adding technology
    add_technology!(p, tech1)
    @test length(collect(get_technologies(Technology, p))) == 1
    @test IS.get_uuid(tech1) ==
          IS.get_uuid(get_technology(ThermalTech, p, PSIP.get_name(tech1)))
    @test_throws(IS.ArgumentError, add_technology!(p, tech1))

    tech2 = SupplyTechnology{ThermalStandard}(
        name="thermal_tech2",
        available=true,
        fuel=PSY.ThermalFuels.COAL,
        prime_mover=PSY.PrimeMovers.ST,
        capacity_factor=0.98, # cap factor
        capital_cost=nothing,
        operational_cost=nothing,
    )

    # Test adding another technology
    add_technology!(p, tech2)
    @test length(collect(get_technologies(Technology, p))) == 2
    @test IS.get_uuid(tech2) ==
          IS.get_uuid(get_technology(ThermalTech, p, PSIP.get_name(tech2)))

    # Test emptyness
    @test isnothing(get_technology(ThermalTech, p, "not-a-name"))
    @test isempty(get_technologies_by_name(Technology, p, "not-a-name"))
    @test_throws(IS.ArgumentError, get_technologies_by_name(ThermalTech, p, "not-a-name"))
    @test isempty(get_technologies(x -> (!PSIP.get_available(x)), ThermalTech, p))
    @test !isempty(get_available_technologies(ThermalTech, p))
end
