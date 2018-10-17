local LuaUnit = require('luaunit')
local PlayerBag = require('model/inventory/player_bag')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
PlayerBagTests = {}

--------------------------------------------------------------------------------
function PlayerBagTests:TestFreeSpaceIsCorrectWhenSlotsFree()
    local items = {max = 2, count = 1}
    local b = PlayerBag:PlayerBag(items)
    LuaUnit.assertEquals(b:FreeSlots(), 1)
end

--------------------------------------------------------------------------------
function PlayerBagTests:TestFreeSpaceIsCorrectWhenFull()
    local items = {max = 1, count = 1}
    local b = PlayerBag:PlayerBag(items)
    LuaUnit.assertEquals(b:FreeSlots(), 0)
end

--------------------------------------------------------------------------------
function PlayerBagTests:TestItemCountIsZeroWhenNoItems()
    local items = {max = 1, count = 1}
    local b = PlayerBag:PlayerBag(items)
    LuaUnit.assertEquals(b:ItemCount(0), 0)
end

--------------------------------------------------------------------------------
function PlayerBagTests:TestItemCountIsAccurateWhenLtOneStack()
    local items = {max = 1, count = 1, [1] = {id = 1, count = 12}}
    local b = PlayerBag:PlayerBag(items)
    LuaUnit.assertEquals(b:ItemCount(1), 12)
end

--------------------------------------------------------------------------------
function PlayerBagTests:TestItemCountIsAccurateWhenMultipleStacks()
    local items = {max = 3, count = 3, [1] = {id = 1, count = 12}, [2] = {id = 1, count = 8}, [3] = {id = 2, count = 4}}
    local b = PlayerBag:PlayerBag(items)
    LuaUnit.assertEquals(b:ItemCount(1), 20)
end

--------------------------------------------------------------------------------
function PlayerBagTests:TestItemIndexIsInvalidWhenNoItems()
    local items = {max = 1, count = 1}
    local b = PlayerBag:PlayerBag(items)
    LuaUnit.assertEquals(b:ItemIndex(0), PlayerBag.INVALID_INDEX)
end

--------------------------------------------------------------------------------
function PlayerBagTests:TestItemIndexIsIndexOfFirstStackFound()
    local items = {max = 10, count = 3, [1] = {id = 1, count = 2}, [2] = {id = 2, count = 4}}
    local b = PlayerBag:PlayerBag(items)
    LuaUnit.assertEquals(b:ItemIndex(1), 1)
end

--------------------------------------------------------------------------------
function PlayerBagTests:TestTypeIsNilBag()
    local b = PlayerBag:PlayerBag()
    LuaUnit.assertEquals(b:Type(), 'PlayerBag')
end

LuaUnit.LuaUnit.run('PlayerBagTests')