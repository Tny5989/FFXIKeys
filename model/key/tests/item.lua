local LuaUnit = require('luaunit')
local ItemKey = require('model/key/item')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ItemKeyTests = {}

--------------------------------------------------------------------------------
function ItemKeyTests:TestItemIdIsCorrect()
    local key = ItemKey:ItemKey(1234, 4321)
    LuaUnit.assertEquals(key:Item(), 1234)
end

--------------------------------------------------------------------------------
function ItemKeyTests:TestOptionIsCorrect()
    local key = ItemKey:ItemKey(1234, 4321)
    LuaUnit.assertEquals(key:Option(), 4321)
end

--------------------------------------------------------------------------------
function ItemKeyTests:TestEntityIsNil()
    local key = ItemKey:ItemKey(1234, 4321)
    LuaUnit.assertEquals(key:Entity():Type(), 'NilEntity')
end

--------------------------------------------------------------------------------
function ItemKeyTests:TestTypeIsItemKey()
    local key = ItemKey:ItemKey(1234, 4321)
    LuaUnit.assertEquals(key:Type(), 'ItemKey')
end

LuaUnit.LuaUnit.run('ItemKeyTests')