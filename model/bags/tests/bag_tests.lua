local LuaUnit = require('luaunit')
local Bag = require('model/bags/bag')

BagTests = {}

function BagTests:TestBagType()
    local bag = Bag:Bag()
    LuaUnit.assertEquals(bag:BagType(), 'Bag')
end

function BagTests:TestNoOpenInvSlots()
    local bag = Bag:Bag()
    LuaUnit.assertEquals(bag:GetOpenInv(), 0)
end

function BagTests:TestNoItemsInBag()
    local bag = Bag:Bag()
    LuaUnit.assertEquals(bag:GetNumItems(), 0)
    LuaUnit.assertEquals(bag:GetNumItems(0), 0)
    LuaUnit.assertEquals(bag:GetNumItems(8973), 0)
end

function BagTests:TestItemIndexIsInvalid()
    local bag = Bag:Bag()
    LuaUnit.assertEquals(bag:GetItemIndex(), bag.INVALID_ITEM_INDEX)
    LuaUnit.assertEquals(bag:GetItemIndex(0), bag.INVALID_ITEM_INDEX)
    LuaUnit.assertEquals(bag:GetItemIndex(8973), bag.INVALID_ITEM_INDEX)
end

LuaUnit.LuaUnit.run('BagTests')