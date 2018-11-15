local Component = require('ui/component')
local UUID = require('util/uuid')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Background = Component:Component()
Background.__index = Background

--------------------------------------------------------------------------------
function Background:Background()
    local o = {}
    setmetatable(o, self)
    o._id = UUID.uuid()
    o._position = { x = 0, y = 0 }
    o._size = { w = 0, h = 0 }
    o._visible = false
    o._fg_color = { a = 255, r = 0, g = 0, b = 0 }
    o._bg_color = { a = 255, r = 0, g = 0, b = 0 }
    o._font = 'Consolas'
    o._font_size = 12
    o._type = 'Background'

    windower.prim.create(o._id)
    o:MoveTo(o._position.x, o._position.y)
    o:SetSize(o._size.w, o._size.h)
    o:SetBackgroundColor(o._bg_color.a, o._bg_color.r, o._bg_color.g, o._bg_color.b)
    o:SetForegroundColor(o._fg_color.a, o._fg_color.r, o._fg_color.g, o._fg_color.b)
    o:SetFont(o._font)
    o:SetFontSize(o._font_size)

    return o
end

--------------------------------------------------------------------------------
function Background:Destroy()
    Component.Destroy(self)
    windower.prim.delete(self._id)
end

--------------------------------------------------------------------------------
function Background:MoveTo(x, y)
    Component.MoveTo(self, x, y)
    windower.prim.set_position(self._id, self._position.x, self._position.y)
end

--------------------------------------------------------------------------------
function Background:DragBy(dx, dy)
    Component.DragBy(self, dx, dy)
    windower.prim.set_position(self._id, self._position.x, self._position.y)
end

--------------------------------------------------------------------------------
function Background:SetSize(w, h)
    Component.SetSize(self, w, h)
    windower.prim.set_size(self._id, self._size.w, self._size.h)
end

--------------------------------------------------------------------------------
function Background:Show()
    Component.Show(self)
    windower.prim.set_visibility(self._id, self._visible)
end

--------------------------------------------------------------------------------
function Background:Hide()
    Component.Hide(self)
    windower.prim.set_visibility(self._id, self._visible)
end

--------------------------------------------------------------------------------
function Background:SetBackgroundColor(alpha, red, green, blue)
    Component.SetBackgroundColor(self, alpha, red, green, blue)
    local color = self:BackgroundColor()
    windower.prim.set_color(self._id, color.a, color.r, color.g, color.b)
end

return Background
