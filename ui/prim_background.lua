local Background = require('ui/background')
local UUID = require('util/uuid')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local PrimBackground = Background:Background()
PrimBackground.__index = PrimBackground

--------------------------------------------------------------------------------
function PrimBackground:PrimBackground()
    local o = {}
    setmetatable(o, self)
    o._position = { x = 0, y = 0 }
    o._size = { w = 0, h = 0 }
    o._visible = false
    o._color = { a = 255, r = 0, g = 0, b = 0 }
    o._type = 'PrimBackground'

    o._id = windower.prim.create(UUID.uuid())

    return o
end

--------------------------------------------------------------------------------
function PrimBackground:Destroy()
    Background.Destroy(self)
    windower.prim.delete(self._id)
end

--------------------------------------------------------------------------------
function PrimBackground:MoveTo(x, y)
    Background.MoveTo(self, x, y)
    windower.prim.set_location(self._id, self._position.x, self._position.y)
end

--------------------------------------------------------------------------------
function PrimBackground:DragBy(dx, dy)
    Background.DragBy(self, dx, dy)
    windower.prim.set_location(self._id, self._position.x, self._position.y)
end

--------------------------------------------------------------------------------
function PrimBackground:SetSize(w, h)
    Background.SetSize(self, w, h)
    windower.prim.set_size(self._id, self._size.w, self._size.h)
end

--------------------------------------------------------------------------------
function PrimBackground:Show()
    Background.Show(self)
    windower.prim.set_visibility(self._id, self._visible)
end

--------------------------------------------------------------------------------
function PrimBackground:Hide()
    Background.Hide(self)
    windower.prim.set_visibility(self._id, self._visible)
end

--------------------------------------------------------------------------------
function PrimBackground:SetColor(alpha, red, green, blue)
    Background.SetColor(self, alpha, red, green, blue)
    windower.prim.set_color(self._id, self._color.a, self._color.r, self._color.g, self._color.b)
end

return PrimBackground
