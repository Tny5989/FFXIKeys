local LuaUnit = require('luaunit')
local CommandFactory = require('command/factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
CommandFactoryTests = {}

--------------------------------------------------------------------------------
function CommandFactoryTests:SetUp()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_mob_by_id(id)
        return { id = id, index = 4321, distance = 9999, valid_target = true }
    end

    function windower.ffxi.get_player()
        return { id = 9999, index = 8888, distance = 0 }
    end

    function windower.ffxi.get_items()
        return { max = 0, count = 0 }
    end

    function windower.ffxi.get_info()
        return { zone = 232 }
    end

    settings = {}
    settings.config = {}
    settings.config.maxdistance = 20

    function log()
    end
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestNilCommandCreatedWhenBadCommand()
    local c = CommandFactory.CreateCommand()
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestNilCommandCreatedWhenUnknownCommand()
    local c = CommandFactory.CreateCommand('unknown')
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestUseCommandCreatedWhenValidParams()
    local c = CommandFactory.CreateCommand('use', 'SP Gobbie Key')
    LuaUnit.assertEquals(c:Type(), 'UseCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestNilCommandCreatedWhenBadUseParam()
    local c = CommandFactory.CreateCommand('use', nil)
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestNilCommandCreatedWhenUnknownParam()
    local c = CommandFactory.CreateCommand('use', 'apples')
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestConfigCommandCreatedWhenConfigCommand()
    local c = CommandFactory.CreateCommand('loop')
    LuaUnit.assertEquals(c:Type(), 'ConfigCommand')

    c = CommandFactory.CreateCommand('printlinks')
    LuaUnit.assertEquals(c:Type(), 'ConfigCommand')

    c = CommandFactory.CreateCommand('openlinks')
    LuaUnit.assertEquals(c:Type(), 'ConfigCommand')

    c = CommandFactory.CreateCommand('logitems')
    LuaUnit.assertEquals(c:Type(), 'ConfigCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestStopCommandCreatedForStop()
    local c = CommandFactory.CreateCommand('stop')
    LuaUnit.assertEquals(c:Type(), 'StopCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestNilCommandCreatedWhenUnknownParam()
    local c = CommandFactory.CreateCommand('use', 'apples')
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end

LuaUnit.LuaUnit.run('CommandFactoryTests')