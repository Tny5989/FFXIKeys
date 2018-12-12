local NilKey = require('model/key/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local ItemKey = NilKey:NilKey()
ItemKey.__index = ItemKey

--------------------------------------------------------------------------------
function ItemKey:ItemKey(id, option)
    local o = NilKey:NilKey()
    setmetatable(o, self)
    o._id = id
    o._option = option
    o._type = 'ItemKey'
    return o
end

return ItemKey
