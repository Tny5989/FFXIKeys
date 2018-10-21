local LuaUnit = require('luaunit')
local KeyFactory = require('model/key/key_factory')
local LockFactory = require('model/lock/lock_factory')
local UnlockFactory = require('model/action/unlock_factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
UnlockFactoryTests = {}

--------------------------------------------------------------------------------
function UnlockFactoryTests:SetUp()
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
function UnlockFactoryTests:TestNilUnlockCreatedWhenNilKey()
    local key = KeyFactory.CreateKey()
    local lock = LockFactory.CreateLock(1234)
    local u = UnlockFactory.CreateUnlock(key, lock)
    LuaUnit.assertEquals(u:Type(), 'NilUnlock')
end

--------------------------------------------------------------------------------
function UnlockFactoryTests:TestNilUnlockCreatedWhenNilLock()
    local key = KeyFactory.CreateKey(1234)
    local lock = LockFactory.CreateLock()
    local u = UnlockFactory.CreateUnlock(key, lock)
    LuaUnit.assertEquals(u:Type(), 'NilUnlock')
end

--------------------------------------------------------------------------------
function UnlockFactoryTests:TestValidUnlockCreatedWhenValidParams()
    local key = KeyFactory.CreateKey(1)
    local lock = LockFactory.CreateLock(4321)
    local u = UnlockFactory.CreateUnlock(key, lock)
    LuaUnit.assertEquals(u:Type(), 'ValidUnlock')
end

--------------------------------------------------------------------------------
function UnlockFactoryTests:TestNilUnlockCreatedWhenNilLockEntity()
    local key = KeyFactory.CreateKey(1)

    function windower.ffxi.get_mob_by_id(id)
        return nil
    end

    local lock = LockFactory.CreateLock(4321)
    local u = UnlockFactory.CreateUnlock(key, lock)
    LuaUnit.assertEquals(u:Type(), 'NilUnlock')
end

--------------------------------------------------------------------------------
function UnlockFactoryTests:TestNilUnlockCreatedWhenFullBag()
    function windower.ffxi.get_items()
        return {max = 2, count = 2, [1] = {id = 1, count = 1}, [2] = {id = 2, count = 4} }
    end

    local key = KeyFactory.CreateKey(1)
    local lock = LockFactory.CreateLock(4321)
    local u = UnlockFactory.CreateUnlock(key, lock)
    LuaUnit.assertEquals(u:Type(), 'NilUnlock')
end

--------------------------------------------------------------------------------
function UnlockFactoryTests:TestNilUnlockCreatedWhenNoItems()
    local key = KeyFactory.CreateKey(43213)
    local lock = LockFactory.CreateLock(4321)
    local u = UnlockFactory.CreateUnlock(key, lock)
    LuaUnit.assertEquals(u:Type(), 'NilUnlock')
end

LuaUnit.LuaUnit.run('UnlockFactoryTests')