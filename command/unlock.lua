local NilCommand = require('command/nil')
local KeyFactory = require('model/key/factory')
local LockFactory = require('model/lock/factory')
local ActionFactory = require('model/action/factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local UnlockCommand = NilCommand:NilCommand()
UnlockCommand.__index = UnlockCommand

--------------------------------------------------------------------------------
function UnlockCommand:UnlockCommand(key_id, lock_id)
    local o = NilCommand:NilCommand()
    setmetatable(o, self)
    o._key = key_id
    o._lock = lock_id
    o._type = 'UnlockCommand'
    return o
end

--------------------------------------------------------------------------------
function UnlockCommand:__call(state)
    local key = KeyFactory.CreateKey(self._key, 0)
    local lock = LockFactory.CreateLock(self._lock, 0)
    state.running = ActionFactory.CreateUnlock(key, lock)()
    state.command = self
    return true
end

return UnlockCommand
