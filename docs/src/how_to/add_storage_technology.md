```@meta
CurrentModule = PowerSystemsInvestmentsPortfolios
```

# Add a Storage Technology

`StorageTechnology{T}` represents a storage asset — battery, pumped hydro, or other storage — that can be built or retired in a capacity expansion model.

## Minimal working example

The example below adds a 4-hour lithium-ion battery to a portfolio.

```julia
using PowerSystemsInvestmentsPortfolios
import PowerSystems as PSY

portfolio = Portfolio()

zone = Zone(; name="Zone_1", id=1)
add_region!(portfolio, zone)

fin = TechnologyFinancialData(;
    capital_recovery_period = 15,
    technology_base_year    = 2030,
    debt_fraction           = 0.4,
    debt_rate               = 0.05,
    return_on_equity        = 0.12,
    tax_rate                = 0.21,
)

battery = StorageTechnology{PSY.EnergyReservoirStorage}(;
    name                       = "battery_z1",
    id                         = 1,
    available                  = true,
    region                     = [zone],
    power_systems_type         = "EnergyReservoirStorage",
    financial_data             = fin,
    storage_tech               = StorageTech.LI_ION,
    capital_costs_energy       = LinearCurve(280.0),   # USD/MWh
    capital_costs_discharge    = LinearCurve(100.0),   # USD/MW
    duration_limits            = (min = 1.0, max = 8.0),   # hours
    efficiency                 = (in = 0.92, out = 0.92),
    capacity_limits_energy     = (min = 0.0, max = 2000.0),  # MWh
    capacity_limits_discharge  = (min = 0.0, max = 500.0),   # MW
)

add_technology!(portfolio, battery)
```

## Key fields

| Field                      | Type                       | Description                                                         |
|----------------------------|----------------------------|---------------------------------------------------------------------|
| `capacity_limits_energy`   | `MinMax` (NamedTuple)      | Minimum and maximum buildable energy capacity in MWh                |
| `capacity_limits_discharge`| `MinMax` (NamedTuple)      | Minimum and maximum buildable discharge power capacity in MW        |
| `capacity_limits_charge`   | `Union{Nothing, MinMax}`   | Charge power limit in MW; `nothing` means charge equals discharge   |
| `duration_limits`          | `MinMax` (NamedTuple)      | Allowed energy-to-power ratio range in hours                        |
| `efficiency`               | `InOut` (NamedTuple)       | Round-trip efficiency: `in` (charge), `out` (discharge), 0–1       |
| `losses`                   | `Float64`                  | Standing self-discharge losses per period (default: `0.0`)         |
| `storage_tech`             | `StorageTech`              | Storage chemistry or technology type (e.g. `StorageTech.LI_ION`)  |

## Capacity vs. energy capital costs

Storage technologies have separate capital cost curves for two independent decision variables:

- **`capital_costs_energy`** (`USD/MWh`) — cost of adding energy capacity (the tank size).
- **`capital_costs_discharge`** (`USD/MW`) — cost of adding discharge power capacity (the inverter/turbine).
- **`capital_costs_charge`** (`USD/MW`, optional) — cost of adding charge power capacity when it differs from the discharge side (e.g. asymmetric pumped hydro). Leave as `nothing` for symmetric systems.

For a standard lithium-ion battery where charge and discharge power hardware are the same, omit `capital_costs_charge` and set only the energy and discharge curves.

## See also

- [`SupplyTechnology`](@ref)
- [`TechnologyFinancialData`](@ref)
- [`add_technology!`](@ref)
