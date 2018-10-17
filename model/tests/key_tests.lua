local LuaUnit = require('luaunit')
local Key = require('model/key')

KeyTests = {}

function KeyTests:TestGetValidKeyId()
    local key = Key:Key('spgobbiekey')
    LuaUnit.assertEquals(key:GetItem(), 8973)
end

function KeyTests:TestGetNullKeyId()
    local key = Key:Key('')
    LuaUnit.assertEquals(key:GetItem(), 0)
end

function KeyTests:TestGetInvalidKeyId()
    local key = Key:Key('test 1 2 3')
    LuaUnit.assertEquals(key:GetItem(), 0)
end

LuaUnit.LuaUnit.run('KeyTests')