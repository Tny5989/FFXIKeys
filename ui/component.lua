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
    o._fg_color = { a = 255, r = 0, g = 0, b = 0 }
    o._bg_color = { a = 255, r = 0, g = 0, b = 0 }
    o._font = 'Consolas'
    o._font_size = 12
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
function Component:SetForegroundColor(alpha, red, green, blue)
    self._fg_color.a = alpha
    self._fg_color.r = red
    self._fg_color.g = green
    self._fg_color.b = blue
end

--------------------------------------------------------------------------------
function Component:SetBackgroundColor(alpha, red, green, blue)
    self._bg_color.a = alpha
    self._bg_color.r = red
    self._bg_color.g = green
    self._bg_color.b = blue
end

--------------------------------------------------------------------------------
function Component:SetFont(font_name)
    self._font = font_name
end

--------------------------------------------------------------------------------
function Component:SetFontSize(font_size)
    self._font_size = font_size
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
function Component:ForegroundColor()
    return { a = self._fg_color.a, r = self._fg_color.r, g = self._fg_color.g, b = self._fg_color.b }
end

--------------------------------------------------------------------------------
function Component:BackgroundColor()
    return { a = self._bg_color.a, r = self._bg_color.r, g = self._bg_color.g, b = self._bg_color.b }
end

--------------------------------------------------------------------------------
function Component:Font()
    return self._font
end

--------------------------------------------------------------------------------
function Component:FontSize()
    return self._font_size
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
