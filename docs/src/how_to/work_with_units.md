```@meta
CurrentModule = PowerSystemsInvestmentsPortfolios
```

# How to work with units

PSIP stores every physical field in a fixed **natural unit** but lets you read and
write it in any compatible unit. This page collects the common recipes. For the
concepts behind them, see [Units and Unit Conversions](@ref).

Every unit-aware field `x` provides:

  - `get_x(component, units)` — the value as a bare number in `units`
  - `get_x_unitful(component, units)` — the value as a `Unitful.Quantity`
  - `set_x!(component, value, units)` — store `value`, interpreting it as `units`

## Read a scalar field in a chosen unit

```julia
using PowerSystemsInvestmentsPortfolios
import PowerSystems as PSY

fin = TechnologyFinancialData(;
    capital_recovery_period=30,
    technology_base_year=2030,
    debt_fraction=0.5,
    debt_rate=0.06,
    return_on_equity=0.12,
    tax_rate=0.21,
)

supply = SupplyTechnology{PSY.ThermalStandard}(;
    name="ccgt",
    id=1,
    available=true,
    power_systems_type="ThermalStandard",
    financial_data=fin,
    unit_size=100.0,                       # stored in MW
    capacity_limits=(min=0.0, max=500.0),  # stored in MW
)

get_unit_size(supply, u"MW")   # 100.0
get_unit_size(supply, u"kW")   # 100000.0
```

## Keep the unit attached

Use the `_unitful` companion when you want a `Unitful.Quantity` back — for example
to convert further or to display with the unit:

```julia
q = get_unit_size_unitful(supply, u"MW")   # 100.0 MW
uconvert(u"kW", q)                          # 100000.0 kW
ustrip(q)                                   # 100.0
```

## Write a field in a convenient unit

The setter interprets the value you pass as being in the given unit and stores it in
the field's natural unit:

```julia
set_unit_size!(supply, 250_000.0, u"kW")   # stores 250.0 MW
get_unit_size(supply, u"MW")               # 250.0
```

## Compound fields (`MinMax`, `UpDown`)

`MinMax` and `UpDown` fields convert each component; pass and receive a `NamedTuple`:

```julia
get_capacity_limits(supply, u"MW")                 # (min = 0.0, max = 500.0)
get_capacity_limits(supply, u"kW")                 # (min = 0.0, max = 500000.0)
set_capacity_limits!(supply, (min=0.0, max=800.0), u"MW")

get_time_limits(supply, u"hr")                     # (up = …, down = …)
get_time_limits(supply, u"minute")                 # same value, in minutes
```

## Cost-curve fields need a `(x_unit, y_unit)` NamedTuple

Cost and capital-cost fields are `PSY.ValueCurve`s spanning two axes, so the units
are given as a [`ConversionUnits`](@ref) `NamedTuple`. The conversion propagates
through the whole curve:

```julia
set_capital_costs!(supply, LinearCurve(900.0), (x_unit=u"MW", y_unit=USD))  # 900 USD/MW

get_capital_costs(supply, (x_unit=u"MW", y_unit=USD))   # LinearCurve(900.0)  (USD/MW)
get_capital_costs(supply, (x_unit=u"kW", y_unit=USD))   # LinearCurve(0.9)    (USD/kW)
```

Energy-based costs use energy on the `x` axis:

```julia
get_operation_costs(supply, (x_unit=u"MW" * u"hr", y_unit=USD))   # in USD/MWh
get_operation_costs(supply, (x_unit=u"kW" * u"hr", y_unit=USD))   # in USD/kWh
```

## Rate units (ramp, startup fuel)

Rate fields use composite Unitful units:

```julia
get_ramp_limits(supply, u"MW" / u"minute")     # (up = …, down = …)
get_ramp_limits(supply, u"MW" / u"s")          # same value, per second

get_start_fuel_mmbtu_per_mw(supply, u"MMBtu" / u"MW")   # MMBtu per MW
get_start_fuel_mmbtu_per_mw(supply, u"MMBtu" / u"kW")   # MMBtu per kW
```

## Emissions units

Emissions fields on policy requirements use the custom `tonne` unit and its rates.
Build composite emissions units from the exported constants (`tonne`, `USD`,
`MMBtu`) — never from a `u"…"` string:

```julia
cap = CarbonCaps(; name="cap", available=true, id=1, max_mtons=50.0, max_tons_mwh=2.0)

get_max_mtons(cap, tonne)                    # 50.0
get_max_mtons(cap, u"kg")                    # 50000.0
get_max_tons_mwh(cap, tonne / (u"MW" * u"hr")) # 2.0

tax = CarbonTax(; name="tax", available=true, id=2, tax_dollars_per_ton=50.0)
get_tax_dollars_per_ton(tax, USD / tonne)    # 50.0
get_tax_dollars_per_ton(tax, USD / u"kg")    # 0.05
```

!!! warning
    
    Do not write emissions units with the string macro (`u"tonne/MMBtu"`); `USD`,
    `MMBtu`, and `tonne` are PSIP-defined and are invisible to `u"…"` at
    macro-expansion time. Compose them with operators instead: `tonne / MMBtu`,
    `USD / tonne`.

## Query a category's natural unit

To find the unit a field is stored in, ask its physical category with
[`natural_unit`](@ref):

```julia
natural_unit(POWER)     # u"MW"
natural_unit(ENERGY)    # u"MW" * u"hr"
natural_unit(VOLTAGE)   # u"kV"
```

## See also

  - [Units and Unit Conversions](@ref)
  - [`natural_unit`](@ref)
  - [`ConversionUnits`](@ref)
  - [`FuelCurveUnits`](@ref)
