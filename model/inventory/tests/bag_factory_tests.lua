local LuaUnit = require('luaunit')
local BagFactory = require('model/inventory/bag_factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
BagFactoryTests = {}

--------------------------------------------------------------------------------
function BagFactoryTests:TestNilBagCreatedWhenBadNumPassed()
    local b = BagFactory.CreateBag(nil)
    LuaUnit.assertEquals(b:Type(), 'NilBag')
end

--------------------------------------------------------------------------------
function BagFactoryTests:TestNilBagCreatedWhenUnableToObtainInventory()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_items()
        return nil
    end

    local b = BagFactory.CreateBag(0)
    LuaUnit.assertEquals(b:Type(), 'NilBag')
end

--------------------------------------------------------------------------------
function BagFactoryTests:TestPlayerBagCreatedWhenInventoryObtained()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_items()
        return {max = 0, count = 0}
    end

    local b = BagFactory.CreateBag(0)
    LuaUnit.assertEquals(b:Type(), 'PlayerBag')
end

LuaUnit.LuaUnit.run('BagFactoryTests')