local Bag = require('model/bags/bag')

local PlayerBag = Bag:Bag()
PlayerBag.__index = PlayerBag

function PlayerBag:PlayerBag(bag)
    local o = {}
    setmetatable(o, self)
    o._bag = bag
    return o
end

function PlayerBag:GetOpenInv()
    return self._bag.max - self._bag.count
end

function PlayerBag:GetNumItems(item_id)
    local count = 0
    for _, item in pairs(self._bag) do
        if type(item) == 'table' and item.id == item_id then
            count = count + item.count
        end
    end
    return count
end

function PlayerBag:GetItemIndex(item_id)
    for index, item in pairs(self._bag) do
        if type(item) == 'table' and item.id == item_id then
            return index
        end
    end
    return Bag.GetItemIndex(self, item_id)
end

return PlayerBag
