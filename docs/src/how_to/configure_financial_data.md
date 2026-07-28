```@meta
CurrentModule = PowerSystemsInvestmentsPortfolios
```

# Configure Financial Data

PSIP has two levels of financial data. Portfolio-level parameters set the economic context for the entire optimisation (discount rate, inflation rate, base year). Technology-level parameters determine how each technology's overnight capital cost is converted to an annualised payment via a capital recovery factor.

## Portfolio-level financial data

`PortfolioFinancialData` holds four scalar parameters that apply across all technologies in the portfolio.

| Field            | Description                                                  | Typical value |
|:---------------- |:------------------------------------------------------------ |:------------- |
| `base_year`      | Reference year for discounting and inflation adjustment      | `2030`        |
| `discount_rate`  | Social or weighted-average discount rate (fraction per year) | `0.07`        |
| `inflation_rate` | General inflation rate (fraction per year)                   | `0.025`       |
| `interest_rate`  | Nominal interest rate used for financing calculations        | `0.05`        |

### Specify at construction

Financial data can be passed directly to the `Portfolio` constructor. The positional arguments are `base_year`, `discount_rate`, `inflation_rate`, and `interest_rate`:

```julia
using PowerSystemsInvestmentsPortfolios
import PowerSystems as PSY

portfolio = Portfolio(
    PSY.LoadZone,   # aggregation type
    base_system,    # PSY.System
    2030,           # base_year
    0.07,           # discount_rate
    0.025,          # inflation_rate
    0.05,           # interest_rate
)
```

### Update after construction

Each field has a dedicated setter. Use these to adjust the economic parameters without rebuilding the portfolio:

```julia
set_base_year!(portfolio, 2035)
set_discount_rate!(portfolio, 0.05)
set_inflation_rate!(portfolio, 0.02)
set_interest_rate!(portfolio, 0.04)

# Inspect the current values
fin = get_financial_data(portfolio)   # returns PortfolioFinancialData or nothing
```

## Technology-level financial data

`TechnologyFinancialData` encodes how a specific technology's overnight capital cost is converted to an annualised payment. It is used to compute the capital recovery factor (CRF), which accounts for the project's debt structure, required return on equity, and tax treatment.

All six fields are required at construction:

```julia
fin = TechnologyFinancialData(;
    capital_recovery_period=30,      # years
    technology_base_year=2030,    # year in which the capital cost is quoted
    debt_fraction=0.5,     # 50% debt financing
    debt_rate=0.07,    # annual interest rate on debt
    return_on_equity=0.10,    # required return on equity
    tax_rate=0.257,   # effective corporate tax rate
)
```

| Field                     | Description                                                                                                  |
|:------------------------- |:------------------------------------------------------------------------------------------------------------ |
| `capital_recovery_period` | Number of years over which capital cost is recovered                                                         |
| `technology_base_year`    | Year in which the overnight capital cost is quoted; used for inflation adjustment to the portfolio base year |
| `debt_fraction`           | Share of capital financed by debt (0–1)                                                                      |
| `debt_rate`               | Annual interest rate on the debt portion                                                                     |
| `return_on_equity`        | Required annual return on the equity portion                                                                 |
| `tax_rate`                | Effective corporate tax rate applied to equity returns                                                       |

The `technology_base_year` field is particularly important: PSIP uses the difference between `technology_base_year` and the portfolio `base_year` together with `inflation_rate` to escalate (or deflate) the quoted capital cost to a consistent present-value basis before computing the annualised cost.

Attach a `TechnologyFinancialData` instance to any technology via its `financial_data` keyword argument:

```julia
wind = SupplyTechnology{PSY.RenewableDispatch}(;
    name="wind_z1",
    id=1,
    available=true,
    financial_data=fin,
    # ... other fields
)
```

## See also

  - [`PortfolioFinancialData`](@ref)
  - [`TechnologyFinancialData`](@ref)
  - [`get_financial_data`](@ref)
