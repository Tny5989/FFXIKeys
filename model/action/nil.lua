--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local NilAction = {}
NilAction.__index = NilAction

--------------------------------------------------------------------------------
function NilAction:NilAction()
    local o = {}
    setmetatable(o, self)
    o._type = 'NilAction'
    return o
end

--------------------------------------------------------------------------------
function NilAction:Type()
    return self._type
end

--------------------------------------------------------------------------------
function NilAction:__call()
    return false
end

return NilAction
