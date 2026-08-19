# NOTE: ThermalStandard uses "fuel_type" but ThermalMultiStart uses "fuel" in OpenAPI schemas.
# This inconsistency means we can't add a simple mapping here. The migration handles this
# by checking both the table column and the fuel_type attribute.

const OPENAPI_FIELDS_TO_DB = Dict(
    ("transmission_lines", "arc") => "arc_id",
    ("thermal_generators", "bus") => "balancing_topology",
    ("renewable_generators", "bus") => "balancing_topology",
    ("hydro_generators", "bus") => "balancing_topology",
    ("storage_units", "bus") => "balancing_topology",
    ("loads", "bus") => "balancing_topology",
    ("arcs", "from") => "from_id",
    ("arcs", "to") => "to_id",
    ("transmission_lines", "rating") => "continuous_rating",
)

const DB_TO_OPENAPI_FIELDS = Dict((s[1], t) => s[2] for (s, t) in OPENAPI_FIELDS_TO_DB)

# Combined OpenAPI-type → DB-table map. Base PSY types (PO.*) are listed first, then the PSIP
# portfolio types (PI.*); several downstream `zip(ALL_PSY_TYPES, ALL_TYPES)` uses rely on that
# ordering (base types come first), so keep base-before-PSIP order when editing.
const TYPE_TO_TABLE_LIST = [
    # ── Base PSY system (PowerOperationsOpenAPIModels) ──
    PO.Area => "planning_regions",
    PO.LoadZone => "balancing_topologies", # Assuming LoadZone maps to balancing topologies
    PO.ACBus => "balancing_topologies", # Assuming ACBus maps to balancing topologies
    PO.Arc => "arcs",
    PO.AreaInterchange => "transmission_interchanges",
    PO.Line => "transmission_lines",
    PO.MonitoredLine => "transmission_lines",
    PO.TwoTerminalGenericHVDCLine => "transmission_lines",
    PO.PowerLoad => "loads",
    PO.StandardLoad => "loads",
    PO.FixedAdmittance => "loads",
    PO.InterruptiblePowerLoad => "loads",
    PO.ThermalStandard => "thermal_generators",
    PO.ThermalMultiStart => "thermal_generators",
    PO.RenewableDispatch => "renewable_generators",
    PO.RenewableNonDispatch => "renewable_generators",
    PO.HydroDispatch => "hydro_generators",
    PO.HydroTurbine => "hydro_generators",
    PO.HydroPumpTurbine => "hydro_generators",
    PO.EnergyReservoirStorage => "storage_units",
    PO.HydroReservoir => "hydro_reservoirs",
    # ── PSIP portfolio (PowerInvestmentsOpenAPIModels) ──
    PI.Zone => "planning_regions",
    PI.Node => "balancing_topologies",
    PI.NodalACTransportTechnology => "transport_technologies",
    PI.NodalHVDCTransportTechnology => "transport_technologies",
    PI.AggregateTransportTechnology => "transport_technologies",
    PI.StorageTechnology => "storage_technologies",
    PI.SupplyTechnology => "supply_technologies",
    PI.DemandRequirement => "demand_technologies",
    PI.DemandSideTechnology => "demand_technologies",
]

const TYPE_TO_TABLE = Dict(TYPE_TO_TABLE_LIST)

const ALL_PSY_TYPES = [
    PSY.Area,
    PSY.LoadZone,
    PSY.ACBus,
    PSY.Arc,
    PSY.AreaInterchange,
    PSY.Line,
    PSY.MonitoredLine,
    PSY.TwoTerminalGenericHVDCLine,
    PSY.PowerLoad,
    PSY.StandardLoad,
    PSY.FixedAdmittance,
    PSY.InterruptiblePowerLoad,
    PSY.ThermalStandard,
    PSY.ThermalMultiStart,
    PSY.RenewableDispatch,
    PSY.RenewableNonDispatch,
    PSY.HydroDispatch,
    PSY.HydroTurbine,
    PSY.HydroPumpTurbine,
    PSY.EnergyReservoirStorage,
    PSY.HydroReservoir,
]

const ALL_TYPES = first.(TYPE_TO_TABLE_LIST)
const PSY_TO_OPENAPI_TYPE = Dict(k => v for (k, v) in zip(ALL_PSY_TYPES, ALL_TYPES))
const OPENAPI_TYPE_TO_PSY = Dict(v => k for (k, v) in zip(ALL_PSY_TYPES, ALL_TYPES))
const TYPE_NAMES = Dict(string(nameof(t)) => t for t in ALL_TYPES)
const PSY_TYPE_NAMES = Dict(string(nameof(t)) => t for t in ALL_PSY_TYPES)

const ALL_SA_PSY_TYPES = [IS.GeographicInfo]

# GeographicInfo is an IS supplemental attribute; its transport struct lives in the shared
# core package (PC), not in PowerOperationsOpenAPIModels.
const ALL_SA_OPENAPI_TYPES = [PC.GeographicInfo]

const SA_PSY_TO_OPENAPI =
    Dict(k => v for (k, v) in zip(ALL_SA_PSY_TYPES, ALL_SA_OPENAPI_TYPES))
const SA_OPENAPI_TO_PSY =
    Dict(v => k for (k, v) in zip(ALL_SA_PSY_TYPES, ALL_SA_OPENAPI_TYPES))
const SA_TYPE_NAMES = Dict(string(nameof(t)) => t for t in ALL_SA_OPENAPI_TYPES)

const PSY_DESERIALIZABLE_TYPES = [
    PO.Area,
    PO.LoadZone,
    PO.ACBus,
    PO.Arc,
    PO.AreaInterchange,
    PO.Line,
    PO.MonitoredLine,
    PO.TwoTerminalGenericHVDCLine,
    PO.PowerLoad,
    PO.StandardLoad,
    PO.FixedAdmittance,
    PO.InterruptiblePowerLoad,
    PO.ThermalStandard,
    PO.ThermalMultiStart,
    PO.RenewableDispatch,
    PO.RenewableNonDispatch,
    PO.HydroDispatch,
    PO.HydroTurbine,
    PO.HydroPumpTurbine,
    PO.EnergyReservoirStorage,
    PO.HydroReservoir,
]

######################
### PSIP Constants ###
######################

const PSIP_OPENAPI_FIELDS_TO_DB = Dict(
    ("transport_technologies", "from_node") => "from_node_id",
    ("transport_technologies", "to_node") => "to_node_id",
    ("supply_technologies", "region") => "balancing_topology",
    ("storage_technologies", "region") => "balancing_topology",
    ("loads", "region") => "balancing_topology",
    ("supply_technologies", "prime_mover_type") => "prime_mover",
    ("storage_technologies", "prime_mover_type") => "prime_mover",
)

const DB_TO_PSIP_OPENAPI_FIELDS =
    Dict((s[1], t) => s[2] for (s, t) in PSIP_OPENAPI_FIELDS_TO_DB)

const PSIP_TYPE_TO_TABLE_LIST = [
    PI.Zone => "planning_regions",
    PI.Node => "balancing_topologies",
    PI.NodalACTransportTechnology => "transport_technologies",
    PI.NodalHVDCTransportTechnology => "transport_technologies",
    PI.AggregateTransportTechnology => "transport_technologies",
    PI.StorageTechnology => "storage_technologies",
    PI.SupplyTechnology => "supply_technologies",
    PI.DemandRequirement => "demand_technologies",
    PI.DemandSideTechnology => "demand_technologies",
]

const PSIP_TYPE_TO_TABLE = Dict(PSIP_TYPE_TO_TABLE_LIST)

const ALL_PSIP_TYPES = [
    Zone,
    Node,
    NodalACTransportTechnology,
    NodalHVDCTransportTechnology,
    AggregateTransportTechnology,
    StorageTechnology,
    SupplyTechnology,
    DemandRequirement,
    DemandSideTechnology,
]

const PSIP_TYPES = first.(PSIP_TYPE_TO_TABLE_LIST)
const PSIP_TO_OPENAPI_TYPE = Dict(k => v for (k, v) in zip(ALL_PSIP_TYPES, PSIP_TYPES))
const OPENAPI_TYPE_TO_PSIP = Dict(v => k for (k, v) in zip(ALL_PSIP_TYPES, PSIP_TYPES))
const PSIP_TYPE_NAMES = Dict(string(nameof(t)) => t for t in ALL_PSIP_TYPES)

const PSIP_DESERIALIZABLE_TYPES = [
    PI.Zone,
    PI.Node,
    PI.NodalACTransportTechnology,
    PI.NodalHVDCTransportTechnology,
    PI.AggregateTransportTechnology,
    PI.StorageTechnology,
    PI.SupplyTechnology,
    PI.DemandRequirement,
    PI.DemandSideTechnology,
]

const ALL_SA_PSIP_TYPES = [
    ExistingDevices,
    AggregateRetirementPotential,
    RetirementPotential,
    AggregateRetrofitPotential,
    RetrofitPotential,
    TopologyMapping,
]

const ALL_SA_PSIP_OPENAPI_TYPES = [
    PI.ExistingDevices,
    PI.AggregateRetirementPotential,
    PI.RetirementPotential,
    PI.AggregateRetrofitPotential,
    PI.RetrofitPotential,
    PI.TopologyMapping,
]

const SA_PSIP_TO_OPENAPI =
    Dict(k => v for (k, v) in zip(ALL_SA_PSIP_TYPES, ALL_SA_PSIP_OPENAPI_TYPES))
const SA_OPENAPI_TO_PSIP =
    Dict(v => k for (k, v) in zip(ALL_SA_PSIP_TYPES, ALL_SA_PSIP_OPENAPI_TYPES))
const SA_TYPE_NAMES_PSIP = Dict(string(nameof(t)) => t for t in ALL_SA_PSIP_OPENAPI_TYPES)
