local Component = require('ui/component')
local Palatte = require('ui/style/palatte')
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
    o._palatte = Palatte:Palatte()
    o._type = 'Background'

    windower.prim.create(o._id)

    o:MoveTo(0, 0)
    o:SetSize(0, 0)

    local color = o:BackgroundColor()
    o:SetBackgroundColor(color.a, color.r, color.g, color.b)

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
    local p = self:Position()
    windower.prim.set_position(self._id, p.x, p.y)
end

--------------------------------------------------------------------------------
function Background:DragBy(dx, dy)
    Component.DragBy(self, dx, dy)
    local p = self:Position()
    windower.prim.set_position(self._id, p.x, p.y)
end

--------------------------------------------------------------------------------
function Background:SetSize(w, h)
    Component.SetSize(self, w, h)
    local s = self:Size()
    windower.prim.set_size(self._id, s.w, s.h)
end

--------------------------------------------------------------------------------
function Background:Show()
    Component.Show(self)
    windower.prim.set_visibility(self._id, self:IsVisible())
end

--------------------------------------------------------------------------------
function Background:Hide()
    Component.Hide(self)
    windower.prim.set_visibility(self._id, self:IsVisible())
end

--------------------------------------------------------------------------------
function Background:SetBackgroundColor(alpha, red, green, blue)
    Component.SetBackgroundColor(self, alpha, red, green, blue)
    local color = self:BackgroundColor()
    windower.prim.set_color(self._id, color.a, color.r, color.g, color.b)
end

return Background
