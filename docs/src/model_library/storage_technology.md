```@meta
CurrentModule = PowerSystemsInvestmentsPortfolios
```

# Storage Technology

A [`StorageTechnology{T}`](@ref) represents a candidate energy storage technology. Storage is characterized by separate energy (MWh) and power (MW) capacity limits and costs, reflecting that energy and power can be sized independently.

## Type parameter

`T` must be a subtype of `PSY.Storage`. The most common choice:

| `T`                          | Typical technology                        |
|:---------------------------- |:----------------------------------------- |
| `PSY.EnergyReservoirStorage` | Battery (lithium-ion, flow), pumped hydro |

## Key field groups

**Capacity:** `capacity_limits_energy` (`MinMax` in MWh), `capacity_limits_discharge` (`MinMax` in MW), `capacity_limits_charge` (optional `MinMax` in MW)

**Efficiency:** `efficiency` (`InOut` — charging and discharging efficiency fractions), `losses` (self-discharge fraction per hour), `min_discharge_fraction`

**Duration:** `duration_limits` (`MinMax` in hours — ratio of energy to discharge power capacity)

**Economics:** `capital_costs_energy` (`PSY.ValueCurve` in USD/MWh), `capital_costs_discharge` (`PSY.ValueCurve` in USD/MW), `capital_costs_charge` (optional `PSY.ValueCurve`), `operation_costs`, `financial_data`

**Build increments:** `unit_size_energy` (MWh), `unit_size_discharge` (MW), `unit_size_charge` (MW)

**Other:** `storage_tech` (`StorageTech` enum), `prime_mover_type`, `lifetime`

```@docs
StorageTechnology
```
