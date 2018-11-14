--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Background = {}
Background.__index = Background

--------------------------------------------------------------------------------
function Background:Background()
    local o = {}
    setmetatable(o, self)
    o._position = { x = 0, y = 0 }
    o._size = { w = 0, h = 0 }
    o._visible = false
    o._color = { a = 255, r = 0, g = 0, b = 0 }
    o._type = 'Background'
    return o
end

--------------------------------------------------------------------------------
function Background:Destroy()
end

--------------------------------------------------------------------------------
function Background:MoveTo(x, y)
    self._position.x = x
    self._position.y = y
end

--------------------------------------------------------------------------------
function Background:DragBy(dx, dy)
    self._position.x = self._position.x + dx
    self._position.y = self._position.y + dy
end

--------------------------------------------------------------------------------
function Background:SetSize(w, h)
    self._size.w = w
    self._size.h = h
end

--------------------------------------------------------------------------------
function Background:Show()
    self._visible = true
end

--------------------------------------------------------------------------------
function Background:Hide()
    self._visible = false
end

--------------------------------------------------------------------------------
function Background:SetColor(alpha, red, green, blue)
    self._color.a = alpha
    self._color.r = red
    self._color.g = green
    self._color.b = blue
end

--------------------------------------------------------------------------------
function Background:Position()
    return { x = self._position.x, y = self._position.y }
end

--------------------------------------------------------------------------------
function Background:Size()
    return { w = self._size.w, h = self._size.h }
end

--------------------------------------------------------------------------------
function Background:IsVisible()
    return self._visible
end

--------------------------------------------------------------------------------
function Background:Color()
    return { a = self._color.a, r = self._color.r, g = self._color.g, b = self._color.b }
end

--------------------------------------------------------------------------------
function Background:ContainsPoint(x, y)
    local valid_x = x >= self._position.x and x <= (self._position.x + self._size.w)
    local valid_y = y >= self._position.y and y <= (self._position.y + self._size.h)
    return valid_x and valid_y
end

--------------------------------------------------------------------------------
function Background:Type()
    return self._type
end

return Background
