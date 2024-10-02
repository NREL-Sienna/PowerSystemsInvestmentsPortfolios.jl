# DemandSideTechnology


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**min_power** | **Float64** | Minimum operation of demandside unit as a fraction of total capacity | [optional] [default to nothing]
**name** | **String** | The technology name | [default to nothing]
**ramp_up_percentage** | **Float64** | Maximum increase in output between operation periods. Fraction of total capacity | [optional] [default to nothing]
**power_systems_type** | **String** | maps to a valid PowerSystems.jl for PCM modeling | [default to nothing]
**internal** | [***InfrastructureSystemsInternal**](InfrastructureSystemsInternal.md) | Internal field | [optional] [default to nothing]
**price_per_unit** | **Float64** | Price or value per unit of output. Ex: USD per ton of hydrogen for electrolyzers | [optional] [default to nothing]
**ext** | **Dict** | Option for providing additional data | [optional] [default to nothing]
**technology_efficiency** | **Float64** | MWh of electricity per unit of output. Ex: MWh per ton of hydrogen for electrolyzers | [optional] [default to nothing]
**ramp_dn_percentage** | **Float64** | Maximum decrease in output between operation periods. Fraction of total capacity | [optional] [default to nothing]
**available** | **Bool** | identifies whether the technology is available | [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


