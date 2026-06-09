```@meta
CurrentModule = PowerSystemsInvestmentsPortfolios
```

# Supply Technology

A [`SupplyTechnology{T}`](@ref) represents a candidate generation technology for capacity expansion. Each instance describes one buildable option: where it can be built, how much it costs, its operational characteristics, and any constraints.

## Type parameter

`T` must be a subtype of `PSY.Generator`. Common choices:

| `T`                     | Typical technology                  |
|:----------------------- |:----------------------------------- |
| `PSY.ThermalStandard`   | Gas CCGT, coal, nuclear             |
| `PSY.RenewableDispatch` | Variable renewable (wind, solar PV) |
| `PSY.HydroDispatch`     | Run-of-river hydropower             |

## Key field groups

**Identity and availability:** `name`, `id`, `available`, `power_systems_type`, `region`

**Capacity:** `capacity_limits` (`MinMax` in MW), `unit_size` (discrete build increment in MW)

**Economics:** `capital_costs` (`PSY.ValueCurve` in USD/MW), `operation_costs` (`PSY.OperationalCost`), `financial_data` (`TechnologyFinancialData`)

**Fuel and prime mover:** `fuel` (`Vector{ThermalFuels}`), `prime_mover_type` (`PrimeMovers`), `co2` (Dict of emission rates), `heat_rate_mmbtu_per_mwh`, `start_fuel_mmbtu_per_mw`

**Operational constraints:** `ramp_limits` (`UpDown` in fraction/hr), `time_limits` (`UpDown` minimum up/down hours), `min_generation_fraction`, `outage_factor`, `lifetime`

**Multi-fuel co-firing:** `cofire_level_limits`, `cofire_start_limits`

```@docs
SupplyTechnology
```

## `ColocatedSupplyStorageTechnology`

A [`ColocatedSupplyStorageTechnology`](@ref) represents a co-located supply and storage system (e.g., solar PV + battery) that shares a single grid interconnection point. Both the supply and storage components are built and dispatched together under one technology entry.

```@docs
ColocatedSupplyStorageTechnology
```
