if not KeyTypes then
    KeyTypes = require('data/key_types')
end

local KeyType = {}
KeyType.__index = KeyType

function KeyType:KeyType(key_id)
    local o = {}
    setmetatable(o, self)

    o._id = key_id
    o._item_id = self:_get_key_type(key_id)

    return o
end

function KeyType:GetItem()
    return self._item_id
end

function KeyType:_get_key_type(key_id)
    local t = KeyTypes[key_id and key_id or '']
    return t and t or KeyTypes['']
end

return KeyType
