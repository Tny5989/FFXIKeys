local ItemKey = require('model/key/item')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local GameKey = ItemKey:ItemKey()
GameKey.__index = GameKey

--------------------------------------------------------------------------------
function GameKey:GameKey(id, option, entity)
    local o = ItemKey:ItemKey(id, option)
    setmetatable(o, self)
    o._entity = entity
    o._type = 'GameKey'
    return o
end

return GameKey
