local LuaUnit = require('luaunit')
local NilBag = require('model/inventory/nil_bag')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NilBagTests = {}

--------------------------------------------------------------------------------
function NilBagTests:TestDefaultFreeSpaceIsZero()
    local b = NilBag:NilBag()
    LuaUnit.assertEquals(b:FreeSlots(), 0)
end

--------------------------------------------------------------------------------
function NilBagTests:TestItemCountIsZero()
    local b = NilBag:NilBag()
    LuaUnit.assertEquals(b:ItemCount(), 0)
    LuaUnit.assertEquals(b:ItemCount(0), 0)
    LuaUnit.assertEquals(b:ItemCount(8973), 0)
end

--------------------------------------------------------------------------------
function NilBagTests:TestItemIndexIsInvalid()
    local b = NilBag:NilBag()
    LuaUnit.assertEquals(b:ItemIndex(), NilBag.INVALID_INDEX)
    LuaUnit.assertEquals(b:ItemIndex(0), NilBag.INVALID_INDEX)
    LuaUnit.assertEquals(b:ItemIndex(8973), NilBag.INVALID_INDEX)
end

--------------------------------------------------------------------------------
function NilBagTests:TestTypeIsNilBag()
    local b = NilBag:NilBag()
    LuaUnit.assertEquals(b:Type(), 'NilBag')
end

LuaUnit.LuaUnit.run('NilBagTests')