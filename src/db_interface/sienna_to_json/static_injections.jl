function psy2openapi(energy_res::PSY.EnergyReservoirStorage, ids::IDGenerator)
    EnergyReservoirStorage(
        id=getid!(ids, energy_res),
        name=energy_res.name,
        available=energy_res.available,
        bus=getid!(ids, energy_res.bus),
        prime_mover_type=string(energy_res.prime_mover_type),
        storage_technology_type=string(energy_res.storage_technology_type),
        storage_capacity=scale(energy_res.storage_capacity, energy_res.base_power),
        storage_level_limits=get_min_max(energy_res.storage_level_limits),
        initial_storage_capacity_level=energy_res.initial_storage_capacity_level,
        rating=scale(energy_res.rating, energy_res.base_power),
        active_power=scale(energy_res.active_power, energy_res.base_power),
        input_active_power_limits=get_min_max(
            scale(energy_res.input_active_power_limits, energy_res.base_power),
        ),
        output_active_power_limits=get_min_max(
            scale(energy_res.output_active_power_limits, energy_res.base_power),
        ),
        efficiency=get_in_out(energy_res.efficiency),
        reactive_power=scale(energy_res.reactive_power, energy_res.base_power),
        reactive_power_limits=get_min_max(
            scale(energy_res.reactive_power_limits, energy_res.base_power),
        ),
        base_power=energy_res.base_power,
        operation_cost=get_operation_cost(energy_res.operation_cost),
        conversion_factor=energy_res.conversion_factor,
        storage_target=energy_res.storage_target,
        cycle_limits=energy_res.cycle_limits,
        dynamic_injector=getid!(ids, energy_res.dynamic_injector),
    )
end

function psy2openapi(load::PSY.ExponentialLoad, ids::IDGenerator)
    ExponentialLoad(
        id=getid!(ids, load),
        name=load.name,
        available=load.available,
        bus=getid!(ids, load.bus),
        active_power=scale(load.active_power, load.base_power),
        reactive_power=scale(load.reactive_power, load.base_power),
        alpha=load.α,
        beta=load.β,
        base_power=load.base_power,
        max_active_power=scale(load.max_active_power, load.base_power),
        max_reactive_power=scale(load.max_reactive_power, load.base_power),
        conformity=string(load.conformity),
        dynamic_injector=getid!(ids, load.dynamic_injector),
    )
end

function psy2openapi(facts::PSY.FACTSControlDevice, ids::IDGenerator)
    FACTSControlDevice(
        id=getid!(ids, facts),
        name=facts.name,
        available=facts.available,
        bus=getid!(ids, facts.bus),
        control_mode=string(facts.control_mode),
        voltage_setpoint=facts.voltage_setpoint,
        max_shunt_current=facts.max_shunt_current,
        reactive_power_required=facts.reactive_power_required,
        dynamic_injector=getid!(ids, facts.dynamic_injector),
    )
end

function psy2openapi(fixedadmit::PSY.FixedAdmittance, ids::IDGenerator)
    FixedAdmittance(
        id=getid!(ids, fixedadmit),
        name=fixedadmit.name,
        available=fixedadmit.available,
        bus=getid!(ids, fixedadmit.bus),
        Y=get_complex_number(fixedadmit.Y),
        dynamic_injector=getid!(ids, fixedadmit.dynamic_injector),
    )
end

function psy2openapi(hydro::PSY.HydroDispatch, ids::IDGenerator)
    HydroDispatch(
        id=getid!(ids, hydro),
        name=hydro.name,
        available=hydro.available,
        bus=getid!(ids, hydro.bus),
        active_power=scale(hydro.active_power, hydro.base_power),
        reactive_power=scale(hydro.reactive_power, hydro.base_power),
        rating=scale(hydro.rating, hydro.base_power),
        prime_mover_type=string(hydro.prime_mover_type),
        active_power_limits=get_min_max(scale(hydro.active_power_limits, hydro.base_power)),
        reactive_power_limits=get_min_max(
            scale(hydro.reactive_power_limits, hydro.base_power),
        ),
        ramp_limits=get_up_down(scale(hydro.ramp_limits, hydro.base_power)),
        time_limits=get_up_down(hydro.time_limits),
        base_power=hydro.base_power,
        status=hydro.status,
        time_at_status=hydro.time_at_status,
        operation_cost=get_operation_cost(hydro.operation_cost),
        dynamic_injector=getid!(ids, hydro.dynamic_injector),
    )
end

function psy2openapi(hydro::PSY.HydroPumpTurbine, ids::IDGenerator)
    HydroPumpTurbine(
        id=getid!(ids, hydro),
        name=hydro.name,
        available=hydro.available,
        bus=getid!(ids, hydro.bus),
        active_power=scale(hydro.active_power, hydro.base_power),
        reactive_power=scale(hydro.reactive_power, hydro.base_power),
        rating=scale(hydro.rating, hydro.base_power),
        active_power_limits=get_min_max(scale(hydro.active_power_limits, hydro.base_power)),
        reactive_power_limits=get_min_max(
            scale(hydro.reactive_power_limits, hydro.base_power),
        ),
        active_power_limits_pump=get_min_max(
            scale(hydro.active_power_limits_pump, hydro.base_power),
        ),
        outflow_limits=get_min_max(hydro.outflow_limits),
        powerhouse_elevation=hydro.powerhouse_elevation,
        ramp_limits=get_up_down(scale(hydro.ramp_limits, hydro.base_power)),
        time_limits=get_up_down(hydro.time_limits),
        base_power=hydro.base_power,
        status=string(hydro.status),
        time_at_status=hydro.time_at_status,
        operation_cost=get_operation_cost(hydro.operation_cost),
        active_power_pump=scale(hydro.active_power_pump, hydro.base_power),
        efficiency=get_turbine_pump(hydro.efficiency),
        transition_time=get_turbine_pump(hydro.transition_time),
        minimum_time=get_turbine_pump(hydro.minimum_time),
        travel_time=hydro.travel_time,
        conversion_factor=hydro.conversion_factor,
        must_run=hydro.must_run,
        prime_mover_type=string(hydro.prime_mover_type),
        dynamic_injector=getid!(ids, hydro.dynamic_injector),
    )
end

function psy2openapi(hydro::PSY.HydroReservoir, ids::IDGenerator)
    HydroReservoir(
        id=getid!(ids, hydro),
        name=hydro.name,
        available=hydro.available,
        storage_level_limits=get_min_max(hydro.storage_level_limits),
        initial_level=hydro.initial_level,
        spillage_limits=get_min_max(hydro.spillage_limits),
        inflow=hydro.inflow,
        outflow=hydro.outflow,
        level_targets=hydro.level_targets,
        intake_elevation=hydro.intake_elevation,
        head_to_volume_factor=ValueCurve(get_value_curve(hydro.head_to_volume_factor)),
        upstream_turbines=map(c -> getid!(ids, c), hydro.upstream_turbines), # this is a vector of "HydroUnit"s
        downstream_turbines=map(c -> getid!(ids, c), hydro.downstream_turbines), # this is a vector of "HydroUnit"s
        upstream_reservoirs=map(c -> getid!(ids, c), hydro.upstream_reservoirs), # this is a vector of "Device"s
        operation_cost=get_operation_cost(hydro.operation_cost),
        level_data_type=string(hydro.level_data_type),
    )
end

function psy2openapi(hydro::PSY.HydroTurbine, ids::IDGenerator)
    HydroTurbine(
        id=getid!(ids, hydro),
        name=hydro.name,
        available=hydro.available,
        bus=getid!(ids, hydro.bus),
        active_power=scale(hydro.active_power, hydro.base_power),
        reactive_power=scale(hydro.reactive_power, hydro.base_power),
        rating=scale(hydro.rating, hydro.base_power),
        active_power_limits=get_min_max(scale(hydro.active_power_limits, hydro.base_power)),
        reactive_power_limits=get_min_max(
            scale(hydro.reactive_power_limits, hydro.base_power),
        ),
        base_power=hydro.base_power,
        operation_cost=get_operation_cost(hydro.operation_cost),
        powerhouse_elevation=hydro.powerhouse_elevation,
        ramp_limits=get_up_down(scale(hydro.ramp_limits, hydro.base_power)),
        time_limits=get_up_down(hydro.time_limits),
        outflow_limits=get_min_max(hydro.outflow_limits),
        efficiency=hydro.efficiency,
        turbine_type=string(hydro.turbine_type),
        conversion_factor=hydro.conversion_factor,
        prime_mover_type=string(hydro.prime_mover_type),
        travel_time=hydro.travel_time,
        dynamic_injector=getid!(ids, hydro.dynamic_injector),
    )
end

function psy2openapi(inter::PSY.InterconnectingConverter, ids::IDGenerator)
    InterconnectingConverter(
        id=getid!(ids, inter),
        name=inter.name,
        available=inter.available,
        bus=getid!(ids, inter.bus),
        dc_bus=getid!(ids, inter.dc_bus),
        active_power=scale(inter.active_power, inter.base_power),
        rating=scale(inter.rating, inter.base_power),
        active_power_limits=get_min_max(scale(inter.active_power_limits, inter.base_power)),
        base_power=inter.base_power,
        dc_current=inter.dc_current,
        max_dc_current=inter.max_dc_current,
        loss_function=get_value_curve(inter.loss_function),
        dynamic_injector=getid!(ids, inter.dynamic_injector),
    )
end

function psy2openapi(interrupt_power::PSY.InterruptiblePowerLoad, ids::IDGenerator)
    InterruptiblePowerLoad(
        id=getid!(ids, interrupt_power),
        name=interrupt_power.name,
        available=interrupt_power.available,
        bus=getid!(ids, interrupt_power.bus),
        active_power=scale(interrupt_power.active_power, interrupt_power.base_power),
        reactive_power=scale(interrupt_power.reactive_power, interrupt_power.base_power),
        max_active_power=scale(
            interrupt_power.max_active_power,
            interrupt_power.base_power,
        ),
        max_reactive_power=scale(
            interrupt_power.max_reactive_power,
            interrupt_power.base_power,
        ),
        base_power=interrupt_power.base_power,
        operation_cost=get_operation_cost(interrupt_power.operation_cost),
        conformity=string(interrupt_power.conformity),
        dynamic_injector=getid!(ids, interrupt_power.dynamic_injector),
    )
end

function psy2openapi(interrupt_standard::PSY.InterruptibleStandardLoad, ids::IDGenerator)
    InterruptibleStandardLoad(
        id=getid!(ids, interrupt_standard),
        name=interrupt_standard.name,
        available=interrupt_standard.available,
        bus=getid!(ids, interrupt_standard.bus),
        base_power=interrupt_standard.base_power,
        operation_cost=get_operation_cost(interrupt_standard.operation_cost),
        conformity=string(interrupt_standard.conformity),
        constant_active_power=scale(
            interrupt_standard.constant_active_power,
            interrupt_standard.base_power,
        ),
        constant_reactive_power=scale(
            interrupt_standard.constant_reactive_power,
            interrupt_standard.base_power,
        ),
        impedance_active_power=scale(
            interrupt_standard.impedance_active_power,
            interrupt_standard.base_power,
        ),
        impedance_reactive_power=scale(
            interrupt_standard.impedance_reactive_power,
            interrupt_standard.base_power,
        ),
        current_active_power=scale(
            interrupt_standard.current_active_power,
            interrupt_standard.base_power,
        ),
        current_reactive_power=scale(
            interrupt_standard.current_reactive_power,
            interrupt_standard.base_power,
        ),
        max_constant_active_power=scale(
            interrupt_standard.max_constant_active_power,
            interrupt_standard.base_power,
        ),
        max_constant_reactive_power=scale(
            interrupt_standard.max_constant_reactive_power,
            interrupt_standard.base_power,
        ),
        max_impedance_active_power=scale(
            interrupt_standard.max_impedance_active_power,
            interrupt_standard.base_power,
        ),
        max_impedance_reactive_power=scale(
            interrupt_standard.max_impedance_reactive_power,
            interrupt_standard.base_power,
        ),
        max_current_active_power=scale(
            interrupt_standard.max_current_active_power,
            interrupt_standard.base_power,
        ),
        max_current_reactive_power=scale(
            interrupt_standard.max_current_reactive_power,
            interrupt_standard.base_power,
        ),
        dynamic_injector=getid!(ids, interrupt_standard.dynamic_injector),
    )
end

function psy2openapi(motor_load::PSY.MotorLoad, ids::IDGenerator)
    MotorLoad(
        id=getid!(ids, motor_load),
        name=motor_load.name,
        available=motor_load.available,
        bus=getid!(ids, motor_load.bus),
        active_power=scale(motor_load.active_power, motor_load.base_power),
        reactive_power=scale(motor_load.reactive_power, motor_load.base_power),
        base_power=motor_load.base_power,
        rating=scale(motor_load.rating, motor_load.base_power),
        max_active_power=scale(motor_load.max_active_power, motor_load.base_power),
        reactive_power_limits=get_min_max(
            scale(motor_load.reactive_power_limits, motor_load.base_power),
        ),
        motor_technology=string(motor_load.motor_technology),
        dynamic_injector=getid!(ids, motor_load.dynamic_injector),
    )
end

function psy2openapi(power_load::PSY.PowerLoad, ids::IDGenerator)
    PowerLoad(
        id=getid!(ids, power_load),
        name=power_load.name,
        available=power_load.available,
        bus=getid!(ids, power_load.bus),
        active_power=scale(power_load.active_power, power_load.base_power),
        reactive_power=scale(power_load.reactive_power, power_load.base_power),
        base_power=power_load.base_power,
        max_active_power=scale(power_load.max_active_power, power_load.base_power),
        max_reactive_power=scale(power_load.max_reactive_power, power_load.base_power),
        conformity=string(power_load.conformity),
        dynamic_injector=getid!(ids, power_load.dynamic_injector),
    )
end

function psy2openapi(renewable::PSY.RenewableDispatch, ids::IDGenerator)
    RenewableDispatch(
        id=getid!(ids, renewable),
        name=renewable.name,
        available=renewable.available,
        bus=getid!(ids, renewable.bus),
        active_power=scale(renewable.active_power, renewable.base_power),
        reactive_power=scale(renewable.reactive_power, renewable.base_power),
        rating=scale(renewable.rating, renewable.base_power),
        prime_mover_type=string(renewable.prime_mover_type),
        reactive_power_limits=get_min_max(
            scale(renewable.reactive_power_limits, renewable.base_power),
        ),
        power_factor=renewable.power_factor,
        operation_cost=get_operation_cost(renewable.operation_cost),
        base_power=renewable.base_power,
        dynamic_injector=getid!(ids, renewable.dynamic_injector),
    )
end

function psy2openapi(renewnondispatch::PSY.RenewableNonDispatch, ids::IDGenerator)
    RenewableNonDispatch(
        id=getid!(ids, renewnondispatch),
        name=renewnondispatch.name,
        available=renewnondispatch.available,
        bus=getid!(ids, renewnondispatch.bus),
        active_power=scale(renewnondispatch.active_power, renewnondispatch.base_power),
        reactive_power=scale(renewnondispatch.reactive_power, renewnondispatch.base_power),
        rating=scale(renewnondispatch.rating, renewnondispatch.base_power),
        prime_mover_type=string(renewnondispatch.prime_mover_type),
        power_factor=renewnondispatch.power_factor,
        base_power=renewnondispatch.base_power,
        dynamic_injector=getid!(ids, renewnondispatch.dynamic_injector),
    )
end

function psy2openapi(power_load::PSY.ShiftablePowerLoad, ids::IDGenerator)
    ShiftablePowerLoad(
        id=getid!(ids, power_load),
        name=power_load.name,
        available=power_load.available,
        bus=getid!(ids, power_load.bus),
        active_power=scale(power_load.active_power, power_load.base_power),
        active_power_limits=get_min_max(
            scale(power_load.active_power_limits, power_load.base_power),
        ),
        reactive_power=scale(power_load.reactive_power, power_load.base_power),
        max_active_power=scale(power_load.max_active_power, power_load.base_power),
        max_reactive_power=scale(power_load.max_reactive_power, power_load.base_power),
        base_power=power_load.base_power,
        load_balance_time_horizon=power_load.load_balance_time_horizon,
        operation_cost=get_operation_cost(power_load.operation_cost),
        dynamic_injector=getid!(ids, power_load.dynamic_injector),
    )
end

function psy2openapi(source::PSY.Source, ids::IDGenerator)
    Source(
        id=getid!(ids, source),
        name=source.name,
        available=source.available,
        bus=getid!(ids, source.bus),
        active_power=scale(source.active_power, source.base_power),
        reactive_power=scale(source.reactive_power, source.base_power),
        active_power_limits=get_min_max(
            scale(source.active_power_limits, source.base_power),
        ),
        reactive_power_limits=get_min_max(
            scale(source.reactive_power_limits, source.base_power),
        ),
        R_th=source.R_th,
        X_th=source.X_th,
        internal_voltage=source.internal_voltage,
        internal_angle=source.internal_angle,
        base_power=source.base_power,
        operation_cost=get_operation_cost(source.operation_cost),
        dynamic_injector=getid!(ids, source.dynamic_injector),
    )
end

function psy2openapi(standard_load::PSY.StandardLoad, ids::IDGenerator)
    StandardLoad(
        id=getid!(ids, standard_load),
        name=standard_load.name,
        available=standard_load.available,
        bus=getid!(ids, standard_load.bus),
        base_power=standard_load.base_power,
        constant_active_power=scale(
            standard_load.constant_active_power,
            standard_load.base_power,
        ),
        constant_reactive_power=scale(
            standard_load.constant_reactive_power,
            standard_load.base_power,
        ),
        impedance_active_power=scale(
            standard_load.impedance_active_power,
            standard_load.base_power,
        ),
        impedance_reactive_power=scale(
            standard_load.impedance_reactive_power,
            standard_load.base_power,
        ),
        current_active_power=scale(
            standard_load.current_active_power,
            standard_load.base_power,
        ),
        current_reactive_power=scale(
            standard_load.current_reactive_power,
            standard_load.base_power,
        ),
        max_constant_active_power=scale(
            standard_load.max_constant_active_power,
            standard_load.base_power,
        ),
        max_constant_reactive_power=scale(
            standard_load.max_constant_reactive_power,
            standard_load.base_power,
        ),
        max_impedance_active_power=scale(
            standard_load.max_impedance_active_power,
            standard_load.base_power,
        ),
        max_impedance_reactive_power=scale(
            standard_load.max_impedance_reactive_power,
            standard_load.base_power,
        ),
        max_current_active_power=scale(
            standard_load.max_current_active_power,
            standard_load.base_power,
        ),
        max_current_reactive_power=scale(
            standard_load.max_current_reactive_power,
            standard_load.base_power,
        ),
        conformity=string(standard_load.conformity),
        dynamic_injector=getid!(ids, standard_load.dynamic_injector),
    )
end

function psy2openapi(switch::PSY.SwitchedAdmittance, ids::IDGenerator)
    SwitchedAdmittance(
        id=getid!(ids, switch),
        name=switch.name,
        available=switch.available,
        bus=getid!(ids, switch.bus),
        Y=get_complex_number(switch.Y),
        initial_status=switch.initial_status,
        number_of_steps=switch.number_of_steps,
        Y_increase=map(get_complex_number, switch.Y_increase),
        admittance_limits=get_min_max(switch.admittance_limits),
        dynamic_injector=getid!(ids, switch.dynamic_injector),
    )
end

function psy2openapi(synch::PSY.SynchronousCondenser, ids::IDGenerator)
    SynchronousCondenser(
        id=getid!(ids, synch),
        name=synch.name,
        available=synch.available,
        bus=getid!(ids, synch.bus),
        reactive_power=scale(synch.reactive_power, synch.base_power),
        rating=scale(synch.rating, synch.base_power),
        reactive_power_limits=get_min_max(
            scale(synch.reactive_power_limits, synch.base_power),
        ),
        base_power=synch.base_power,
        active_power_losses=scale(synch.active_power_losses, synch.base_power),
        dynamic_injector=getid!(ids, synch.dynamic_injector),
    )
end

function psy2openapi(multi::PSY.ThermalMultiStart, ids::IDGenerator)
    ThermalMultiStart(
        id=getid!(ids, multi),
        name=multi.name,
        available=multi.available,
        status=multi.status,
        bus=getid!(ids, multi.bus),
        active_power=scale(multi.active_power, multi.base_power),
        reactive_power=scale(multi.reactive_power, multi.base_power),
        rating=scale(multi.rating, multi.base_power),
        prime_mover_type=string(multi.prime_mover_type),
        fuel=string(multi.fuel),
        active_power_limits=get_min_max(scale(multi.active_power_limits, multi.base_power)),
        reactive_power_limits=get_min_max(
            scale(multi.reactive_power_limits, multi.base_power),
        ),
        ramp_limits=get_up_down(scale(multi.ramp_limits, multi.base_power)),
        power_trajectory=get_startup_shutdown(
            scale(multi.power_trajectory, multi.base_power),
        ),
        time_limits=get_up_down(multi.time_limits),
        start_time_limits=get_startup(multi.start_time_limits),
        start_types=multi.start_types,
        operation_cost=get_operation_cost(multi.operation_cost),
        base_power=multi.base_power,
        time_at_status=multi.time_at_status,
        must_run=multi.must_run,
        dynamic_injector=getid!(ids, multi.dynamic_injector),
    )
end

function psy2openapi(thermal_standard::PSY.ThermalStandard, ids::IDGenerator)
    ThermalStandard(
        id=getid!(ids, thermal_standard),
        name=thermal_standard.name,
        prime_mover_type=string(thermal_standard.prime_mover_type),
        fuel_type=string(thermal_standard.fuel),
        rating=scale(thermal_standard.rating, thermal_standard.base_power),
        base_power=thermal_standard.base_power,
        available=thermal_standard.available,
        status=thermal_standard.status,
        time_at_status=thermal_standard.time_at_status,
        active_power=scale(thermal_standard.active_power, thermal_standard.base_power),
        reactive_power=scale(thermal_standard.reactive_power, thermal_standard.base_power),
        active_power_limits=get_min_max(
            scale(thermal_standard.active_power_limits, thermal_standard.base_power),
        ),
        reactive_power_limits=get_min_max(
            scale(thermal_standard.reactive_power_limits, thermal_standard.base_power),
        ),
        ramp_limits=get_up_down(
            scale(thermal_standard.ramp_limits, thermal_standard.base_power),
        ),
        operation_cost=get_operation_cost(thermal_standard.operation_cost),
        time_limits=get_up_down(thermal_standard.time_limits),
        must_run=thermal_standard.must_run,
        bus=getid!(ids, thermal_standard.bus),
    )
end
