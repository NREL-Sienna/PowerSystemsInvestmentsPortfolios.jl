module PowerSystemsInvestmentsPortfolios

import PowerSystems
# TODO: Some of these re-exports may cause name collisions with PowerSystems
import PowerSystems:
    add_time_series!,
    get_time_series,
    has_time_series,
    get_time_series_array,
    get_time_series_timestamps,
    get_time_series_values,
    get_time_series_names

import InfrastructureSystems
import InfrastructureSystems:
    Components,
    TimeSeriesData,
    StaticTimeSeries,
    Forecast,
    AbstractDeterministic,
    Deterministic,
    Probabilistic,
    SingleTimeSeries,
    DeterministicSingleTimeSeries,
    Scenarios,
    ForecastCache,
    StaticTimeSeriesCache,
    InfrastructureSystemsComponent,
    InfrastructureSystemsType,
    InfrastructureSystemsInternal,
    DeviceParameter,
    FlattenIteratorWrapper,
    LazyDictFromIterator,
    DataFormatError,
    InvalidRange,
    InvalidValue,
    copy_time_series!,
    get_count,
    get_data,
    get_horizon,
    get_resolution,
    get_window,
    get_name,
    set_name!,
    get_internal,
    set_internal!,
    get_time_series_container,
    iterate_windows,
    get_time_series,
    has_time_series,
    get_time_series_array,
    get_time_series_timestamps,
    get_time_series_values,
    get_time_series_names,
    get_scenario_count, # Scenario Forecast Exports
    get_percentiles, # Probabilistic Forecast Exports
    get_next_time_series_array!,
    get_next_time,
    get_units_info,
    set_units_info!,
    to_json,
    from_json,
    serialize,
    deserialize,
    get_time_series_multiple,
    compare_values,
    CompressionSettings,
    CompressionTypes,
    NormalizationFactor,
    NormalizationTypes,
    UnitSystem,
    SystemUnitsSettings,
    open_file_logger,
    make_logging_config_file,
    validate_struct,
    MultiLogger,
    LogEventTracker,
    StructField,
    StructDefinition

const IS = InfrastructureSystems

import PowerSystems
import PrettyTables

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
