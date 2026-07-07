function psip2openapi(storage::StorageTechnology, ids::IDGenerator)
    PowerOpenAPIModels.StorageTechnology(;
        name=storage.name,
        id=getid!(ids, storage),
        available=storage.available,
        region=[getid!(ids, r) for r in storage.region],
        prime_mover_type=string(storage.prime_mover_type),
        storage_tech=string(storage.storage_tech),
        lifetime=storage.lifetime,
        min_discharge_fraction=storage.min_discharge_fraction,
        duration_limits=get_min_max(storage.duration_limits),
        capacity_limits_charge=get_min_max(storage.capacity_limits_charge),
        capacity_limits_discharge=get_min_max(storage.capacity_limits_discharge),
        capacity_limits_energy=get_min_max(storage.capacity_limits_energy),
        capital_costs_charge=get_value_curve(storage.capital_costs_charge),
        capital_costs_discharge=get_value_curve(storage.capital_costs_discharge),
        capital_costs_energy=get_value_curve(storage.capital_costs_energy),
        operation_costs=get_operation_cost(storage.operation_costs),
        financial_data=get_technology_financial_data(storage.financial_data),
        power_systems_type=storage.power_systems_type,
        unit_size_charge=storage.unit_size_charge,
        unit_size_discharge=storage.unit_size_discharge,
        unit_size_energy=storage.unit_size_energy,
        efficiency=get_in_out(storage.efficiency),
    )
end

function psip2openapi(demand::DemandRequirement, ids::IDGenerator)
    PowerOpenAPIModels.DemandRequirement(;
        name=demand.name,
        id=getid!(ids, demand),
        available=demand.available,
        region=[getid!(ids, r) for r in demand.region],
        power_systems_type=demand.power_systems_type,
        peak_demand_mw=demand.peak_demand_mw,
        unserved_demand_curve=get_value_curve(demand.unserved_demand_curve),
        value_of_lost_load=demand.value_of_lost_load,
    )
end

function psip2openapi(demand::DemandSideTechnology, ids::IDGenerator)
    PowerOpenAPIModels.DemandSideTechnology(;
        name=demand.name,
        id=getid!(ids, demand),
        available=demand.available,
        region=[getid!(ids, r) for r in demand.region],
        power_systems_type=demand.power_systems_type,
        price_per_unit=get_value_curve(demand.price_per_unit),
        curtailment_cost=get_value_curve(demand.curtailment_cost),
        technology_efficiency=demand.technology_efficiency,
        max_demand_advance=demand.max_demand_advance,
        demand_energy_efficiency=demand.demand_energy_efficiency,
        max_demand_curtailment=demand.max_demand_curtailment,
        max_demand_delay=demand.max_demand_delay,
        min_power=demand.min_power,
        peak_demand_mw=demand.peak_demand_mw,
    )
end

function psip2openapi(supply::SupplyTechnology, ids::IDGenerator)
    PowerOpenAPIModels.SupplyTechnology(;
        name=supply.name,
        id=getid!(ids, supply),
        available=supply.available,
        power_systems_type=supply.power_systems_type,
        region=[getid!(ids, r) for r in supply.region],
        prime_mover_type=string(supply.prime_mover_type),
        financial_data=get_technology_financial_data(supply.financial_data),
        fuel=[string(f) for f in supply.fuel],
        ramp_limits=get_up_down(supply.ramp_limits),
        capital_costs=get_value_curve(supply.capital_costs),
        operation_costs=get_operation_cost(supply.operation_costs),
        time_limits=get_up_down(supply.time_limits),
        lifetime=supply.lifetime,
        min_generation_fraction=supply.min_generation_fraction,
        unit_size=supply.unit_size,
        capacity_limits=get_min_max(supply.capacity_limits),
        co2=get_fuel_dictionary(supply.co2),
        cofire_start_limits=get_fuel_dictionary(supply.cofire_start_limits),
        cofire_level_limits=get_fuel_dictionary(supply.cofire_level_limits),
    )
end

function psip2openapi(line::AggregateTransportTechnology, ids::IDGenerator)
    PowerOpenAPIModels.AggregateTransportTechnology(;
        name=line.name,
        id=getid!(ids, line),
        available=line.available,
        power_systems_type=line.power_systems_type,
        start_region=getid!(ids, line.start_region),
        end_region=getid!(ids, line.end_region),
        capital_costs=get_value_curve(line.capital_costs),
        financial_data=get_technology_financial_data(line.financial_data),
        unit_size=line.unit_size,
        line_loss=line.line_loss,
        capacity_limits=get_min_max(line.capacity_limits),
    )
end

function psip2openapi(line::NodalACTransportTechnology, ids::IDGenerator)
    PowerOpenAPIModels.NodalACTransportTechnology(;
        name=line.name,
        id=getid!(ids, line),
        available=line.available,
        power_systems_type=line.power_systems_type,
        start_node=getid!(ids, line.start_node),
        end_node=getid!(ids, line.end_node),
        capital_costs=get_value_curve(line.capital_costs),
        financial_data=get_technology_financial_data(line.financial_data),
        unit_size=line.unit_size,
        resistance=line.resistance,
        reactance=line.reactance,
        voltage=line.voltage,
        capacity_limits=get_min_max(line.capacity_limits),
    )
end

function psip2openapi(line::NodalHVDCTransportTechnology, ids::IDGenerator)
    PowerOpenAPIModels.NodalHVDCTransportTechnology(;
        name=line.name,
        id=getid!(ids, line),
        available=line.available,
        power_systems_type=line.power_systems_type,
        start_node=getid!(ids, line.start_node),
        end_node=getid!(ids, line.end_node),
        capital_costs=get_value_curve(line.capital_costs),
        financial_data=get_technology_financial_data(line.financial_data),
        unit_size=line.unit_size,
        capacity_limits=get_min_max(line.capacity_limits),
        line_loss=get_value_curve(line.line_loss),
    )
end

function psip2openapi(supply::ColocatedSupplyStorageTechnology, ids::IDGenerator)
    PowerOpenAPIModels.ColocatedSupplyStorageTechnology(;
        name=supply.name,
        id=getid!(ids, supply),
        available=supply.available,
        region=[getid!(ids, r) for r in supply.region],
        capital_costs_solar=get_value_curve(supply.capital_costs_solar),
        capital_costs_wind=get_value_curve(supply.capital_costs_wind),
        capital_costs_inverter=get_value_curve(supply.capital_costs_inverter),
        capital_costs_power=get_value_curve(supply.capital_costs_power),
        capital_costs_energy=get_value_curve(supply.capital_costs_energy),
        operation_costs_power=get_operation_cost(supply.operation_costs_power),
        operation_costs_solar=get_operation_cost(supply.operation_costs_solar),
        operation_costs_energy=get_operation_cost(supply.operation_costs_energy),
        operation_costs_inverter=get_operation_cost(supply.operation_costs_inverter),
        operation_costs_wind=get_operation_cost(supply.operation_costs_wind),
        financial_data=get_technology_financial_data(supply.financial_data),
        lifetime_wind=supply.lifetime_wind,
        lifetime_solar=supply.lifetime_solar,
        lifetime_storage=supply.lifetime_storage,
        capacity_limits_wind=get_min_max(supply.capacity_limits_wind),
        capacity_power_limits=get_min_max(supply.capacity_power_limits),
        capacity_energy_limits=get_min_max(supply.capacity_energy_limits),
        capacity_limits_solar=get_min_max(supply.capacity_limits_solar),
        duration_limits=get_min_max(supply.duration_limits),
        min_inverter_capacity=supply.min_inverter_capacity,
        inverter_efficiency=supply.inverter_efficiency,
        power_systems_type=supply.power_systems_type,
        efficiency_storage=supply.efficiency_storage,
        losses_storage=supply.losses_storage,
        inverter_supply_ratio=supply.inverter_supply_ratio,
        max_inverter_capacity=supply.max_inverter_capacity,
    )
end
