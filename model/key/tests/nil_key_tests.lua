local LuaUnit = require('luaunit')
local NilKey = require('model/key/nil_key')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NilKeyTests = {}

--------------------------------------------------------------------------------
function NilKeyTests:TestItemIdIsZero()
    local key = NilKey:NilKey()
    LuaUnit.assertEquals(key:Item(), 0)
end

--------------------------------------------------------------------------------
function NilKeyTests:TestEntityIsNil()
    local key = NilKey:NilKey()
    LuaUnit.assertEquals(key:Entity():Type(), 'NilEntity')
end

--------------------------------------------------------------------------------
function NilKeyTests:TestTypeIsNilKey()
    local key = NilKey:NilKey()
    LuaUnit.assertEquals(key:Type(), 'NilKey')
end

LuaUnit.LuaUnit.run('NilKeyTests')