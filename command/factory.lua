local ConfigCommand = require('command/config')
local NilCommand = require('command/nil')
local StopCommand = require('command/stop')
local UseCommand = require('command/use')
local BuyCommand = require('command/buy')
local Keys = require('data/keys')
local Goblins = require('data/goblins')
local Vendors = require('data/vendors')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local CommandFactory = {}

--------------------------------------------------------------------------------
local ConfigCommands = {}
ConfigCommands['loop'] = true
ConfigCommands['printlinks'] = true
ConfigCommands['openlinks'] = true
ConfigCommands['logitems'] = true
setmetatable(ConfigCommands,
    { __index = function() return false end })

--------------------------------------------------------------------------------
function CommandFactory.CreateCommand(cmd, p1, p2)
    if cmd == 'use' then
        local key = Keys.GetByProperty('en', p1)
        if key.id == 0 then
            log('Invalid key argument')
            return NilCommand:NilCommand()
        end
        local npc = Goblins.GetClosest()
        return UseCommand:UseCommand(npc.id, key.id, npc.zone)
    elseif cmd == 'buy' then
        local key = Keys.GetByProperty('en', p1)
        if key.id == 0 then
            log('Invalid key argument')
            return NilCommand:NilCommand()
        end
        if not p2 or not tonumber(p2) then
            log('Invalid count argument')
            return NilCommand:NilCommand()
        end
        local npc = Vendors.GetClosest()
        return BuyCommand:BuyCommand(npc.id, key.idx, npc.zone, tonumber(p2))
    elseif cmd == 'stop' then
        return StopCommand:StopCommand()
    elseif ConfigCommands[cmd] then
        return ConfigCommand:ConfigCommand(cmd, not (settings.config[cmd]))
    end

    return NilCommand:NilCommand()
end

return CommandFactory