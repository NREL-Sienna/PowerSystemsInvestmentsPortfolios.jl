```@meta
CurrentModule = PowerSystemsInvestmentsPortfolios
```

# The Portfolio

## What is a Portfolio?

A [`Portfolio`](@ref) is the central data container in `PowerSystemsInvestmentsPortfolios.jl` (PSIP). It plays the same structural role for capacity expansion modeling (CEM) that `PSY.System` plays for production cost modeling: everything lives in it, and the optimizer reads from it.

Where a `PSY.System` describes the grid as it exists at a point in time, a `Portfolio` describes the *space of possibilities* for future investment planning. It holds:

- **Technology candidates** — generation, storage, and transmission options that can be built or retired
- **Regions** — the spatial units (zones or nodes) over which investment decisions are made
- **Requirements** — constraints that must be satisfied (e.g., reserve margins, renewable portfolio standards)
- **Time series profiles** — capacity factors, load shapes, and other temporal data indexed by `(year, rep_day)` keys
- **Financial data** — discount rates, cost escalation, and other economic parameters

The portfolio does not represent a single operating snapshot. It encodes an investment horizon spanning multiple planning years, and the optimizer (PowerSystemsInvestments.jl, PSI) decides which technologies to build or retire across that horizon.

## Portfolio vs. System

| | `PSY.System` | `PSIP.Portfolio` |
|---|---|---|
| Primary question | What exists now? | What can be built, when, where? |
| Central concept | Component (bus, generator, line) | Technology candidate |
| Spatial unit | Bus (`ACBus`) | Zone ([`Zone`](@ref)) or Node ([`Node`](@ref)) |
| Time dimension | Single operating snapshot | Multi-period investment horizon |
| Time series key | Datetime index | `(year, rep_day)` keys |

A `Portfolio` always wraps a `PSY.System` (the `base_system` field). The two objects are complementary: the system describes the existing grid, the portfolio describes how that grid might change.

## Fields of a Portfolio

```julia
mutable struct Portfolio
    aggregation::Type{<:Union{PSY.ACBus, PSY.AggregationTopology}}
    data::IS.SystemData
    base_system::PSY.System
    investment_schedule::Union{Nothing, InvestmentScheduleResults}
    time_series_directory::Union{Nothing, String}
    financial_data::Union{Nothing, PortfolioFinancialData}
    metadata::PortfolioMetadata
    internal::IS.InfrastructureSystemsInternal
end
```

| Field | Type | Purpose |
|---|---|---|
| `aggregation` | `Type{<:Union{PSY.ACBus, PSY.AggregationTopology}}` | Spatial resolution for this portfolio; set at construction and controls how regions map to PSY topology |
| `data` | `IS.SystemData` | Internal InfrastructureSystems container that stores all components (technologies, requirements, regions) and attached time series |
| `base_system` | `PSY.System` | The existing grid; provides component type definitions, base power, and network topology |
| `investment_schedule` | `Union{Nothing, InvestmentScheduleResults}` | `nothing` until PSI solves; populated with investment decisions after optimization |
| `time_series_directory` | `Union{Nothing, String}` | Optional path for on-disk time series storage; `nothing` stores time series in memory |
| `financial_data` | `Union{Nothing, PortfolioFinancialData}` | Portfolio-level economic parameters (discount rate, cost escalation); see [`PortfolioFinancialData`](@ref) |
| `metadata` | `PortfolioMetadata` | Name, description, and data source strings |
| `internal` | `IS.InfrastructureSystemsInternal` | InfrastructureSystems bookkeeping; not used directly |

### `financial_data`

[`PortfolioFinancialData`](@ref) carries portfolio-wide economic assumptions: the discount rate, transmission loss factor, and other scalars that apply uniformly across all technologies. Individual technologies can override these with their own [`TechnologyFinancialData`](@ref).

### `metadata`

`PortfolioMetadata` holds three strings — `name`, `description`, and `data_source` — that identify the portfolio in logs, saved files, and reports.

## The `base_system` Relationship

Every `Portfolio` holds a reference to a `PSY.System`. This coupling exists because PSIP technology types are parameterized by PSY component types — for example, `SupplyTechnology{PSY.RenewableDispatch}`. The `base_system` serves three purposes:

1. **Type registry** — PSI looks up existing units in the base system when computing capacity constraints against existing capacity.
2. **Base power** — the system's `base_power` field sets the per-unit base for all power quantities in the portfolio.
3. **Network topology** — for nodal models, the existing buses and branches define the admittance matrix.

If you construct a `Portfolio` without providing a real system (using `Portfolio()` with no arguments), PSIP automatically creates a minimal default `PSY.System(100.0)` and assigns it as the `base_system`. This is useful for testing and small examples, but production workflows should always pass a real `PSY.System`.

## Aggregation Level

The first argument to most `Portfolio` constructors is a PSY topology type that controls spatial resolution. This choice determines how technologies, requirements, and regions are organized.

```julia
# Zonal — one planning zone per PSY.LoadZone (most common for multi-zone CEM)
portfolio = Portfolio(PSY.LoadZone, base_sys, 2030, 0.07, 0.025, 0.05)

# Nodal — one planning node per PSY.ACBus (for power-flow-constrained models)
portfolio = Portfolio(PSY.ACBus, base_sys, 2030, 0.07, 0.025, 0.05)
```

| Aggregation type | Spatial unit | Typical use |
|---|---|---|
| `PSY.Area` (default) | One region per PSY area | Large-region, coarse studies |
| `PSY.LoadZone` | One zone per PSY load zone | Multi-zone capacity expansion |
| `PSY.ACBus` | One node per PSY bus | Power-flow-constrained investment |

!!! tip
    `PSY.LoadZone` is the most common choice for capacity expansion studies. Use `PSY.ACBus` only when you need nodal power flow constraints; it substantially increases model size.

## See Also

- [`Portfolio`](@ref)
- [`PortfolioFinancialData`](@ref)
- [`Zone`](@ref)
- [`Node`](@ref)
