local LuaUnit = require('luaunit')
local NilPurchase = require('model/action/nil_purchase')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NilPurchaseTests = {}

--------------------------------------------------------------------------------
function NilPurchaseTests:TestNilPurchaseReturnFalse()
    local u = NilPurchase:NilPurchase()
    LuaUnit.assertFalse(u())
end

--------------------------------------------------------------------------------
function NilPurchaseTests:TestNilPurchaseWindowerRequirement()
    windower = nil
    NilPurchase:NilPurchase()()
end

--------------------------------------------------------------------------------
function NilPurchaseTests:TestTypeIsNilPurchase()
    local u = NilPurchase:NilPurchase()
    LuaUnit.assertEquals(u:Type(), 'NilPurchase')
end

LuaUnit.LuaUnit.run('NilPurchaseTests')