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
local FileLogger = require('util/logger')
local NilCommand = require('command/nil')

--------------------------------------------------------------------------------
local command = NilCommand:NilCommand()

--------------------------------------------------------------------------------
local function OnReward(reward)
    if reward then
        if settings.config.printlinks then
            log('https://www.ffxiah.com/item/' .. reward .. '/')
        end
        if settings.config.openlinks then
            windower.open_url('https://www.ffxiah.com/item/' .. reward .. '/')
        end
        if settings.config.logitems then
            FileLogger.AddItem(reward)
        end
    end
end

--------------------------------------------------------------------------------
local function OnCommandSuccess(reward)
    if settings.config.loop then
        command:Reset()
        command()
    else
        command = NilCommand:NilCommand()
        FileLogger.Flush()
    end

    OnReward(reward)
end

--------------------------------------------------------------------------------
local function OnCommandFailure()
    command = NilCommand:NilCommand()
    FileLogger.Flush()
end

--------------------------------------------------------------------------------
local function OnLoad()
    settings.load()
    Aliases.Update()
end

--------------------------------------------------------------------------------
local function OnIncomingData(id, _, pkt, b, i)
    return command:OnIncomingData(id, pkt)
end

--------------------------------------------------------------------------------
local function OnOutgoingData(id, _, pkt, b, i)
    return command:OnOutgoingData(id, pkt)
end

--------------------------------------------------------------------------------
local function OnCommand(cmd, name)
    local new_command = CommandFactory.CreateCommand(cmd, name)
    if new_command:IsSimple() then
        new_command()
    elseif command:IsSimple() then
        command = new_command
        command:SetSuccessCallback(OnCommandSuccess)
        command:SetFailureCallback(OnCommandFailure)
        command()
    else
        log('Already running a complex command')
    end
end

--------------------------------------------------------------------------------
windower.register_event('load', OnLoad)
windower.register_event('zone change', OnLoad)
windower.register_event('addon command', OnCommand)
windower.register_event('incoming chunk', OnIncomingData)
windower.register_event('outgoing chunk', OnOutgoingData)