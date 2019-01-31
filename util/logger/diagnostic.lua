local Logger = require('util/logger/logger')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local DiagnosticLogger = Logger:Logger()
DiagnosticLogger.__index = DiagnosticLogger

--------------------------------------------------------------------------------
function DiagnosticLogger:DiagnosticLogger(character)
    local o = Logger:Logger(character, 'diagnostics.log', 'a+')
    setmetatable(o, self)
    o._type = 'DiagnosticLogger'
    return o
end

--------------------------------------------------------------------------------
function DiagnosticLogger:Log(...)
    Logger.Log(self, ...)
    self:Flush()
end

--------------------------------------------------------------------------------
function DiagnosticLogger:_WriteCache(handle)
    for i = 1, #self._cache do
        handle:write(self._cache[i] .. '\n')
    end
end

return DiagnosticLogger
