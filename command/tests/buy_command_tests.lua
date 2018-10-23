local LuaUnit = require('luaunit')
local BuyCommand = require('command/buy_command')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
BuyCommandTests = {}

--------------------------------------------------------------------------------
function BuyCommandTests:SetUp()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_player()
        return {id = 1234}
    end
    function windower.ffxi.get_mob_by_id(id)
        return {id = id, index = 4321, distance = 5}
    end
    function windower.ffxi.get_items()
        return {max = 3, count = 2, [1] = {id = 1, count = 1}, [2] = {id = 2, count = 4} }
    end

    packets = {}
    packets.p = nil
    function packets.new()
        return {}
    end
    function packets.inject(pkt)
        packets.p = pkt
    end

    settings = {}
    settings.config = {}
    settings.config.maxdistance = 20
end

--------------------------------------------------------------------------------
function BuyCommandTests:TestBuyCommandReturnTrue()
    local state = {}
    LuaUnit.assertEquals(BuyCommand:BuyCommand(1, 4444, 32, 23, 241, 6)(state), true)
end

--------------------------------------------------------------------------------
function BuyCommandTests:TestBuyCommandUpdatesStateWhenGood()
    local state = {}
    local c = BuyCommand:BuyCommand(1, 4444, 32, 23, 241, 6)
    c(state)
    LuaUnit.assertEquals(state, {running = true, command = c})
    c(state)
    LuaUnit.assertEquals(state, {running = false, command = c})
    c(state)
    LuaUnit.assertEquals(state, {running = false, command = c})
end

--------------------------------------------------------------------------------
function BuyCommandTests:TestBuyCommandUpdatesStateWhenBad()
    local state = {}
    local c = BuyCommand:BuyCommand(0, 1234)
    c(state)
    LuaUnit.assertEquals(state, {running = false, command = c})
end

--------------------------------------------------------------------------------
function BuyCommandTests:TestTypeIsBuyCommand()
    local c = BuyCommand:BuyCommand(1, 1234)
    LuaUnit.assertEquals(c:Type(), 'BuyCommand')
end

LuaUnit.LuaUnit.run('BuyCommandTests')