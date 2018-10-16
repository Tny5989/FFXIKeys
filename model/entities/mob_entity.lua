local Entity = require('model/entities/entity')

local MobEntity = Entity:Entity()
MobEntity.__index = MobEntity

function MobEntity:MobEntity(mob)
    local o = {}
    setmetatable(o, self)
    o._distance = mob.distance
    o._id = mob.id
    o._index = mob.index
    return o
end

return MobEntity
