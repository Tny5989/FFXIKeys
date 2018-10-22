--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local NilLock = {}
NilLock.__index = NilLock

--------------------------------------------------------------------------------
function NilLock:NilLock()
    local o = {}
    setmetatable(o, self)
    o._id = 0
    o._option = 0
    o._type = 'NilLock'
    return o
end

--------------------------------------------------------------------------------
function NilLock:Npc()
    return self._id
end

--------------------------------------------------------------------------------
function NilLock:Option()
    return self._option
end

--------------------------------------------------------------------------------
function NilLock:Type()
    return self._type
end

return NilLock
