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

--------------------------------------------------------------------------------
local function OnCommandFailure()
    command = NilCommand:NilCommand()
    log('Done')
end

--------------------------------------------------------------------------------
local function OnCommandSuccess()
    if command:Type() == 'UseCommand' then
        command = CommandFactory.CreateCommand('use', unpack(command:RawParams()))
        command:SetSuccessCallback(OnCommandSuccess)
        command:SetFailureCallback(OnCommandFailure)
        command()
    else
        OnCommandFailure()
    end
end

--------------------------------------------------------------------------------
local function OnLoad()
    settings.load()
    Aliases.Update()
end

--------------------------------------------------------------------------------
local function OnZoneChange()
    Aliases.Update()
end

--------------------------------------------------------------------------------
local function OnCommand(cmd, name)
    if command:Type() == 'NilCommand' then
        command = CommandFactory.CreateCommand(cmd, name)
        command:SetSuccessCallback(OnCommandSuccess)
        command:SetFailureCallback(OnCommandFailure)
        command()
    else
        log('Already running a command')
    end
end

--------------------------------------------------------------------------------
local function OnIncomingData(id, _, pkt, b, i)
    return command:OnIncomingData(id, pkt)
end

--------------------------------------------------------------------------------
windower.register_event('load', OnLoad)
windower.register_event('zone change', OnZoneChange)
windower.register_event('addon command', OnCommand)
windower.register_event('incoming chunk', OnIncomingData)