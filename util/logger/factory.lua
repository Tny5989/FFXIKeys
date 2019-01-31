local DiagnosticLogger = require('util/logger/diagnostic')
local ItemLogger = require('util/logger/item')
local NilLogger = require('util/logger/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local LoggerFactory = {}

--------------------------------------------------------------------------------
function LoggerFactory.CreateDiagnosticLogger()
    local player = windower.ffxi.get_player()
    if not player or not player.name then
        return NilLogger:NilLogger()
    end

    return DiagnosticLogger:DiagnosticLogger(player.name)
end

--------------------------------------------------------------------------------
function LoggerFactory.CreateItemLogger()
    local player = windower.ffxi.get_player()
    if not player or not player.name then
        return NilLogger:NilLogger()
    end

    return ItemLogger:ItemLogger(player.name)
end

return LoggerFactory
