local LuaUnit = require('luaunit')
local LockFactory = require('model/lock/lock_factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
LockFactoryTests = {}

--------------------------------------------------------------------------------
function LockFactoryTests:SetUp()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_mob_by_id(id)
        return {id = id, index = 4321, distance = 5}
    end

    settings = {}
    settings.config = {}
    settings.config.maxdistance = 20
end

--------------------------------------------------------------------------------
function LockFactoryTests:TestNilLockCreatedWhenBadParam()
    local lock = LockFactory.CreateLock()
    LuaUnit.assertEquals(lock:Type(), 'NilLock')
end

--------------------------------------------------------------------------------
function LockFactoryTests:TestNilLockCreatedWhenBadMob()
    function windower.ffxi.get_mob_by_id(id)
        return nil
    end

    local key = LockFactory.CreateLock(0, 1)
    LuaUnit.assertEquals(key:Type(), 'NilLock')
end

--------------------------------------------------------------------------------
function LockFactoryTests:TestNilLockCreatedWhenFarAway()
    function windower.ffxi.get_mob_by_id(id)
        return {id = id, index = 4321, distance = 9999}
    end


    local lock = LockFactory.CreateLock(0, 1)
    LuaUnit.assertEquals(lock:Type(), 'NilLock')
end


--------------------------------------------------------------------------------
function LockFactoryTests:TestNpcLockCreatedWhenValidIdPassed()
    local lock = LockFactory.CreateLock(0, 1)
    LuaUnit.assertEquals(lock:Type(), 'GameLock')
end

LuaUnit.LuaUnit.run('LockFactoryTests')