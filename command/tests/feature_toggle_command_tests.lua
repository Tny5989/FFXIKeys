local LuaUnit = require('luaunit')
local FeatureToggleCommand = require('command/feature_toggle_command')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
FeatureToggleCommandTests = {}

--------------------------------------------------------------------------------
function FeatureToggleCommandTests:SetUp()
    settings = {}
    settings.config = {printlinks = false, openlinks = false }

    settings.count = 0
    function settings.save()
        settings.count = settings.count + 1
    end
end

--------------------------------------------------------------------------------
function FeatureToggleCommandTests:TestFeatureToggleCommandReturnTrue()
    local u = FeatureToggleCommand:FeatureToggleCommand('printlinks')
    LuaUnit.assertTrue(u())
end

--------------------------------------------------------------------------------
function FeatureToggleCommandTests:TestFeatureToggleCommandWindowerRequirement()
    windower = nil
    FeatureToggleCommand:FeatureToggleCommand('printlinks')()
end

--------------------------------------------------------------------------------
function FeatureToggleCommandTests:TestFeatureToggleCommandUpdatesSettings()
    FeatureToggleCommand:FeatureToggleCommand('printlinks')()
    LuaUnit.assertTrue(settings.config.printlinks)
    LuaUnit.assertFalse(settings.config.openlinks)

    settings.config.printlinks = false

    FeatureToggleCommand:FeatureToggleCommand('openlinks')()
    LuaUnit.assertFalse(settings.config.printlinks)
    LuaUnit.assertTrue(settings.config.openlinks)
end

--------------------------------------------------------------------------------
function FeatureToggleCommandTests:TestFeatureToggleCommandSavesSettings()
    FeatureToggleCommand:FeatureToggleCommand('printlinks')()
    LuaUnit.assertEquals(settings.count, 1)
end

--------------------------------------------------------------------------------
function FeatureToggleCommandTests:TestFeatureToggleCommandDoesNotUpdateState()
    local state = {}
    FeatureToggleCommand:FeatureToggleCommand('printlinks')(state)
    LuaUnit.assertEquals(state, {})
end

--------------------------------------------------------------------------------
function FeatureToggleCommandTests:TestTypeIsFeatureToggleCommand()
    local u = FeatureToggleCommand:FeatureToggleCommand()
    LuaUnit.assertEquals(u:Type(), 'FeatureToggleCommand')
end

LuaUnit.LuaUnit.run('FeatureToggleCommandTests')