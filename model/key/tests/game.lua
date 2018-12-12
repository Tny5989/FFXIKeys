local LuaUnit = require('luaunit')
local EntityFactory = require('model/entity/factory')
local GameKey = require('model/key/game')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
GameKeyTests = {}

--------------------------------------------------------------------------------
function GameKeyTests:SetUp()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_player()
        return {id = 1234}
    end
    function windower.ffxi.get_mob_by_id(id)
        return {id = id, index = 4321, distance = 9999}
    end
    function windower.ffxi.get_items()
        return {max = 2, count = 2, [1] = {id = 1, count = 1}, [2] = {id = 2, count = 4} }
    end
end

--------------------------------------------------------------------------------
function GameKeyTests:TestItemIdIsCorrect()
    local key = GameKey:GameKey(1234, 4321, EntityFactory.CreatePlayer())
    LuaUnit.assertEquals(key:Item(), 1234)
end

--------------------------------------------------------------------------------
function GameKeyTests:TestOptionIsCorrect()
    local key = GameKey:GameKey(1234, 4321, EntityFactory.CreatePlayer())
    LuaUnit.assertEquals(key:Option(), 4321)
end

--------------------------------------------------------------------------------
function GameKeyTests:TestItemIndexIsCorrect()
    local entity = EntityFactory.CreatePlayer()
    local key = GameKey:GameKey(2, 1, entity)
    LuaUnit.assertEquals(key:Entity(), entity)
end

--------------------------------------------------------------------------------
function GameKeyTests:TestTypeIsGameKey()
    local key = GameKey:GameKey(1234, 3, EntityFactory.CreatePlayer())
    LuaUnit.assertEquals(key:Type(), 'GameKey')
end

LuaUnit.LuaUnit.run('GameKeyTests')