local Key = require('model/key')
local Lock = require('model/lock')
local UnlockFactory = require('model/actions/unlock_factory')

local LockSmith = {}

function LockSmith.Unlock(key_id, lock_id)
    return UnlockFactory.GetUnlock(Key:Key(key_id), Lock:Lock(lock_id))()
end

return LockSmith
