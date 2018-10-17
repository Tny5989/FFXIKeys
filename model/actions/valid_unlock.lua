local EntityFactory = require('model/entities/entity_factory')

local ValidUnlock = {}
ValidUnlock.__index = ValidUnlock

function ValidUnlock:ValidUnlock(key, lock)
    local o = {}
    setmetatable(o, self)
    o._key = key
    o._lock = lock
    return o
end

function ValidUnlock:__call()
    local player = EntityFactory.GetPlayer()
    local target = EntityFactory.GetTarget(self._lock:GetName())

    local pkt = packets.new('outgoing', 0x036)

    pkt['Target'] = target:GetId()
    pkt['Item Count 1'] = 1
    pkt['Item Index 1'] = player:GetBag():GetItemIndex(self._key:GetItem())
    pkt['Target Index'] = target:GetIndex()
    pkt['Number of Items'] = 1

    packets.inject(pkt)
    return true
end

return ValidUnlock
