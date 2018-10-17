local EntityFactory = require('model/entities/entity_factory')
local Packets = require('packets')

local Unlock = {}
Unlock.__index = Unlock

function Unlock:Unlock(key, lock)
    local o = {}
    setmetatable(o, self)
    o._key = key
    o._lock = lock
    return o
end

function Unlock:__call()
    local player = EntityFactory.GetPlayer()
    local target = EntityFactory.GetTarget(self._lock:GetName())

    if player:GetBag():GetOpenInv() <= 0 then
        print('space')
        return false
    end

    if player:GetBag():GetNumItems(self._key:GetItem()) <= 0 then
        print('items')
        return false
    end

    if target:GetDistance() > settings.config.maxdistance then
        print('distance')
        return false
    end

    local pkt = Packets.new('outgoing', 0x036)
    if not pkt then
        print('packets')
        return false
    end

    pkt['Target'] = target:GetId()
    pkt['Item Count 1'] = 1
    pkt['Item Index 1'] = player:GetItemIndex(self._key:GetItem())
    pkt['Target Index'] = target:GetIndex()
    pkt['Number of Items'] = 1

--    packets.inject(pkt)
    return true
end

return Unlock
