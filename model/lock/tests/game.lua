local LuaUnit = require('luaunit')
local EntityFactory = require('model/entity/factory')
local GameLock = require('model/lock/game')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
GameLockTests = {}

--------------------------------------------------------------------------------
function GameLockTests:SetUp()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_mob_by_id(id)
        return {id = id, index = 4321, distance = 9999}
    end
end

--------------------------------------------------------------------------------
function GameLockTests:TestNpcIdIsCorrect()
    local lock = GameLock:GameLock(1234, 4321, EntityFactory.CreateMob(1234))
    LuaUnit.assertEquals(lock:Npc(), 1234)
end

--------------------------------------------------------------------------------
function GameLockTests:TestNpcIndexIsCorrect()
    local entity = EntityFactory.CreateMob(1234)
    local lock = GameLock:GameLock(1234, 4321, entity)
    LuaUnit.assertEquals(lock:Entity(), entity)
end

--------------------------------------------------------------------------------
function GameLockTests:TestMenuIsCorrect()
    local lock = GameLock:GameLock(1234, 4321, EntityFactory.CreateMob(1234))
    LuaUnit.assertEquals(lock:Menu(), 4321)
end

--------------------------------------------------------------------------------
function GameLockTests:TestTypeIsGameLock()
    local lock = GameLock:GameLock(1234, 4321, EntityFactory.CreateMob(1234))
    LuaUnit.assertEquals(lock:Type(), 'GameLock')
end

LuaUnit.LuaUnit.run('GameLockTests')