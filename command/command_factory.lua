local NilCommand = require('command/nil_command')
local StopCommand = require('command/stop_command')
local UnlockCommand = require('command/unlock_command')
local Keys = require('data/keys')
local Locks = require('data/locks')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local CommandFactory = {}

--------------------------------------------------------------------------------
function CommandFactory.CreateCommand(cmd, p1, p2)
    if not cmd then
        return NilCommand:NilCommand()
    end

    if cmd == 'stop' then
        return StopCommand:StopCommand(cmd)
    end

    if cmd == 'unlock' then
        local key_id = Keys.GetKey(p1)
        local lock_id = Locks.GetLock(p2)
        return UnlockCommand:UnlockCommand(key_id.id, lock_id)
    end

    return NilCommand:NilCommand()
end

return CommandFactory
