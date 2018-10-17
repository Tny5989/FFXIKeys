local Bag = {}
Bag.__index = Bag
Bag.INVALID_ITEM_INDEX = -1

function Bag:Bag()
    local o = {}
    setmetatable(o, self)
    return o
end

function Bag:BagType()
    return 'Bag'
end

function Bag:GetOpenInv()
    return 0
end

function Bag:GetNumItems(item_id)
    return 0
end

function Bag:GetItemIndex(item_id)
    return Bag.INVALID_ITEM_INDEX
end

return Bag
