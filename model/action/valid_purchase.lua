local NilPurchase = require('model/action/nil_purchase')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local ValidPurchase = NilPurchase:NilPurchase()
ValidPurchase.__index = ValidPurchase

--------------------------------------------------------------------------------
function ValidPurchase:ValidPurchase()
    local o = {}
    setmetatable(o, self)
    o._type = 'ValidPurchase'
    o._packets = {}
    o._packets[1] = {}
    return o
end

--------------------------------------------------------------------------------
function ValidPurchase:_create_action_packet()
    local pkt = packets.new('outgoing', 0x01A)
    pkt['Target'] = self._lock:Npc()
    pkt['Target Index'] = self._lock:Entity():Index()
    return {pkt}
end

--------------------------------------------------------------------------------
function ValidPurchase:_create_choices()
    local pkt = packets.new('outgoing', 0x05B)
    pkt['Target'] = self._lock:Npc()
    pkt['Option Index'] = 10
    pkt['Target Index'] = self._lock:Entity():Index()
    pkt['Automated Message'] = true
    pkt['Zone'] = 241
    pkt['Menu ID'] = 879
    return pkt
end

--------------------------------------------------------------------------------
function ValidPurchase:__call()
    local pkt = packets.new('outgoing', 0x01A)
    pkt['Target'] = self._lock:Npc()
    pkt['Target Index'] = self._lock:Entity():Index()

    packets.inject(pkt)
    return true
end

return ValidPurchase
