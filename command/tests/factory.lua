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
    local c = CommandFactory.CreateOrRunCommand()
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestNilCommandCreatedWhenUnknownCommand()
    local c = CommandFactory.CreateOrRunCommand('unknown')
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestUseCommandCreatedWhenValidParams()
    local c = CommandFactory.CreateOrRunCommand('use', 'SP Gobbie Key')
    LuaUnit.assertEquals(c:Type(), 'UseCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestNilCommandCreatedWhenBadUseParam()
    local c = CommandFactory.CreateOrRunCommand('use', nil)
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestNilCommandCreatedWhenUnknownParam()
    local c = CommandFactory.CreateOrRunCommand('use', 'apples')
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestNilCommandCreatedWhenConfigCommand()
    local c = CommandFactory.CreateOrRunCommand('loop')
    LuaUnit.assertEquals(c:Type(), 'NilCommand')

    c = CommandFactory.CreateOrRunCommand('printlinks')
    LuaUnit.assertEquals(c:Type(), 'NilCommand')

    c = CommandFactory.CreateOrRunCommand('openlinks')
    LuaUnit.assertEquals(c:Type(), 'NilCommand')

    c = CommandFactory.CreateOrRunCommand('logitems')
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end

LuaUnit.LuaUnit.run('CommandFactoryTests')