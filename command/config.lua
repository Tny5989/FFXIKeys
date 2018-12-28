local NilCommand = require('command/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local ConfigCommand = NilCommand:NilCommand()
ConfigCommand.__index = ConfigCommand

--------------------------------------------------------------------------------
function ConfigCommand:ConfigCommand(setting)
    local o = NilCommand:NilCommand()
    setmetatable(o, self)
    o._setting = tostring(setting)
    o._type = 'ConfigCommand'
    return o
end

--------------------------------------------------------------------------------
function ConfigCommand:__call(_)
    settings.config[self._setting] = not settings.config[self._setting]
    settings.save()
    return true
end

return ConfigCommand
