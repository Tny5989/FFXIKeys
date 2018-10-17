local Key = require('model/key')
local Lock = require('model/lock')
local UnlockFactory = require('model/actions/unlock_factory')

local KeySmith = {}

function KeySmith.GetUnlock(key_id, lock_id)
    local key = Key:Key(key_id)
    local lock = Lock:Lock(lock_id)
    return UnlockFactory.GetUnlock(key, lock)
end

return KeySmith
