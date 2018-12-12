local LuaUnit = require('luaunit')
local StopCommand = require('command/stop')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
StopCommandTests = {}

--------------------------------------------------------------------------------
function StopCommandTests:SetUp()
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
function StopCommandTests:TestStopCommandReturnTrue()
    local state = {}
    local c = StopCommand:StopCommand()
    LuaUnit.assertTrue(c(state))
end

--------------------------------------------------------------------------------
function StopCommandTests:TestStopCommandUpdatesState()
    local state = {}
    StopCommand:StopCommand()(state)
    LuaUnit.assertEquals(state, {running = false, command = nil})
end

--------------------------------------------------------------------------------
function StopCommandTests:TestTypeIsStopCommand()
    local c = StopCommand:StopCommand()
    LuaUnit.assertEquals(c:Type(), 'StopCommand')
end

LuaUnit.LuaUnit.run('StopCommandTests')