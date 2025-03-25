module PowerSystemsInvestmentsPortfolios

import InfrastructureSystems
# TODO: Some of these re-exports may cause name collisions with PowerSystems
import InfrastructureSystems:
    from_json,
    serialize,
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
import PowerSystems: StorageCost, ThermalGenerationCost

import JSONSchema
import JSON3
import PrettyTables
import SQLite
import DataFrames
import DBInterface
import TimeSeries
import Dates
import DataStructures: OrderedDict, SortedDict
import OpenAPI

# Temporary, imports not working properly for some reason?
using DataFrames
using PowerSystems
using Dates
using TimeSeries
using StringEncodings

export Portfolio
export Technology
export Requirement
export FinancialData
export Region
export SupplyTechnology
export ACTransportTechnology
export HVDCTransportTechnology
export StorageTechnology
export DemandRequirement
export DemandSideTechnology
export RetirementPotential
export AggregateRetirementPotential
export RetrofitPotential
export AggregateRetrofitPotential
export ExistingCapacity
export CarbonCaps
export CapacityReserveMargin
export CarbonTax
export HourlyMatching
export EnergyShareRequirements
export MinimumCapacityRequirements
export MaximumCapacityRequirements
export Region
export Zone
export PortfolioFinancialData
export TechnologyFinancialData

export get_name
export get_description
export get_regions
export get_technologies
export get_technology
export get_requirements
export get_ext
export get_description
export get_financial_data
export get_base_year
export get_inflation_rate
export get_interest_rate
export get_discount_rate
export set_description!
export set_name!
export set_base_year!
export set_inflation_rate!
export set_interest_rate!
export set_discount_rate!
export add_technology!
export add_technologies!
export add_region!
export add_requirement!
export add_time_series!
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
export from_json

const PSY = PowerSystems
const IS = InfrastructureSystems
const MU = IS.Mustache

##### Imports #####

import PowerSystems: ThermalFuels, PrimeMovers, StorageTech

##### Exports #####

export ThermalFuels
export PrimeMovers
export StorageTech

#submodule for OpenAPI structs 
include("models/generated/open_api_models/src/APIServer.jl")
using .APIServer

include("definitions.jl")

include("models/technologies.jl")
include("models/regions.jl")
include("models/financial_data/financial_data.jl")
include("models/financial_data/TechnologyFinancialData.jl")
include("models/requirements.jl")
include("models/generated/includes.jl")

include("portfolio.jl")
include("serialization.jl")
include("generate_structs.jl")
include("db_parser.jl")
include("utils/print.jl")

using DocStringExtensions

@template (FUNCTIONS, METHODS) = """
                                 $(TYPEDSIGNATURES)
                                 $(DOCSTRING)
                                 """

end
