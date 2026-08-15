# The type ordering both conversion directions share. References resolve by id, and
# `OpenAPIRefs` errors on an unregistered one, so a type must appear after everything
# it points at: regions have no references, requirements have none, technologies point
# at both, supplemental attributes reference nothing.
const DOCUMENT_PLAN = [
    (Zone, "Zone"),
    (Node, "Node"),
    (CarbonCaps, "CarbonCaps"),
    (CarbonTax, "CarbonTax"),
    (CapacityReserveMargin, "CapacityReserveMargin"),
    (EnergyShareRequirements, "EnergyShareRequirements"),
    (HourlyMatching, "HourlyMatching"),
    (MinimumCapacityRequirements, "MinimumCapacityRequirements"),
    (MaximumCapacityRequirements, "MaximumCapacityRequirements"),
    (SupplyTechnology, "SupplyTechnology"),
    (StorageTechnology, "StorageTechnology"),
    (ColocatedSupplyStorageTechnology, "ColocatedSupplyStorageTechnology"),
    (DemandRequirement, "DemandRequirement"),
    (DemandSideTechnology, "DemandSideTechnology"),
    (AggregateTransportTechnology, "AggregateTransportTechnology"),
    (NodalACTransportTechnology, "NodalACTransportTechnology"),
    (NodalHVDCTransportTechnology, "NodalHVDCTransportTechnology"),
]

const SUPPLEMENTAL_ATTRIBUTE_PLAN = [
    (RetirementPotential, "RetirementPotential"),
    (AggregateRetirementPotential, "AggregateRetirementPotential"),
    (RetrofitPotential, "RetrofitPotential"),
    (AggregateRetrofitPotential, "AggregateRetrofitPotential"),
    (ExistingDevices, "ExistingDevices"),
    (TopologyMapping, "TopologyMapping"),
]
