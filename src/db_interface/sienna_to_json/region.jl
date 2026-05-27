function psip2openapi(node::Node, ids::IDGenerator)
    PowerOpenAPIModels.Node(name=node.name, id=getid!(ids, node), bus_type=string(node.bus_type))
end

function psip2openapi(zone::Zone, ids::IDGenerator)
    PowerOpenAPIModels.Zone(name=zone.name, id=getid!(ids, zone))
end
