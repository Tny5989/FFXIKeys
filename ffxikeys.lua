_addon.name = 'FFXIKeys'
_addon.author = 'Areint/Alzade'
_addon.version = '1.3.1'
_addon.commands = {'keys'}

require('logger')
packets = require('packets')
settings = require('settings')
local CommandFactory = require('command/command_factory')
local Locks = require('data/locks')

local state = {running = false, command = nil}

--------------------------------------------------------------------------------
function handle_load()
    settings.load()

    local info = windower.ffxi.get_info()
    if info then
        handle_zone_change(info.zone)
    end
end

--------------------------------------------------------------------------------
function handle_zone_change(zone_id, _)
    windower.send_command('alias buykeys input //keys buy spgobbiekey ' .. Locks.GetLockIndexForZone(zone_id, true))
    windower.send_command('alias usekeys input //keys unlock spgobbiekey ' .. Locks.GetLockIndexForZone(zone_id, false))
end

--------------------------------------------------------------------------------
function handle_command(cmd, param1, param2, param3)
    CommandFactory.CreateCommand(cmd, param1, param2, param3)(state)
end

--------------------------------------------------------------------------------
function handle_incoming(id, _, pkt, b, i)
    if not state.running then
        return false
    end

    if state.command:Type() == 'UnlockCommand' then
        if id == 0x02A then
            local pkt = packets.parse('incoming', pkt)
            if settings.config.printlinks then
                log('https://www.ffxiah.com/item/' .. pkt['Param 1'] .. '/')
            end
            if settings.config.openlinks then
                windower.open_url('https://www.ffxiah.com/item/' .. pkt['Param 1'] .. '/')
            end
            state.command(state)
        end
    elseif state.command:Type() == 'BuyCommand' then
        if id == 0x034 then
            state.command(state)
            return true
        elseif id == 0x05C then
            return true
        elseif id == 0x052 then
            return true
        end
    end
end

--------------------------------------------------------------------------------
windower.register_event('load', handle_load)
windower.register_event('zone change', handle_zone_change)
windower.register_event('addon command', handle_command)
windower.register_event('incoming chunk', handle_incoming)