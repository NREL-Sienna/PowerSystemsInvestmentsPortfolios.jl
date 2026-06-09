```@meta
CurrentModule = PowerSystemsInvestmentsPortfolios
```

# Add a Transmission Technology

PSIP provides two transmission technology types for capacity expansion modeling:

  - **`AggregateTransportTechnology`** — zonal (transport) model. Connects two [`Zone`](@ref) regions. Use this for most capacity expansion studies where nodal detail is not required.
  - **`NodalACTransportTechnology`** — nodal AC model. Connects two [`Node`](@ref) regions and includes electrical parameters. Use this when the model requires power-flow constraints.

## When to use each

| Type                           | Region type    | Electrical params              | Typical use case         |
|:------------------------------ |:-------------- |:------------------------------ |:------------------------ |
| `AggregateTransportTechnology` | `Zone` (zonal) | None                           | Zonal capacity expansion |
| `NodalACTransportTechnology`   | `Node` (nodal) | Reactance, resistance, voltage | Nodal/AC power flow      |

## Aggregate (zonal) example

```julia
using PowerSystemsInvestmentsPortfolios
import PowerSystems as PSY

portfolio = Portfolio()

zone_west = Zone(; name="West", id=1)
zone_east = Zone(; name="East", id=2)
add_region!(portfolio, zone_west)
add_region!(portfolio, zone_east)

fin = TechnologyFinancialData(;
    capital_recovery_period=40,
    technology_base_year=2030,
    debt_fraction=0.6,
    debt_rate=0.05,
    return_on_equity=0.10,
    tax_rate=0.21,
)

line = AggregateTransportTechnology{PSY.ACBranch}(;
    name="west_east_ac",
    id=1,
    available=true,
    start_region=zone_west,
    end_region=zone_east,
    power_systems_type="ACBranch",
    financial_data=fin,
    capital_costs=LinearCurve(500.0),    # USD/MW
    capacity_limits=(min=0.0, max=1000.0),  # MW
    line_loss=0.01,
)

add_technology!(portfolio, line)
```

## Nodal AC example

For nodal models, use `Node` regions and supply the additional AC electrical parameters.

```julia
portfolio = Portfolio()

node_a = Node(; name="Bus_A", id=1)
node_b = Node(; name="Bus_B", id=2)
add_region!(portfolio, node_a)
add_region!(portfolio, node_b)

fin = TechnologyFinancialData(;
    capital_recovery_period=40,
    technology_base_year=2030,
    debt_fraction=0.6,
    debt_rate=0.05,
    return_on_equity=0.10,
    tax_rate=0.21,
)

ac_line = NodalACTransportTechnology{PSY.ACBranch}(;
    name="bus_a_bus_b",
    id=2,
    available=true,
    start_node=node_a,
    end_node=node_b,
    power_systems_type="ACBranch",
    financial_data=fin,
    capital_costs=LinearCurve(600.0),    # USD/MW
    capacity_limits=(min=0.0, max=500.0),  # MW
    reactance=0.05,
    resistance=0.01,
    voltage=345.0,                 # kV
)

add_technology!(portfolio, ac_line)
```

The electrical fields `reactance`, `resistance`, and `voltage` are used by the solver when power-flow constraints are active. For pure transport models use `AggregateTransportTechnology` instead.

## Key fields

| Field                         | Type                  | Description                                                               |
|:----------------------------- |:--------------------- |:------------------------------------------------------------------------- |
| `start_region` / `start_node` | `Zone` or `Node`      | Sending-end region (`start_region` for aggregate, `start_node` for nodal) |
| `end_region` / `end_node`     | `Zone` or `Node`      | Receiving-end region (`end_region` for aggregate, `end_node` for nodal)   |
| `capacity_limits`             | `MinMax` (NamedTuple) | Minimum and maximum buildable transmission capacity in MW                 |
| `capital_costs`               | `PSY.ValueCurve`      | Capital cost curve in USD/MW (e.g. `LinearCurve(500.0)`)                  |
| `line_loss`                   | `Float64`             | Fractional power loss on the line (default: `0.0`)                        |
| `unit_size`                   | `Float64`             | Discrete build increment in MW (default: `1.0`)                           |

## See also

  - [`Zone`](@ref)
  - [`Node`](@ref)
  - [`AggregateTransportTechnology`](@ref)
  - [`NodalACTransportTechnology`](@ref)
