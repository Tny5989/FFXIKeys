local NilLock = require('model/lock/nil_lock')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local NpcLock = NilLock:NilLock()
NpcLock.__index = NpcLock

--------------------------------------------------------------------------------
function NpcLock:NpcLock(id, option)
    local o = {}
    setmetatable(o, self)
    o._id = id
    o._option = option
    o._type = 'NpcLock'
    return o
end

return NpcLock
