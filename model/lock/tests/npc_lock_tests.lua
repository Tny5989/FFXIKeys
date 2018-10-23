local LuaUnit = require('luaunit')
local NpcLock = require('model/lock/npc_lock')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NpcLockTests = {}

--------------------------------------------------------------------------------
function NpcLockTests:TestNpcIdIsCorrect()
    local key = NpcLock:NpcLock(1234, 4321)
    LuaUnit.assertEquals(key:Npc(), 1234)
end

--------------------------------------------------------------------------------
function NpcLockTests:TestMenuMenuIsCorrect()
    local lock = NpcLock:NpcLock(1234, 4321)
    LuaUnit.assertEquals(lock:Menu(), 4321)
end

--------------------------------------------------------------------------------
function NpcLockTests:TestTypeIsNpcLock()
    local key = NpcLock:NpcLock(1234, 4321)
    LuaUnit.assertEquals(key:Type(), 'NpcLock')
end

LuaUnit.LuaUnit.run('NpcLockTests')