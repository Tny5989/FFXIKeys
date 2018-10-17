local LuaUnit = require('luaunit')
local KeyFactory = require('model/key/key_factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
KeyFactoryTests = {}

--------------------------------------------------------------------------------
function KeyFactoryTests:TestNilKeyCreatedWhenBadParam()
    local key = KeyFactory.CreateKey()
    LuaUnit.assertEquals(key:Type(), 'NilKey')
end

--------------------------------------------------------------------------------
function KeyFactoryTests:TestItemKeyCreatedWhenValidIdPassed()
    local key = KeyFactory.CreateKey(0)
    LuaUnit.assertEquals(key:Type(), 'ItemKey')
end

LuaUnit.LuaUnit.run('KeyFactoryTests')