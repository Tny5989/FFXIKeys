local LuaUnit = require('luaunit')
local LockFactory = require('model/lock/factory')
local KeyFactory = require('model/key/factory')
local UnlockAction = require('model/action/unlock')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
UnlockActionTests = {}

function UnlockActionTests:SetUp()
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
    packets.p = nil
    function packets.new()
        return {}
    end
    function packets.inject(pkt)
        packets.p = pkt
    end

    settings = {}
    settings.config = {}
    settings.config.maxdistance = 20
end

--------------------------------------------------------------------------------
function UnlockActionTests:TestReturnsTrue()
    local u = UnlockAction:UnlockAction(KeyFactory.CreateKey(1), LockFactory.CreateLock(1234, 1))
    LuaUnit.assertTrue(u())
end

--------------------------------------------------------------------------------
function UnlockActionTests:TestPacketSent()
    local u = UnlockAction:UnlockAction(KeyFactory.CreateKey(1), LockFactory.CreateLock(5555, 1))
    u()
    LuaUnit.assertTrue(packets.p ~= nil)
end

--------------------------------------------------------------------------------
function UnlockActionTests:TestPacketData()
    local u = UnlockAction:UnlockAction(KeyFactory.CreateKey(2), LockFactory.CreateLock(5555, 1))
    u()
    LuaUnit.assertTrue(packets.p ~= nil)
    LuaUnit.assertEquals(packets.p['Target'], 5555)
    LuaUnit.assertEquals(packets.p['Item Count 1'], 1)
    LuaUnit.assertEquals(packets.p['Item Index 1'], 2)
    LuaUnit.assertEquals(packets.p['Target Index'], 4321)
    LuaUnit.assertEquals(packets.p['Number of Items'], 1)

end

--------------------------------------------------------------------------------
function UnlockActionTests:TestTypeIsUnlockAction()
    local u = UnlockAction:UnlockAction()
    LuaUnit.assertEquals(u:Type(), 'UnlockAction')
end

LuaUnit.LuaUnit.run('UnlockActionTests')