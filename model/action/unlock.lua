local NilAction = require('model/action/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local UnlockAction = NilAction:NilAction()
UnlockAction.__index = UnlockAction

--------------------------------------------------------------------------------
function UnlockAction:UnlockAction(key, lock)
    local o = NilAction:NilAction()
    setmetatable(o, self)
    o._type = 'UnlockAction'
    o._key = key
    o._lock = lock
    return o
end

--------------------------------------------------------------------------------
function UnlockAction:__call()
    local pkt = packets.new('outgoing', 0x036)
    pkt['Target'] = self._lock:Npc()
    pkt['Item Count 1'] = 1
    pkt['Item Index 1'] = self._key:Entity():Bag():ItemIndex(self._key:Item())
    pkt['Target Index'] = self._lock:Entity():Index()
    pkt['Number of Items'] = 1

    packets.inject(pkt)

    return true
end

return UnlockAction
