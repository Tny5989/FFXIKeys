local ValidUnlock = require('model/action/valid_unlock')
local NilUnlock = require('model/action/nil_unlock')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local UnlockFactory = {}

--------------------------------------------------------------------------------
function UnlockFactory.CreateUnlock(key, lock)
    if key:Type() == 'NilKey' or lock:Type() == 'NilLock' then
        return NilUnlock:NilUnlock()
    end
    return ValidUnlock:ValidUnlock(key, lock)
end

return UnlockFactory
