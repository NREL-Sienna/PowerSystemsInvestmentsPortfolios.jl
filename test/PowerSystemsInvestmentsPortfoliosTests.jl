module PowerSystemsInvestmentsPortfoliosTests
using ReTest
using Logging
using TerminalLoggers
using DataStructures
using PowerSystems
using PowerSystemsInvestmentsPortfolios
import PowerSystemsInvestmentsPortfolios as PSIP
using PowerSystemCaseBuilder
using Statistics
import InfrastructureSystems as IS
using InfrastructureSystems
using TimeSeries
using Dates
using CSV
using DataFrames
import InteractiveUtils
import JSON3
import Pkg
import PowerSystems as PSY

# Automatically download and get path to CaseData artifact from test/Artifacts.toml
const ARTIFACTS_TOML = joinpath(@__DIR__, "Artifacts.toml")
const ARTIFACT_NAME = "CaseData"
artifact_path = Pkg.Artifacts.ensure_artifact_installed(ARTIFACT_NAME, ARTIFACTS_TOML)
const DATA_DIR =
    joinpath(artifact_path, "PowerSystemsInvestmentsPortfoliosTestData-1.0-alpha1")
const BASE_DIR = dirname(dirname(Base.find_package("PowerSystemsInvestmentsPortfolios")))

import Aqua
Aqua.test_unbound_args(PowerSystemsInvestmentsPortfolios)
Aqua.test_undefined_exports(PowerSystemsInvestmentsPortfolios)
Aqua.test_ambiguities(PowerSystemsInvestmentsPortfolios)
Aqua.test_stale_deps(PowerSystemsInvestmentsPortfolios)
Aqua.test_deps_compat(PowerSystemsInvestmentsPortfolios)

LOG_FILE = "power-systems-investments-portfolio.log"
LOG_LEVELS = Dict(
    "Debug" => Logging.Debug,
    "Info" => Logging.Info,
    "Warn" => Logging.Warn,
    "Error" => Logging.Error,
)

include("common.jl")
include("portfolio_5bus.jl")

for filename in readdir(joinpath(BASE_DIR, "test"))
    if startswith(filename, "test_") && endswith(filename, ".jl")
        include(filename)
    end
end

function get_logging_level_from_env(env_name::String, default)
    level = get(ENV, env_name, default)
    return IS.get_logging_level(level)
end

function run_tests(args...; kwargs...)
    logger = global_logger()
    try
        logging_config_filename = get(ENV, "SIENNA_LOGGING_CONFIG", nothing)
        if logging_config_filename !== nothing
            config = IS.LoggingConfiguration(logging_config_filename)
        else
            config = IS.LoggingConfiguration(;
                filename=LOG_FILE,
                file_level=get_logging_level_from_env("SIENNA_FILE_LOG_LEVEL", "Info"),
                console_level=get_logging_level_from_env(
                    "SIENNA_CONSOLE_LOG_LEVEL",
                    "Error",
                ),
            )
        end
        console_logger = TerminalLogger(config.console_stream, config.console_level)

        IS.open_file_logger(config.filename, config.file_level) do file_logger
            levels = (Logging.Info, Logging.Warn, Logging.Error)
            multi_logger =
                IS.MultiLogger([console_logger, file_logger], IS.LogEventTracker(levels))
            global_logger(multi_logger)

            if !isempty(config.group_levels)
                IS.set_group_levels!(multi_logger, config.group_levels)
            end

            @time retest(args...; kwargs...)
            @test length(IS.get_log_events(multi_logger.tracker, Logging.Error)) == 0
            @info IS.report_log_summary(multi_logger)
        end
    finally
        # Guarantee that the global logger is reset.
        global_logger(logger)
        nothing
    end
end

export run_tests

end

using .PowerSystemsInvestmentsPortfoliosTests
