# CurtailableDemandSideTechnology


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **String** | The technology name | [default to nothing]
**power_systems_type** | **String** | maps to a valid PowerSystems.jl for PCM modeling | [default to nothing]
**curtailment_cost_mwh** | [***Vector{Float64}**](Vector{Float64}.md) | Energy cost of curtailment | [optional] [default to nothing]
**segments** | [***Vector{Int64}**](Vector{Int64}.md) | Demand segment IDs | [optional] [default to nothing]
**curtailment_cost** | [***Vector{Float64}**](Vector{Float64}.md) | Fraction of VOLL for curtailment cost | [optional] [default to nothing]
**voll** | **Float64** | value of lost load | [optional] [default to nothing]
**ext** | **Dict** | Option for providing additional data | [optional] [default to nothing]
**internal** | [***InfrastructureSystemsInternal**](InfrastructureSystemsInternal.md) | Internal field | [optional] [default to nothing]
**max_demand_curtailment** | [***Vector{Float64}**](Vector{Float64}.md) | percent of demand that can be curtailed in that segment | [optional] [default to nothing]
**available** | **Bool** | identifies whether the technology is available | [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


