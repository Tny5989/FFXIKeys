local Bag = {}
Bag.__index = Bag

function Bag:Bag()
    local o = {}
    setmetatable(o, self)
    return o
end

function Bag:GetOpenInv()
    return 0
end

function Bag:GetNumItems(item_id)
    return 0
end

function Bag:GetItemIndex(item_id)
    return -1
end

return Bag
