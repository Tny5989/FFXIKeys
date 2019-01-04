local NilInteraction = require('model/interaction/nil')

--------------------------------------------------------------------------------
local function CreateItemPacket(target, player, item_id)
    local pkt = packets.new('outgoing', 0x036)
    pkt['Target'] = target:Id()
    pkt['Target Index'] = target:Index()
    pkt['Item Count 1'] = 1
    pkt['Item Index 1'] = player:Bag():ItemIndex(item_id)
    pkt['Number of Items'] = 1
    return pkt
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Trade = NilInteraction:NilInteraction()
Trade.__index = Trade

--------------------------------------------------------------------------------
function Trade:Trade()
    local o = NilInteraction:NilInteraction()
    setmetatable(o, self)
    o._to_send = { [1] = function(target, player, item_id)
        return {CreateItemPacket(target, player, item_id)} end }
    o._idx = 1
    o._type = 'Trade'

    setmetatable(o._to_send,
        { __index = function() return function() return {} end end })
    return o
end

--------------------------------------------------------------------------------
function Trade:OnIncomingData(id, _)
    if id == 0x052 then
        self._on_failure()
        return true
    elseif id == 0x034 or id == 0x032 then
        self._on_success()
        return true
    else
        return false
    end
end

--------------------------------------------------------------------------------
function Trade:_GeneratePackets(target, player, item_id)
    local pkts = self._to_send[self._idx](target, player, item_id)
    self._idx = self._idx + 1
    return pkts
end

--------------------------------------------------------------------------------
function Trade:__call(target, _, _, _, _, player, item_id)
    local pkts = self:_GeneratePackets(target, player, item_id)
    for _, pkt in pairs(pkts) do
        packets.inject(pkt)
    end
end

return Trade