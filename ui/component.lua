local Palatte = require('ui/style/palatte')

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

    o._palatte = Palatte:Palatte()

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
function Component:SetPalatte(palatte)
    self._palatte = palatte
end

--------------------------------------------------------------------------------
function Component:Palatte()
    return self._palatte
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
