local LuaUnit = require('luaunit')
local KeyFactory = require('model/key/key_factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
KeyFactoryTests = {}

--------------------------------------------------------------------------------
function KeyFactoryTests:SetUp()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_player()
        return {id = 1234}
    end
    function windower.ffxi.get_mob_by_id(id)
        return {id = id, index = 4321, distance = 9999}
    end
    function windower.ffxi.get_items()
        return {max = 3, count = 2, [1] = {id = 1, count = 1}, [2] = {id = 2, count = 4} }
    end
end

--------------------------------------------------------------------------------
function KeyFactoryTests:TestNilKeyCreatedWhenBadParam()
    local key = KeyFactory.CreateKey()
    LuaUnit.assertEquals(key:Type(), 'NilKey')
end

--------------------------------------------------------------------------------
function KeyFactoryTests:TestNilKeyCreatedWhenBadPlayer()
    function windower.ffxi.get_player()
        return nil
    end

    local key = KeyFactory.CreateKey()
    LuaUnit.assertEquals(key:Type(), 'NilKey')
end

--------------------------------------------------------------------------------
function KeyFactoryTests:TestGameKeyCreatedWhenInvFull()
    function windower.ffxi.get_items()
        return {max = 2, count = 2, [1] = {id = 1, count = 1}, [2] = {id = 2, count = 4} }
    end

    local key = KeyFactory.CreateKey(1)
    LuaUnit.assertEquals(key:Type(), 'GameKey')
end

--------------------------------------------------------------------------------
function KeyFactoryTests:TestGameKeyCreatedWhenNoKeys()
    local key = KeyFactory.CreateKey(5)
    LuaUnit.assertEquals(key:Type(), 'GameKey')
end

--------------------------------------------------------------------------------
function KeyFactoryTests:TestGameKeyCreatedWhenValidIdPassed()
    local key = KeyFactory.CreateKey(1)
    LuaUnit.assertEquals(key:Type(), 'GameKey')
end

LuaUnit.LuaUnit.run('KeyFactoryTests')