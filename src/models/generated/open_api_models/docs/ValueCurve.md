# ValueCurve



## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**value** | This is a oneOf model. The value must be exactly one of the following types: AverageRateCurve, IncrementalCurve, InputOutputCurve |  | [optional] 

The discriminator field is `curve_type` with the following mapping:
 - `AVERAGE_RATE`: `AverageRateCurve`
 - `INCREMENTAL`: `IncrementalCurve`
 - `INPUT_OUTPUT`: `InputOutputCurve`



[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


