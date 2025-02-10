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
    supports_time_series,
    InfrastructureSystemsInternal,
    CompressionSettings,
    CompressionTypes,
    MultiLogger,
    LogEventTracker,
    StructField,
    CostCurve,
    LinearCurve,
    InfrastructureSystemsComponent

import PowerSystems
import PowerSystems: StorageCost, ThermalGenerationCost

import JSONSchema
import JSON3
import PrettyTables
import SQLite
import DataFrames
import DBInterface
import TimeSeries
import Dates

# Temporary, imports not working properly for some reason?
using DataFrames
using PowerSystems
using Dates
using TimeSeries
using StringEncodings

export Portfolio
export Technology
export Requirements
export SupplyTechnology
export ACTransportTechnology
export HVDCTransportTechnology
export ExistingTransportTechnology
export StorageTechnology
export DemandRequirement
export DemandSideTechnology
export FlexibleDemandSideTechnology
export CurtailableDemandSideTechnology
export RetirementPotential
export AggregateRetirementPotential
export RetrofitPotential
export AggregateRetrofitPotential
export ExistingCapacity
export CarbonCaps
export CapacityReserveMargin
export MinimumCapacityRequirements
export MaximumCapacityRequirements
export Region
export Zone
export PortfolioFinancialData
export TechnologyFinancialData

export get_name
export get_regions
export get_technologies
export get_technology
export get_requirements
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
include("models/financials.jl")
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
