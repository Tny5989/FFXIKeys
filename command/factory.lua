local ConfigCommand = require('command/config')
local NilCommand = require('command/nil')
local UseCommand = require('command/use')
local Keys = require('data/keys')
local Npcs = require('data/npcs')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local CommandFactory = {}

--------------------------------------------------------------------------------
local ConfigCommands = {}
ConfigCommands['loop'] = true
ConfigCommands['printlinks'] = true
ConfigCommands['openlinks'] = true
ConfigCommands['logitems'] = true

--------------------------------------------------------------------------------
function CommandFactory.CreateOrRunCommand(cmd, p1)
    if cmd == 'use' then
        local key = Keys.GetByProperty('en', p1)
        if key.id == 0 then
            log('Invalid argument')
            return NilCommand:NilCommand()
        end

        local npc = Npcs.GetClosest()
        return UseCommand:UseCommand(npc.id, key.id, npc.zone)
    elseif cmd and ConfigCommands[cmd] then
        -- Config commands are simple and ran immediately to avoid interrupting
        -- longer running commands
        ConfigCommand:ConfigCommand(cmd, not (settings.config[cmd]))()
        return NilCommand:NilCommand()
    end

    log('Unknown command')
    return NilCommand:NilCommand()
end

return CommandFactory