# ColocatedSupplyStorageTechnology


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **String** |  | [default to nothing]
**id** | **Int64** |  | [optional] [default to nothing]
**power_systems_type** | **String** |  | [default to nothing]
**base_year** | **Int64** |  | [optional] [default to nothing]
**region** | **Vector{Int64}** |  | [optional] [default to nothing]
**available** | **Bool** |  | [default to nothing]
**balancing_topology** | **String** |  | [optional] [default to nothing]
**capital_costs_solar** | [***ValueCurve**](ValueCurve.md) |  | [optional] [default to nothing]
**operation_costs_solar** | [***RenewableGenerationCost**](RenewableGenerationCost.md) |  | [optional] [default to nothing]
**initial_capacity_solar** | **Float64** |  | [optional] [default to nothing]
**capacity_limits_solar** | [***MinMax**](MinMax.md) |  | [optional] [default to nothing]
**lifetime_solar** | **Int64** |  | [optional] [default to nothing]
**financial_data_solar** | **Any** |  | [optional] [default to nothing]
**capital_costs_wind** | [***ValueCurve**](ValueCurve.md) |  | [optional] [default to nothing]
**operation_costs_wind** | [***RenewableGenerationCost**](RenewableGenerationCost.md) |  | [optional] [default to nothing]
**initial_capacity_wind** | **Float64** |  | [optional] [default to nothing]
**capacity_limits_wind** | [***MinMax**](MinMax.md) |  | [optional] [default to nothing]
**lifetime_wind** | **Int64** |  | [optional] [default to nothing]
**financial_data_wind** | **Any** |  | [optional] [default to nothing]
**capital_costs_energy** | [***ValueCurve**](ValueCurve.md) |  | [optional] [default to nothing]
**capital_costs_power** | [***ValueCurve**](ValueCurve.md) |  | [optional] [default to nothing]
**operations_costs_energy** | [***StorageCost**](StorageCost.md) |  | [optional] [default to nothing]
**operations_costs_power** | [***StorageCost**](StorageCost.md) |  | [optional] [default to nothing]
**existing_capacity_power** | **Float64** |  | [optional] [default to nothing]
**existing_capacity_energy** | **Float64** |  | [optional] [default to nothing]
**capacity_power_limits** | [***MinMax**](MinMax.md) |  | [optional] [default to nothing]
**capacity_energy_limits** | [***MinMax**](MinMax.md) |  | [optional] [default to nothing]
**duration_limits** | [***MinMax**](MinMax.md) |  | [optional] [default to nothing]
**efficiency_storage** | [***InOut**](InOut.md) |  | [optional] [default to nothing]
**losses_storage** | **Float64** |  | [optional] [default to 1.0]
**lifetime_storage** | **Int64** |  | [optional] [default to 100]
**financial_data_storage** | **Any** |  | [optional] [default to nothing]
**maximum_inverter_capacity** | **Float64** |  | [optional] [default to nothing]
**minimum_inverter_capacity** | **Float64** |  | [optional] [default to nothing]
**capital_costs_inverter** | [***ValueCurve**](ValueCurve.md) |  | [optional] [default to nothing]
**operation_costs_inverter** | [***ProductionVariableCostCurve**](ProductionVariableCostCurve.md) |  | [optional] [default to nothing]
**inverter_efficiency** | **Float64** |  | [optional] [default to nothing]
**inverter_supply_ratio** | **Float64** |  | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


