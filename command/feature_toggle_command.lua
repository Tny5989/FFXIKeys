local NilCommand = require('command/nil_command')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local FeatureToggleCommand = NilCommand:NilCommand()
FeatureToggleCommand.__index = FeatureToggleCommand

--------------------------------------------------------------------------------
function FeatureToggleCommand:FeatureToggleCommand(setting)
    local o = {}
    setmetatable(o, self)
    o._setting = setting
    o._type = 'FeatureToggleCommand'
    return o
end

--------------------------------------------------------------------------------
function FeatureToggleCommand:__call(state)
    settings.config[self._setting] = not settings.config[self._setting]
    settings.save()
    return true
end

return FeatureToggleCommand
