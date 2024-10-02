# FlexibleDemandTechnology


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**max_demand_delay** | **Float64** | Maximum number of hours that demand can be deferred or delayed (hours). | [optional] [default to nothing]
**name** | **String** | The technology name | [default to nothing]
**power_systems_type** | **String** | maps to a valid PowerSystems.jl for PCM modeling | [default to nothing]
**var_cost_per_mwh** | [***PSYValueCurve**](PSYValueCurve.md) | Variable operations and maintenance costs associated with flexible demand deferral | [optional] [default to nothing]
**internal** | [***InfrastructureSystemsInternal**](InfrastructureSystemsInternal.md) | Internal field | [optional] [default to nothing]
**ext** | **Dict** | Option for providing additional data | [optional] [default to nothing]
**max_demand_advance** | **Float64** | Maximum number of hours that demand can be scheduled in advance of the original schedule (hours). | [optional] [default to nothing]
**demand_energy_efficiency** | **Float64** | Energy efficiency associated with time shifting demand. Represents energy losses due to time shifting | [optional] [default to nothing]
**available** | **Bool** | identifies whether the technology is available | [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


