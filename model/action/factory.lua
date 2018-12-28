local UnlockAction = require('model/action/unlock')
local NilAction = require('model/action/nil')
local PurchaseAction = require('model/action/purchase')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local ActionFactory = {}

--------------------------------------------------------------------------------
function ActionFactory.CreateUnlock(key, lock)
    if key:Type() == 'NilKey' or lock:Type() == 'NilLock' then
        return NilAction:NilAction()
    end

    if key:Entity():Type() == 'NilEntity' then
        if log then
            log('Unable to find key')
        end
        return NilAction:NilAction()
    end

    -- Require two free slots as a workaround for a bug.
    if key:Entity():Bag():FreeSlots() <= 1 then
        if log then
            log('Inventory full')
        end
        return NilAction:NilAction()
    end

    if key:Entity():Bag():ItemCount(key:Item()) <= 0 then
        if log then
            log('No keys')
        end
        return NilAction:NilAction()
    end

    return UnlockAction:UnlockAction(key, lock)
end

--------------------------------------------------------------------------------
function ActionFactory.CreatePurchase(key, vendor, zone, count)
    if key:Type() == 'NilKey' then
        if log then
            log('Unknown key')
        end
        return NilAction:NilAction()
    end
    if vendor:Type() == 'NilLock' then
        if log then
            log('Unknown vendor')
        end
        return NilAction:NilAction()
    end
    if not count or not zone then
        if log then
            log('Invalid param or zone')
        end
        return NilAction:NilAction()
    end
    if key:Entity():Bag():FreeSlots() <= 0 then
        if log then
            log('Inventory full')
        end
        return NilAction:NilAction()
    end

    return PurchaseAction:PurchaseAction(key, vendor, zone, count)
end

return ActionFactory
