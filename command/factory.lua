local NilCommand = require('command/nil')
local UseCommand = require('command/use')
local Keys = require('data/keys')
local Npcs = require('data/npcs')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local CommandFactory = {}

--------------------------------------------------------------------------------
function CommandFactory.CreateCommand(cmd, p1)
    if cmd == 'use' then
        local key = Keys.GetByProperty('en', p1)
        if key.id == 0 then
            log('Invalid argument')
            return NilCommand:NilCommand()
        end

        return UseCommand:UseCommand(Npcs.GetClosest().id, key.id)
    end

    return NilCommand:NilCommand()
end

return CommandFactory