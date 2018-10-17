_addon.name = 'FFXIKeys'
_addon.author = 'Areint'
_addon.version = '1.1.1'
_addon.commands = {'keys'}

require('logger')
settings = require('settings')
packets = require('packets')
local keysmith = require('keysmith')

--------------------------------------------------------------------------------
-- Validates game state before attempting to trade.
--
function run()
    keysmith.GetUnlock('test', 'test')()
end

--------------------------------------------------------------------------------
-- Handles addon commands.
--
-- param [in] cmd - The user command.
--
function handle_command(cmd)
    if not cmd then
        return
    end

    local lcmd = cmd:lower()
    if lcmd == 'start' then
        log('Starting')
        run()

    elseif lcmd == 'stop' then
        log('Stopping')

    elseif lcmd == 'printlinks' then
        log('Turning printing links ' .. (settings.config.printlinks and 'off' or 'on'))
        settings.config.printlinks = not settings.config.printlinks
        settings.save()

    elseif lcmd == 'openlinks' then
        log('Turning opening links ' .. (settings.config.openlinks and 'off' or 'on'))
        settings.config.openlinks = not settings.config.openlinks
        settings.save()

    end
end

--------------------------------------------------------------------------------
-- Handles addon load.
--
function handle_load()
    settings.load()
end

--------------------------------------------------------------------------------
-- Parses incoming chunks.  Used to trigger additional trades.
--
-- param [in] id  - The packet id.
-- param [in] pkt - The packet data.
--
function handle_incoming(id, _, pkt, _, _)
    if running and id == 0x037 then
        local pkt = packets.parse('incoming', pkt)
        if pkt and pkt['Status'] == 0 and pkt['Player'] == player_id then
            run()
        end
    elseif running and npc and id == 0x02A then
        local pkt = packets.parse('incoming', pkt)
        if pkt and pkt['Message ID'] == 39155 and pkt['Player'] == npc.id and pkt['Player Index'] == npc.index then
            if settings.config.printlinks then
                log('https://www.ffxiah.com/item/' .. pkt['Param 1'] .. '/')
            end
            if settings.config.openlinks then
                windower.open_url('https://www.ffxiah.com/item/' .. pkt['Param 1'] .. '/')
            end
        end
    end
end

--------------------------------------------------------------------------------
windower.register_event('load', handle_load)
windower.register_event('addon command', handle_command)
--windower.register_event('incoming chunk', handle_incoming)
