```@meta
CurrentModule = PowerSystemsInvestmentsPortfolios
```

# Regions and Topology

## `RegionTopology` abstract type

[`RegionTopology`](@ref) is the abstract type for all spatial units in PSIP. It defines where capacity expansion decisions apply. Every technology must be assigned to one or more `RegionTopology` instances via its `region` field, and every requirement can scope its effect to a set of eligible regions.

Two concrete types extend `RegionTopology`:

  - [`Zone`](@ref) — represents a planning zone in a zonal model
  - [`Node`](@ref) — represents a bus in a nodal model

The choice between zonal and nodal models affects which transmission technology types are available and how PSI builds the network constraints.

## Zone vs. Node — when to use each

|                      | [`Zone`](@ref)                 | [`Node`](@ref)                                               |
|:-------------------- |:------------------------------ |:------------------------------------------------------------ |
| Typical PSY analogue | `PSY.LoadZone`                 | `PSY.ACBus`                                                  |
| Spatial resolution   | Planning zone (aggregate)      | Individual bus                                               |
| Transmission model   | Zonal transport capacity       | Nodal AC (or HVDC) power flow                                |
| Technology class     | `AggregateTransportTechnology` | `NodalACTransportTechnology`, `NodalHVDCTransportTechnology` |
| Typical use          | Multi-zone capacity expansion  | Power-flow-constrained investment                            |

**Zone fields:**

```julia
Zone(;
    name::String,   # name of the zone — should match PSY.LoadZone name in base_system
    id::Int64,      # unique integer ID
)
```

**Node fields:**

```julia
Node(;
    name::String,         # name of the node — should match PSY.ACBus name in base_system
    id::Int64,            # unique integer ID
    bus_type::ACBusTypes, # default: ACBusTypes.PQ
)
```

Creating a zone and adding it to a portfolio:

```julia
zone = Zone(; name="MISO_North", id=1)
add_region!(portfolio, zone)
```

## How regions relate to the `base_system`

Zone and Node names are matched against the base `PSY.System` by PSI when it builds the optimization model. A zone named `"MISO_North"` must correspond to a `PSY.LoadZone` with the same name in the `base_system`; otherwise PSI cannot link supply technologies to their demand or network topology.

The same matching requirement applies to nodes: a `Node` named `"BUS_101"` must correspond to a `PSY.ACBus` named `"BUS_101"` in the `base_system`.

!!! tip
    
    When building a portfolio from an existing `PSY.System`, iterate over the system's `LoadZone` or `ACBus` components to create the corresponding `Zone` or `Node` objects — this ensures names match automatically.

```julia
for (i, lz) in enumerate(get_components(PSY.LoadZone, base_sys))
    add_region!(portfolio, Zone(; name=get_name(lz), id=i))
end
```

## Multiple regions per technology

The `region` field of [`SupplyTechnology`](@ref) is `Vector{RegionTopology}`, not a scalar. A single technology can span multiple zones, which is the correct representation for inter-regional technologies whose output can serve demand in more than one zone.

Most technologies will have a single-element region vector:

```julia
wind = SupplyTechnology{PSY.RenewableDispatch}(;
    region=[zone_west],
    # ...
)
```

For technologies that operate in multiple zones simultaneously, pass all relevant zones:

```julia
interregional_solar = SupplyTechnology{PSY.RenewableDispatch}(;
    region=[zone_west, zone_east],
    # ...
)
```

Requirements also accept a region vector to scope their applicability. A reserve margin requirement assigned to `[zone_west, zone_east]` must be satisfied by supply capacity located in either of those zones.

## See Also

  - [`Zone`](@ref)
  - [`Node`](@ref)
  - [`RegionTopology`](@ref)
  - [`AggregateTransportTechnology`](@ref)
  - [`NodalACTransportTechnology`](@ref)
