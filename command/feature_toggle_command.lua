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

    if log then
        log(self._setting .. ' is ' .. (settings.config[self._setting] and 'off' or 'on'))
    end

    return true
end

return FeatureToggleCommand
