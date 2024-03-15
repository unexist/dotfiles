local ports_om = ObjectManager {
    Interest {
        type = "port",
    }
}

function _handleAdded(args)
    local wtf = ports_om:lookup { Constraint { "port.alias", "matches", "Brave*" } }

    print(ports_om:get_n_objects(), wtf)
end

ports_om:connect("object-added", _handleAdded)

ports_om:activate()
