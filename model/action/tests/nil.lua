local LuaUnit = require('luaunit')
local NilAction = require('model/action/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NilActionTests = {}

--------------------------------------------------------------------------------
function NilActionTests:TestNilActionReturnFalse()
    local u = NilAction:NilAction()
    LuaUnit.assertFalse(u())
end

--------------------------------------------------------------------------------
function NilActionTests:TestNilActionWindowerRequirement()
    windower = nil
    NilAction:NilAction()()
end

--------------------------------------------------------------------------------
function NilActionTests:TestTypeIsNilAction()
    local u = NilAction:NilAction()
    LuaUnit.assertEquals(u:Type(), 'NilAction')
end

LuaUnit.LuaUnit.run('NilActionTests')