```@meta
CurrentModule = PowerSystemsInvestmentsPortfolios
```

# Region Topologies

All spatial units in PSIP extend the abstract type [`RegionTopology`](@ref). Technologies are assigned to regions via their `region` field; requirements scope their effect via `eligible_regions`.

## `Zone`

A [`Zone`](@ref) represents a planning zone in a zonal capacity expansion model. Zone names should match the corresponding `PSY.LoadZone` name in the portfolio's `base_system`.

**Fields:** `name::String`, `id::Int64`

```@docs
Zone
```

## `Node`

A [`Node`](@ref) represents an individual bus in a nodal capacity expansion model. Node names should match the corresponding `PSY.ACBus` name in the portfolio's `base_system`.

**Fields:** `name::String`, `id::Int64`, `bus_type::ACBusTypes`

```@docs
Node
```
