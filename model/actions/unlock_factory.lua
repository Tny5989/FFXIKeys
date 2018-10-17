local EntityFactory = require('model/entities/entity_factory')
local Unlock = require('model/actions/unlock')
local ValidUnlock = require('model/actions/valid_unlock')

local UnlockFactory = {}

function UnlockFactory.GetUnlock(key, lock)
    local player = EntityFactory.GetPlayer()
    local target = EntityFactory.GetTarget(lock:GetName())

    if player:GetBag():GetOpenInv() <= 0 then
        return Unlock()
    end

    if player:GetBag():GetNumItems(key:GetItem()) <= 0 then
        return Unlock()
    end

    if target:GetDistance() > settings.config.maxdistance then
        return Unlock()
    end

    return ValidUnlock(key, lock)
end

return UnlockFactory
