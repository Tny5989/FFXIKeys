local LuaUnit = require('luaunit')
local KeyFactory = require('model/key/factory')
local LockFactory = require('model/lock/factory')
local ActionFactory = require('model/action/factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ActionFactoryTests = {}

--------------------------------------------------------------------------------
function ActionFactoryTests:SetUp()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_player()
        return {id = 1234}
    end
    function windower.ffxi.get_mob_by_id(id)
        return {id = id, index = 4321, distance = 5}
    end
    function windower.ffxi.get_items()
        return {max = 4, count = 2, [1] = {id = 1, count = 1}, [2] = {id = 2, count = 4} }
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
function ActionFactoryTests:TestNilActionCreatedWhenNilKey()
    local key = KeyFactory.CreateKey()
    local lock = LockFactory.CreateLock(1234, 1)
    local u = ActionFactory.CreateUnlock(key, lock)
    LuaUnit.assertEquals(u:Type(), 'NilAction')
end

--------------------------------------------------------------------------------
function ActionFactoryTests:TestNilActionCreatedWhenNilLock()
    local key = KeyFactory.CreateKey(1234)
    local lock = LockFactory.CreateLock()
    local u = ActionFactory.CreateUnlock(key, lock)
    LuaUnit.assertEquals(u:Type(), 'NilAction')
end

--------------------------------------------------------------------------------
function ActionFactoryTests:TestUnlockActionCreatedWhenValidParams()
    local key = KeyFactory.CreateKey(1)
    local lock = LockFactory.CreateLock(4321, 1)
    local u = ActionFactory.CreateUnlock(key, lock)
    LuaUnit.assertEquals(u:Type(), 'UnlockAction')
end

--------------------------------------------------------------------------------
function ActionFactoryTests:TestNilActionCreatedWhenNilLockEntity()
    local key = KeyFactory.CreateKey(1)

    function windower.ffxi.get_mob_by_id(id)
        return nil
    end

    local lock = LockFactory.CreateLock(4321, 1)
    local u = ActionFactory.CreateUnlock(key, lock)
    LuaUnit.assertEquals(u:Type(), 'NilAction')
end

--------------------------------------------------------------------------------
function ActionFactoryTests:TestNilActionCreatedWhenFullBag()
    function windower.ffxi.get_items()
        return {max = 2, count = 2, [1] = {id = 1, count = 1}, [2] = {id = 2, count = 4} }
    end

    local key = KeyFactory.CreateKey(1)
    local lock = LockFactory.CreateLock(4321, 1)
    local u = ActionFactory.CreateUnlock(key, lock)
    LuaUnit.assertEquals(u:Type(), 'NilAction')
end

--------------------------------------------------------------------------------
function ActionFactoryTests:TestNilActionCreatedWhenNoItems()
    local key = KeyFactory.CreateKey(43213)
    local lock = LockFactory.CreateLock(4321, 1)
    local u = ActionFactory.CreateUnlock(key, lock)
    LuaUnit.assertEquals(u:Type(), 'NilAction')
end

--------------------------------------------------------------------------------
function ActionFactoryTests:TestNilActionCreatedWhenNilKey()
    local key = KeyFactory.CreateKey()
    local lock = LockFactory.CreateLock(1234, 1)
    local u = ActionFactory.CreatePurchase(key, lock, 241, 6)
    LuaUnit.assertEquals(u:Type(), 'NilAction')
end

--------------------------------------------------------------------------------
function ActionFactoryTests:TestNilActionCreatedWhenNilLock()
    local key = KeyFactory.CreateKey(1234)
    local lock = LockFactory.CreateLock()
    local u = ActionFactory.CreatePurchase(key, lock, 241, 6)
    LuaUnit.assertEquals(u:Type(), 'NilAction')
end

--------------------------------------------------------------------------------
function ActionFactoryTests:TestNilActionCreatedWhenNilZone()
    local key = KeyFactory.CreateKey(1234)
    local lock = LockFactory.CreateLock()
    local u = ActionFactory.CreatePurchase(key, lock)
    LuaUnit.assertEquals(u:Type(), 'NilAction')
end

--------------------------------------------------------------------------------
function ActionFactoryTests:TestNilActionCreatedWhenNilCount()
    local key = KeyFactory.CreateKey(1234)
    local lock = LockFactory.CreateLock()
    local u = ActionFactory.CreatePurchase(key, lock, 241)
    LuaUnit.assertEquals(u:Type(), 'NilAction')
end

--------------------------------------------------------------------------------
function ActionFactoryTests:TestPurchaseActionCreatedWhenValidParams()
    local key = KeyFactory.CreateKey(1)
    local lock = LockFactory.CreateLock(4321, 1)
    local u = ActionFactory.CreatePurchase(key, lock, 241, 6)
    LuaUnit.assertEquals(u:Type(), 'PurchaseAction')
end

--------------------------------------------------------------------------------
function ActionFactoryTests:TestNilActionCreatedWhenFullBag()
    function windower.ffxi.get_items()
        return {max = 2, count = 2, [1] = {id = 1, count = 1}, [2] = {id = 2, count = 4} }
    end

    local key = KeyFactory.CreateKey(1)
    local lock = LockFactory.CreateLock(4321, 1)
    local u = ActionFactory.CreatePurchase(key, lock, 241, 6)
    LuaUnit.assertEquals(u:Type(), 'NilAction')
end

LuaUnit.LuaUnit.run('ActionFactoryTests')