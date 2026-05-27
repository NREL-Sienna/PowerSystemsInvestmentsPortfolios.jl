function openapi2psip(requirement::PowerOpenAPIModels.CapacityReserveMargin, resolver::Resolver)
    CapacityReserveMargin(
        name=requirement.name,
        id=requirement.id,
        available=requirement.available,
        capacity_reserve_fraction=requirement.capacity_reserve_fraction,
        target_year=requirement.target_year,
        eligible_technologies=[resolver(r) for r in requirement.eligible_technologies],
        eligible_regions=[resolver(r) for r in requirement.eligible_regions],
    )
end

function openapi2psip(requirement::PowerOpenAPIModels.CarbonCaps, resolver::Resolver)
    CarbonCaps(
        name=requirement.name,
        id=requirement.id,
        available=requirement.available,
        max_mtons=requirement.max_mtons,
        max_tons_mwh=requirement.max_tons_mwh,
        target_year=requirement.target_year,
        eligible_regions=[resolver(r) for r in requirement.eligible_regions],
    )
end

function openapi2psip(requirement::PowerOpenAPIModels.CarbonTax, resolver::Resolver)
    CarbonTax(
        name=requirement.name,
        id=requirement.id,
        available=requirement.available,
        tax_dollars_per_ton=requirement.tax_dollars_per_ton,
        target_year=requirement.target_year,
        eligible_regions=[resolver(r) for r in requirement.eligible_regions],
    )
end

function openapi2psip(requirement::PowerOpenAPIModels.EnergyShareRequirements, resolver::Resolver)
    EnergyShareRequirements(
        name=requirement.name,
        id=requirement.id,
        available=requirement.available,
        generation_fraction_requirement=requirement.generation_fraction_requirement,
        target_year=requirement.target_year,
        eligible_resources=[resolver(r) for r in requirement.eligible_resources],
        eligible_regions=[resolver(r) for r in requirement.eligible_regions],
    )
end

function openapi2psip(requirement::PowerOpenAPIModels.HourlyMatching, resolver::Resolver)
    HourlyMatching(
        name=requirement.name,
        id=requirement.id,
        available=requirement.available,
        eligible_demand=[resolver(r) for r in requirement.eligible_demand],
        eligible_resources=[resolver(r) for r in requirement.eligible_resources],
    )
end

function openapi2psip(requirement::PowerOpenAPIModels.MaximumCapacityRequirements, resolver::Resolver)
    MaximumCapacityRequirements(
        name=requirement.name,
        id=requirement.id,
        available=requirement.available,
        max_capacity_mw=requirement.max_capacity_mw,
        target_year=requirement.target_year,
        eligible_resources=[resolver(r) for r in requirement.eligible_resources],
    )
end

function openapi2psip(requirement::PowerOpenAPIModels.MinimumCapacityRequirements, resolver::Resolver)
    MinimumCapacityRequirements(
        name=requirement.name,
        id=requirement.id,
        available=requirement.available,
        min_capacity_mw=requirement.min_capacity_mw,
        target_year=requirement.target_year,
        eligible_resources=[resolver(r) for r in requirement.eligible_resources],
    )
end
