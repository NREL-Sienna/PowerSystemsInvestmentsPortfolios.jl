```@meta
CurrentModule = PowerSystemsInvestmentsPortfolios
```

# Add Policy Requirements

Requirements represent policy constraints that influence investment decisions. They are added to a portfolio via `add_requirement!`.

!!! note
    `Requirement` subtypes use `add_requirement!`, not `add_technology!`. Passing a requirement to `add_technology!` will throw a method error.

## Add a [`CarbonCaps`](@ref) constraint

`CarbonCaps` enforces a CO₂ limit. It supports two modes — use `max_tons_mwh` to cap emission *intensity* (tCO₂/MWh), or use `max_mtons` to cap the *absolute* annual volume (million tCO₂). You may set one or both.

```julia
using PowerSystemsInvestmentsPortfolios

# Intensity-based cap: no more than 0.05 tCO2/MWh by 2035
cap = CarbonCaps(;
    name        = "carbon_intensity_cap",
    id          = 1,
    available   = true,
    max_tons_mwh = 0.05,   # intensity limit (tCO2/MWh); use max_mtons for absolute limit
    target_year = 2035,
)

add_requirement!(portfolio, cap)
```

## Add a [`CarbonTax`](@ref)

`CarbonTax` adds a price signal on CO₂ emissions rather than a hard cap.

```julia
tax = CarbonTax(;
    name               = "carbon_tax_2040",
    id                 = 2,
    available          = true,
    tax_dollars_per_ton = 75.0,   # USD/tCO2
    target_year        = 2040,
)

add_requirement!(portfolio, tax)
```

## Add a [`CapacityReserveMargin`](@ref)

`CapacityReserveMargin` requires installed capacity to exceed peak demand by a given fraction. A value of `0.15` means 15% above peak demand.

```julia
crm = CapacityReserveMargin(;
    name                      = "reserve_margin",
    id                        = 3,
    available                 = true,
    capacity_reserve_fraction = 0.15,   # 15% above peak demand
    target_year               = 2050,
)

add_requirement!(portfolio, crm)
```

## Add an [`EnergyShareRequirements`](@ref)

`EnergyShareRequirements` enforces that a minimum fraction of total annual energy is served by eligible resources. A value of `0.50` means 50% of demand must be met by the eligible resources.

```julia
rps = EnergyShareRequirements(;
    name                          = "50pct_rps",
    id                            = 4,
    available                     = true,
    generation_fraction_requirement = 0.50,   # 50% of total annual demand
    target_year                   = 2030,
    eligible_resources            = [wind_tech, solar_tech],
)

add_requirement!(portfolio, rps)
```

## Add an [`HourlyMatching`](@ref) constraint

`HourlyMatching` enforces hour-by-hour clean energy matching (24/7 carbon-free energy, CFE). Eligible resources must cover eligible demand in every hour of the year, not just on an annual average basis.

```julia
cfe = HourlyMatching(;
    name               = "247_cfe",
    id                 = 5,
    available          = true,
    eligible_resources = [wind_tech, solar_tech, storage_tech],
    eligible_demand    = [datacenter_demand],
)

add_requirement!(portfolio, cfe)
```

## MinimumCapacityRequirements and MaximumCapacityRequirements

These requirements enforce a floor or ceiling on total installed capacity for a set of eligible resources.

```julia
min_cap = MinimumCapacityRequirements(;
    name               = "min_offshore_wind",
    id                 = 6,
    available          = true,
    min_capacity_mw    = 2000.0,   # at least 2 GW of eligible resources
    target_year        = 2035,
    eligible_resources = [offshore_wind_tech],
)

add_requirement!(portfolio, min_cap)

max_cap = MaximumCapacityRequirements(;
    name               = "max_nuclear",
    id                 = 7,
    available          = true,
    max_capacity_mw    = 5000.0,   # no more than 5 GW of eligible resources
    target_year        = 2050,
    eligible_resources = [nuclear_tech],
)

add_requirement!(portfolio, max_cap)
```

## Querying requirements

Use `get_requirements` to retrieve all requirements of a given type, or `get_requirement` to retrieve one by name.

```julia
# Retrieve all capacity reserve margin requirements
all_crm = get_requirements(CapacityReserveMargin, portfolio)

# Retrieve a single requirement by type and name
rps = get_requirement(EnergyShareRequirements, portfolio, "50pct_rps")
```

## See also

- [`Requirement`](@ref)
- [`get_requirement`](@ref)
- [`remove_technology!`](@ref)
