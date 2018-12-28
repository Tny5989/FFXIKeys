local NpcLock = require('model/lock/npc')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local GameLock = NpcLock:NpcLock()
GameLock.__index = GameLock

--------------------------------------------------------------------------------
function GameLock:GameLock(id, menu, entity)
    local o = NpcLock:NpcLock(id, menu)
    setmetatable(o, self)
    o._entity = entity
    o._type = 'GameLock'
    return o
end

function GameLock:Entity()
    return self._entity
end

return GameLock
