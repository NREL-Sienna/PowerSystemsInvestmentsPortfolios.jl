function psy2openapi(agc::PSY.AGC, ids::IDGenerator)
    AGC(
        id=getid!(ids, agc),
        name=agc.name,
        available=agc.available,
        bias=agc.bias,
        K_p=agc.K_p,
        K_i=agc.K_i,
        K_d=agc.K_d,
        delta_t=agc.delta_t,
        area=getid!(ids, agc.area),
        initial_ace=agc.initial_ace,
    )
end

function psy2openapi(reserve::PSY.ConstantReserve{T}, ids::IDGenerator) where {T}
    ConstantReserve(
        id=getid!(ids, reserve),
        name=reserve.name,
        available=reserve.available,
        time_frame=reserve.time_frame,
        requirement=scale(reserve.requirement, PSY.get_base_power(reserve)),
        sustained_time=reserve.sustained_time,
        max_output_fraction=reserve.max_output_fraction,
        max_participation_factor=reserve.max_participation_factor,
        deployed_fraction=reserve.deployed_fraction,
        reserve_direction=get_reserve_direction(T),
    )
end

function psy2openapi(reserve::PSY.ConstantReserveGroup{T}, ids::IDGenerator) where {T}
    ConstantReserveGroup(
        id=getid!(ids, reserve),
        name=reserve.name,
        available=reserve.available,
        requirement=scale(reserve.requirement, PSY.get_base_power(reserve)),
        reserve_direction=get_reserve_direction(T),
    )
end

function psy2openapi(reserve::PSY.ConstantReserveNonSpinning, ids::IDGenerator)
    ConstantReserveNonSpinning(
        id=getid!(ids, reserve),
        name=reserve.name,
        available=reserve.available,
        time_frame=reserve.time_frame,
        requirement=scale(reserve.requirement, PSY.get_base_power(reserve)),
        sustained_time=reserve.sustained_time,
        max_output_fraction=reserve.max_output_fraction,
        max_participation_factor=reserve.max_participation_factor,
        deployed_fraction=reserve.deployed_fraction,
    )
end

function psy2openapi(reserve::PSY.VariableReserve{T}, ids::IDGenerator) where {T}
    VariableReserve(
        id=getid!(ids, reserve),
        name=reserve.name,
        available=reserve.available,
        deployed_fraction=reserve.deployed_fraction,
        max_output_fraction=reserve.max_output_fraction,
        max_participation_factor=reserve.max_participation_factor,
        requirement=scale(reserve.requirement, PSY.get_base_power(reserve)),
        reserve_direction=get_reserve_direction(T),
        sustained_time=reserve.sustained_time,
        time_frame=reserve.time_frame,
    )
end

function psy2openapi(reserve::PSY.VariableReserveNonSpinning, ids::IDGenerator)
    VariableReserveNonSpinning(
        id=getid!(ids, reserve),
        name=reserve.name,
        available=reserve.available,
        time_frame=reserve.time_frame,
        requirement=scale(reserve.requirement, PSY.get_base_power(reserve)),
        sustained_time=reserve.sustained_time,
        max_output_fraction=reserve.max_output_fraction,
        max_participation_factor=reserve.max_participation_factor,
        deployed_fraction=reserve.deployed_fraction,
    )
end
