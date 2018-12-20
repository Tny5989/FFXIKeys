_addon.name = 'FFXIKeys'
_addon.author = 'Areint/Alzade'
_addon.version = '2.0.1'
_addon.commands = {'keys'}

--------------------------------------------------------------------------------
require('logger')
settings = require('util/settings')
resources = require('resources')

local CommandFactory = require('command/factory')
local Aliases = require('util/aliases')
local NilCommand = require('command/nil')

--------------------------------------------------------------------------------
local command = NilCommand:NilCommand()

--------------------------------------------------------------------------------
local function OnCommandFinished()
    command = NilCommand:NilCommand()
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
        command:SetSuccessCallback(OnCommandFinished)
        command:SetFailureCallback(OnCommandFinished)
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