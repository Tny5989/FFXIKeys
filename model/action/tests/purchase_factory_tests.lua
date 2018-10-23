local LuaUnit = require('luaunit')
local KeyFactory = require('model/key/key_factory')
local LockFactory = require('model/lock/lock_factory')
local PurchaseFactory = require('model/action/purchase_factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
PurchaseFactoryTests = {}

--------------------------------------------------------------------------------
function PurchaseFactoryTests:SetUp()
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
function PurchaseFactoryTests:TestNilPurchaseCreatedWhenNilKey()
    local key = KeyFactory.CreateKey()
    local lock = LockFactory.CreateLock(1234, 1)
    local u = PurchaseFactory.CreatePurchase(key, lock, 241, 6)
    LuaUnit.assertEquals(u:Type(), 'NilPurchase')
end

--------------------------------------------------------------------------------
function PurchaseFactoryTests:TestNilPurchaseCreatedWhenNilLock()
    local key = KeyFactory.CreateKey(1234)
    local lock = LockFactory.CreateLock()
    local u = PurchaseFactory.CreatePurchase(key, lock, 241, 6)
    LuaUnit.assertEquals(u:Type(), 'NilPurchase')
end

--------------------------------------------------------------------------------
function PurchaseFactoryTests:TestNilPurchaseCreatedWhenNilZone()
    local key = KeyFactory.CreateKey(1234)
    local lock = LockFactory.CreateLock()
    local u = PurchaseFactory.CreatePurchase(key, lock)
    LuaUnit.assertEquals(u:Type(), 'NilPurchase')
end

--------------------------------------------------------------------------------
function PurchaseFactoryTests:TestNilPurchaseCreatedWhenNilCount()
    local key = KeyFactory.CreateKey(1234)
    local lock = LockFactory.CreateLock()
    local u = PurchaseFactory.CreatePurchase(key, lock, 241)
    LuaUnit.assertEquals(u:Type(), 'NilPurchase')
end

--------------------------------------------------------------------------------
function PurchaseFactoryTests:TestValidPurchaseCreatedWhenValidParams()
    local key = KeyFactory.CreateKey(1)
    local lock = LockFactory.CreateLock(4321, 1)
    local u = PurchaseFactory.CreatePurchase(key, lock, 241, 6)
    LuaUnit.assertEquals(u:Type(), 'ValidPurchase')
end

--------------------------------------------------------------------------------
function PurchaseFactoryTests:TestNilPurchaseCreatedWhenFullBag()
    function windower.ffxi.get_items()
        return {max = 2, count = 2, [1] = {id = 1, count = 1}, [2] = {id = 2, count = 4} }
    end

    local key = KeyFactory.CreateKey(1)
    local lock = LockFactory.CreateLock(4321, 1)
    local u = PurchaseFactory.CreatePurchase(key, lock, 241, 6)
    LuaUnit.assertEquals(u:Type(), 'NilPurchase')
end

LuaUnit.LuaUnit.run('PurchaseFactoryTests')