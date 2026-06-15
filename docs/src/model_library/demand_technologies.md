```@meta
CurrentModule = PowerSystemsInvestmentsPortfolios
```

# Demand Technologies

## `DemandRequirement{T}`

A [`DemandRequirement{T}`](@ref) represents a load that must be served in a region. Despite its name, `DemandRequirement` is a subtype of `DemandTechnology` and is added to the portfolio with `add_technology!`.

**Type parameter:** `T <: PSY.StaticInjection`, typically `PSY.PowerLoad`.

**Key fields:** `name`, `id`, `available`, `region` (`Vector{RegionTopology}`), `power_systems_type`

!!! note
    
    `DemandRequirement` encodes a demand that the optimizer must satisfy — it is the demand side of the supply-demand balance constraint, not a policy requirement. See [`Requirement`](@ref) for policy constraints.

```@docs
DemandRequirement
```

## `DemandSideTechnology{T}`

A [`DemandSideTechnology{T}`](@ref) represents a demand flexibility resource — a load that can shift, curtail, or respond to price signals as part of the investment plan.

**Type parameter:** `T <: PSY.StaticInjection`.

```@docs
DemandSideTechnology
```
