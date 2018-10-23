local NilCommand = require('command/nil_command')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local StopCommand = NilCommand:NilCommand()
StopCommand.__index = StopCommand

--------------------------------------------------------------------------------
function StopCommand:StopCommand(key_id, lock_id)
    local o = {}
    setmetatable(o, self)
    o._key = key_id
    o._lock = lock_id
    o._type = 'StopCommand'
    return o
end

--------------------------------------------------------------------------------
function StopCommand:__call(state)
    state.running = false
    state.command = nil
    return true
end

return StopCommand
