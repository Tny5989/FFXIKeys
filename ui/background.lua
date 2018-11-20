local Component = require('ui/component')
local UUID = require('util/uuid')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Background = Component:Component()
Background.__index = Background

--------------------------------------------------------------------------------
function Background:Background()
    local o = Component:Component()
    setmetatable(o, self)
    o._id = UUID.uuid()
    o._type = 'Background'
    windower.prim.create(o._id)
    o:Hide()
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
function Background:SetPalatte(palatte)
    Component.SetPalatte(self, palatte)
    local color = self:Palatte():Color('bg')
    windower.prim.set_color(self._id, color.a, color.r, color.g, color.b)
end

return Background
