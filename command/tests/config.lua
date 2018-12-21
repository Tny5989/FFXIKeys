local LuaUnit = require('luaunit')
local ConfigCommand = require('command/config')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ConfigCommandTests = {}

--------------------------------------------------------------------------------
function ConfigCommandTests:SetUp()
    settings = {}
    settings.config = {}
    settings.config.test = false
end

--------------------------------------------------------------------------------
function ConfigCommandTests:TestConfigIsUpdated()
    local c = ConfigCommand:ConfigCommand('test', true)
    c()
    LuaUnit.assertTrue(settings.config.test)
end

--------------------------------------------------------------------------------
function ConfigCommandTests:TestTypeIsConfigCommand()
    local c = ConfigCommand:ConfigCommand()
    LuaUnit.assertEquals(c:Type(), 'ConfigCommand')
end

LuaUnit.LuaUnit.run('ConfigCommandTests')