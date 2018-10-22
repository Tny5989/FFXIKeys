local ItemKey = require('model/key/item_key')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local GameKey = ItemKey:ItemKey()
GameKey.__index = GameKey

--------------------------------------------------------------------------------
function GameKey:GameKey(id, entity)
    local o = {}
    setmetatable(o, self)
    o._id = id
    o._entity = entity
    o._type = 'GameKey'
    return o
end

return GameKey
