```@meta
CurrentModule = PowerSystemsInvestmentsPortfolios
```

# Policy Requirements

Requirements represent policy constraints added to a portfolio via [`add_requirement!`](@ref). Each type adds one or more constraints to the optimization problem.

!!! note
    
    All requirement types use `add_requirement!`, not `add_technology!`.

CO₂ emissions limit. Use `max_tons_mwh` for an intensity cap (tCO₂/MWh) or `max_mtons` for an absolute annual cap (million tCO₂).

```@docs
CarbonCaps
```

Per-ton CO₂ cost signal (USD/tCO₂) added to the objective function rather than a hard emissions cap.

```@docs
CarbonTax
```

Requires installed capacity to exceed peak demand by `capacity_reserve_fraction` (e.g., `0.15` = 15% above peak).

```@docs
CapacityReserveMargin
```

Requires that at least `generation_fraction_requirement` of total annual energy is served by `eligible_resources` (e.g., renewables portfolio standard).

```@docs
EnergyShareRequirements
```

Requires `eligible_resources` to cover `eligible_demand` in every hour of the year (24/7 carbon-free energy matching).

```@docs
HourlyMatching
```

Sets a floor (`min_capacity_mw`) on total installed capacity across `eligible_resources`.

```@docs
MinimumCapacityRequirements
```

Sets a ceiling (`max_capacity_mw`) on total installed capacity across `eligible_resources`.

```@docs
MaximumCapacityRequirements
```
