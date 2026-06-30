# SupplyTechnology


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**`available`** | **`Bool`** |  | [default to nothing]
**`capacity_limits`** | [**`*MinMax`**](MinMax.md) |  | [optional] [default to nothing]
**`capital_costs`** | [**`*ValueCurve`**](ValueCurve.md) |  | [optional] [default to nothing]
**`co2`** | **`Dict{String, Float64}`** |  | [optional] [default to nothing]
**`cofire_level_limits`** | [**`Dict{String, MinMax}`**](MinMax.md) |  | [optional] [default to nothing]
**`cofire_start_limits`** | [**`Dict{String, MinMax}`**](MinMax.md) |  | [optional] [default to nothing]
**`financial_data`** | [**`*TechnologyFinancialData`**](TechnologyFinancialData.md) |  | [optional] [default to nothing]
**`fuel`** | **`Vector{String}`** |  | [optional] [default to nothing]
**`id`** | **`Int64`** |  | [optional] [default to nothing]
**`lifetime`** | **`Int64`** |  | [optional] [default to 100]
**`min_generation_fraction`** | **`Float64`** |  | [optional] [default to 0.0]
**`name`** | **`String`** |  | [default to nothing]
**`operation_costs`** | [**`*ThermalRenewableGenerationCost`**](ThermalRenewableGenerationCost.md) |  | [optional] [default to nothing]
**`outage_factor`** | **`Float64`** |  | [optional] [default to 1.0]
**`power_systems_type`** | **`String`** |  | [default to nothing]
**`prime_mover_type`** | **`String`** |  | [optional] [default to "OT"]
**`ramp_limits`** | [**`*UpDown`**](UpDown.md) |  | [optional] [default to nothing]
**`region`** | **`Vector{Int64}`** |  | [optional] [default to nothing]
**`start_fuel_mmbtu_per_mw`** | **`Float64`** |  | [optional] [default to 0.0]
**`time_limits`** | [**`*UpDown`**](UpDown.md) |  | [optional] [default to nothing]
**`unit_size`** | **`Float64`** |  | [optional] [default to 0.0]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


