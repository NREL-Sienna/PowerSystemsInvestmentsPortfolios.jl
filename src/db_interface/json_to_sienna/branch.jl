function openapi2psy(
    area_interchange::PowerOpenAPIModels.AreaInterchange,
    resolver::Resolver,
)
    PSY.AreaInterchange(
        name=area_interchange.name,
        available=area_interchange.available,
        active_power_flow=divide(
            area_interchange.active_power_flow,
            PSY.get_base_power(resolver.sys),
        ),
        flow_limits=divide(
            get_tuple_fromto_tofrom(area_interchange.flow_limits),
            PSY.get_base_power(resolver.sys),
        ),
        from_area=resolver(area_interchange.from_area),
        to_area=resolver(area_interchange.to_area),
    )
end

function openapi2psy(
    branch::PowerOpenAPIModels.DiscreteControlledACBranch,
    resolver::Resolver,
)
    PSY.DiscreteControlledACBranch(
        name=branch.name,
        available=branch.available,
        active_power_flow=divide(
            branch.active_power_flow,
            PSY.get_base_power(resolver.sys),
        ),
        reactive_power_flow=divide(
            branch.reactive_power_flow,
            PSY.get_base_power(resolver.sys),
        ),
        arc=resolver(branch.arc),
        r=divide(
            branch.r,
            get_Z_fraction(
                resolver(branch.arc).from.base_voltage,
                PSY.get_base_power(resolver.sys),
            ),
        ),
        x=divide(
            branch.x,
            get_Z_fraction(
                resolver(branch.arc).from.base_voltage,
                PSY.get_base_power(resolver.sys),
            ),
        ),
        rating=divide(branch.rating, PSY.get_base_power(resolver.sys)),
        discrete_branch_type=PSY.DiscreteControlledBranchType(branch.discrete_branch_type),
        branch_status=PSY.DiscreteControlledBranchStatus(branch.branch_status),
    )
end

function openapi2psy(line::PowerOpenAPIModels.Line, resolver::Resolver)
    PSY.Line(;
        name=line.name,
        available=line.available,
        active_power_flow=divide(line.active_power_flow, PSY.get_base_power(resolver.sys)),
        reactive_power_flow=divide(
            line.reactive_power_flow,
            PSY.get_base_power(resolver.sys),
        ),
        arc=resolver(line.arc),
        r=divide(
            line.r,
            get_Z_fraction(
                resolver(line.arc).from.base_voltage,
                PSY.get_base_power(resolver.sys),
            ),
        ),
        x=divide(
            line.x,
            get_Z_fraction(
                resolver(line.arc).from.base_voltage,
                PSY.get_base_power(resolver.sys),
            ),
        ),
        b=scale(
            get_tuple_from_to(line.b),
            get_Z_fraction(
                resolver(line.arc).from.base_voltage,
                PSY.get_base_power(resolver.sys),
            ),
        ),
        rating=divide(line.rating, PSY.get_base_power(resolver.sys)),
        angle_limits=get_tuple_min_max(line.angle_limits),
        rating_b=divide(line.rating_b, PSY.get_base_power(resolver.sys)),
        rating_c=divide(line.rating_c, PSY.get_base_power(resolver.sys)),
        g=scale(
            get_tuple_from_to(line.g),
            get_Z_fraction(
                resolver(line.arc).from.base_voltage,
                PSY.get_base_power(resolver.sys),
            ),
        ),
    )
end

function openapi2psy(monitored::PowerOpenAPIModels.MonitoredLine, resolver::Resolver)
    PSY.MonitoredLine(
        name=monitored.name,
        available=monitored.available,
        active_power_flow=divide(
            monitored.active_power_flow,
            PSY.get_base_power(resolver.sys),
        ),
        reactive_power_flow=divide(
            monitored.reactive_power_flow,
            PSY.get_base_power(resolver.sys),
        ),
        arc=resolver(monitored.arc),
        r=divide(
            monitored.r,
            get_Z_fraction(
                resolver(monitored.arc).from.base_voltage,
                PSY.get_base_power(resolver.sys),
            ),
        ),
        x=divide(
            monitored.x,
            get_Z_fraction(
                resolver(monitored.arc).from.base_voltage,
                PSY.get_base_power(resolver.sys),
            ),
        ),
        b=scale(
            get_tuple_from_to(monitored.b),
            get_Z_fraction(
                resolver(monitored.arc).from.base_voltage,
                PSY.get_base_power(resolver.sys),
            ),
        ),
        flow_limits=divide(
            get_tuple_fromto_tofrom(monitored.flow_limits),
            PSY.get_base_power(resolver.sys),
        ),
        rating=divide(monitored.rating, PSY.get_base_power(resolver.sys)),
        angle_limits=get_tuple_min_max(monitored.angle_limits),
        rating_b=divide(monitored.rating_b, PSY.get_base_power(resolver.sys)),
        rating_c=divide(monitored.rating_c, PSY.get_base_power(resolver.sys)),
        g=scale(
            get_tuple_from_to(monitored.g),
            get_Z_fraction(
                resolver(monitored.arc).from.base_voltage,
                PSY.get_base_power(resolver.sys),
            ),
        ),
    )
end

function openapi2psy(
    transformer::PowerOpenAPIModels.PhaseShiftingTransformer,
    resolver::Resolver,
)
    PSY.PhaseShiftingTransformer(
        name=transformer.name,
        available=transformer.available,
        active_power_flow=divide(transformer.active_power_flow, transformer.base_power),
        reactive_power_flow=divide(transformer.reactive_power_flow, transformer.base_power),
        arc=resolver(transformer.arc),
        # Based off scaling TwoWindingTransformers in PSY/src/models/components.jl
        r=divide(
            transformer.r,
            get_Z_fraction(transformer.base_voltage_primary, transformer.base_power),
        ),
        x=divide(
            transformer.x,
            get_Z_fraction(transformer.base_voltage_primary, transformer.base_power),
        ),
        primary_shunt=scale(
            get_julia_complex(transformer.primary_shunt),
            get_Z_fraction(transformer.base_voltage_primary, transformer.base_power),
        ),
        tap=transformer.tap,
        α=transformer.alpha,
        rating=divide(transformer.rating, transformer.base_power),
        base_power=transformer.base_power,
        # TO-DO: incorporate default values for base voltages? unsure if this is necessary anymore
        base_voltage_primary=transformer.base_voltage_primary,
        base_voltage_secondary=transformer.base_voltage_secondary,
        rating_b=divide(transformer.rating_b, transformer.base_power),
        rating_c=divide(transformer.rating_c, transformer.base_power),
        phase_angle_limits=get_tuple_min_max(transformer.phase_angle_limits),
        control_objective=PSY.TransformerControlObjective(transformer.control_objective),
    )
end

function openapi2psy(
    phase3w::PowerOpenAPIModels.PhaseShiftingTransformer3W,
    resolver::Resolver,
)
    PSY.PhaseShiftingTransformer3W(
        name=phase3w.name,
        available=phase3w.available,
        primary_star_arc=resolver(phase3w.primary_star_arc),
        secondary_star_arc=resolver(phase3w.secondary_star_arc),
        tertiary_star_arc=resolver(phase3w.tertiary_star_arc),
        star_bus=resolver(phase3w.star_bus),
        active_power_flow_primary=divide(
            phase3w.active_power_flow_primary,
            phase3w.base_power_12,
        ),
        reactive_power_flow_primary=divide(
            phase3w.reactive_power_flow_primary,
            phase3w.base_power_12,
        ),
        active_power_flow_secondary=divide(
            phase3w.active_power_flow_secondary,
            phase3w.base_power_23,
        ),
        reactive_power_flow_secondary=divide(
            phase3w.reactive_power_flow_secondary,
            phase3w.base_power_23,
        ),
        active_power_flow_tertiary=divide(
            phase3w.active_power_flow_tertiary,
            phase3w.base_power_13,
        ),
        reactive_power_flow_tertiary=divide(
            phase3w.reactive_power_flow_tertiary,
            phase3w.base_power_13,
        ),
        r_primary=divide(
            phase3w.r_primary,
            get_Z_fraction(phase3w.base_voltage_primary, phase3w.base_power_12),
        ),
        x_primary=divide(
            phase3w.x_primary,
            get_Z_fraction(phase3w.base_voltage_primary, phase3w.base_power_12),
        ),
        r_secondary=divide(
            phase3w.r_secondary,
            get_Z_fraction(phase3w.base_voltage_secondary, phase3w.base_power_23),
        ),
        x_secondary=divide(
            phase3w.x_secondary,
            get_Z_fraction(phase3w.base_voltage_secondary, phase3w.base_power_23),
        ),
        r_tertiary=divide(
            phase3w.r_tertiary,
            get_Z_fraction(phase3w.base_voltage_tertiary, phase3w.base_power_13),
        ),
        x_tertiary=divide(
            phase3w.x_tertiary,
            get_Z_fraction(phase3w.base_voltage_tertiary, phase3w.base_power_13),
        ),
        rating=divide(phase3w.rating, phase3w.base_power_12),
        r_12=divide(
            phase3w.r_12,
            get_Z_fraction(phase3w.base_voltage_primary, phase3w.base_power_12),
        ),
        x_12=divide(
            phase3w.x_12,
            get_Z_fraction(phase3w.base_voltage_primary, phase3w.base_power_12),
        ),
        r_23=divide(
            phase3w.r_23,
            get_Z_fraction(phase3w.base_voltage_secondary, phase3w.base_power_23),
        ),
        x_23=divide(
            phase3w.x_23,
            get_Z_fraction(phase3w.base_voltage_secondary, phase3w.base_power_23),
        ),
        r_13=divide(
            phase3w.r_13,
            get_Z_fraction(phase3w.base_voltage_tertiary, phase3w.base_power_13),
        ),
        x_13=divide(
            phase3w.x_13,
            get_Z_fraction(phase3w.base_voltage_tertiary, phase3w.base_power_13),
        ),
        α_primary=phase3w.alpha_primary,
        α_secondary=phase3w.alpha_secondary,
        α_tertiary=phase3w.alpha_tertiary,
        base_power_12=phase3w.base_power_12,
        base_power_23=phase3w.base_power_23,
        base_power_13=phase3w.base_power_13,
        # TO-DO: incorporate default values for base voltages? unsure if this is necessary anymore
        base_voltage_primary=phase3w.base_voltage_primary,
        base_voltage_secondary=phase3w.base_voltage_secondary,
        base_voltage_tertiary=phase3w.base_voltage_tertiary,
        g=scale(
            phase3w.g,
            get_Z_fraction(phase3w.base_voltage_primary, phase3w.base_power_12),
        ),
        b=scale(
            phase3w.b,
            get_Z_fraction(phase3w.base_voltage_primary, phase3w.base_power_12),
        ),
        primary_turns_ratio=phase3w.primary_turns_ratio,
        secondary_turns_ratio=phase3w.secondary_turns_ratio,
        tertiary_turns_ratio=phase3w.tertiary_turns_ratio,
        available_primary=phase3w.available_primary,
        available_secondary=phase3w.available_secondary,
        available_tertiary=phase3w.available_tertiary,
        rating_primary=divide(phase3w.rating_primary, phase3w.base_power_12),
        rating_secondary=divide(phase3w.rating_secondary, phase3w.base_power_23),
        rating_tertiary=divide(phase3w.rating_tertiary, phase3w.base_power_13),
        phase_angle_limits=get_tuple_min_max(phase3w.phase_angle_limits),
        control_objective_primary=PSY.TransformerControlObjective(
            phase3w.control_objective_primary,
        ),
        control_objective_secondary=PSY.TransformerControlObjective(
            phase3w.control_objective_secondary,
        ),
        control_objective_tertiary=PSY.TransformerControlObjective(
            phase3w.control_objective_tertiary,
        ),
    )
end

function openapi2psy(taptransform::PowerOpenAPIModels.TapTransformer, resolver::Resolver)
    PSY.TapTransformer(;
        name=taptransform.name,
        available=taptransform.available,
        active_power_flow=divide(taptransform.active_power_flow, taptransform.base_power),
        reactive_power_flow=divide(
            taptransform.reactive_power_flow,
            taptransform.base_power,
        ),
        arc=resolver(taptransform.arc),
        # Based off scaling TwoWindingTransformers in PSY/src/models/components.jl
        r=divide(
            taptransform.r,
            get_Z_fraction(taptransform.base_voltage_primary, taptransform.base_power),
        ),
        x=divide(
            taptransform.x,
            get_Z_fraction(taptransform.base_voltage_primary, taptransform.base_power),
        ),
        primary_shunt=scale(
            get_julia_complex(taptransform.primary_shunt),
            get_Z_fraction(taptransform.base_voltage_primary, taptransform.base_power),
        ),
        tap=taptransform.tap,
        rating=divide(taptransform.rating, taptransform.base_power),
        base_power=taptransform.base_power,
        # TO-DO: incorporate default values for base voltages? unsure if this is necessary anymore
        base_voltage_primary=taptransform.base_voltage_primary,
        base_voltage_secondary=taptransform.base_voltage_secondary,
        rating_b=divide(taptransform.rating_b, taptransform.base_power),
        rating_c=divide(taptransform.rating_c, taptransform.base_power),
        winding_group_number=PSY.WindingGroupNumber(taptransform.winding_group_number),
        control_objective=PSY.TransformerControlObjective(taptransform.control_objective),
    )
end

function openapi2psy(tmodel::PowerOpenAPIModels.TModelHVDCLine, resolver::Resolver)
    PSY.TModelHVDCLine(
        name=tmodel.name,
        available=tmodel.available,
        active_power_flow=divide(
            tmodel.active_power_flow,
            PSY.get_base_power(resolver.sys),
        ),
        arc=resolver(tmodel.arc),
        r=tmodel.r, # not scaled on purpose as of psy v5.3
        l=tmodel.l,
        c=tmodel.c,
        active_power_limits_from=divide(
            get_tuple_min_max(tmodel.active_power_limits_from),
            PSY.get_base_power(resolver.sys),
        ),
        active_power_limits_to=divide(
            get_tuple_min_max(tmodel.active_power_limits_to),
            PSY.get_base_power(resolver.sys),
        ),
    )
end

function openapi2psy(transform::PowerOpenAPIModels.Transformer2W, resolver::Resolver)
    PSY.Transformer2W(;
        name=transform.name,
        available=transform.available,
        active_power_flow=divide(transform.active_power_flow, transform.base_power),
        reactive_power_flow=divide(transform.reactive_power_flow, transform.base_power),
        arc=resolver(transform.arc),
        # Based off scaling TwoWindingTransformers in PSY/src/models/components.jl
        r=divide(
            transform.r,
            get_Z_fraction(transform.base_voltage_primary, transform.base_power),
        ),
        x=divide(
            transform.x,
            get_Z_fraction(transform.base_voltage_primary, transform.base_power),
        ),
        primary_shunt=scale(
            get_julia_complex(transform.primary_shunt),
            get_Z_fraction(transform.base_voltage_primary, transform.base_power),
        ),
        rating=divide(transform.rating, transform.base_power),
        base_power=transform.base_power,
        # TO-DO: incorporate default values for base voltages? unsure if this is necessary anymore
        base_voltage_primary=transform.base_voltage_primary,
        base_voltage_secondary=transform.base_voltage_secondary,
        rating_b=divide(transform.rating_b, transform.base_power),
        rating_c=divide(transform.rating_c, transform.base_power),
        winding_group_number=PSY.WindingGroupNumber(transform.winding_group_number),
    )
end

function openapi2psy(trans3w::PowerOpenAPIModels.Transformer3W, resolver::Resolver)
    PSY.Transformer3W(;
        name=trans3w.name,
        available=trans3w.available,
        primary_star_arc=resolver(trans3w.primary_star_arc),
        secondary_star_arc=resolver(trans3w.secondary_star_arc),
        tertiary_star_arc=resolver(trans3w.tertiary_star_arc),
        star_bus=resolver(trans3w.star_bus),
        active_power_flow_primary=divide(
            trans3w.active_power_flow_primary,
            trans3w.base_power_12,
        ),
        reactive_power_flow_primary=divide(
            trans3w.reactive_power_flow_primary,
            trans3w.base_power_12,
        ),
        active_power_flow_secondary=divide(
            trans3w.active_power_flow_secondary,
            trans3w.base_power_23,
        ),
        reactive_power_flow_secondary=divide(
            trans3w.reactive_power_flow_secondary,
            trans3w.base_power_23,
        ),
        active_power_flow_tertiary=divide(
            trans3w.active_power_flow_tertiary,
            trans3w.base_power_13,
        ),
        reactive_power_flow_tertiary=divide(
            trans3w.reactive_power_flow_tertiary,
            trans3w.base_power_13,
        ),
        r_primary=divide(
            trans3w.r_primary,
            get_Z_fraction(trans3w.base_voltage_primary, trans3w.base_power_12),
        ),
        x_primary=divide(
            trans3w.x_primary,
            get_Z_fraction(trans3w.base_voltage_primary, trans3w.base_power_12),
        ),
        r_secondary=divide(
            trans3w.r_secondary,
            get_Z_fraction(trans3w.base_voltage_secondary, trans3w.base_power_23),
        ),
        x_secondary=divide(
            trans3w.x_secondary,
            get_Z_fraction(trans3w.base_voltage_secondary, trans3w.base_power_23),
        ),
        r_tertiary=divide(
            trans3w.r_tertiary,
            get_Z_fraction(trans3w.base_voltage_tertiary, trans3w.base_power_13),
        ),
        x_tertiary=divide(
            trans3w.x_tertiary,
            get_Z_fraction(trans3w.base_voltage_tertiary, trans3w.base_power_13),
        ),
        rating=divide(trans3w.rating, trans3w.base_power_12),
        r_12=divide(
            trans3w.r_12,
            get_Z_fraction(trans3w.base_voltage_primary, trans3w.base_power_12),
        ),
        x_12=divide(
            trans3w.x_12,
            get_Z_fraction(trans3w.base_voltage_primary, trans3w.base_power_12),
        ),
        r_23=divide(
            trans3w.r_23,
            get_Z_fraction(trans3w.base_voltage_secondary, trans3w.base_power_23),
        ),
        x_23=divide(
            trans3w.x_23,
            get_Z_fraction(trans3w.base_voltage_secondary, trans3w.base_power_23),
        ),
        r_13=divide(
            trans3w.r_13,
            get_Z_fraction(trans3w.base_voltage_tertiary, trans3w.base_power_13),
        ),
        x_13=divide(
            trans3w.x_13,
            get_Z_fraction(trans3w.base_voltage_tertiary, trans3w.base_power_13),
        ),
        base_power_12=trans3w.base_power_12,
        base_power_23=trans3w.base_power_23,
        base_power_13=trans3w.base_power_13,
        # TO-DO: incorporate default values for base voltages? unsure if this is necessary anymore
        base_voltage_primary=trans3w.base_voltage_primary,
        base_voltage_secondary=trans3w.base_voltage_secondary,
        base_voltage_tertiary=trans3w.base_voltage_tertiary,
        g=scale(
            trans3w.g,
            get_Z_fraction(trans3w.base_voltage_primary, trans3w.base_power_12),
        ),
        b=scale(
            trans3w.b,
            get_Z_fraction(trans3w.base_voltage_primary, trans3w.base_power_12),
        ),
        primary_turns_ratio=trans3w.primary_turns_ratio,
        secondary_turns_ratio=trans3w.secondary_turns_ratio,
        tertiary_turns_ratio=trans3w.tertiary_turns_ratio,
        available_primary=trans3w.available_primary,
        available_secondary=trans3w.available_secondary,
        available_tertiary=trans3w.available_tertiary,
        rating_primary=divide(trans3w.rating_primary, trans3w.base_power_12),
        rating_secondary=divide(trans3w.rating_secondary, trans3w.base_power_23),
        rating_tertiary=divide(trans3w.rating_tertiary, trans3w.base_power_13),
        primary_group_number=PSY.WindingGroupNumber(trans3w.primary_group_number),
        secondary_group_number=PSY.WindingGroupNumber(trans3w.secondary_group_number),
        tertiary_group_number=PSY.WindingGroupNumber(trans3w.tertiary_group_number),
        control_objective_primary=PSY.TransformerControlObjective(
            trans3w.control_objective_primary,
        ),
        control_objective_secondary=PSY.TransformerControlObjective(
            trans3w.control_objective_secondary,
        ),
        control_objective_tertiary=PSY.TransformerControlObjective(
            trans3w.control_objective_tertiary,
        ),
    )
end

function openapi2psy(
    hvdc::PowerOpenAPIModels.TwoTerminalGenericHVDCLine,
    resolver::Resolver,
)
    PSY.TwoTerminalGenericHVDCLine(
        name=hvdc.name,
        available=hvdc.available,
        active_power_flow=divide(hvdc.active_power_flow, PSY.get_base_power(resolver.sys)),
        arc=resolver(hvdc.arc),
        active_power_limits_from=divide(
            get_tuple_min_max(hvdc.active_power_limits_from),
            PSY.get_base_power(resolver.sys),
        ),
        active_power_limits_to=divide(
            get_tuple_min_max(hvdc.active_power_limits_to),
            PSY.get_base_power(resolver.sys),
        ),
        reactive_power_limits_from=divide(
            get_tuple_min_max(hvdc.reactive_power_limits_from),
            PSY.get_base_power(resolver.sys),
        ),
        reactive_power_limits_to=divide(
            get_tuple_min_max(hvdc.reactive_power_limits_to),
            PSY.get_base_power(resolver.sys),
        ),
        loss=get_sienna_value_curve(hvdc.loss),
    )
end

function openapi2psy(lcc::PowerOpenAPIModels.TwoTerminalLCCLine, resolver::Resolver)
    PSY.TwoTerminalLCCLine(
        name=lcc.name,
        available=lcc.available,
        arc=resolver(lcc.arc),
        active_power_flow=divide(lcc.active_power_flow, PSY.get_base_power(resolver.sys)),
        r=lcc.r, # not scaled on purpose as of psy v5.3
        transfer_setpoint=lcc.transfer_setpoint,
        scheduled_dc_voltage=lcc.scheduled_dc_voltage,
        rectifier_bridges=lcc.rectifier_bridges,
        rectifier_delay_angle_limits=get_tuple_min_max(lcc.rectifier_delay_angle_limits),
        rectifier_rc=lcc.rectifier_rc, # not scaled on purpose as of psy v5.3
        rectifier_xc=lcc.rectifier_xc, # not scaled on purpose as of psy v5.3
        rectifier_base_voltage=lcc.rectifier_base_voltage,
        inverter_bridges=lcc.inverter_bridges,
        inverter_extinction_angle_limits=get_tuple_min_max(
            lcc.inverter_extinction_angle_limits,
        ),
        inverter_rc=lcc.inverter_rc, # not scaled on purpose as of psy v5.3
        inverter_xc=lcc.inverter_xc, # not scaled on purpose as of psy v5.3
        inverter_base_voltage=lcc.inverter_base_voltage,
        power_mode=lcc.power_mode,
        switch_mode_voltage=lcc.switch_mode_voltage,
        compounding_resistance=lcc.compounding_resistance,
        min_compounding_voltage=lcc.min_compounding_voltage,
        rectifier_transformer_ratio=lcc.rectifier_transformer_ratio,
        rectifier_tap_setting=lcc.rectifier_tap_setting,
        rectifier_tap_limits=get_tuple_min_max(lcc.rectifier_tap_limits),
        rectifier_tap_step=lcc.rectifier_tap_step,
        rectifier_delay_angle=lcc.rectifier_delay_angle,
        rectifier_capacitor_reactance=lcc.rectifier_capacitor_reactance,
        inverter_transformer_ratio=lcc.inverter_transformer_ratio,
        inverter_tap_setting=lcc.inverter_tap_setting,
        inverter_tap_limits=get_tuple_min_max(lcc.inverter_tap_limits),
        inverter_tap_step=lcc.inverter_tap_step,
        inverter_extinction_angle=lcc.inverter_extinction_angle,
        inverter_capacitor_reactance=lcc.inverter_capacitor_reactance,
        active_power_limits_from=divide(
            get_tuple_min_max(lcc.active_power_limits_from),
            PSY.get_base_power(resolver.sys),
        ),
        active_power_limits_to=divide(
            get_tuple_min_max(lcc.active_power_limits_to),
            PSY.get_base_power(resolver.sys),
        ),
        reactive_power_limits_from=divide(
            get_tuple_min_max(lcc.reactive_power_limits_from),
            PSY.get_base_power(resolver.sys),
        ),
        reactive_power_limits_to=divide(
            get_tuple_min_max(lcc.reactive_power_limits_to),
            PSY.get_base_power(resolver.sys),
        ),
        loss=get_sienna_value_curve(lcc.loss),
    )
end

function openapi2psy(vsc::PowerOpenAPIModels.TwoTerminalVSCLine, resolver::Resolver)
    PSY.TwoTerminalVSCLine(
        name=vsc.name,
        available=vsc.available,
        arc=resolver(vsc.arc),
        active_power_flow=divide(vsc.active_power_flow, PSY.get_base_power(resolver.sys)),
        rating=divide(vsc.rating, PSY.get_base_power(resolver.sys)),
        active_power_limits_from=divide(
            get_tuple_min_max(vsc.active_power_limits_from),
            PSY.get_base_power(resolver.sys),
        ),
        active_power_limits_to=divide(
            get_tuple_min_max(vsc.active_power_limits_to),
            PSY.get_base_power(resolver.sys),
        ),
        g=vsc.g, # not scaled on purpose as of psy v5.3
        dc_current=vsc.dc_current,
        reactive_power_from=divide(
            vsc.reactive_power_from,
            PSY.get_base_power(resolver.sys),
        ),
        dc_voltage_control_from=vsc.dc_voltage_control_from,
        ac_voltage_control_from=vsc.ac_voltage_control_from,
        dc_setpoint_from=vsc.dc_setpoint_from,
        ac_setpoint_from=vsc.ac_setpoint_from,
        converter_loss_from=get_sienna_value_curve(vsc.converter_loss_from),
        max_dc_current_from=vsc.max_dc_current_from,
        rating_from=divide(vsc.rating_from, PSY.get_base_power(resolver.sys)),
        reactive_power_limits_from=divide(
            get_tuple_min_max(vsc.reactive_power_limits_from),
            PSY.get_base_power(resolver.sys),
        ),
        power_factor_weighting_fraction_from=vsc.power_factor_weighting_fraction_from,
        voltage_limits_from=get_tuple_min_max(vsc.voltage_limits_from),
        reactive_power_to=divide(vsc.reactive_power_to, PSY.get_base_power(resolver.sys)),
        dc_voltage_control_to=vsc.dc_voltage_control_to,
        ac_voltage_control_to=vsc.ac_voltage_control_to,
        dc_setpoint_to=vsc.dc_setpoint_to,
        ac_setpoint_to=vsc.ac_setpoint_to,
        converter_loss_to=get_sienna_value_curve(vsc.converter_loss_to),
        max_dc_current_to=vsc.max_dc_current_to,
        rating_to=divide(vsc.rating_to, PSY.get_base_power(resolver.sys)),
        reactive_power_limits_to=divide(
            get_tuple_min_max(vsc.reactive_power_limits_to),
            PSY.get_base_power(resolver.sys),
        ),
        power_factor_weighting_fraction_to=vsc.power_factor_weighting_fraction_to,
        voltage_limits_to=get_tuple_min_max(vsc.voltage_limits_to),
    )
end
