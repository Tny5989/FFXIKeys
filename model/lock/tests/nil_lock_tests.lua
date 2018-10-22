local LuaUnit = require('luaunit')
local NilLock = require('model/lock/nil_lock')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NilLockTests = {}

--------------------------------------------------------------------------------
function NilLockTests:TestNpcIdIsZero()
    local lock = NilLock:NilLock()
    LuaUnit.assertEquals(lock:Npc(), 0)
end

--------------------------------------------------------------------------------
function NilLockTests:TestMenuOptionIsZero()
    local lock = NilLock:NilLock()
    LuaUnit.assertEquals(lock:Option(), 0)
end

--------------------------------------------------------------------------------
function NilLockTests:TestTypeIsNilLock()
    local lock = NilLock:NilLock()
    LuaUnit.assertEquals(lock:Type(), 'NilLock')
end

LuaUnit.LuaUnit.run('NilLockTests')