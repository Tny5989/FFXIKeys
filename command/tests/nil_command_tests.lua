local LuaUnit = require('luaunit')
local NilCommand = require('command/nil_command')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NilCommandTests = {}

--------------------------------------------------------------------------------
function NilCommandTests:TestNilCommandReturnFalse()
    local c = NilCommand:NilCommand()
    LuaUnit.assertFalse(c())
end

--------------------------------------------------------------------------------
function NilCommandTests:TestNilCommandWindowerRequirement()
    windower = nil
    NilCommand:NilCommand()()
end

--------------------------------------------------------------------------------
function NilCommandTests:TestNilCommandSettingsRequirement()
    settings = nil
    NilCommand:NilCommand()()
end

--------------------------------------------------------------------------------
function NilCommandTests:TestNilCommandDoesNotUpdateState()
    local state = {}
    NilCommand:NilCommand()(state)
    LuaUnit.assertEquals(state, {})
end

--------------------------------------------------------------------------------
function NilCommandTests:TestTypeIsNilCommand()
    local u = NilCommand:NilCommand()
    LuaUnit.assertEquals(u:Type(), 'NilCommand')
end

LuaUnit.LuaUnit.run('NilCommandTests')