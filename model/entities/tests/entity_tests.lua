local LuaUnit = require('luaunit')
local Entity = require('model/entities/entity')

EntityTests = {}

function EntityTests:TestDefaultId()
    local entity = Entity:Entity()
    LuaUnit.assertEquals(entity:GetId(), 0)
end

function EntityTests:TestDefaultIndex()
    local entity = Entity:Entity()
    LuaUnit.assertEquals(entity:GetIndex(), 0)
end

function EntityTests:TestDefaultDistance()
    local entity = Entity:Entity()
    LuaUnit.assertEquals(entity:GetDistance(), Entity.MAX_DISTANCE)
end

function EntityTests:TestDefaultBag()
    local entity = Entity:Entity()
    LuaUnit.assertEquals(entity:GetBag():BagType(), 'Bag')
end

LuaUnit.LuaUnit.run('EntityTests')