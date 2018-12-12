local LuaUnit = require('luaunit')
local LockFactory = require('model/lock/factory')
local KeyFactory = require('model/key/factory')
local PurchaseAction = require('model/action/purchase')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
PurchaseActionTests = {}

function PurchaseActionTests:SetUp()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_player()
        return {id = 1234}
    end
    function windower.ffxi.get_mob_by_id(id)
        return {id = id, index = 4321, distance = 5}
    end
    function windower.ffxi.get_items()
        return {max = 3, count = 2, [1] = {id = 1, count = 1}, [2] = {id = 2, count = 4} }
    end

    packets = {}
    packets.p = {}
    function packets.new()
        return {}
    end
    function packets.inject(pkt)
        table.insert(packets.p, pkt)
    end

    settings = {}
    settings.config = {}
    settings.config.maxdistance = 20
end

--------------------------------------------------------------------------------
function PurchaseActionTests:TestReturnsTrue()
    local key = KeyFactory.CreateKey(1, 2)
    local vendor = LockFactory.CreateLock(5421, 7865)
    local p = PurchaseAction:PurchaseAction(key, vendor, 241, 6)
    LuaUnit.assertTrue(p())
    LuaUnit.assertFalse(p())
end

--------------------------------------------------------------------------------
function PurchaseActionTests:TestActionPacketSent()
    local key = KeyFactory.CreateKey(1, 2)
    local vendor = LockFactory.CreateLock(4321, 7865)
    local p = PurchaseAction:PurchaseAction(key, vendor, 241, 6)
    p()
    LuaUnit.assertEquals(#packets.p, 1)
end
--------------------------------------------------------------------------------
function PurchaseActionTests:TestActionPacketData()
    local key = KeyFactory.CreateKey(1, 2)
    local vendor = LockFactory.CreateLock(4321, 7865)
    local p = PurchaseAction:PurchaseAction(key, vendor, 241, 6)
    p()
    LuaUnit.assertEquals(packets.p[1]['Target'], vendor:Npc())
    LuaUnit.assertEquals(packets.p[1]['Target Index'], vendor:Entity():Index())
end

--------------------------------------------------------------------------------
function PurchaseActionTests:TestChoicePacketsSent()
    local key = KeyFactory.CreateKey(1, 2)
    local vendor = LockFactory.CreateLock(4321, 7865)
    local p = PurchaseAction:PurchaseAction(key, vendor, 241, 6)
    p()
    p()
    LuaUnit.assertEquals(#packets.p, 5)
end

--------------------------------------------------------------------------------
function PurchaseActionTests:TestChoicePacketDatas()
    local key = KeyFactory.CreateKey(1, 2)
    local vendor = LockFactory.CreateLock(4321, 7865)
    local p = PurchaseAction:PurchaseAction(key, vendor, 240, 6)
    p()
    p()
    LuaUnit.assertEquals(packets.p[2]['Target'], vendor:Npc())
    LuaUnit.assertEquals(packets.p[2]['Option Index'], 10)
    LuaUnit.assertEquals(packets.p[2]['Target Index'], vendor:Entity():Index())
    LuaUnit.assertEquals(packets.p[2]['Automated Message'], true)
    LuaUnit.assertEquals(packets.p[2]['Zone'], 240)
    LuaUnit.assertEquals(packets.p[2]['Menu ID'], vendor:Menu())

    LuaUnit.assertEquals(packets.p[3]['Target'], vendor:Npc())
    LuaUnit.assertEquals(packets.p[3]['Option Index'], key:Option())
    LuaUnit.assertEquals(packets.p[3]['Target Index'], vendor:Entity():Index())
    LuaUnit.assertEquals(packets.p[3]['Automated Message'], true)
    LuaUnit.assertEquals(packets.p[3]['Zone'], 240)
    LuaUnit.assertEquals(packets.p[3]['Menu ID'], vendor:Menu())

    LuaUnit.assertEquals(packets.p[4]['Target'], vendor:Npc())
    LuaUnit.assertEquals(packets.p[4]['Option Index'], 6 * (2^13) + key:Option() + 1)
    LuaUnit.assertEquals(packets.p[4]['Target Index'], vendor:Entity():Index())
    LuaUnit.assertEquals(packets.p[4]['Automated Message'], true)
    LuaUnit.assertEquals(packets.p[4]['Zone'], 240)
    LuaUnit.assertEquals(packets.p[4]['Menu ID'], vendor:Menu())

    LuaUnit.assertEquals(packets.p[5]['Target'], vendor:Npc())
    LuaUnit.assertEquals(packets.p[5]['Option Index'], 0)
    LuaUnit.assertEquals(packets.p[5]['Target Index'], vendor:Entity():Index())
    LuaUnit.assertEquals(packets.p[5]['Automated Message'], false)
    LuaUnit.assertEquals(packets.p[5]['Zone'], 240)
    LuaUnit.assertEquals(packets.p[5]['Menu ID'], vendor:Menu())
end

----------------------------------------------------------------------------------
function PurchaseActionTests:TestNoPacketsSentWhenDone()
    local key = KeyFactory.CreateKey(1, 2)
    local vendor = LockFactory.CreateLock(4321, 7865)
    local p = PurchaseAction:PurchaseAction(key, vendor, 241, 6)
    p()
    p()

    packets = nil
    p()
end

--------------------------------------------------------------------------------
function PurchaseActionTests:TestTypeIsPurchaseAction()
    local key = KeyFactory.CreateKey(1, 2)
    local vendor = LockFactory.CreateLock(4321, 7865)
    local p = PurchaseAction:PurchaseAction(key, vendor, 241, 6)
    LuaUnit.assertEquals(p:Type(), 'PurchaseAction')
end

LuaUnit.LuaUnit.run('PurchaseActionTests')