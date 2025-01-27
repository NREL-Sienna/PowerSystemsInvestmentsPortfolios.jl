# DemandRequirement


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **String** | The technology name | [default to nothing]
**power_systems_type** | **String** | maps to a valid PowerSystems.jl for PCM modeling | [default to nothing]
**internal** | [***InfrastructureSystemsInternal**](InfrastructureSystemsInternal.md) | Internal field | [optional] [default to nothing]
**ext** | **Dict** | Option for providing additional data | [optional] [default to nothing]
**demand_mw** | **Float64** | Demand value in MW | [optional] [default to nothing]
**region** | [***Union{NothingRegion}**](Union{NothingRegion}.md) | Region | [optional] [default to nothing]
**available** | **Bool** | identifies whether the technology is available | [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


