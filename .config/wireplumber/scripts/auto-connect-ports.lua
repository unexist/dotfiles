-- Link two ports together
function link_port(output_port, input_port)
    if not input_port or not output_port then
        print("No ports for linking")

        return false
    end

    local link_args = {
        ["link.input.node"] = input_port.properties["node.id"],
        ["link.input.port"] = input_port.properties["object.id"],

        ["link.output.node"] = output_port.properties["node.id"],
        ["link.output.port"] = output_port.properties["object.id"],

        -- The node never got created if it didn't have this field set to something
        ["object.id"] = nil,

        -- I was running into issues when I didn't have this set
        ["object.linger"] = true,

        ["node.description"] = "Link created by auto_connect_ports"
    }

    local link = Link("link-factory", link_args)
    link:activate(1)

    return true
end

function auto_connect_ports(args)
    local output_om = ObjectManager {
        Interest {
            type = "port",
            args["output"],
            Constraint { "port.direction", "equals", "out" }
        }
    }

    local input_om = ObjectManager {
        Interest {
            type = "port",
            args["input"],
            Constraint { "port.direction", "equals", "in" }
        }
    }

    local links_om = ObjectManager {
        Interest {
            type = "link",
        }
    }

    local ports_om = ObjectManager {
        Interest {
            type = "port",
        }
    }

    function _handle_obj_added()
        for output_name, input_name in pairs(args.connect) do
            local output = output_om:lookup { Constraint { "audio.channel", "equals", output_name } }
            local input = input_om:lookup { Constraint { "audio.channel", "equals", input_name } }

            link_port(output, input)
        end
    end

    output_om:connect("object-added", _handle_obj_added)
    input_om:connect("object-added", _handle_obj_added)
    links_om:connect("object-added", _handle_obj_added)

    output_om:activate()
    input_om:activate()
    links_om:activate()
end

-- Connect Brave
auto_connect_ports {
    output = Constraint { "port.alias", "matches", "Brave:output_*" },
    input = Constraint { "port.alias", "matches", "Speaker:playback_*" },
    connect = {
        ["FL"] = "FL",
        ["FR"] = "FR"
    }
}
