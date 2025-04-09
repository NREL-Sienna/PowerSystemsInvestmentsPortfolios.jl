# SupplyTechnology


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **String** |  | [default to nothing]
**power_systems_type** | **String** |  | [default to nothing]
**build_year** | **Int64** |  | [optional] [default to 2020]
**region** | **Vector{Int64}** |  | [optional] [default to nothing]
**id** | **Int64** |  | [optional] [default to nothing]
**available** | **Bool** |  | [default to nothing]
**balancing_topology** | **String** |  | [optional] [default to nothing]
**base_power** | **Float64** |  | [optional] [default to nothing]
**prime_mover_type** | **String** |  | [optional] [default to "OT"]
**fuel** | **Vector{String}** |  | [optional] [default to nothing]
**co2** | **Dict{String, Float64}** |  | [optional] [default to nothing]
**cofire_start_limits** | [**Dict{String, MinMax}**](MinMax.md) |  | [optional] [default to nothing]
**cofire_level_limits** | [**Dict{String, MinMax}**](MinMax.md) |  | [optional] [default to nothing]
**capital_costs** | [***ValueCurve**](ValueCurve.md) |  | [optional] [default to nothing]
**operation_costs** | [***SupplyTechnologyOperationCosts**](SupplyTechnologyOperationCosts.md) |  | [optional] [default to nothing]
**initial_capacity** | **Float64** |  | [optional] [default to 0.0]
**unit_size** | **Float64** |  | [optional] [default to 0.0]
**capacity_limits** | [***MinMax**](MinMax.md) |  | [optional] [default to nothing]
**outage_factor** | **Float64** |  | [optional] [default to 1.0]
**min_generation_percentage** | **Float64** |  | [optional] [default to 0.0]
**max_operation_reserves_percentage** | **Float64** |  | [optional] [default to 0.0]
**max_regulatory_reserves_percentage** | **Float64** |  | [optional] [default to 0.0]
**ramp_limits** | [***UpDown**](UpDown.md) |  | [optional] [default to nothing]
**time_limits** | [***UpDown**](UpDown.md) |  | [optional] [default to nothing]
**start_fuel_mmbtu_per_mw** | **Float64** |  | [optional] [default to 0.0]
**lifetime** | **Int64** |  | [optional] [default to 100]
**financial_data** | **Any** |  | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


