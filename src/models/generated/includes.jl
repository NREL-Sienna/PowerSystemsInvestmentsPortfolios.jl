include("Zone.jl")
include("MinimumCapacityRequirements.jl")
include("SupplyTechnology.jl")
include("DemandRequirement.jl")
include("RetirementPotential.jl")
include("ExistingCapacity.jl")
include("ACTransportTechnology.jl")
include("AggregateRetrofitPotential.jl")
include("DemandSideTechnology.jl")
include("AggregateRetirementPotential.jl")
include("HVDCTransportTechnology.jl")
include("StorageTechnology.jl")
include("CarbonCaps.jl")
include("RetrofitPotential.jl")
include("CurtailableDemandSideTechnology.jl")
include("FlexibleDemandTechnology.jl")

export get_angle_limit
export get_available
export get_balancing_topology
export get_base_power
export get_base_year
export get_capacity_energy_limits
export get_capacity_limits
export get_capacity_power_limits
export get_capital_cost
export get_capital_costs
export get_capital_costs_energy
export get_capital_costs_power
export get_co2
export get_co_2_max_mtons
export get_co_2_max_tons_mwh
export get_cofire_level_limits
export get_cofire_start_limits
export get_curtailment_cost
export get_curtailment_cost_mwh
export get_demand_energy_efficiency
export get_demand_mw
export get_dn_time
export get_duration_limits
export get_efficiency
export get_eligible_resources
export get_eligible_zones
export get_end_region
export get_existing_capacity
export get_existing_capacity_energy
export get_existing_capacity_power
export get_existing_line_capacity
export get_ext
export get_financial_data
export get_fuel
export get_heat_rate_mmbtu_per_mwh
export get_id
export get_initial_capacity
export get_lifetime
export get_line_loss
export get_losses
export get_max_demand_advance
export get_max_demand_curtailment
export get_max_demand_delay
export get_maximum_new_capacity
export get_min_generation_percentage
export get_min_mw
export get_min_power
export get_name
export get_operation_costs
export get_operations_costs_energy
export get_operations_costs_power
export get_outage_factor
export get_power_systems_type
export get_price_per_unit
export get_pricecap
export get_prime_mover_type
export get_ramp_dn_percentage
export get_ramp_up_percentage
export get_region
export get_resistance
export get_retirement_potential
export get_retrofit_fraction
export get_retrofit_id
export get_retrofit_potential
export get_segments
export get_start_cost_per_mw
export get_start_fuel_mmbtu_per_mw
export get_start_region
export get_storage_tech
export get_technology_efficiency
export get_unit_size
export get_unit_size_energy
export get_unit_size_power
export get_up_time
export get_var_cost_per_mwh
export get_voll
export get_voltage
export set_angle_limit!
export set_available!
export set_balancing_topology!
export set_base_power!
export set_base_year!
export set_capacity_energy_limits!
export set_capacity_limits!
export set_capacity_power_limits!
export set_capital_cost!
export set_capital_costs!
export set_capital_costs_energy!
export set_capital_costs_power!
export set_co2!
export set_co_2_max_mtons!
export set_co_2_max_tons_mwh!
export set_cofire_level_limits!
export set_cofire_start_limits!
export set_curtailment_cost!
export set_curtailment_cost_mwh!
export set_demand_energy_efficiency!
export set_demand_mw!
export set_dn_time!
export set_duration_limits!
export set_efficiency!
export set_eligible_resources!
export set_eligible_zones!
export set_end_region!
export set_existing_capacity!
export set_existing_capacity_energy!
export set_existing_capacity_power!
export set_existing_line_capacity!
export set_ext!
export set_financial_data!
export set_fuel!
export set_heat_rate_mmbtu_per_mwh!
export set_id!
export set_initial_capacity!
export set_lifetime!
export set_line_loss!
export set_losses!
export set_max_demand_advance!
export set_max_demand_curtailment!
export set_max_demand_delay!
export set_maximum_new_capacity!
export set_min_generation_percentage!
export set_min_mw!
export set_min_power!
export set_name!
export set_operation_costs!
export set_operations_costs_energy!
export set_operations_costs_power!
export set_outage_factor!
export set_power_systems_type!
export set_price_per_unit!
export set_pricecap!
export set_prime_mover_type!
export set_ramp_dn_percentage!
export set_ramp_up_percentage!
export set_region!
export set_resistance!
export set_retirement_potential!
export set_retrofit_fraction!
export set_retrofit_id!
export set_retrofit_potential!
export set_segments!
export set_start_cost_per_mw!
export set_start_fuel_mmbtu_per_mw!
export set_start_region!
export set_storage_tech!
export set_technology_efficiency!
export set_unit_size!
export set_unit_size_energy!
export set_unit_size_power!
export set_up_time!
export set_var_cost_per_mwh!
export set_voll!
export set_voltage!
