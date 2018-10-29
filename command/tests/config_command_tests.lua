local LuaUnit = require('luaunit')
local ConfigCommand = require('command/config_command')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ConfigCommandTests = {}

--------------------------------------------------------------------------------
function ConfigCommandTests:SetUp()
    settings = {}
    settings.config = {}
    settings.config.printlinks = false
    settings.config.openlinks = false

    settings.save_count = 0
    function settings.save()
        settings.save_count = settings.save_count + 1
    end

    settings.load_count = 0
    function settings.load()
        settings.load_count = settings.load_count + 1
    end
end

--------------------------------------------------------------------------------
function ConfigCommandTests:TestConfigCommandReturnTrue()
    local state = {}
    local c = ConfigCommand:ConfigCommand('printlinks')
    LuaUnit.assertTrue(c(state))
end

--------------------------------------------------------------------------------
function ConfigCommandTests:TestConfigIsUpdated()
    local state = {}
    local c = ConfigCommand:ConfigCommand('printlinks')
    c(state)
    LuaUnit.assertTrue(settings.config.printlinks)
end

--------------------------------------------------------------------------------
function ConfigCommandTests:TestUnrelatedSettingsAreUnchanged()
    local state = {}
    local c = ConfigCommand:ConfigCommand('printlinks')
    c(state)
    LuaUnit.assertFalse(settings.config.openlinks)
end

--------------------------------------------------------------------------------
function ConfigCommandTests:TestSettingsAreSaved()
    local state = {}
    local c = ConfigCommand:ConfigCommand('printlinks')
    c(state)
    LuaUnit.assertEquals(1, settings.save_count)
end

--------------------------------------------------------------------------------
function ConfigCommandTests:TestStateIsNotRequired()
    local c = ConfigCommand:ConfigCommand('printlinks')
    LuaUnit.assertTrue(c(nil))
end

--------------------------------------------------------------------------------
function ConfigCommandTests:TestTypeIsConfigCommand()
    local c = ConfigCommand:ConfigCommand(1, 1234)
    LuaUnit.assertEquals(c:Type(), 'ConfigCommand')
end

LuaUnit.LuaUnit.run('ConfigCommandTests')