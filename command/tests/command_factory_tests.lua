local LuaUnit = require('luaunit')
local CommandFactory = require('command/command_factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
CommandFactoryTests = {}

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
function CommandFactoryTests:TestUnlockCommmandCreatedForUnlock()
    local c = CommandFactory.CreateCommand('unlock', 0, 0)
    LuaUnit.assertEquals(c:Type(), 'UnlockCommand')
end

function CommandFactoryTests:TestStopCommandCreatedForStop()
    local c = CommandFactory.CreateCommand('stop', 0, 0)
    LuaUnit.assertEquals(c:Type(), 'StopCommand')
end

LuaUnit.LuaUnit.run('CommandFactoryTests')