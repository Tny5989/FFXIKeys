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

function LockType:_get_lock_type(lock_id)
    return LockTypes[lock_id and lock_id or '']
end

return LockType
