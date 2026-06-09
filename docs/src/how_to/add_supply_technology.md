```@meta
CurrentModule = PowerSystemsInvestmentsPortfolios
```

# Add a Supply Technology

`SupplyTechnology{T}` represents a generation asset — thermal, renewable, or hydro — that can be built or retired in a capacity expansion model.

## Common PSY type mappings

| Type parameter `T`      | Represents                                        |
|:----------------------- |:------------------------------------------------- |
| `PSY.ThermalStandard`   | Gas, coal, nuclear, or other dispatchable thermal |
| `PSY.RenewableDispatch` | Wind, solar, or other variable renewables         |
| `PSY.HydroDispatch`     | Conventional hydro dispatch                       |

## Minimal working example

The example below adds a wind supply technology to a portfolio.

```julia
using PowerSystemsInvestmentsPortfolios
import PowerSystems as PSY

portfolio = Portfolio()

zone = Zone(; name="Zone_1", id=1)
add_region!(portfolio, zone)

fin = TechnologyFinancialData(;
    capital_recovery_period=20,
    technology_base_year=2030,
    debt_fraction=0.4,
    debt_rate=0.05,
    return_on_equity=0.12,
    tax_rate=0.21,
)

wind = SupplyTechnology{PSY.RenewableDispatch}(;
    name="wind_z1",
    id=1,
    available=true,
    region=[zone],
    power_systems_type="RenewableDispatch",
    financial_data=fin,
    capital_costs=LinearCurve(1200.0),   # USD/MW
    capacity_limits=(min=0.0, max=500.0),  # MW
)

add_technology!(portfolio, wind)
```

## Thermal generator example

Thermal technologies support additional fuel and emissions fields.

```julia
fin = TechnologyFinancialData(;
    capital_recovery_period=30,
    technology_base_year=2030,
    debt_fraction=0.5,
    debt_rate=0.06,
    return_on_equity=0.12,
    tax_rate=0.21,
)

ccgt = SupplyTechnology{PSY.ThermalStandard}(;
    name="ccgt_z1",
    id=2,
    available=true,
    region=[zone],
    power_systems_type="ThermalStandard",
    financial_data=fin,
    prime_mover_type=PrimeMovers.CT,
    fuel=[ThermalFuels.NATURAL_GAS],
    co2=Dict(ThermalFuels.NATURAL_GAS => 0.053),  # tonne CO2/MMBtu
    capital_costs=LinearCurve(900.0),    # USD/MW
    capacity_limits=(min=0.0, max=1000.0),  # MW
    ramp_limits=(up=0.5, down=0.5),
)

add_technology!(portfolio, ccgt)
```

## Key fields

| Field             | Type                      | Description                                                   |
|:----------------- |:------------------------- |:------------------------------------------------------------- |
| `capacity_limits` | `MinMax` (NamedTuple)     | Minimum and maximum buildable capacity in MW                  |
| `capital_costs`   | `PSY.ValueCurve`          | Capital cost curve in USD/MW (e.g. `LinearCurve(1200.0)`)     |
| `operation_costs` | `PSY.OperationalCost`     | Operating cost structure (default: `ThermalGenerationCost()`) |
| `financial_data`  | `TechnologyFinancialData` | Financing parameters for annualised cost calculation          |
| `region`          | `Vector{RegionTopology}`  | Zones or nodes where the technology can be built              |
| `lifetime`        | `Int`                     | Asset lifetime in years (default: 100)                        |
| `ramp_limits`     | `UpDown` (NamedTuple)     | Maximum up/down ramp rate as a fraction of capacity per hour  |
| `time_limits`     | `UpDown` (NamedTuple)     | Minimum up/down time in hours                                 |

## Marking existing capacity

To link a `SupplyTechnology` to devices already present in a PowerSystems.jl system (i.e. pre-existing installed capacity that can be retired), attach an `ExistingDevices` supplemental attribute:

```julia
existing = ExistingDevices(; existing_devices=["wind_z1_unit1", "wind_z1_unit2"])
add_supplemental_attribute!(portfolio, wind, existing)
```

The strings in `existing_devices` must match the `name` field of the corresponding components in the PowerSystems.jl `System`.

## See also

  - [`StorageTechnology`](@ref)
  - [`TechnologyFinancialData`](@ref)
  - [`add_technology!`](@ref)
