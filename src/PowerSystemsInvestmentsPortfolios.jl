module PowerSystemsInvestmentsPortfolios

import InfrastructureSystems
# TODO: Some of these re-exports may cause name collisions with PowerSystems
import InfrastructureSystems:
    add_time_series,
    to_json,
    from_json,
    serialize,
    deserialize,
    get_time_series,
    has_time_series,
    get_time_series_array,
    get_time_series_timestamps,
    get_time_series_values,
    get_time_series_names,
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

export Portfolio
export SupplyTechnology
export TransportTechnology
export DemandTechnology
export StorageTechnology

export add_technology!
export add_technologies!
export read_json_data
export generate_invest_structs
export generate_structs

const PSY = PowerSystems
const IS = InfrastructureSystems
const MU = IS.Mustache

include("models/technologies.jl")
include("models/generated/includes.jl")
include("portfolio.jl")
include("generate_structs.jl")

using DocStringExtensions

@template (FUNCTIONS, METHODS) = """
                                 $(TYPEDSIGNATURES)
                                 $(DOCSTRING)
                                 """

end
