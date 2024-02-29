module PowerSystemsInvestmentsPortfolios

import InfrastructureSystems
# TODO: Some of these re-exports may cause name collisions
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
    CompressionSettings,
    CompressionTypes,
    MultiLogger,
    LogEventTracker,
    StructField

import PowerSystems

export Portfolio
export SupplyTechnology
export TransportTechnology
export DemandTechnology
export StorageTechnology

export add_technology!
export add_technologies!

const PSY = PowerSystems
const IS = InfrastructureSystems

include("technologies.jl")
include("demand.jl")
include("supply.jl")
include("transport.jl")
include("storage.jl")
include("portfolio.jl")

using DocStringExtensions

@template (FUNCTIONS, METHODS) = """
                                 $(TYPEDSIGNATURES)
                                 $(DOCSTRING)
                                 """

end
