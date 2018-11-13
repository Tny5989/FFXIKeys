--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local NilMenuItem = {}
NilMenuItem.__index = NilMenuItem

--------------------------------------------------------------------------------
function NilMenuItem:NilMenuItem()
    local o = {}
    setmetatable(o, self)
    o._type = 'NilMenuItem'
    o._position = { x = 0, y = 0 }
    return o
end

--------------------------------------------------------------------------------
function NilMenuItem:Destroy()
end

--------------------------------------------------------------------------------
function NilMenuItem:DisplayText()
    return 'NilMenuItem'
end

--------------------------------------------------------------------------------
function NilMenuItem:Position()
    return { x = self._position.x, y = self._position.y }
end

--------------------------------------------------------------------------------
function NilMenuItem:Size()
    return { width = 0, height = 0 }
end

--------------------------------------------------------------------------------
function NilMenuItem:MoveTo(x, y)
    self._position.x = x
    self._position.y = y
end

--------------------------------------------------------------------------------
function NilMenuItem:DragBy(dx, dy)
    self._position.x = self._position.x + dx
    self._position.y = self._position.y + dy
end

--------------------------------------------------------------------------------
function NilMenuItem:Activate(_)
end

--------------------------------------------------------------------------------
function NilMenuItem:IsActive()
    return false
end

--------------------------------------------------------------------------------
function NilMenuItem:Show()
end

--------------------------------------------------------------------------------
function NilMenuItem:Hide()
end

--------------------------------------------------------------------------------
function NilMenuItem:SetVisibility(_)
end

--------------------------------------------------------------------------------
function NilMenuItem:IsVisible()
    return false
end

--------------------------------------------------------------------------------
function NilMenuItem:ContainsPoint(x, y)
    return false
end

--------------------------------------------------------------------------------
function NilMenuItem:Type()
    return self._type
end

return NilMenuItem
