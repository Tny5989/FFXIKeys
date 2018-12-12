local NilCommand = require('command/nil')
local KeyFactory = require('model/key/factory')
local LockFactory = require('model/lock/factory')
local PurchaseFactory = require('model/action/factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local BuyCommand = NilCommand:NilCommand()
BuyCommand.__index = BuyCommand

--------------------------------------------------------------------------------
function BuyCommand:BuyCommand(key_id, vendor_id, option_id, menu_id, zone_id, count)
    local o = NilCommand:NilCommand()
    setmetatable(o, self)
    local key = KeyFactory.CreateKey(key_id, option_id)
    local lock = LockFactory.CreateLock(vendor_id, menu_id)
    o._purchase = PurchaseFactory.CreatePurchase(key, lock, zone_id, count)
    o._type = 'BuyCommand'
    return o
end

--------------------------------------------------------------------------------
function BuyCommand:__call(state)
    state.running = self._purchase(state)
    state.command = self
    return true
end

return BuyCommand
