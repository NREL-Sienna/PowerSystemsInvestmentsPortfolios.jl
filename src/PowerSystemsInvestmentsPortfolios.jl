module PowerSystemsInvestmentsPortfolios

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
    InfrastructureSystemsInternal,
    CompressionSettings,
    CompressionTypes,
    MultiLogger,
    LogEventTracker,
    StructField,
    InfrastructureSystemsComponent

import PowerSystems
import JSONSchema
import JSON3
import PrettyTables
import SQLite
import DataFrames

export Portfolio
export Technology
export SupplyTechnology
export TransportTechnology
export StorageTechnology
export DemandRequirement
export DemandsideTechnology

export add_technology!
export add_technologies!
export read_json_data
export generate_invest_structs
export generate_structs
export db_to_dataframes
export map_prime_mover
export dataframe_to_structs
export db_to_portfolio_parser

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
