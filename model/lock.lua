local LockType = require('model/lock_type')

local Lock = {}
Lock.__index = Lock

function Lock:Lock(lock_id)
    local o = {}
    setmetatable(o, self)

    o._lock_type = LockType:LockType(lock_id)

    return o
end

function Lock:GetName()
    return self._lock_type:GetName()
end

return Lock
