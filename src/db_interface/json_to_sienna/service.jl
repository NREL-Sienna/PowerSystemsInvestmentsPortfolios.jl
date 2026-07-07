function openapi2psy(agc::PowerOpenAPIModels.AGC, resolver::Resolver)
    PSY.AGC(
        name=agc.name,
        available=agc.available,
        bias=agc.bias,
        K_p=agc.K_p,
        K_i=agc.K_i,
        K_d=agc.K_d,
        delta_t=agc.delta_t,
        area=resolver(agc.area),
        initial_ace=agc.initial_ace,
    )
end

function openapi2psy(reserve::PowerOpenAPIModels.ConstantReserve, resolver::Resolver)
    PSY.ConstantReserve{get_reserve_enum(reserve.reserve_direction)}(
        name=reserve.name,
        available=reserve.available,
        time_frame=reserve.time_frame,
        requirement=divide(reserve.requirement, PSY.get_base_power(resolver.sys)),
        sustained_time=reserve.sustained_time,
        max_output_fraction=reserve.max_output_fraction,
        max_participation_factor=reserve.max_participation_factor,
        deployed_fraction=reserve.deployed_fraction,
    )
end

function openapi2psy(reserve::PowerOpenAPIModels.ConstantReserveGroup, resolver::Resolver)
    PSY.ConstantReserveGroup{get_reserve_enum(reserve.reserve_direction)}(
        name=reserve.name,
        available=reserve.available,
        requirement=divide(reserve.requirement, PSY.get_base_power(resolver.sys)),
    )
end

function openapi2psy(
    reserve::PowerOpenAPIModels.ConstantReserveNonSpinning,
    resolver::Resolver,
)
    PSY.ConstantReserveNonSpinning(
        name=reserve.name,
        available=reserve.available,
        time_frame=reserve.time_frame,
        requirement=divide(reserve.requirement, PSY.get_base_power(resolver.sys)),
        sustained_time=reserve.sustained_time,
        max_output_fraction=reserve.max_output_fraction,
        max_participation_factor=reserve.max_participation_factor,
        deployed_fraction=reserve.deployed_fraction,
    )
end

function openapi2psy(reserve::PowerOpenAPIModels.VariableReserve, resolver::Resolver)
    PSY.VariableReserve{get_reserve_enum(reserve.reserve_direction)}(
        name=reserve.name,
        available=reserve.available,
        deployed_fraction=reserve.deployed_fraction,
        max_output_fraction=reserve.max_output_fraction,
        max_participation_factor=reserve.max_participation_factor,
        requirement=divide(reserve.requirement, PSY.get_base_power(resolver.sys)),
        sustained_time=reserve.sustained_time,
        time_frame=reserve.time_frame,
    )
end

function openapi2psy(
    reserve::PowerOpenAPIModels.VariableReserveNonSpinning,
    resolver::Resolver,
)
    PSY.VariableReserveNonSpinning(
        name=reserve.name,
        available=reserve.available,
        time_frame=reserve.time_frame,
        requirement=divide(reserve.requirement, PSY.get_base_power(resolver.sys)),
        sustained_time=reserve.sustained_time,
        max_output_fraction=reserve.max_output_fraction,
        max_participation_factor=reserve.max_participation_factor,
        deployed_fraction=reserve.deployed_fraction,
    )
end
