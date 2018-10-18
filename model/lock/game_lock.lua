local NpcLock = require('model/lock/npc_lock')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local GameLock = NpcLock:NpcLock()
GameLock.__index = GameLock

--------------------------------------------------------------------------------
function GameLock:GameLock(id, entity)
    local o = {}
    setmetatable(o, self)
    o._id = id
    o._entity = entity
    o._type = 'GameLock'
    return o
end

function GameLock:Entity()
    return self._entity
end

return GameLock
