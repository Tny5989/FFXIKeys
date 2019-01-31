local Logger = require('util/logger/logger')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local NilLogger = Logger:Logger()
NilLogger.__index = NilLogger

--------------------------------------------------------------------------------
function NilLogger:NilLogger()
    local o = Logger:Logger('', '', 'a+')
    setmetatable(o, self)
    o._type = 'NilLogger'
    return o
end

--------------------------------------------------------------------------------
function NilLogger:Log(_)
end

--------------------------------------------------------------------------------
function NilLogger:Flush()
end

--------------------------------------------------------------------------------
function NilLogger:_CreatePath()
end

return NilLogger
