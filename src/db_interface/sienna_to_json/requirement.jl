function psip2openapi(requirement::CapacityReserveMargin, ids::IDGenerator)
    CapacityReserveMargin(
        name=requirement.name,
        id=requirement.id,
        available=requirement.available,
        capacity_reserve_fraction=requirement.capacity_reserve_fraction,
        target_year=requirement.target_year,
        eligible_technologies=[getid!(ids, t) for t in requirement.eligible_technologies],
        eligible_regions=[getid!(ids, t) for t in requirement.eligible_regions],
    )
end

function psip2openapi(requirement::CarbonCaps, ids::IDGenerator)
    CarbonCaps(
        name=requirement.name,
        id=requirement.id,
        available=requirement.available,
        max_mtons=requirement.max_mtons,
        max_tons_mwh=requirement.max_tons_mwh,
        target_year=requirement.target_year,
        eligible_regions=[getid!(ids, t) for t in requirement.eligible_regions],
    )
end

function psip2openapi(requirement::CarbonTax, ids::IDGenerator)
    CarbonTax(
        name=requirement.name,
        id=requirement.id,
        available=requirement.available,
        tax_dollars_per_ton=requirement.tax_dollars_per_ton,
        target_year=requirement.target_year,
        eligible_regions=[getid!(ids, t) for t in requirement.eligible_regions],
    )
end

function psip2openapi(requirement::EnergyShareRequirements, ids::IDGenerator)
    EnergyShareRequirements(
        name=requirement.name,
        id=requirement.id,
        available=requirement.available,
        generation_fraction_requirement=requirement.generation_fraction_requirement,
        target_year=requirement.target_year,
        eligible_resources=[getid!(ids, t) for t in requirement.eligible_resources],
        eligible_regions=[getid!(ids, t) for t in requirement.eligible_regions],
    )
end

function psip2openapi(requirement::HourlyMatching, ids::IDGenerator)
    HourlyMatching(
        name=requirement.name,
        id=requirement.id,
        available=requirement.available,
        eligible_demand=[getid!(ids, t) for t in requirement.eligible_demand],
        eligible_resources=[getid!(ids, t) for t in requirement.eligible_resources],
    )
end

function psip2openapi(requirement::MaximumCapacityRequirements, ids::IDGenerator)
    MaximumCapacityRequirements(
        name=requirement.name,
        id=requirement.id,
        available=requirement.available,
        max_capacity_mw=requirement.max_capacity_mw,
        target_year=requirement.target_year,
        eligible_resources=[getid!(ids, t) for t in requirement.eligible_resources],
    )
end

function psip2openapi(requirement::MinimumCapacityRequirements, ids::IDGenerator)
    MinimumCapacityRequirements(
        name=requirement.name,
        id=requirement.id,
        available=requirement.available,
        min_capacity_mw=requirement.min_capacity_mw,
        target_year=requirement.target_year,
        eligible_resources=[getid!(ids, t) for t in requirement.eligible_resources],
    )
end
