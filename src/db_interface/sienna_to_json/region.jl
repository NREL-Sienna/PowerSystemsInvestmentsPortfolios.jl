function psip2openapi(node::Node, ids::IDGenerator)
    Node(name=node.name, id=getid!(ids, node), bus_type=string(node.bus_type))
end

function psip2openapi(zone::Zone, ids::IDGenerator)
    Zone(name=zone.name, id=getid!(ids, zone))
end
