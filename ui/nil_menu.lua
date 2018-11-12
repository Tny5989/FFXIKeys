--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local NilMenu = {}
NilMenu.__index = NilMenu

--------------------------------------------------------------------------------
function NilMenu:NilMenu()
    local o = {}
    setmetatable(o, self)
    o._type = 'NilMenu'
    o._position = { x = 0, y = 0 }
    return o
end

--------------------------------------------------------------------------------
function NilMenu:Position()
    return { x = self._position.x, y = self._position.y }
end

--------------------------------------------------------------------------------
function NilMenu:MoveTo(x, y)
    self._position.x = x
    self._position.y = y
end

--------------------------------------------------------------------------------
function NilMenu:DragBy(dx, dy)
    self._position.x = self._position.x + dx
    self._position.y = self._position.y + dy
end

--------------------------------------------------------------------------------
function NilMenu:Size()
    return 0
end

--------------------------------------------------------------------------------
function NilMenu:Append()
end

--------------------------------------------------------------------------------
function NilMenu:Clear()
end

--------------------------------------------------------------------------------
function NilMenu:Show()
end

--------------------------------------------------------------------------------
function NilMenu:Hide()
end

--------------------------------------------------------------------------------
function NilMenu:IsVisible()
    return false
end

--------------------------------------------------------------------------------
function NilMenu:ContainsPoint()
    return 0
end

--------------------------------------------------------------------------------
function NilMenu:OnMouseMove(x, y)
    return false
end

--------------------------------------------------------------------------------
function NilMenu:OnMouseLeftClick(x, y)
    return false
end

--------------------------------------------------------------------------------
function NilMenu:OnMouseLeftRelease(x, y)
    return false
end

--------------------------------------------------------------------------------
function NilMenu:Type()
    return self._type
end

return NilMenu
