local LuaUnit = require('luaunit')
local LockFactory = require('model/lock/lock_factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
LockFactoryTests = {}

--------------------------------------------------------------------------------
function LockFactoryTests:TestNilLockCreatedWhenBadParam()
    local lock = LockFactory.CreateLock()
    LuaUnit.assertEquals(lock:Type(), 'NilLock')
end

--------------------------------------------------------------------------------
function LockFactoryTests:TestNpcLockCreatedWhenValidIdPassed()
    local lock = LockFactory.CreateLock(0)
    LuaUnit.assertEquals(lock:Type(), 'NpcLock')
end

LuaUnit.LuaUnit.run('LockFactoryTests')