_addon.name = 'FFXIKeys'
_addon.author = 'Areint/Alzade'
_addon.version = '1.2.1'
_addon.commands = {'keys'}

require('logger')
packets = require('packets')
settings = require('settings')
local locksmith = require('locksmith')

local running

--------------------------------------------------------------------------------
-- Handles addon load.  Gets the player id for the session.
--
function handle_load()
    settings.load()
    running = false
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
        if locksmith.Unlock(8973, 17780998) then
            running = true
        end

    elseif lcmd == 'stop' then
        log('Stopping')
        running = false

    elseif lcmd == 'printlinks' then
        log('Printing links is ' .. (settings.config.printlinks and 'off' or 'on'))
        settings.config.printlinks = not settings.config.printlinks
        settings.save()

    elseif lcmd == 'openlinks' then
        log('Opening links is ' .. (settings.config.openlinks and 'off' or 'on'))
        settings.config.openlinks = not settings.config.openlinks
        settings.save()
    end
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
        if pkt and pkt['Status'] == 0 then
            running = locksmith.Unlock(8973, 17780998)
        end
    elseif running and id == 0x02A then
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