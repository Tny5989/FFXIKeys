local LuaUnit = require('luaunit')
local LockFactory = require('model/lock/lock_factory')
local KeyFactory = require('model/key/key_factory')
local ValidUnlock = require('model/action/valid_unlock')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ValidUnlockTests = {}

function ValidUnlockTests:SetUp()
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
function ValidUnlockTests:TestReturnsTrue()
    local u = ValidUnlock:ValidUnlock(KeyFactory.CreateKey(1), LockFactory.CreateLock(1234))
    LuaUnit.assertTrue(u())
end

--------------------------------------------------------------------------------
function ValidUnlockTests:TestPacketSent()
    local u = ValidUnlock:ValidUnlock(KeyFactory.CreateKey(1), LockFactory.CreateLock(5555))
    u()
    LuaUnit.assertTrue(packets.p ~= nil)
end

--------------------------------------------------------------------------------
function ValidUnlockTests:TestPacketData()
    local u = ValidUnlock:ValidUnlock(KeyFactory.CreateKey(2), LockFactory.CreateLock(5555))
    u()
    LuaUnit.assertTrue(packets.p ~= nil)
    LuaUnit.assertEquals(packets.p['Target'], 5555)
    LuaUnit.assertEquals(packets.p['Item Count 1'], 1)
    LuaUnit.assertEquals(packets.p['Item Index 1'], 2)
    LuaUnit.assertEquals(packets.p['Target Index'], 4321)
    LuaUnit.assertEquals(packets.p['Number of Items'], 1)

end

--------------------------------------------------------------------------------
function ValidUnlockTests:TestTypeIsValidUnlock()
    local u = ValidUnlock:ValidUnlock()
    LuaUnit.assertEquals(u:Type(), 'ValidUnlock')
end

LuaUnit.LuaUnit.run('ValidUnlockTests')