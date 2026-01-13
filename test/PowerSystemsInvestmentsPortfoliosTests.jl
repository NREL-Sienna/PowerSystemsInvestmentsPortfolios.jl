module PowerSystemsInvestmentsPortfoliosTests
using ReTest
using Logging
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
const PSY = PowerSystems

# Automatically download and get path to CaseData artifact from test/Artifacts.toml
const ARTIFACTS_TOML = joinpath(@__DIR__, "Artifacts.toml")
const ARTIFACT_NAME = "CaseData"
artifact_path = Pkg.Artifacts.ensure_artifact_installed(ARTIFACT_NAME, ARTIFACTS_TOML)
const DATA_DIR = joinpath(artifact_path, "PowerSystemsInvestmentsPortfoliosTestData-1.0-alpha1")

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

"""
Copied @includetests from https://github.com/ssfrr/TestSetExtensions.jl.
Ideally, we could import and use TestSetExtensions.  Its functionality was broken by changes
in Julia v0.7.  Refer to https://github.com/ssfrr/TestSetExtensions.jl/pull/7.
"""

"""
Includes the given test files, given as a list without their ".jl" extensions.
If none are given it will scan the directory of the calling file and include all
the julia files.
"""
macro includetests(testarg...)
    if length(testarg) == 0
        tests = []
    elseif length(testarg) == 1
        tests = testarg[1]
    else
        error("@includetests takes zero or one argument")
    end

    quote
        tests = $tests
        rootfile = @__FILE__
        if length(tests) == 0
            tests = readdir(dirname(rootfile))
            tests = filter(
                f ->
                    startswith(f, "test_") && endswith(f, ".jl") && f != basename(rootfile),
                tests,
            )
        else
            tests = map(f -> string(f, ".jl"), tests)
        end
        println()
        for test in tests
            print(splitext(test)[1], ": ")
            include(test)
            println()
        end
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
                filename = LOG_FILE,
                file_level = get_logging_level_from_env("SIENNA_FILE_LOG_LEVEL", "Info"),
                console_level = get_logging_level_from_env(
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

using .InfrastructureSystemsTests
