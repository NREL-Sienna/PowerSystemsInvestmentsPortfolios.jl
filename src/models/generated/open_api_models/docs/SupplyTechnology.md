# SupplyTechnology


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**base_power** | **Float64** | Base power | [optional] [default to nothing]
**heat_rate_mmbtu_per_mwh** | [***Union{Float64PSYValueCurveDict{ThermalFuelsPSYValueCurve}}**](Union{Float64PSYValueCurveDict{ThermalFuelsPSYValueCurve}}.md) | Heat rate of generator, MMBTU/MWh | [optional] [default to nothing]
**outage_factor** | **Float64** | Derating factor to account for planned or forced outages of a technology | [optional] [default to nothing]
**prime_mover_type** | [***PrimeMovers**](PrimeMovers.md) | Prime mover for generator | [optional] [default to nothing]
**cofire_level_min** | [***Union{NothingDict{ThermalFuelsFloat64}}**](Union{NothingDict{ThermalFuelsFloat64}}.md) | Minimum blending level of each fuel during normal generation process for multi-fuel generator | [optional] [default to nothing]
**capital_costs** | [***PSYValueCurve**](PSYValueCurve.md) | Capital costs for investing in a technology. | [optional] [default to nothing]
**max_capacity** | **Float64** | Maximum allowable installed capacity for a technology | [optional] [default to nothing]
**dn_time** | **Float64** | Minimum amount of time a resource has to remain in the shutdown state. | [optional] [default to nothing]
**lifetime** | [***Int**](Int.md) | Maximum number of years a technology can be active once installed | [optional] [default to nothing]
**cofire_start_max** | [***Union{NothingDict{ThermalFuelsFloat64}}**](Union{NothingDict{ThermalFuelsFloat64}}.md) | Maximum blending level of each fuel during start-up process for multi-fuel generator | [optional] [default to nothing]
**available** | **Bool** | identifies whether the technology is available | [default to nothing]
**co2** | [***Union{Float64Dict{StringFloat64}Dict{ThermalFuelsFloat64}}**](Union{Float64Dict{StringFloat64}Dict{ThermalFuelsFloat64}}.md) | Carbon Intensity of fuel | [optional] [default to nothing]
**cofire_start_min** | [***Union{NothingDict{ThermalFuelsFloat64}}**](Union{NothingDict{ThermalFuelsFloat64}}.md) | Minimum blending level of each fuel during start-up process for multi-fuel generator | [optional] [default to nothing]
**name** | **String** | The technology name | [default to nothing]
**ramp_dn_percentage** | **Float64** | Maximum decrease in output between operation periods. Fraction of total capacity | [optional] [default to nothing]
**min_capacity** | **Float64** | Minimum required capacity for a technology | [optional] [default to nothing]
**id** | **Int64** | ID for individual generator | [optional] [default to nothing]
**initial_capacity** | **Float64** | Pre-existing capacity for a technology | [optional] [default to nothing]
**financial_data** | [***TechnologyFinancialData**](TechnologyFinancialData.md) | Struct containing relevant financial information for a technology | [optional] [default to nothing]
**start_fuel_mmbtu_per_mw** | **Float64** | Startup fuel use per MW of nameplate capacity of each generator (MMBtu/MW per start) | [optional] [default to nothing]
**operation_costs** | [***PSYOperationalCost**](PSYOperationalCost.md) | Fixed and variable O&amp;M costs for a technology | [optional] [default to nothing]
**fuel** | [***Union{StringThermalFuelsVector{ThermalFuels}Vector{String}}**](Union{StringThermalFuelsVector{ThermalFuels}Vector{String}}.md) | Fuel type according to IEA | [optional] [default to nothing]
**power_systems_type** | **String** | maps to a valid PowerSystems.jl for PCM modeling | [default to nothing]
**cofire_level_max** | [***Union{NothingDict{ThermalFuelsFloat64}}**](Union{NothingDict{ThermalFuelsFloat64}}.md) | Maximum blending level of each fuel during normal generation process for multi-fuel generator | [optional] [default to nothing]
**internal** | [***InfrastructureSystemsInternal**](InfrastructureSystemsInternal.md) | Internal field | [optional] [default to nothing]
**ext** | **Dict** | Option for providing additional data | [optional] [default to nothing]
**balancing_topology** | **String** | Set of balancing nodes | [optional] [default to nothing]
**region** | [***Union{NothingRegionVector{Region}}**](Union{NothingRegionVector{Region}}.md) | Zone where tech operates in | [optional] [default to nothing]
**ramp_up_percentage** | **Float64** | Maximum increase in output between operation periods. Fraction of total capacity | [optional] [default to nothing]
**base_year** | [***Int**](Int.md) | Reference year for technology data | [optional] [default to nothing]
**unit_size** | **Float64** | Used for discrete investment decisions. Size of each unit being built (MW) | [optional] [default to nothing]
**min_generation_percentage** | **Float64** | Minimum generation as a fraction of total capacity | [optional] [default to nothing]
**start_cost_per_mw** | **Float64** | Cost per MW of nameplate capacity to start a generator (/MW per start). | [optional] [default to nothing]
**up_time** | **Float64** | Minimum amount of time a resource has to stay in the committed state. | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


