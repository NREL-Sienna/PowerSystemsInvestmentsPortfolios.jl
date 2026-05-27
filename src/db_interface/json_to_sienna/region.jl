function openapi2psip(node::PowerOpenAPIModels.Node, resolver::Resolver)
    Node(name=node.name, id=node.id, bus_type=PSY.ACBusTypes(node.bus_type))
end

function openapi2psip(zone::PowerOpenAPIModels.Zone, resolver::Resolver)
    Zone(name=zone.name, id=zone.id)
end
