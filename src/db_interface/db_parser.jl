"""
`DBParser` — the SiennaGridDB SQLite ⇄ Portfolio / base-`System` bridge.
Uses OpenAPI converters (`to_openapi`/`from_openapi` + `OpenAPIRefs`) from PSIP
and PSY to populate a SQLite database using the SiennaGridDB schema.

"""
module DBParser

import SQLite
import DBInterface
import Tables
import JSON3
import OpenAPI
import Dates
import InfrastructureSystems
const IS = InfrastructureSystems
import PowerSystems
const PSY = PowerSystems
import PowerCoreOpenAPIModels
const PC = PowerCoreOpenAPIModels
import PowerInvestmentsOpenAPIModels
const PI = PowerInvestmentsOpenAPIModels
import PowerOperationsOpenAPIModels
const PO = PowerOperationsOpenAPIModels

# Base-`System` accessors used bare (they come from `using PowerSystems` at parent scope).
import PowerSystems: get_frequency, get_subsystems

# Parent-package types and functions the DB bridge builds on. Imported explicitly (the
# submodule does not `using ..PowerSystemsInvestmentsPortfolios`) so the set is auditable.
import ..PowerSystemsInvestmentsPortfolios:
    Portfolio,
    OpenAPIRefs,
    to_openapi,
    from_openapi,
    component_id,
    get_id,
    get_base_system,
    get_regions,
    get_technologies,
    add_region!,
    add_technology!,
    Technology,
    RegionTopology,
    Requirement,
    Zone,
    Node,
    SupplyTechnology,
    StorageTechnology,
    NodalACTransportTechnology,
    NodalHVDCTransportTechnology,
    AggregateTransportTechnology,
    DemandRequirement,
    DemandSideTechnology,
    ExistingDevices,
    AggregateRetirementPotential,
    RetirementPotential,
    AggregateRetrofitPotential,
    RetrofitPotential,
    TopologyMapping

# Order matters: schema tables and type/table maps before the code that indexes them;
# `common.jl` (dispatch helpers + id/uuid bridge) before the sqlite/time-series drivers.
include("db_definition.jl")
include("translation_constants.jl")
include("common.jl")
include("sqlite.jl")
include("time_series.jl")

end # module DBParser
