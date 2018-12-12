local LuaUnit = require('luaunit')
local NilLock = require('model/lock/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NilLockTests = {}

--------------------------------------------------------------------------------
function NilLockTests:TestNpcIdIsZero()
    local lock = NilLock:NilLock()
    LuaUnit.assertEquals(lock:Npc(), 0)
end

--------------------------------------------------------------------------------
function NilLockTests:TestMenuMenuIsZero()
    local lock = NilLock:NilLock()
    LuaUnit.assertEquals(lock:Menu(), 0)
end

--------------------------------------------------------------------------------
function NilLockTests:TestTypeIsNilLock()
    local lock = NilLock:NilLock()
    LuaUnit.assertEquals(lock:Type(), 'NilLock')
end

LuaUnit.LuaUnit.run('NilLockTests')