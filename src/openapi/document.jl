# The type ordering both conversion directions share. References resolve by id, and
# `OpenAPIRefs` errors on an unregistered one, so a type must appear after everything
# it points at: requirements have no references, technologies point at the base system's
# topology (seeded into `refs` up front) and at requirements. Topology components live in
# the base `PSY.System`, not the portfolio, so they are not in this plan.
const DOCUMENT_PLAN = [
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

"""
Seed an `OpenAPIRefs` with the base system's topology components (buses, areas, load zones,
arcs), keyed by their integer id. Technology reference fields (`region`, `start_node`,
`start_region`, ...) point at these `PSY` topology structs by id, so they must be resolvable
before any technology is converted in either direction.
"""
function _register_base_system_topology!(refs::OpenAPIRefs, base_system::PSY.System)
    for component in PSY.get_components(PSY.Topology, base_system)
        refs[IS.get_id(component)] = component
    end
    return refs
end

const SUPPLEMENTAL_ATTRIBUTE_PLAN = [
    (RetirementPotential, "RetirementPotential"),
    (RetrofitPotential, "RetrofitPotential"),
    (ExistingDevices, "ExistingDevices"),
    (TopologyMapping, "TopologyMapping"),
]

function _build_export_refs(portfolio::Portfolio)
    refs = OpenAPIRefs()
    _register_base_system_topology!(refs, portfolio.base_system)
    for (psip_type, _key) in DOCUMENT_PLAN
        for component in IS.get_components(psip_type, portfolio.data)
            refs[get_id(component)] = component
        end
    end
    return refs
end
