--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Component = {}
Component.__index = Component

--------------------------------------------------------------------------------
function Component:Component()
    local o = {}
    setmetatable(o, self)
    o._position = { x = 0, y = 0 }
    o._size = { w = 0, h = 0 }
    o._visible = false
    o._color = { a = 255, r = 0, g = 0, b = 0 }
    o._type = 'Component'
    return o
end

--------------------------------------------------------------------------------
function Component:Destroy()
end

--------------------------------------------------------------------------------
function Component:MoveTo(x, y)
    self._position.x = x
    self._position.y = y
end

--------------------------------------------------------------------------------
function Component:DragBy(dx, dy)
    self._position.x = self._position.x + dx
    self._position.y = self._position.y + dy
end

--------------------------------------------------------------------------------
function Component:SetSize(w, h)
    self._size.w = w
    self._size.h = h
end

--------------------------------------------------------------------------------
function Component:Show()
    self._visible = true
end

--------------------------------------------------------------------------------
function Component:Hide()
    self._visible = false
end

--------------------------------------------------------------------------------
function Component:SetColor(alpha, red, green, blue)
    self._color.a = alpha
    self._color.r = red
    self._color.g = green
    self._color.b = blue
end

--------------------------------------------------------------------------------
function Component:Position()
    return { x = self._position.x, y = self._position.y }
end

--------------------------------------------------------------------------------
function Component:Size()
    return { w = self._size.w, h = self._size.h }
end

--------------------------------------------------------------------------------
function Component:IsVisible()
    return self._visible
end

--------------------------------------------------------------------------------
function Component:Color()
    return { a = self._color.a, r = self._color.r, g = self._color.g, b = self._color.b }
end

--------------------------------------------------------------------------------
function Component:ContainsPoint(x, y)
    local valid_x = x >= self._position.x and x <= (self._position.x + self._size.w)
    local valid_y = y >= self._position.y and y <= (self._position.y + self._size.h)
    return valid_x and valid_y
end

--------------------------------------------------------------------------------
function Component:Type()
    return self._type
end

return Component
