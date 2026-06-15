```@meta
CurrentModule = PowerSystemsInvestmentsPortfolios
```

# Transport Technologies

PSIP provides three transmission technology types for capacity expansion modeling.

## `AggregateTransportTechnology{T}`

Zonal (transport) model. Represents a buildable transfer capacity corridor between two [`Zone`](@ref) regions. Use for most capacity expansion studies where nodal detail is not required.

**Type parameter:** `T <: PSY.Device`, typically `PSY.ACBranch`.

**Key fields:** `start_region` (`Zone`), `end_region` (`Zone`), `capacity_limits` (`MinMax` in MW), `capital_costs` (`PSY.ValueCurve` in USD/MW), `line_loss` (fractional), `unit_size`

```@docs
AggregateTransportTechnology
```

## `NodalACTransportTechnology{T}`

Nodal AC model. Represents a buildable AC line between two [`Node`](@ref) regions. Includes electrical parameters for power-flow constraints.

**Type parameter:** `T <: PSY.Device`, typically `PSY.ACBranch`.

**Key fields:** `start_node` (`Node`), `end_node` (`Node`), `capacity_limits` (`MinMax` in MW), `capital_costs`, `reactance`, `resistance`, `voltage` (kV)

```@docs
NodalACTransportTechnology
```

## `NodalHVDCTransportTechnology{T}`

Nodal HVDC model. Represents a buildable HVDC link between two [`Node`](@ref) regions.

**Type parameter:** `T <: PSY.Device`, typically `PSY.DCBranch`.

```@docs
NodalHVDCTransportTechnology
```
