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
    o._position = { x = 0, y = 0 }
    o._size = { w = 0, h = 0 }
    o._visible = false
    o._fg_color = { a = 255, r = 0, g = 0, b = 0 }
    o._bg_color = { a = 255, r = 0, g = 0, b = 0 }
    o._type = 'Background'

    o._id = UUID.uuid()
    windower.prim.create(o._id)

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
