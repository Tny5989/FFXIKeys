_addon.name = 'FFXIKeys'
_addon.author = 'Areint/Alzade'
_addon.version = '2.0.1'
_addon.commands = {'keys'}

--------------------------------------------------------------------------------
require('logger')
packets = require('packets')
settings = require('util/settings')

local CommandFactory = require('command/factory')
local Aliases = require('util/aliases')
local NilCommand = require('command/nil')

--------------------------------------------------------------------------------
local command = NilCommand:NilCommand()

-- Forward declarations
local CreateCommand
local OnCommandSuccess
local OnCommandFailure
local OnLoad
local OnZoneChange
local OnCommand
local OnIncomingData

--------------------------------------------------------------------------------
CreateCommand = function(cmd, param)
    local command = CommandFactory.CreateCommand(cmd, param)
    command:SetSuccessCallback(OnCommandSuccess)
    command:SetFailureCallback(OnCommandFailure)
    return command
end

--------------------------------------------------------------------------------
OnCommandFailure = function()
    command = NilCommand:NilCommand()
    log('Done')
end

--------------------------------------------------------------------------------
OnCommandSuccess = function()
    if command:Type() == 'UseCommand' then
        command = CreateCommand('use', command:RawParams())
        command()
    else
        OnCommandFailure()
    end
end

--------------------------------------------------------------------------------
OnLoad = function()
    settings.load()
    Aliases.Update()
end

--------------------------------------------------------------------------------
OnZoneChange = function()
    Aliases.Update()
end

--------------------------------------------------------------------------------
OnCommand = function(cmd, name)
    if command:Type() == 'NilCommand' then
        command = CreateCommand(cmd, name)
        command()
    else
        log('Already running a command')
    end
end

--------------------------------------------------------------------------------
OnIncomingData = function(id, _, pkt, b, i)
    return command:OnIncomingData(id, pkt)
end

--------------------------------------------------------------------------------
windower.register_event('load', OnLoad)
windower.register_event('zone change', OnZoneChange)
windower.register_event('addon command', OnCommand)
windower.register_event('incoming chunk', OnIncomingData)