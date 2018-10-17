local LuaUnit = require('luaunit')
local PlayerBag = require('model/bags/player_bag')

PlayerBagTests = {}
local items_full = {}
items_full.max = 3
items_full.count = 3
items_full[1] = {id = 1, count = 1}
items_full[2] = {id = 2, count = 12}
items_full[3] = {id = 2, count = 4}

local items_open = {}
items_open.max = 2
items_open.count = 1
items_open[1] = {id = 1, count = 1 }

function PlayerBagTests:TestBagType()
    local bag = PlayerBag:Bag()
    LuaUnit.assertEquals(bag:BagType(), 'PlayerBag')
end

function PlayerBagTests:TestNoOpenInvSlots()
    local bag = PlayerBag:PlayerBag(items_full)
    LuaUnit.assertEquals(bag:GetOpenInv(), 0)
end

function PlayerBagTests:TestOpenInvSlots()
    local bag = PlayerBag:PlayerBag(items_open)
    LuaUnit.assertEquals(bag:GetOpenInv(), 1)
end

function PlayerBagTests:TestGetNumItemsForUnknownItem()
    local bag = PlayerBag:PlayerBag(items_full)
    LuaUnit.assertEquals(bag:GetNumItems(0), 0)
end

function PlayerBagTests:TestGetNumItemsForKnownItem()
    local bag = PlayerBag:PlayerBag(items_full)
    LuaUnit.assertEquals(bag:GetNumItems(1), 1)
    LuaUnit.assertEquals(bag:GetNumItems(2), 16)
end

function PlayerBagTests:TestGetItemIndexForUnknownItem()
    local bag = PlayerBag:PlayerBag(items_full)
    LuaUnit.assertEquals(bag:GetItemIndex(0), PlayerBag.INVALID_ITEM_INDEX)
end

function PlayerBagTests:TestGetItemIndexForKnownItem()
    local bag = PlayerBag:PlayerBag(items_full)
    LuaUnit.assertEquals(bag:GetItemIndex(1), 1)
    LuaUnit.assertEquals(bag:GetItemIndex(2), 2)
end

LuaUnit.LuaUnit.run('PlayerBagTests')