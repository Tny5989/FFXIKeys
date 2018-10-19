_addon.name = 'FFXIKeys'
_addon.author = 'Areint/Alzade'
_addon.version = '1.2.1'
_addon.commands = {'keys'}

require('logger')
packets = require('packets')
settings = require('settings')
local CommandFactory = require('command/command_factory')

local state = {running = false, command = {}}

--------------------------------------------------------------------------------
function handle_load()
    settings.load()
end

--------------------------------------------------------------------------------
function handle_command(cmd, param1, param2)
    CommandFactory.CreateCommand(cmd, param1, param2)(state)
end

--------------------------------------------------------------------------------
function handle_incoming(id, _, pkt, _, _)
    if not state.running then
        return
    end

    if id == 0x037 then
        local pkt = packets.parse('incoming', pkt)
        if pkt and pkt['Status'] == 0 then
            state.command(state)
        end
    elseif id == 0x02A then
        local pkt = packets.parse('incoming', pkt)
        if settings.config.printlinks then
            log('https://www.ffxiah.com/item/' .. pkt['Param 1'] .. '/')
        end
        if settings.config.openlinks then
            windower.open_url('https://www.ffxiah.com/item/' .. pkt['Param 1'] .. '/')
        end
    end
end

--------------------------------------------------------------------------------
windower.register_event('load', handle_load)
windower.register_event('addon command', handle_command)
windower.register_event('incoming chunk', handle_incoming)