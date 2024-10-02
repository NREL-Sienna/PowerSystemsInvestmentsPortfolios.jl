# CarbonCaps


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **String** | The technology name | [default to nothing]
**power_systems_type** | **String** | maps to a valid PowerSystems.jl for PCM modeling | [optional] [default to nothing]
**pricecap** | **Float64** | pricecap value for carbon caps | [optional] [default to nothing]
**eligible_zones** | [***Vector{Int64}**](Vector{Int64}.md) | List of zones that contribute to the carbon cap constraint. | [optional] [default to nothing]
**internal** | [***InfrastructureSystemsInternal**](InfrastructureSystemsInternal.md) | Internal field | [optional] [default to nothing]
**co_2_max_tons_mwh** | **Float64** | Emission limit in terms of rate (tCO@/MWh) | [optional] [default to nothing]
**ext** | **Dict** | Option for providing additional data | [optional] [default to nothing]
**co_2_max_mtons** | **Float64** | Emission limit in absolute values, in Million of tons | [optional] [default to nothing]
**available** | **Bool** | Availability | [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


