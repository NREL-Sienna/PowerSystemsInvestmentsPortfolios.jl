# StorageTechnology


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **String** |  | [default to nothing]
**base_year** | **Int64** |  | [optional] [default to nothing]
**region** | [***SupplyTechnologyRegion**](SupplyTechnologyRegion.md) |  | [optional] [default to nothing]
**id** | **Int64** |  | [optional] [default to nothing]
**available** | **Bool** |  | [default to nothing]
**power_systems_type** | **String** |  | [default to nothing]
**balancing_topology** | **String** |  | [optional] [default to nothing]
**base_power** | **Float64** |  | [optional] [default to nothing]
**prime_mover_type** | **String** |  | [optional] [default to "OT"]
**storage_tech** | **String** | defines the storage technology used in an energy Storage system, based on the options in EIA form 923. | [optional] [default to nothing]
**capital_costs_energy** | [***ValueCurve**](ValueCurve.md) |  | [optional] [default to nothing]
**capital_costs_power** | [***ValueCurve**](ValueCurve.md) |  | [optional] [default to nothing]
**operations_costs_energy** | [***StorageCost**](StorageCost.md) |  | [optional] [default to nothing]
**operations_costs_power** | [***StorageCost**](StorageCost.md) |  | [optional] [default to nothing]
**existing_capacity_power** | **Float64** |  | [optional] [default to 0.0]
**existing_capacity_energy** | **Float64** |  | [optional] [default to 0.0]
**unit_size_power** | **Float64** |  | [optional] [default to 0.0]
**unit_size_energy** | **Float64** |  | [optional] [default to 0.0]
**max_capacity_power** | **Float64** |  | [optional] [default to 1e8]
**max_capacity_energy** | **Float64** |  | [optional] [default to 1e8]
**min_capacity_power** | **Float64** |  | [optional] [default to 0.0]
**min_capacity_energy** | **Float64** |  | [optional] [default to 0.0]
**min_duration** | **Float64** |  | [optional] [default to 0.0]
**max_duration** | **Float64** |  | [optional] [default to 1000.0]
**efficiency_in** | **Float64** |  | [optional] [default to 1.0]
**efficiency_out** | **Float64** |  | [optional] [default to 1.0]
**losses** | **Float64** |  | [optional] [default to 1.0]
**lifetime** | **Int64** |  | [optional] [default to 100]
**financial_data** | **String** |  | [optional] [default to nothing]
**ext** | **Any** |  | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


