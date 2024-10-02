# StorageTechnology


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**base_power** | **Float64** | Base power | [optional] [default to nothing]
**om_costs_energy** | [***PSYOperationalCost**](PSYOperationalCost.md) | Fixed and variable O&amp;M costs for a technology | [optional] [default to nothing]
**zone** | [***Union{NothingInt64Zone}**](Union{NothingInt64Zone}.md) | Zone number | [optional] [default to nothing]
**prime_mover_type** | [***PrimeMovers**](PrimeMovers.md) | Prime mover for generator | [optional] [default to nothing]
**existing_cap_energy** | **Float64** | Pre-existing energy capacity for a technology (MWh) | [optional] [default to nothing]
**rsv_cost** | **Float64** | Cost of providing upwards spinning or contingency reserves | [optional] [default to nothing]
**available** | **Bool** | identifies whether the technology is available | [default to nothing]
**existing_cap_power** | **Float64** | Pre-existing power capacity for a technology (MW) | [optional] [default to nothing]
**name** | **String** | The technology name | [default to nothing]
**storage_tech** | [***StorageTech**](StorageTech.md) | Storage Technology Type | [optional] [default to nothing]
**capital_costs_power** | [***PSYValueCurve**](PSYValueCurve.md) | Capital costs for investing in a technology. | [optional] [default to nothing]
**max_duration** | **Float64** | Maximum allowable durection for a storage technology | [optional] [default to nothing]
**unit_size_power** | **Float64** | Used for discrete investment decisions. Size of each unit being built (MW) | [optional] [default to nothing]
**id** | **Int64** | ID for individual generator | [optional] [default to nothing]
**min_cap_power** | **Float64** | Minimum required power capacity for a storage technology | [optional] [default to nothing]
**capital_costs_energy** | [***PSYValueCurve**](PSYValueCurve.md) | Capital costs for investing in a technology. | [optional] [default to nothing]
**losses** | **Float64** | Power loss (pct per hour) | [optional] [default to nothing]
**eff_down** | **Float64** | Efficiency of discharging storage | [optional] [default to nothing]
**rsv_max** | **Float64** | Fraction of nameplate capacity that can committed to provided upwards spinning or contingency reserves. | [optional] [default to nothing]
**max_cap_power** | **Float64** | Maximum allowable installed power capacity for a storage technology | [optional] [default to nothing]
**power_systems_type** | **String** | maps to a valid PowerSystems.jl for PCM modeling | [default to nothing]
**internal** | [***InfrastructureSystemsInternal**](InfrastructureSystemsInternal.md) | Internal field | [optional] [default to nothing]
**om_costs_power** | [***PSYOperationalCost**](PSYOperationalCost.md) | Fixed and variable O&amp;M costs for a technology | [optional] [default to nothing]
**balancing_topology** | **String** | Set of balancing nodes | [optional] [default to nothing]
**min_cap_energy** | **Float64** | Minimum required energy capacity for a storage technology | [optional] [default to nothing]
**initial_state_of_charge** | **Float64** | State of charge for storage technology in the first timepoint (MWh). | [optional] [default to nothing]
**eff_up** | **Float64** | Efficiency of charging storage | [optional] [default to nothing]
**unit_size_energy** | **Float64** | Used for discrete investment decisions. Size of each unit being built (MW) | [optional] [default to nothing]
**ext** | **Dict** | Option for providing additional data | [optional] [default to nothing]
**reg_cost** | **Float64** | Cost of providing regulation reserves  | [optional] [default to nothing]
**min_duration** | **Float64** | Minimum required durection for a storage technology | [optional] [default to nothing]
**max_cap_energy** | **Float64** | Maximum allowable installed energy capacity for a storage technology | [optional] [default to nothing]
**reg_max** | **Float64** | Fraction of nameplate capacity that can committed to provided regulation reserves | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


