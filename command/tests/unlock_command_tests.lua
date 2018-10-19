local LuaUnit = require('luaunit')
local UnlockCommand = require('command/unlock_command')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
UnlockCommandTests = {}

--------------------------------------------------------------------------------
function UnlockCommandTests:SetUp()
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
function UnlockCommandTests:TestUnlockCommandReturnTrue()
    local state = {}
    local u = UnlockCommand:UnlockCommand(0, 1234)
    LuaUnit.assertTrue(u(state))
end

--------------------------------------------------------------------------------
function UnlockCommandTests:TestUnlockCommandUpdatesStateWhenGood()
    local state = {}
    local c = UnlockCommand:UnlockCommand(1, 1234)
    c(state)
    LuaUnit.assertEquals(state, {running = true, command = c})
end

--------------------------------------------------------------------------------
function UnlockCommandTests:TestUnlockCommandUpdatesStateWhenBad()
    local state = {}
    local c = UnlockCommand:UnlockCommand(0, 1234)
    c(state)
    LuaUnit.assertEquals(state, {running = false, command = c})
end

--------------------------------------------------------------------------------
function UnlockCommandTests:TestTypeIsUnlockCommand()
    local u = UnlockCommand:UnlockCommand(1, 1234)
    LuaUnit.assertEquals(u:Type(), 'UnlockCommand')
end

LuaUnit.LuaUnit.run('UnlockCommandTests')