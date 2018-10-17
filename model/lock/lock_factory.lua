local NilLock = require('model/lock/nil_lock')
local NpcLock = require('model/lock/npc_lock')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local LockFactory = {}

--------------------------------------------------------------------------------
function LockFactory.CreateLock(id)
    if not id then
        return NilLock:NilLock()
    end

    return NpcLock:NpcLock(id)
end

return LockFactory
