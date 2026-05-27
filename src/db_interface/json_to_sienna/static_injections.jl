function openapi2psy(energy_res::PowerOpenAPIModels.EnergyReservoirStorage, resolver::Resolver)
    PSY.EnergyReservoirStorage(;
        name=energy_res.name,
        available=energy_res.available,
        bus=resolver(energy_res.bus),
        prime_mover_type=PSY.PrimeMovers(energy_res.prime_mover_type),
        storage_technology_type=PSY.StorageTech(energy_res.storage_technology_type),
        storage_capacity=divide(energy_res.storage_capacity, energy_res.base_power),
        storage_level_limits=get_tuple_min_max(energy_res.storage_level_limits),
        initial_storage_capacity_level=energy_res.initial_storage_capacity_level,
        rating=divide(energy_res.rating, energy_res.base_power),
        active_power=divide(energy_res.active_power, energy_res.base_power),
        input_active_power_limits=divide(
            get_tuple_min_max(energy_res.input_active_power_limits),
            energy_res.base_power,
        ),
        output_active_power_limits=divide(
            get_tuple_min_max(energy_res.output_active_power_limits),
            energy_res.base_power,
        ),
        efficiency=get_tuple_in_out(energy_res.efficiency),
        reactive_power=divide(energy_res.reactive_power, energy_res.base_power),
        reactive_power_limits=divide(
            get_tuple_min_max(energy_res.reactive_power_limits),
            energy_res.base_power,
        ),
        base_power=energy_res.base_power,
        operation_cost=get_sienna_operation_cost(energy_res.operation_cost),
        conversion_factor=energy_res.conversion_factor,
        storage_target=energy_res.storage_target,
        cycle_limits=energy_res.cycle_limits,
    )
end

function openapi2psy(load::PowerOpenAPIModels.ExponentialLoad, resolver::Resolver)
    PSY.ExponentialLoad(
        name=load.name,
        available=load.available,
        bus=resolver(load.bus),
        active_power=divide(load.active_power, load.base_power),
        reactive_power=divide(load.reactive_power, load.base_power),
        α=load.alpha,
        β=load.beta,
        base_power=load.base_power,
        max_active_power=divide(load.max_active_power, load.base_power),
        max_reactive_power=divide(load.max_reactive_power, load.base_power),
        conformity=PSY.LoadConformity(load.conformity),
    )
end

function openapi2psy(facts::PowerOpenAPIModels.FACTSControlDevice, resolver::Resolver)
    PSY.FACTSControlDevice(
        name=facts.name,
        available=facts.available,
        bus=resolver(facts.bus),
        control_mode=PSY.FACTSOperationModes(facts.control_mode),
        voltage_setpoint=facts.voltage_setpoint,
        max_shunt_current=facts.max_shunt_current,
        reactive_power_required=facts.reactive_power_required,
    )
end

function openapi2psy(fixed::PowerOpenAPIModels.FixedAdmittance, resolver::Resolver)
    PSY.FixedAdmittance(
        name=fixed.name,
        available=fixed.available,
        bus=resolver(fixed.bus),
        Y=get_julia_complex(fixed.Y),
    )
end

function openapi2psy(hydro::PowerOpenAPIModels.HydroDispatch, resolver::Resolver)
    PSY.HydroDispatch(;
        name=hydro.name,
        available=hydro.available,
        bus=resolver(hydro.bus),
        active_power=divide(hydro.active_power, hydro.base_power),
        reactive_power=divide(hydro.reactive_power, hydro.base_power),
        rating=divide(hydro.rating, hydro.base_power),
        prime_mover_type=PSY.PrimeMovers(hydro.prime_mover_type),
        active_power_limits=divide(
            get_tuple_min_max(hydro.active_power_limits),
            hydro.base_power,
        ),
        reactive_power_limits=divide(
            get_tuple_min_max(hydro.reactive_power_limits),
            hydro.base_power,
        ),
        ramp_limits=divide(get_tuple_up_down(hydro.ramp_limits), hydro.base_power),
        time_limits=get_tuple_up_down(hydro.time_limits),
        base_power=hydro.base_power,
        status=hydro.status,
        time_at_status=hydro.time_at_status,
        operation_cost=get_sienna_operation_cost(hydro.operation_cost),
    )
end

function openapi2psy(hydro::PowerOpenAPIModels.HydroPumpTurbine, resolver::Resolver)
    PSY.HydroPumpTurbine(
        name=hydro.name,
        available=hydro.available,
        bus=resolver(hydro.bus),
        active_power=divide(hydro.active_power, hydro.base_power),
        reactive_power=divide(hydro.reactive_power, hydro.base_power),
        rating=divide(hydro.rating, hydro.base_power),
        active_power_limits=divide(
            get_tuple_min_max(hydro.active_power_limits),
            hydro.base_power,
        ),
        reactive_power_limits=divide(
            get_tuple_min_max(hydro.reactive_power_limits),
            hydro.base_power,
        ),
        active_power_limits_pump=divide(
            get_tuple_min_max(hydro.active_power_limits_pump),
            hydro.base_power,
        ),
        outflow_limits=get_tuple_min_max(hydro.outflow_limits),
        powerhouse_elevation=hydro.powerhouse_elevation,
        ramp_limits=divide(get_tuple_up_down(hydro.ramp_limits), hydro.base_power),
        time_limits=get_tuple_up_down(hydro.time_limits),
        base_power=hydro.base_power,
        status=PSY.PumpHydroStatus(hydro.status),
        time_at_status=hydro.time_at_status,
        operation_cost=get_sienna_operation_cost(hydro.operation_cost),
        active_power_pump=divide(hydro.active_power_pump, hydro.base_power),
        efficiency=get_tuple_turbine_pump(hydro.efficiency),
        transition_time=get_tuple_turbine_pump(hydro.transition_time),
        minimum_time=get_tuple_turbine_pump(hydro.minimum_time),
        travel_time=hydro.travel_time,
        conversion_factor=hydro.conversion_factor,
        must_run=hydro.must_run,
        prime_mover_type=PSY.PrimeMovers(hydro.prime_mover_type),
    )
end

function openapi2psy(hydro::PowerOpenAPIModels.HydroReservoir, resolver::Resolver)
    PSY.HydroReservoir(
        name=hydro.name,
        available=hydro.available,
        storage_level_limits=get_tuple_min_max(hydro.storage_level_limits),
        initial_level=hydro.initial_level,
        spillage_limits=get_tuple_min_max(hydro.spillage_limits),
        inflow=hydro.inflow,
        outflow=hydro.outflow,
        level_targets=hydro.level_targets,
        intake_elevation=hydro.intake_elevation,
        head_to_volume_factor=get_sienna_value_curve(hydro.head_to_volume_factor),
        upstream_turbines=map(resolver, hydro.upstream_turbines), # this is a vector of "HydroUnit"s
        downstream_turbines=map(resolver, hydro.downstream_turbines), # this is a vector of "HydroUnit"s
        upstream_reservoirs=map(resolver, hydro.upstream_reservoirs), # this is a vector of "Device"s
        operation_cost=get_sienna_operation_cost(hydro.operation_cost),
        level_data_type=PSY.ReservoirDataType(hydro.level_data_type),
    )
end

function openapi2psy(hydro::PowerOpenAPIModels.HydroTurbine, resolver::Resolver)
    PSY.HydroTurbine(
        name=hydro.name,
        available=hydro.available,
        bus=resolver(hydro.bus),
        active_power=divide(hydro.active_power, hydro.base_power),
        reactive_power=divide(hydro.reactive_power, hydro.base_power),
        rating=divide(hydro.rating, hydro.base_power),
        active_power_limits=divide(
            get_tuple_min_max(hydro.active_power_limits),
            hydro.base_power,
        ),
        reactive_power_limits=divide(
            get_tuple_min_max(hydro.reactive_power_limits),
            hydro.base_power,
        ),
        base_power=hydro.base_power,
        operation_cost=get_sienna_operation_cost(hydro.operation_cost),
        powerhouse_elevation=hydro.powerhouse_elevation,
        ramp_limits=divide(get_tuple_up_down(hydro.ramp_limits), hydro.base_power),
        time_limits=get_tuple_up_down(hydro.time_limits),
        outflow_limits=get_tuple_min_max(hydro.outflow_limits),
        efficiency=hydro.efficiency,
        turbine_type=PSY.HydroTurbineType(hydro.turbine_type),
        conversion_factor=hydro.conversion_factor,
        prime_mover_type=PSY.PrimeMovers(hydro.prime_mover_type),
        travel_time=hydro.travel_time,
    )
end

function openapi2psy(inter::PowerOpenAPIModels.InterconnectingConverter, resolver::Resolver)
    PSY.InterconnectingConverter(
        name=inter.name,
        available=inter.available,
        bus=resolver(inter.bus),
        dc_bus=resolver(inter.dc_bus),
        active_power=divide(inter.active_power, inter.base_power),
        rating=divide(inter.rating, inter.base_power),
        active_power_limits=divide(
            get_tuple_min_max(inter.active_power_limits),
            inter.base_power,
        ),
        base_power=inter.base_power,
        dc_current=inter.dc_current,
        max_dc_current=inter.max_dc_current,
        loss_function=get_sienna_value_curve(inter.loss_function),
    )
end

function openapi2psy(interrupt_power::PowerOpenAPIModels.InterruptiblePowerLoad, resolver::Resolver)
    PSY.InterruptiblePowerLoad(
        name=interrupt_power.name,
        available=interrupt_power.available,
        bus=resolver(interrupt_power.bus),
        active_power=divide(interrupt_power.active_power, interrupt_power.base_power),
        reactive_power=divide(interrupt_power.reactive_power, interrupt_power.base_power),
        max_active_power=divide(
            interrupt_power.max_active_power,
            interrupt_power.base_power,
        ),
        max_reactive_power=divide(
            interrupt_power.max_reactive_power,
            interrupt_power.base_power,
        ),
        base_power=interrupt_power.base_power,
        operation_cost=get_sienna_operation_cost(interrupt_power.operation_cost),
        conformity=PSY.LoadConformity(interrupt_power.conformity),
    )
end

function openapi2psy(interrupt_standard::PowerOpenAPIModels.InterruptibleStandardLoad, resolver::Resolver)
    PSY.InterruptibleStandardLoad(
        name=interrupt_standard.name,
        available=interrupt_standard.available,
        bus=resolver(interrupt_standard.bus),
        base_power=interrupt_standard.base_power,
        operation_cost=get_sienna_operation_cost(interrupt_standard.operation_cost),
        conformity=PSY.LoadConformity(interrupt_standard.conformity),
        constant_active_power=divide(
            interrupt_standard.constant_active_power,
            interrupt_standard.base_power,
        ),
        constant_reactive_power=divide(
            interrupt_standard.constant_reactive_power,
            interrupt_standard.base_power,
        ),
        impedance_active_power=divide(
            interrupt_standard.impedance_active_power,
            interrupt_standard.base_power,
        ),
        impedance_reactive_power=divide(
            interrupt_standard.impedance_reactive_power,
            interrupt_standard.base_power,
        ),
        current_active_power=divide(
            interrupt_standard.current_active_power,
            interrupt_standard.base_power,
        ),
        current_reactive_power=divide(
            interrupt_standard.current_reactive_power,
            interrupt_standard.base_power,
        ),
        max_constant_active_power=divide(
            interrupt_standard.max_constant_active_power,
            interrupt_standard.base_power,
        ),
        max_constant_reactive_power=divide(
            interrupt_standard.max_constant_reactive_power,
            interrupt_standard.base_power,
        ),
        max_impedance_active_power=divide(
            interrupt_standard.max_impedance_active_power,
            interrupt_standard.base_power,
        ),
        max_impedance_reactive_power=divide(
            interrupt_standard.max_impedance_reactive_power,
            interrupt_standard.base_power,
        ),
        max_current_active_power=divide(
            interrupt_standard.max_current_active_power,
            interrupt_standard.base_power,
        ),
        max_current_reactive_power=divide(
            interrupt_standard.max_current_reactive_power,
            interrupt_standard.base_power,
        ),
    )
end

function openapi2psy(motor_load::PowerOpenAPIModels.MotorLoad, resolver::Resolver)
    PSY.MotorLoad(
        name=motor_load.name,
        available=motor_load.available,
        bus=resolver(motor_load.bus),
        active_power=divide(motor_load.active_power, motor_load.base_power),
        reactive_power=divide(motor_load.reactive_power, motor_load.base_power),
        base_power=motor_load.base_power,
        rating=divide(motor_load.rating, motor_load.base_power),
        max_active_power=divide(motor_load.max_active_power, motor_load.base_power),
        reactive_power_limits=divide(
            get_tuple_min_max(motor_load.reactive_power_limits),
            motor_load.base_power,
        ),
        motor_technology=PSY.MotorLoadTechnology(motor_load.motor_technology),
    )
end

function openapi2psy(load::PowerOpenAPIModels.PowerLoad, resolver::Resolver)
    PSY.PowerLoad(;
        name=load.name,
        available=load.available,
        bus=resolver(load.bus),
        active_power=divide(load.active_power, load.base_power),
        reactive_power=divide(load.reactive_power, load.base_power),
        base_power=load.base_power,
        max_active_power=divide(load.max_active_power, load.base_power),
        max_reactive_power=divide(load.max_reactive_power, load.base_power),
        conformity=PSY.LoadConformity(load.conformity),
    )
end

function openapi2psy(renew::PowerOpenAPIModels.RenewableDispatch, resolver::Resolver)
    PSY.RenewableDispatch(;
        name=renew.name,
        available=renew.available,
        bus=resolver(renew.bus),
        active_power=divide(renew.active_power, renew.base_power),
        reactive_power=divide(renew.reactive_power, renew.base_power),
        rating=divide(renew.rating, renew.base_power),
        prime_mover_type=PSY.PrimeMovers(renew.prime_mover_type),
        reactive_power_limits=divide(
            get_tuple_min_max(renew.reactive_power_limits),
            renew.base_power,
        ),
        power_factor=renew.power_factor,
        operation_cost=get_sienna_operation_cost(renew.operation_cost),
        base_power=renew.base_power,
    )
end

function openapi2psy(renewnon::PowerOpenAPIModels.RenewableNonDispatch, resolver::Resolver)
    PSY.RenewableNonDispatch(;
        name=renewnon.name,
        available=renewnon.available,
        bus=resolver(renewnon.bus),
        active_power=divide(renewnon.active_power, renewnon.base_power),
        reactive_power=divide(renewnon.reactive_power, renewnon.base_power),
        rating=divide(renewnon.rating, renewnon.base_power),
        prime_mover_type=PSY.PrimeMovers(renewnon.prime_mover_type),
        power_factor=renewnon.power_factor,
        base_power=renewnon.base_power,
    )
end

function openapi2psy(power_load::PowerOpenAPIModels.ShiftablePowerLoad, resolver::Resolver)
    PSY.ShiftablePowerLoad(
        name=power_load.name,
        available=power_load.available,
        bus=resolver(power_load.bus),
        active_power=divide(power_load.active_power, power_load.base_power),
        active_power_limits=divide(
            get_tuple_min_max(power_load.active_power_limits),
            power_load.base_power,
        ),
        reactive_power=divide(power_load.reactive_power, power_load.base_power),
        max_active_power=divide(power_load.max_active_power, power_load.base_power),
        max_reactive_power=divide(power_load.max_reactive_power, power_load.base_power),
        base_power=power_load.base_power,
        load_balance_time_horizon=power_load.load_balance_time_horizon,
        operation_cost=get_sienna_operation_cost(power_load.operation_cost),
    )
end

function openapi2psy(source::PowerOpenAPIModels.Source, resolver::Resolver)
    PSY.Source(
        name=source.name,
        available=source.available,
        bus=resolver(source.bus),
        active_power=divide(source.active_power, source.base_power),
        reactive_power=divide(source.reactive_power, source.base_power),
        active_power_limits=divide(
            get_tuple_min_max(source.active_power_limits),
            source.base_power,
        ),
        reactive_power_limits=divide(
            get_tuple_min_max(source.reactive_power_limits),
            source.base_power,
        ),
        R_th=source.R_th,
        X_th=source.X_th,
        internal_voltage=source.internal_voltage,
        internal_angle=source.internal_angle,
        base_power=source.base_power,
        operation_cost=get_sienna_operation_cost(source.operation_cost),
    )
end

function openapi2psy(standard_load::PowerOpenAPIModels.StandardLoad, resolver::Resolver)
    PSY.StandardLoad(
        name=standard_load.name,
        available=standard_load.available,
        bus=resolver(standard_load.bus),
        base_power=standard_load.base_power,
        constant_active_power=divide(
            standard_load.constant_active_power,
            standard_load.base_power,
        ),
        constant_reactive_power=divide(
            standard_load.constant_reactive_power,
            standard_load.base_power,
        ),
        impedance_active_power=divide(
            standard_load.impedance_active_power,
            standard_load.base_power,
        ),
        impedance_reactive_power=divide(
            standard_load.impedance_reactive_power,
            standard_load.base_power,
        ),
        current_active_power=divide(
            standard_load.current_active_power,
            standard_load.base_power,
        ),
        current_reactive_power=divide(
            standard_load.current_reactive_power,
            standard_load.base_power,
        ),
        max_constant_active_power=divide(
            standard_load.max_constant_active_power,
            standard_load.base_power,
        ),
        max_constant_reactive_power=divide(
            standard_load.max_constant_reactive_power,
            standard_load.base_power,
        ),
        max_impedance_active_power=divide(
            standard_load.max_impedance_active_power,
            standard_load.base_power,
        ),
        max_impedance_reactive_power=divide(
            standard_load.max_impedance_reactive_power,
            standard_load.base_power,
        ),
        max_current_active_power=divide(
            standard_load.max_current_active_power,
            standard_load.base_power,
        ),
        max_current_reactive_power=divide(
            standard_load.max_current_reactive_power,
            standard_load.base_power,
        ),
        conformity=PSY.LoadConformity(standard_load.conformity),
    )
end

function openapi2psy(switch::PowerOpenAPIModels.SwitchedAdmittance, resolver::Resolver)
    PSY.SwitchedAdmittance(
        name=switch.name,
        available=switch.available,
        bus=resolver(switch.bus),
        Y=get_julia_complex(switch.Y),
        initial_status=switch.initial_status,
        number_of_steps=switch.number_of_steps,
        Y_increase=map(get_julia_complex, switch.Y_increase),
        admittance_limits=get_tuple_min_max(switch.admittance_limits),
    )
end

function openapi2psy(synch::PowerOpenAPIModels.SynchronousCondenser, resolver::Resolver)
    PSY.SynchronousCondenser(
        name=synch.name,
        available=synch.available,
        bus=resolver(synch.bus),
        reactive_power=divide(synch.reactive_power, synch.base_power),
        rating=divide(synch.rating, synch.base_power),
        reactive_power_limits=divide(
            get_tuple_min_max(synch.reactive_power_limits),
            synch.base_power,
        ),
        base_power=synch.base_power,
        active_power_losses=divide(synch.active_power_losses, synch.base_power),
    )
end

function openapi2psy(multi::PowerOpenAPIModels.ThermalMultiStart, resolver::Resolver)
    PSY.ThermalMultiStart(
        name=multi.name,
        available=multi.available,
        status=multi.status,
        bus=resolver(multi.bus),
        active_power=divide(multi.active_power, multi.base_power),
        reactive_power=divide(multi.reactive_power, multi.base_power),
        rating=divide(multi.rating, multi.base_power),
        prime_mover_type=PSY.PrimeMovers(multi.prime_mover_type),
        fuel=PSY.ThermalFuels(multi.fuel),
        active_power_limits=divide(
            get_tuple_min_max(multi.active_power_limits),
            multi.base_power,
        ),
        reactive_power_limits=divide(
            get_tuple_min_max(multi.reactive_power_limits),
            multi.base_power,
        ),
        ramp_limits=divide(get_tuple_up_down(multi.ramp_limits), multi.base_power),
        power_trajectory=divide(
            get_tuple_startup_shutdown(multi.power_trajectory),
            multi.base_power,
        ),
        time_limits=get_tuple_up_down(multi.time_limits),
        start_time_limits=get_sienna_startup(multi.start_time_limits),
        start_types=multi.start_types,
        operation_cost=get_sienna_operation_cost(multi.operation_cost),
        base_power=multi.base_power,
        time_at_status=multi.time_at_status,
        must_run=multi.must_run,
    )
end

function openapi2psy(thermal::PowerOpenAPIModels.ThermalStandard, resolver::Resolver)
    PSY.ThermalStandard(;
        name=thermal.name,
        prime_mover_type=PSY.PrimeMovers(thermal.prime_mover_type),
        fuel=PSY.ThermalFuels(thermal.fuel_type),
        rating=divide(thermal.rating, thermal.base_power),
        base_power=thermal.base_power,
        available=thermal.available,
        status=thermal.status,
        time_at_status=thermal.time_at_status,
        active_power=divide(thermal.active_power, thermal.base_power),
        reactive_power=divide(thermal.reactive_power, thermal.base_power),
        active_power_limits=divide(
            get_tuple_min_max(thermal.active_power_limits),
            thermal.base_power,
        ),
        reactive_power_limits=divide(
            get_tuple_min_max(thermal.reactive_power_limits),
            thermal.base_power,
        ),
        ramp_limits=divide(get_tuple_up_down(thermal.ramp_limits), thermal.base_power),
        operation_cost=get_sienna_operation_cost(thermal.operation_cost),
        time_limits=get_tuple_up_down(thermal.time_limits),
        must_run=thermal.must_run,
        bus=resolver(thermal.bus),
    )
end
