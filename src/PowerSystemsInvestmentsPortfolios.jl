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
    StructField

import PowerSystems
import JSONSchema

export Portfolio
export SupplyTechnology
export TransportTechnology
export DemandTechnology
export StorageTechnology

export add_technology!
export add_technologies!

const PSY = PowerSystems
const IS = InfrastructureSystems

include("models/includes.jl")
include("portfolio.jl")
include("generate_structs.jl")

using DocStringExtensions

@template (FUNCTIONS, METHODS) = """
                                 $(TYPEDSIGNATURES)
                                 $(DOCSTRING)
                                 """

end
