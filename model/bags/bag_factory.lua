local Bag = require('model/bags/bag')
local PlayerBag = require('model/bags/player_bag')

local BagFactory = {}
BagFactory.__index = BagFactory

function BagFactory.GetBag(bag_num)
    local bag = windower.ffxi.get_items(bag_num)
    if not bag then
        return Bag:Bag()
    else
        return PlayerBag:PlayerBag(bag)
    end
end

return BagFactory
