local BagFactory = require('model/bags/bag_factory')
local Entity = require('model/entities/entity')

local PlayerEntity = Entity:Entity()
PlayerEntity.__index = PlayerEntity

function PlayerEntity:PlayerEntity(mob)
    local o = {}
    setmetatable(o, self)
    o._bag = BagFactory.GetBag(0)
    o._distance = 0
    o._id = mob.id
    o._index = mob.index
    return o
end

return PlayerEntity
