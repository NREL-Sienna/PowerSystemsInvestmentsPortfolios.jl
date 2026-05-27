function openapi2sienna(geo::PowerOpenAPIModels.GeographicInfo)
    IS.GeographicInfo(geo_json=geo.geo_json)
end

function openapi2sienna(attribute::PowerOpenAPIModels.RetirementPotential)
    RetirementPotential(;
        planned_retirement_year=attribute.planned_retirement_year,
        eligible_generators=attribute.eligible_generators,
        build_year=attribute.build_year,
    )
end

function openapi2sienna(attribute::PowerOpenAPIModels.RetrofitPotential)
    RetrofitPotential(; eligible_generators=attribute.eligible_generators)
end

function openapi2sienna(attribute::PowerOpenAPIModels.AggregateRetirementPotential)
    AggregateRetirementPotential(; retirement_potential=attribute.retirement_potential)
end

function openapi2sienna(attribute::PowerOpenAPIModels.AggregateRetrofitPotential)
    AggregateRetrofitPotential(;
        retrofit_fraction=attribute.retrofit_fraction,
        retrofit_potential=attribute.retrofit_potential,
    )
end

function openapi2sienna(attribute::PowerOpenAPIModels.TopologyMapping)
    TopologyMapping(; buses=attribute.buses)
end

function openapi2sienna(attribute::PowerOpenAPIModels.ExistingCapacity)
    ExistingCapacity(; existing_technologies=attribute.existing_technologies)
end
