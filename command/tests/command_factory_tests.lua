local LuaUnit = require('luaunit')
local CommandFactory = require('command/command_factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
CommandFactoryTests = {}

--------------------------------------------------------------------------------
function CommandFactoryTests:SetUp()
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
function CommandFactoryTests:TestNilCommandCreatedWhenBadCommand()
    local c = CommandFactory.CreateCommand(nil, '', '')
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestNilCommandCreatedWhenUnknownCommand()
    local c = CommandFactory.CreateCommand('', '', '')
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestNilCommandCreatedWhenNilUnlockParams()
    local c = CommandFactory.CreateCommand('unlock', '')
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
    c = CommandFactory.CreateCommand('unlock', nil, '')
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
    c = CommandFactory.CreateCommand('unlock')
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestNilCommandCreatedWhenNilBuyParams()
    local c = CommandFactory.CreateCommand('buy', '', '')
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
    c = CommandFactory.CreateCommand('buy', '', nil, '')
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
    c = CommandFactory.CreateCommand('buy', nil, '', '')
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
    c = CommandFactory.CreateCommand('buy')
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestUnlockCommmandCreatedForUnlock()
    local c = CommandFactory.CreateCommand('unlock', 0, 0)
    LuaUnit.assertEquals(c:Type(), 'UnlockCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestStopCommandCreatedForStop()
    local c = CommandFactory.CreateCommand('stop', 0, 0)
    LuaUnit.assertEquals(c:Type(), 'StopCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestBuyCommandCreatedForBuy()
    local c = CommandFactory.CreateCommand('buy', 0, 0, 1)
    LuaUnit.assertEquals(c:Type(), 'BuyCommand')
end


LuaUnit.LuaUnit.run('CommandFactoryTests')