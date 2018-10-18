local KeyFactory = require('model/key/key_factory')
local LockFactory = require('model/lock/lock_factory')
local UnlockFactory = require('model/action/unlock_factory')

local LockSmith = {}

function LockSmith.Unlock(key_id, lock_id)
    return UnlockFactory.CreateUnlock(KeyFactory.CreateKey(key_id), LockFactory.CreateLock(lock_id))()
end

return LockSmith