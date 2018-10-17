local LuaUnit = require('luaunit')
local MobEntity = require('model/entities/mob_entity')

MobEntityTests = {}
local mob = {}
mob.id = 1234
mob.index = 4321
mob.distance = 9999

function MobEntityTests:TestMobId()
    local entity = MobEntity:MobEntity(mob)
    LuaUnit.assertEquals(entity:GetId(), mob.id)
end

function MobEntityTests:TestMobIdWithBadData()
    local entity = MobEntity:MobEntity({})
    LuaUnit.assertEquals(entity:GetId(), 0)
end

function MobEntityTests:TestMobIndex()
    local entity = MobEntity:MobEntity(mob)
    LuaUnit.assertEquals(entity:GetIndex(), mob.index)
end

function MobEntityTests:TestMobIndexWithBadData()
    local entity = MobEntity:MobEntity({})
    LuaUnit.assertEquals(entity:GetIndex(), 0)
end

function MobEntityTests:TestMobDistance()
    local entity = MobEntity:MobEntity(mob)
    LuaUnit.assertEquals(entity:GetDistance(), mob.distance)
end

function MobEntityTests:TestMobDistanceWithBadData()
    local entity = MobEntity:MobEntity({})
    LuaUnit.assertEquals(entity:GetDistance(), MobEntity.MAX_DISTANCE)
end

function MobEntityTests:TestBagType()
    local entity = MobEntity:MobEntity(mob)
    LuaUnit.assertEquals(entity:GetBag():BagType(), 'Bag')
end

function MobEntityTests:TestBagTypeWithBadData()
    local entity = MobEntity:MobEntity({})
    LuaUnit.assertEquals(entity:GetBag():BagType(), 'Bag')
end

LuaUnit.LuaUnit.run('MobEntityTests')