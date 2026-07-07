function openapi2psip(storage::PowerOpenAPIModels.StorageTechnology, resolver::Resolver)
    StorageTechnology{getproperty(PSY, Symbol(storage.power_systems_type))}(;
        name=storage.name,
        id=storage.id,
        available=storage.available,
        region=[resolver(r) for r in storage.region],
        prime_mover_type=PSY.PrimeMovers(storage.prime_mover_type),
        storage_tech=PSY.StorageTech(storage.storage_tech),
        lifetime=storage.lifetime,
        min_discharge_fraction=storage.min_discharge_fraction,
        duration_limits=get_tuple_min_max(storage.duration_limits),
        capacity_limits_charge=get_tuple_min_max(storage.capacity_limits_charge),
        capacity_limits_discharge=get_tuple_min_max(storage.capacity_limits_discharge),
        capacity_limits_energy=get_tuple_min_max(storage.capacity_limits_energy),
        capital_costs_charge=get_sienna_value_curve(storage.capital_costs_charge),
        capital_costs_discharge=get_sienna_value_curve(storage.capital_costs_discharge),
        capital_costs_energy=get_sienna_value_curve(storage.capital_costs_energy),
        operation_costs=get_sienna_operation_cost(storage.operation_costs),
        financial_data=get_sienna_technology_financial_data(storage.financial_data),
        power_systems_type=storage.power_systems_type,
        unit_size_charge=storage.unit_size_charge,
        unit_size_discharge=storage.unit_size_discharge,
        unit_size_energy=storage.unit_size_energy,
        efficiency=get_tuple_in_out(storage.efficiency),
    )
end

function openapi2psip(demand::PowerOpenAPIModels.DemandRequirement, resolver::Resolver)
    DemandRequirement{getproperty(PSY, Symbol(demand.power_systems_type))}(;
        name=demand.name,
        id=demand.id,
        available=demand.available,
        region=[resolver(r) for r in demand.region],
        power_systems_type=demand.power_systems_type,
        peak_demand_mw=demand.peak_demand_mw,
        unserved_demand_curve=get_sienna_value_curve(demand.unserved_demand_curve),
        value_of_lost_load=demand.value_of_lost_load,
    )
end

function openapi2psip(demand::PowerOpenAPIModels.DemandSideTechnology, resolver::Resolver)
    DemandSideTechnology{getproperty(PSY, Symbol(demand.power_systems_type))}(;
        name=demand.name,
        id=demand.id,
        available=demand.available,
        region=[resolver(r) for r in demand.region],
        power_systems_type=demand.power_systems_type,
        price_per_unit=get_sienna_value_curve(demand.price_per_unit),
        curtailment_cost=get_sienna_value_curve(demand.curtailment_cost),
        technology_efficiency=demand.technology_efficiency,
        max_demand_advance=demand.max_demand_advance,
        demand_energy_efficiency=demand.demand_energy_efficiency,
        max_demand_curtailment=demand.max_demand_curtailment,
        max_demand_delay=demand.max_demand_delay,
        min_power=demand.min_power,
        peak_demand_mw=demand.peak_demand_mw,
    )
end

function openapi2psip(supply::PowerOpenAPIModels.SupplyTechnology, resolver::Resolver)
    SupplyTechnology{getproperty(PSY, Symbol(supply.power_systems_type))}(;
        name=supply.name,
        id=supply.id,
        available=supply.available,
        power_systems_type=supply.power_systems_type,
        region=[resolver(r) for r in supply.region],
        prime_mover_type=PSY.PrimeMovers(supply.prime_mover_type),
        financial_data=get_sienna_technology_financial_data(supply.financial_data),
        fuel=[PSY.ThermalFuels(f) for f in supply.fuel],
        ramp_limits=get_tuple_up_down(supply.ramp_limits),
        capital_costs=get_sienna_value_curve(supply.capital_costs),
        operation_costs=get_sienna_operation_cost(supply.operation_costs),
        time_limits=get_tuple_up_down(supply.time_limits),
        lifetime=supply.lifetime,
        min_generation_fraction=supply.min_generation_fraction,
        unit_size=supply.unit_size,
        capacity_limits=get_tuple_min_max(supply.capacity_limits),
        co2=get_sienna_fuel_dictionary(supply.co2),
        cofire_start_limits=get_sienna_fuel_dictionary(supply.cofire_start_limits),
        cofire_level_limits=get_sienna_fuel_dictionary(supply.cofire_level_limits),
    )
end

function openapi2psip(
    line::PowerOpenAPIModels.AggregateTransportTechnology,
    resolver::Resolver,
)
    AggregateTransportTechnology{getproperty(PSY, Symbol(line.power_systems_type))}(;
        name=line.name,
        id=line.id,
        available=line.available,
        power_systems_type=line.power_systems_type,
        start_region=resolver(line.start_region),
        end_region=resolver(line.end_region),
        capital_costs=get_sienna_value_curve(line.capital_costs),
        financial_data=get_sienna_technology_financial_data(line.financial_data),
        unit_size=line.unit_size,
        line_loss=line.line_loss,
        capacity_limits=get_tuple_min_max(line.capacity_limits),
    )
end

function openapi2psip(
    line::PowerOpenAPIModels.NodalACTransportTechnology,
    resolver::Resolver,
)
    NodalACTransportTechnology{getproperty(PSY, Symbol(line.power_systems_type))}(;
        name=line.name,
        id=line.id,
        available=line.available,
        power_systems_type=line.power_systems_type,
        start_node=resolver(line.start_node),
        end_node=resolver(line.end_node),
        capital_costs=get_sienna_value_curve(line.capital_costs),
        financial_data=get_sienna_technology_financial_data(line.financial_data),
        unit_size=line.unit_size,
        resistance=line.resistance,
        reactance=line.reactance,
        voltage=line.voltage,
        capacity_limits=get_tuple_min_max(line.capacity_limits),
    )
end

function openapi2psip(
    line::PowerOpenAPIModels.NodalHVDCTransportTechnology,
    resolver::Resolver,
)
    NodalHVDCTransportTechnology{getproperty(PSY, Symbol(line.power_systems_type))}(;
        name=line.name,
        id=line.id,
        available=line.available,
        power_systems_type=line.power_systems_type,
        start_node=resolver(line.start_node),
        end_node=resolver(line.end_node),
        capital_costs=get_sienna_value_curve(line.capital_costs),
        financial_data=get_sienna_technology_financial_data(line.financial_data),
        unit_size=line.unit_size,
        capacity_limits=get_tuple_min_max(line.capacity_limits),
        line_loss=get_sienna_value_curve(line.line_loss),
    )
end
