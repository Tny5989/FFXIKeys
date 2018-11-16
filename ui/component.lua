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
function Component:SetForegroundColor(alpha, red, green, blue)
    self._palatte:SetColor('fg', { a = alpha, r = red, g = green, b = blue })
end

--------------------------------------------------------------------------------
function Component:SetBackgroundColor(alpha, red, green, blue)
    self._palatte:SetColor('bg', { a = alpha, r = red, g = green, b = blue })
end

--------------------------------------------------------------------------------
function Component:SetFont(font_name)
    self._palatte:SetFont('default', font_name, self._palatte:Font('default').fs)
end

--------------------------------------------------------------------------------
function Component:SetFontSize(font_size)
    self._palatte:SetFont('default', self._palatte:Font('default').fn, font_size)
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
    local color = self._palatte:Color('fg')
    return { a = color.a, r = color.r, g = color.g, b = color.b }
end

--------------------------------------------------------------------------------
function Component:BackgroundColor()
    local color = self._palatte:Color('bg')
    return { a = color.a, r = color.r, g = color.g, b = color.b }
end

--------------------------------------------------------------------------------
function Component:Font()
    return self._palatte:Font('default').fn
end

--------------------------------------------------------------------------------
function Component:FontSize()
    return self._palatte:Font('default').fs
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
