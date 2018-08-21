_addon.name = 'FFXIKeys'
_addon.author = 'Areint'
_addon.version = '0.5'
_addon.commands = {'keys' }

local resources = require('resources')
local packets = require('packets')
require('logger')

local targets =
{
    [resources.zones:with('en', 'Port San d\'Oria').id] =
    {
        name = 'Habitox'
    },
    [resources.zones:with('en', 'Southern San d\'Oria').id] =
    {
        name = 'Mystrix'
    },
    [resources.zones:with('en', 'Bastok Mines').id] =
    {
        name = 'Bountibox'
    },
    [resources.zones:with('en', 'Bastok Markets').id] =
    {
        name = 'Specilox'
    },
    [resources.zones:with('en', 'Windurst Walls').id] =
    {
        name = 'Arbitrix'
    },
    [resources.zones:with('en', 'Windurst Woods').id] =
    {
        name = 'Funtrox'
    },
    [resources.zones:with('en', 'Lower Jeuno').id] =
    {
        name = 'Sweepstox'
    },
    [resources.zones:with('en', 'Upper Jeuno').id] =
    {
        name = 'Priztrix'
    },
    [resources.zones:with('en', 'Aht Urhgan Whitegate').id] =
    {
        name = 'Wondrix'
    },
    [resources.zones:with('en', 'Western Adoulin').id] =
    {
        name = 'Rewardox'
    },
    [resources.zones:with('en', 'Eastern Adoulin').id] =
    {
        name = 'Winrix'
    }
}
local key_id = resources.items:with('en', 'SP Gobbie Key').id
local max_distance = 25.0
local running = false
local print_links = false
local open_links = false
local player_id

--------------------------------------------------------------------------------
-- Validates game state before attempting to trade.
--
function run()
    running = false

    -- Make sure we have player information
    if not player_id then
        log('Unable to get player information')
        return
    end

    -- Make sure we can get info from the game
    local info = windower.ffxi.get_info()
    if not info then
        log('Unable to get game info')
        return
    end

    -- Make sure the player is in a supported zone
    local data = targets[info.zone]
    if not data then
        log('Not in a valid zone')
        return
    end

    -- Make sure the npc is in range
    local mob = windower.ffxi.get_mob_by_name(data.name)
    if not mob or mob.distance > max_distance then
        log('Not in range of npc')
        return
    end

    -- Make sure there is room in the players inventory
    local bag = windower.ffxi.get_items(0)
    if not bag or bag.count >= bag.max then
        log('Inventory is full')
        return
    end

    -- Find keys in the players inventory and trade one
    for index, item in pairs(bag) do
        if type(item) == 'table' and item.id == key_id then
            local pkt = packets.new('outgoing', 0x036)
            if not pkt then
                log('Unable to create outgoing packet')
                return
            end

            pkt['Target'] = mob.id
            pkt['Item Count 1'] = 1
            pkt['Item Index 1'] = index
            pkt['Target Index'] = mob.index
            pkt['Number of Items'] = 1

            packets.inject(pkt)
            running = true
            return
        end
    end

    log('No more keys')
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
        running = true
        run()
    elseif lcmd == 'stop' then
        running = false
    elseif lcmd == 'printlinks' then
        print_links = not print_links
    elseif lcmd == 'openlinks' then
        open_links = not open_links
    end
end

--------------------------------------------------------------------------------
-- Handles addon load.  Gets the player id for the session.
--
function handle_load()
    local player = windower.ffxi.get_player()
    if not player then
        player_id = nil
    else
        player_id = player.id
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
        if pkt and pkt['Status'] == 0 and pkt['Player'] == player_id then
            run()
        end
    end
end

--------------------------------------------------------------------------------
windower.register_event('load', handle_load)
windower.register_event('addon command', handle_command)
windower.register_event('incoming chunk', handle_incoming)
