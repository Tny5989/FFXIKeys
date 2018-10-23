local LuaUnit = require('luaunit')
local LockFactory = require('model/lock/lock_factory')
local KeyFactory = require('model/key/key_factory')
local ValidPurchase = require('model/action/valid_purchase')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ValidPurchaseTests = {}

function ValidPurchaseTests:SetUp()
    packets = {}
    packets.p = nil
    function packets.new()
        return {}
    end
    function packets.inject(pkt)
        packets.p = pkt
    end
end

--------------------------------------------------------------------------------
function ValidPurchaseTests:TestReturnsTrue()
    local u = ValidPurchase:ValidPurchase()
    LuaUnit.assertTrue(u())
end

--------------------------------------------------------------------------------
function ValidPurchaseTests:TestPacketSent()
    local u = ValidPurchase:ValidPurchase()
    u()
    LuaUnit.assertEquals(packets.p, 1)
end

----------------------------------------------------------------------------------
--function ValidPurchaseTests:TestPacketData()
--    local u = ValidPurchase:ValidPurchase(KeyFactory.CreateKey(2), LockFactory.CreateLock(5555))
--    u()
--    LuaUnit.assertTrue(packets.p ~= nil)
--    LuaUnit.assertEquals(packets.p['Target'], 5555)
--    LuaUnit.assertEquals(packets.p['Item Count 1'], 1)
--    LuaUnit.assertEquals(packets.p['Item Index 1'], 2)
--    LuaUnit.assertEquals(packets.p['Target Index'], 4321)
--    LuaUnit.assertEquals(packets.p['Number of Items'], 1)
--
--end

--------------------------------------------------------------------------------
function ValidPurchaseTests:TestTypeIsValidPurchase()
    local u = ValidPurchase:ValidPurchase()
    LuaUnit.assertEquals(u:Type(), 'ValidPurchase')
end

LuaUnit.LuaUnit.run('ValidPurchaseTests')