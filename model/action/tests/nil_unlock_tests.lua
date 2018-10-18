local LuaUnit = require('luaunit')
local NilUnlock = require('model/action/nil_unlock')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NilUnlockTests = {}

--------------------------------------------------------------------------------
function NilUnlockTests:TestNilUnlockReturnFalse()
    local u = NilUnlock:NilUnlock()
    LuaUnit.assertFalse(u())
end

--------------------------------------------------------------------------------
function NilUnlockTests:TestNilUnlockWindowerRequirement()
    windower = nil
    NilUnlock:NilUnlock()()
end

--------------------------------------------------------------------------------
function NilUnlockTests:TestTypeIsNilUnlock()
    local u = NilUnlock:NilUnlock()
    LuaUnit.assertEquals(u:Type(), 'NilUnlock')
end

LuaUnit.LuaUnit.run('NilUnlockTests')