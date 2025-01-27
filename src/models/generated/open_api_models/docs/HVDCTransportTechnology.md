# HVDCTransportTechnology


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**base_power** | **Float64** | Base power | [optional] [default to nothing]
**capital_cost** | [***PSYValueCurve**](PSYValueCurve.md) | Cost of adding new capacity to the inter-regional transmission line. | [optional] [default to nothing]
**start_region** | [***Region**](Region.md) | Start region for transport technology | [optional] [default to nothing]
**available** | **Bool** | identifies whether the technology is available | [default to nothing]
**name** | **String** | Name | [default to nothing]
**id** | **Int64** | Numerical Index | [optional] [default to nothing]
**end_region** | [***Region**](Region.md) | End region for transport technology | [optional] [default to nothing]
**financial_data** | [***TechnologyFinancialData**](TechnologyFinancialData.md) | Struct containing relevant financial information for a technology | [optional] [default to nothing]
**power_systems_type** | **String** | maps to a valid PowerSystems.jl for PCM modeling | [optional] [default to nothing]
**angle_limit** | **Float64** | Votlage angle limit (radians) | [optional] [default to nothing]
**internal** | [***InfrastructureSystemsInternal**](InfrastructureSystemsInternal.md) | Internal field | [optional] [default to nothing]
**ext** | **Dict** | Option for providing additional data | [optional] [default to nothing]
**resistance** | **Float64** | Technology resistance in Ohms | [optional] [default to nothing]
**voltage** | **Float64** | Technology resistance in Ohms | [optional] [default to nothing]
**maximum_new_capacity** | **Float64** | Maximum capacity that can be added to transmission line (MW) | [optional] [default to nothing]
**base_year** | [***Int**](Int.md) | Reference year for technology data | [optional] [default to nothing]
**existing_line_capacity** | **Float64** | Existing capacity of transport technology (MW) | [optional] [default to nothing]
**line_loss** | **Float64** | Transmission loss for each transport technology (%) | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


