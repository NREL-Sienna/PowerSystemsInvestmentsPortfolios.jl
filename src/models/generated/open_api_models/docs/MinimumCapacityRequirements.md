# MinimumCapacityRequirements


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **String** | The technology name | [default to nothing]
**power_systems_type** | **String** | maps to a valid PowerSystems.jl for PCM modeling | [optional] [default to nothing]
**pricecap** | **Float64** | price threshold for policy constraint, USD/MW | [optional] [default to nothing]
**internal** | [***InfrastructureSystemsInternal**](InfrastructureSystemsInternal.md) | Internal field | [optional] [default to nothing]
**ext** | **Dict** | Option for providing additional data | [optional] [default to nothing]
**min_mw** | **Float64** | Minimum total capacity across all eligible resources | [optional] [default to nothing]
**eligible_resources** | [***Vector{String}**](Vector{String}.md) | List of resources that contribute to the carbon cap constraint. | [optional] [default to nothing]
**available** | **Bool** | Availability | [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


