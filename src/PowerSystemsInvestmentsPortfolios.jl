module PowerSystemsInvestmentsPortfolios

#submodule for OpenAPI structs 
module deserialization
import OpenAPI
include("models/generated/open_api_models/src/modelincludes.jl")
end

import InfrastructureSystems
# TODO: Some of these re-exports may cause name collisions with PowerSystems
import InfrastructureSystems:
    to_json,
    from_json,
    serialize,
    deserialize,
    has_time_series,
    get_time_series_array,
    get_time_series_timestamps,
    get_time_series_values,
    supports_time_series,
    InfrastructureSystemsInternal,
    CompressionSettings,
    CompressionTypes,
    MultiLogger,
    LogEventTracker,
    StructField,
    CostCurve,
    LinearCurve,
    InfrastructureSystemsComponent,
    InfrastructureSystemsType

import PowerSystems
import PowerSystems:
    StorageCost,
    ThermalGenerationCost

import JSONSchema
import JSON3
import PrettyTables
import SQLite
import DataFrames
import DBInterface
import TimeSeries
import Dates
import DataStructures: OrderedDict
import OpenAPI

# Temporary, imports not working properly for some reason?
using DataFrames
using PowerSystems
using Dates
using TimeSeries

export Portfolio
export Technology
export Requirements
export SupplyTechnology
export TransportTechnology
export StorageTechnology
export DemandRequirement
export DemandsideTechnology
export FlexibleDemandTechnology
export Electrolyzers
export CurtailableDemandSideTechnology
export RetireableCapacity
export RetrofitCapacity
export ExistingCapacity
export CarbonCaps
export MinimumCapacityRequirements
export Region
export Zone

export get_technologies
export get_technology
export get_requirements
export get_time_series_resolution
export get_ext
export add_technology!
export add_technologies!
export read_json_data
export generate_invest_structs
export generate_structs
export db_to_dataframes
export map_prime_mover
export dataframe_to_structs
export db_to_portfolio_parser
export add_supplemental_attribute!
export remove_supplemental_attribute!
export get_supplemental_attribute
export to_json

const PSY = PowerSystems
const IS = InfrastructureSystems
const MU = IS.Mustache

##### Imports #####

import PowerSystems: ThermalFuels, PrimeMovers, StorageTech

##### Exports #####

export ThermalFuels
export PrimeMovers
export StorageTech

include("models/technologies.jl")
include("models/regions.jl")
include("models/requirements.jl")
include("models/generated/includes.jl")
include("portfolio.jl")
include("serialization.jl")
include("generate_structs.jl")
include("utils/print.jl")

using DocStringExtensions

@template (FUNCTIONS, METHODS) = """
                                 $(TYPEDSIGNATURES)
                                 $(DOCSTRING)
                                 """

end
