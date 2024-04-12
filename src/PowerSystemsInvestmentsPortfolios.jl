module PowerSystemsInvestmentsPortfolios

import InfrastructureSystems
# TODO: Some of these re-exports may cause name collisions with PowerSystems
import InfrastructureSystems:
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
import PrettyTables

export Portfolio
export Technology
export SupplyTechnology
export TransportTechnology
export DemandSideTechnology
export StorageTechnology

export add_technology!
export add_technologies!
export remove_technology!
export remove_technologies!
export get_technology
export get_technologies
export get_technologies_by_name
export get_available_technologies
export iterate_technologies
export clear_technologies!

export get_name
export set_name!
export get_description
export set_description!
export get_available
export set_available!

const PSY = PowerSystems
const IS = InfrastructureSystems

include("technologies.jl")
include("demand_requirement.jl")
include("supply.jl")
include("demand_side.jl")
include("transport.jl")
include("storage.jl")
include("portfolio.jl")
include("utils/print.jl")

using DocStringExtensions

@template (FUNCTIONS, METHODS) = """
                                 $(TYPEDSIGNATURES)
                                 $(DOCSTRING)
                                 """

end
