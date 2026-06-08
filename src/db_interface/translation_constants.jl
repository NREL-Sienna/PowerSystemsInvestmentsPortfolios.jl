# NOTE: ThermalStandard uses "fuel_type" but ThermalMultiStart uses "fuel" in OpenAPI schemas.
# This inconsistency means we can't add a simple mapping here. The migration handles this
# by checking both the table column and the fuel_type attribute.
# TODO: Fix in PowerSystemSchemas to use consistent field names.
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

const TYPE_TO_TABLE_LIST = [
    PowerOpenAPIModels.Area => "planning_regions",
    PowerOpenAPIModels.LoadZone => "balancing_topologies", # Assuming LoadZone maps to balancing topologies
    PowerOpenAPIModels.ACBus => "balancing_topologies", # Assuming ACBus maps to balancing topologies
    PowerOpenAPIModels.Arc => "arcs",
    PowerOpenAPIModels.AreaInterchange => "transmission_interchanges",
    PowerOpenAPIModels.Line => "transmission_lines",
    PowerOpenAPIModels.Transformer2W => "transmission_lines",
    PowerOpenAPIModels.MonitoredLine => "transmission_lines",
    PowerOpenAPIModels.PhaseShiftingTransformer => "transmission_lines",
    PowerOpenAPIModels.TapTransformer => "transmission_lines",
    PowerOpenAPIModels.TwoTerminalGenericHVDCLine => "transmission_lines",
    PowerOpenAPIModels.Transformer3W => "three_winding_transformers",
    PowerOpenAPIModels.PhaseShiftingTransformer3W => "three_winding_transformers",
    PowerOpenAPIModels.PowerLoad => "loads",
    PowerOpenAPIModels.StandardLoad => "loads",
    PowerOpenAPIModels.FixedAdmittance => "loads",
    PowerOpenAPIModels.InterruptiblePowerLoad => "loads",
    PowerOpenAPIModels.ThermalStandard => "thermal_generators",
    PowerOpenAPIModels.ThermalMultiStart => "thermal_generators",
    PowerOpenAPIModels.RenewableDispatch => "renewable_generators",
    PowerOpenAPIModels.RenewableNonDispatch => "renewable_generators",
    PowerOpenAPIModels.HydroDispatch => "hydro_generators",
    PowerOpenAPIModels.HydroTurbine => "hydro_generators",
    PowerOpenAPIModels.HydroPumpTurbine => "hydro_generators",
    PowerOpenAPIModels.EnergyReservoirStorage => "storage_units",
    PowerOpenAPIModels.HydroReservoir => "hydro_reservoirs",
    PowerOpenAPIModels.Zone => "planning_regions",
    PowerOpenAPIModels.Node => "balancing_topologies",
    PowerOpenAPIModels.NodalACTransportTechnology => "transport_technologies",
    PowerOpenAPIModels.NodalHVDCTransportTechnology => "transport_technologies",
    PowerOpenAPIModels.AggregateTransportTechnology => "transport_technologies",
    PowerOpenAPIModels.StorageTechnology => "storage_technologies",
    PowerOpenAPIModels.SupplyTechnology => "supply_technologies",
    PowerOpenAPIModels.DemandRequirement => "demand_technologies",
    PowerOpenAPIModels.DemandSideTechnology => "demand_technologies",
]

const TYPE_TO_TABLE = Dict(TYPE_TO_TABLE_LIST)

const ALL_PSY_TYPES = [
    PSY.Area,
    PSY.LoadZone,
    PSY.ACBus,
    PSY.Arc,
    PSY.AreaInterchange,
    PSY.Line,
    PSY.Transformer2W,
    PSY.MonitoredLine,
    PSY.PhaseShiftingTransformer,
    PSY.TapTransformer,
    PSY.TwoTerminalGenericHVDCLine,
    PSY.Transformer3W,
    PSY.PhaseShiftingTransformer3W,
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

const ALL_SA_OPENAPI_TYPES = [GeographicInfo]

const SA_PSY_TO_OPENAPI =
    Dict(k => v for (k, v) in zip(ALL_SA_PSY_TYPES, ALL_SA_OPENAPI_TYPES))
const SA_OPENAPI_TO_PSY =
    Dict(v => k for (k, v) in zip(ALL_SA_PSY_TYPES, ALL_SA_OPENAPI_TYPES))
const SA_TYPE_NAMES = Dict(string(nameof(t)) => t for t in ALL_SA_OPENAPI_TYPES)

const ALL_DESERIALIZABLE_TYPES = [
    Area,
    LoadZone,
    ACBus,
    Arc,
    AreaInterchange,
    Line,
    Transformer2W,
    MonitoredLine,
    PhaseShiftingTransformer,
    TapTransformer,
    TwoTerminalGenericHVDCLine,
    Transformer3W,
    PhaseShiftingTransformer3W,
    PowerLoad,
    StandardLoad,
    FixedAdmittance,
    InterruptiblePowerLoad,
    ThermalStandard,
    ThermalMultiStart,
    RenewableDispatch,
    RenewableNonDispatch,
    HydroDispatch,
    HydroTurbine,
    HydroPumpTurbine,
    EnergyReservoirStorage,
    HydroReservoir,
    Zone,
    Node,
    SupplyTechnology,
    StorageTechnology,
    AggregateTransportTechnology,
    NodalACTransportTechnology,
    NodalHVDCTransportTechnology,
    DemandRequirement,
    DemandSideTechnology,
]

const PSY_DESERIALIZABLE_TYPES = [
    PowerOpenAPIModels.Area,
    PowerOpenAPIModels.LoadZone,
    PowerOpenAPIModels.ACBus,
    PowerOpenAPIModels.Arc,
    PowerOpenAPIModels.AreaInterchange,
    PowerOpenAPIModels.Line,
    PowerOpenAPIModels.Transformer2W,
    PowerOpenAPIModels.MonitoredLine,
    PowerOpenAPIModels.PhaseShiftingTransformer,
    PowerOpenAPIModels.TapTransformer,
    PowerOpenAPIModels.TwoTerminalGenericHVDCLine,
    PowerOpenAPIModels.Transformer3W,
    PowerOpenAPIModels.PhaseShiftingTransformer3W,
    PowerOpenAPIModels.PowerLoad,
    PowerOpenAPIModels.StandardLoad,
    PowerOpenAPIModels.FixedAdmittance,
    PowerOpenAPIModels.InterruptiblePowerLoad,
    PowerOpenAPIModels.ThermalStandard,
    PowerOpenAPIModels.ThermalMultiStart,
    PowerOpenAPIModels.RenewableDispatch,
    PowerOpenAPIModels.RenewableNonDispatch,
    PowerOpenAPIModels.HydroDispatch,
    PowerOpenAPIModels.HydroTurbine,
    PowerOpenAPIModels.HydroPumpTurbine,
    PowerOpenAPIModels.EnergyReservoirStorage,
    PowerOpenAPIModels.HydroReservoir,
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
    PowerOpenAPIModels.PowerOpenAPIModels.Zone => "planning_regions",
    PowerOpenAPIModels.Node => "balancing_topologies",
    PowerOpenAPIModels.NodalACTransportTechnology => "transport_technologies",
    PowerOpenAPIModels.NodalHVDCTransportTechnology => "transport_technologies",
    PowerOpenAPIModels.AggregateTransportTechnology => "transport_technologies",
    PowerOpenAPIModels.StorageTechnology => "storage_technologies",
    PowerOpenAPIModels.SupplyTechnology => "supply_technologies",
    PowerOpenAPIModels.DemandRequirement => "demand_technologies",
    PowerOpenAPIModels.DemandSideTechnology => "demand_technologies",
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
    PowerOpenAPIModels.Zone,
    PowerOpenAPIModels.Node,
    PowerOpenAPIModels.NodalACTransportTechnology,
    PowerOpenAPIModels.NodalHVDCTransportTechnology,
    PowerOpenAPIModels.AggregateTransportTechnology,
    PowerOpenAPIModels.StorageTechnology,
    PowerOpenAPIModels.SupplyTechnology,
    PowerOpenAPIModels.DemandRequirement,
    PowerOpenAPIModels.DemandSideTechnology,
]

const ALL_SA_PSIP_TYPES = [
    ExistingCapacity,
    AggregateRetirementPotential,
    RetirementPotential,
    AggregateRetrofitPotential,
    RetrofitPotential,
]

const ALL_SA_PSIP_OPENAPI_TYPES = [
    PowerOpenAPIModels.ExistingCapacity,
    PowerOpenAPIModels.AggregateRetirementPotential,
    PowerOpenAPIModels.RetirementPotential,
    PowerOpenAPIModels.AggregateRetrofitPotential,
    PowerOpenAPIModels.RetrofitPotential,
]

const SA_PSIP_TO_OPENAPI =
    Dict(k => v for (k, v) in zip(ALL_SA_PSIP_TYPES, ALL_SA_PSIP_OPENAPI_TYPES))
const SA_OPENAPI_TO_PSIP =
    Dict(v => k for (k, v) in zip(ALL_SA_PSIP_TYPES, ALL_SA_PSIP_OPENAPI_TYPES))
const SA_TYPE_NAMES_PSIP = Dict(string(nameof(t)) => t for t in ALL_SA_PSIP_OPENAPI_TYPES)
