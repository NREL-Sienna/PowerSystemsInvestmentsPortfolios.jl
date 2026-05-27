function sienna2openapi(geo::IS.GeographicInfo, ids::IDGenerator)
    GeographicInfo(id=getid!(ids, geo), geo_json=IS.get_geo_json(geo))
end

function sienna2openapi(attribute::RetirementPotential, ids::IDGenerator)
    RetirementPotential(;
        id=getid!(ids, attribute),
        planned_retirement_year=attribute.planned_retirement_year,
        eligible_generators=attribute.eligible_generators,
        build_year=attribute.build_year,
    )
end

function sienna2openapi(attribute::RetrofitPotential, ids::IDGenerator)
    RetrofitPotential(;
        id=getid!(ids, attribute),
        eligible_generators=attribute.eligible_generators,
    )
end

function sienna2openapi(attribute::AggregateRetirementPotential, ids::IDGenerator)
    AggregateRetirementPotential(;
        id=getid!(ids, attribute),
        retirement_potential=attribute.retirement_potential,
    )
end

function sienna2openapi(attribute::AggregateRetrofitPotential, ids::IDGenerator)
    AggregateRetrofitPotential(;
        id=getid!(ids, attribute),
        retrofit_fraction=attribute.retrofit_fraction,
        retrofit_potential=attribute.retrofit_potential,
    )
end

function sienna2openapi(attribute::TopologyMapping, ids::IDGenerator)
    TopologyMapping(; id=getid!(ids, attribute), buses=attribute.buses)
end

function sienna2openapi(attribute::ExistingCapacity, ids::IDGenerator)
    ExistingCapacity(;
        id=getid!(ids, attribute),
        existing_technologies=attribute.existing_technologies,
    )
end
