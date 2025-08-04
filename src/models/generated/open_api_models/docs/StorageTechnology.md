# StorageTechnology


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **String** |  | [default to nothing]
**uuid** | **String** |  | [optional] [default to nothing]
**region** | **Vector{Int64}** |  | [optional] [default to nothing]
**id** | **Int64** |  | [optional] [default to nothing]
**available** | **Bool** |  | [default to nothing]
**power_systems_type** | **String** |  | [default to nothing]
**min_discharge_fraction** | **Float64** |  | [optional] [default to 0.0]
**prime_mover_type** | **String** |  | [optional] [default to "OT"]
**storage_tech** | **String** | defines the storage technology used in an energy Storage system, based on the options in EIA form 923. | [optional] [default to nothing]
**capital_costs_energy** | [***ValueCurve**](ValueCurve.md) |  | [optional] [default to nothing]
**capital_costs_charge** | [***ValueCurve**](ValueCurve.md) |  | [optional] [default to nothing]
**capital_costs_discharge** | [***ValueCurve**](ValueCurve.md) |  | [optional] [default to nothing]
**operation_costs** | [***StorageCost**](StorageCost.md) |  | [optional] [default to nothing]
**unit_size_discharge** | **Float64** |  | [optional] [default to 0.0]
**unit_size_charge** | **Float64** |  | [optional] [default to 0.0]
**unit_size_energy** | **Float64** |  | [optional] [default to 0.0]
**capacity_limits_charge** | [***MinMax**](MinMax.md) |  | [optional] [default to nothing]
**capacity_limits_discharge** | [***MinMax**](MinMax.md) |  | [optional] [default to nothing]
**capacity_limits_energy** | [***MinMax**](MinMax.md) |  | [optional] [default to nothing]
**duration_limits** | [***MinMax**](MinMax.md) |  | [optional] [default to nothing]
**efficiency** | [***InOut**](InOut.md) |  | [optional] [default to nothing]
**losses** | **Float64** |  | [optional] [default to 1.0]
**lifetime** | **Int64** |  | [optional] [default to 100]
**financial_data** | **Any** |  | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


