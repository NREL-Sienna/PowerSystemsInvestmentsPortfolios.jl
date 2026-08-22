@testset "OpenAPIRefs registration and resolution" begin
    refs = PSIP.OpenAPIRefs()
    zone = Zone(name="z1")
    node = Node(name="n1")

    refs[1] = zone
    refs[2] = node

    @test refs[1] === zone
    @test PSIP.component_id(refs, node) == 2
    @test PSIP.has_ref(refs, 1)
    @test !PSIP.has_ref(refs, 99)
    @test PSIP.has_component_id(refs, zone)

    # `nothing` in, `nothing` out: an omitted optional reference is an absent
    # relationship, not a malformed one.
    @test isnothing(PSIP.resolve_ref(refs, nothing))
    @test PSIP.resolve_ref(refs, 2) === node
    @test PSIP.resolve_refs(refs, [1, 2]) == [zone, node]
    @test isempty(PSIP.resolve_refs(refs, nothing))
    @test PSIP.component_ids(refs, [node, zone]) == [2, 1]
end

@testset "OpenAPIRefs errors loudly on malformed input" begin
    refs = PSIP.OpenAPIRefs()
    zone = Zone(name="z1")
    refs[1] = zone

    @test_throws ErrorException refs[1] = Zone(name="other")
    @test_throws ErrorException refs[7]
    @test_throws ErrorException PSIP.resolve_ref(refs, 7)
    @test_throws ErrorException PSIP.component_id(refs, Node(name="n"))
end
