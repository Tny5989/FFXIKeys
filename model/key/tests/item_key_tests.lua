local LuaUnit = require('luaunit')
local ItemKey = require('model/key/item_key')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ItemKeyTests = {}

--------------------------------------------------------------------------------
function ItemKeyTests:TestItemIdIsCorrect()
    local key = ItemKey:ItemKey(1234)
    LuaUnit.assertEquals(key:Item(), 1234)
end

--------------------------------------------------------------------------------
function ItemKeyTests:TestTypeIsItemKey()
    local key = ItemKey:ItemKey(1234)
    LuaUnit.assertEquals(key:Type(), 'ItemKey')
end

LuaUnit.LuaUnit.run('ItemKeyTests')