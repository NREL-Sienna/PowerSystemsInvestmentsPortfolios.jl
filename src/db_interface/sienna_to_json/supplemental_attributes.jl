function sienna2openapi(geo::IS.GeographicInfo, ids::IDGenerator)
    PowerOpenAPIModels.GeographicInfo(id=getid!(ids, geo), geo_json=IS.get_geo_json(geo))
end

function sienna2openapi(attribute::RetirementPotential, ids::IDGenerator)
    PowerOpenAPIModels.RetirementPotential(;
        id=getid!(ids, attribute),
        planned_retirement_year=attribute.planned_retirement_year,
        eligible_generators=attribute.eligible_generators,
        build_year=attribute.build_year,
    )
end

function sienna2openapi(attribute::RetrofitPotential, ids::IDGenerator)
    PowerOpenAPIModels.RetrofitPotential(;
        id=getid!(ids, attribute),
        eligible_generators=attribute.eligible_generators,
    )
end

function sienna2openapi(attribute::AggregateRetirementPotential, ids::IDGenerator)
    PowerOpenAPIModels.AggregateRetirementPotential(;
        id=getid!(ids, attribute),
        retirement_potential=attribute.retirement_potential,
    )
end

function sienna2openapi(attribute::AggregateRetrofitPotential, ids::IDGenerator)
    PowerOpenAPIModels.AggregateRetrofitPotential(;
        id=getid!(ids, attribute),
        retrofit_fraction=attribute.retrofit_fraction,
        retrofit_potential=attribute.retrofit_potential,
    )
end

function sienna2openapi(attribute::TopologyMapping, ids::IDGenerator)
    PowerOpenAPIModels.TopologyMapping(; id=getid!(ids, attribute), buses=attribute.buses)
end

function sienna2openapi(attribute::ExistingCapacity, ids::IDGenerator)
    PowerOpenAPIModels.ExistingCapacity(;
        id=getid!(ids, attribute),
        existing_technologies=attribute.existing_technologies,
    )
end
