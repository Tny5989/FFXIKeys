local Key = require('model/key')
local Lock = require('model/lock')
local Unlock = require('model/actions/unlock')

local KeySmith = {}

function KeySmith.GetUnlock(key_id, lock_id)
    local key = Key:Key(key_id)
    local lock = Lock:Lock(lock_id)
    return Unlock:Unlock(key, lock)
end

return KeySmith
