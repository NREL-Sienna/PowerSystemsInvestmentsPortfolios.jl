@testset "Test utility functions" begin
    p_5bus = build_portfolio()

    thermal = get_technology(SupplyTechnology{ThermalStandard}, p_5bus, "cheap_thermal")
    renewable = get_technology(SupplyTechnology{RenewableDispatch}, p_5bus, "wind")

    @test has_supplemental_attributes(thermal, ExistingCapacity)
    @test !is_new(thermal)
    @test is_new(renewable)
    @test get_existing_capacity_mw(p_5bus, thermal) == 79125.00
    @test get_existing_capacity_mw(p_5bus, renewable) == 0
end

@testset "Test constructors" begin
    port = build_portfolio()

    tech = first(get_technologies(SupplyTechnology{ThermalStandard}, port))
    @test tech isa PSIP.ResourceTechnology

    tech = first(get_technologies(SupplyTechnology{RenewableDispatch}, port))
    @test tech isa PSIP.ResourceTechnology

    tech = first(get_technologies(StorageTechnology, port))
    @test tech isa PSIP.ResourceTechnology

    tech = first(get_technologies(AggregateTransportTechnology, port))
    @test tech isa PSIP.TransmissionTechnology

    tech = first(get_technologies(NodalACTransportTechnology, port))
    @test tech isa PSIP.TransmissionTechnology

    tech = first(get_technologies(DemandRequirement, port))
    @test tech isa PSIP.DemandTechnology

    tech = first(get_technologies(DemandSideTechnology, port))
    @test tech isa PSIP.DemandTechnology

    region = first(get_regions(Zone, port))
    @test region isa PSIP.RegionTopology

    region = first(get_regions(Node, port))
    @test region isa PSIP.RegionTopology
end
