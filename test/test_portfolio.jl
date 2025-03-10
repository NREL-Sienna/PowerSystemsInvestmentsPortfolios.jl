include("portfolio_5bus.jl")

@testset "Test functionality of Portfolio" begin
    technologies = collect(get_technologies(SupplyTechnology, p_5bus))
    technology = get_technology(SupplyTechnology, p_5bus, PSIP.get_name(technologies[1]))
    @test IS.get_uuid(technology) == IS.get_uuid(technologies[1])

end