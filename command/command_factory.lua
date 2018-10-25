local BuyCommand = require('command/buy_command')
local NilCommand = require('command/nil_command')
local StopCommand = require('command/stop_command')
local UnlockCommand = require('command/unlock_command')
local Keys = require('data/keys')
local Locks = require('data/locks')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local CommandFactory = {}

--------------------------------------------------------------------------------
function CommandFactory.CreateCommand(cmd, p1, p2)
    if not cmd then
        return NilCommand:NilCommand()
    end

    if cmd == 'stop' then
        return CommandFactory._create_stop_command()
    elseif cmd == 'unlock' then
        return CommandFactory._create_unlock_command(p1)
    elseif cmd == 'buy' then
        return CommandFactory._create_buy_command(p1, p2)
    end

    return NilCommand:NilCommand()
end

--------------------------------------------------------------------------------
function CommandFactory._create_stop_command()
    return StopCommand:StopCommand()
end

--------------------------------------------------------------------------------
function CommandFactory._create_unlock_command(key_str)
    if not key_str and log then
        log('Using Default Key')
    end

    local key = Keys.GetKey(key_str and key_str or settings.config.key)
    local lock = Locks.GetLockByZone(CommandFactory._get_current_zone(), false)
    return UnlockCommand:UnlockCommand(key.id, lock.id)
end

--------------------------------------------------------------------------------
function CommandFactory._create_buy_command(key_str, count_str)
    if not key_str and log then
        log('Using Default Key')
    end

    local key = Keys.GetKey(key_str and key_str or settings.config.key)
    local lock = Locks.GetLockByZone(CommandFactory._get_current_zone(), true)
    local count = count_str and tonumber(count_str) or nil
    return BuyCommand:BuyCommand(key.id, lock.id, key.option, lock.menu, lock.zone, count)
end

--------------------------------------------------------------------------------
function CommandFactory._get_current_zone()
    local info = windower.ffxi.get_info()
    return info and info.zone or 0
end

return CommandFactory
