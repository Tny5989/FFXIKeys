local LuaUnit = require('luaunit')
local NpcLock = require('model/lock/npc_lock')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NpcLockTests = {}

--------------------------------------------------------------------------------
function NpcLockTests:TestItemIdIsCorrect()
    local key = NpcLock:NpcLock(1234)
    LuaUnit.assertEquals(key:Item(), 1234)
end

--------------------------------------------------------------------------------
function NpcLockTests:TestTypeIsNilLock()
    local key = NpcLock:NpcLock(1234)
    LuaUnit.assertEquals(key:Type(), 'NpcLock')
end

LuaUnit.LuaUnit.run('NpcLockTests')