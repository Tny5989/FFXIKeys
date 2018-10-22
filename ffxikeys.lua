_addon.name = 'FFXIKeys'
_addon.author = 'Areint/Alzade'
_addon.version = '1.2.1'
_addon.commands = {'keys'}

require('logger')
packets = require('packets')
settings = require('settings')
local CommandFactory = require('command/command_factory')

local state = {running = false, command = nil}

--------------------------------------------------------------------------------
function handle_load()
    settings.load()
end

--------------------------------------------------------------------------------
function handle_command(cmd, param1, param2)
    CommandFactory.CreateCommand(cmd, param1, param2)(state)

--    local pkt = packets.new('outgoing', 0x01A)
--    pkt['Target'] = 17764611
--    pkt['Target Index'] = 259
--    packets.inject(pkt)
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
--    if id == 0x034 then
--            local pkt2 = packets.new('outgoing', 0x05B)
--            pkt2['Target'] = 17764611
--            pkt2['Option Index'] = 10
--            pkt2['Target Index'] = 259
--            pkt2['Automated Message'] = true
--            pkt2['Zone'] = 241
--            pkt2['Menu ID'] = 879
--            packets.inject(pkt2)
--
--            local pkt3 = packets.new('outgoing', 0x05B)
--            pkt3['Target'] = 17764611
--            pkt3['Option Index'] = 35
--            pkt3['Target Index'] = 259
--            pkt3['Automated Message'] = true
--            pkt3['Zone'] = 241
--            pkt3['Menu ID'] = 879
--            packets.inject(pkt3)
--
--            local count = 7
--            local unknown_parts = 36
--            local option = count * (2^13) + unknown_parts
--            print(option)
--
--            local pkt4 = packets.new('outgoing', 0x05B)
--            pkt4['Target'] = 17764611
--            pkt4['Option Index'] = option
--            pkt4['Target Index'] = 259
--            pkt4['Automated Message'] = true
--            pkt4['Zone'] = 241
--            pkt4['Menu ID'] = 879
--            packets.inject(pkt4)
--
--            local pkt5 = packets.new('outgoing', 0x05B)
--            pkt5['Target'] = 17764611
--            pkt5['Option Index'] = 0
--            pkt5['Target Index'] = 259
--            pkt5['Automated Message'] = false
--            pkt5['Zone'] = 241
--            pkt5['Menu ID'] = 879
--            packets.inject(pkt5)
--        return true
--    end
end

--------------------------------------------------------------------------------
windower.register_event('load', handle_load)
windower.register_event('addon command', handle_command)
windower.register_event('incoming chunk', handle_incoming)