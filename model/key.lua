local KeyType = require('model/key_type')

local Key = {}
Key.__index = Key

function Key:Key(key_id)
    local o = {}
    setmetatable(o, self)

    o._key_type = KeyType:KeyType(key_id)

    return o
end

function Key:GetItem()
    return self._key_type:GetItem()
end

return Key
