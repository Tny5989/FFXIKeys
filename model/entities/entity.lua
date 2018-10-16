local Bag = require('model/bags/bag')

local Entity = {}
Entity.__index = Entity
Entity.__max_distance = 1000000

function Entity:Entity()
    local o = {}
    setmetatable(o, self)
    o._bag = Bag:Bag()
    o._distance = Entity.__max_distance
    o._id = 0
    o._index = 0
    return o
end

function Entity:GetId()
    return self._id
end

function Entity:GetIndex()
    return self._index
end

function Entity:GetDistance()
    return self._distance
end

function Entity:GetBag()
    return self._bag
end

return Entity
