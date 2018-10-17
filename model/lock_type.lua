if not LockTypes then
    LockTypes = require('data/lock_types')
end

local LockType = {}
LockType.__index = LockType

function LockType:LockType(lock_id)
    local o = {}
    setmetatable(o, self)

    o._id = lock_id
    o._target_name = self:_get_lock_type(lock_id)

    return o
end

function LockType:GetName()
    return self._target_name
end

function LockType:_get_lock_type(lock_id)
    local t = LockTypes[lock_id and lock_id or '']
    return t and t or LockTypes['']
end

return LockType
