local Component = require('ui/component')
local UUID = require('util/uuid')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Label = Component:Component()
Label.__index = Label

--------------------------------------------------------------------------------
function Label:Label(t)
    local o = Component:Component()
    setmetatable(o, self)
    o._id = UUID.uuid()
    o._text = t and t or ''
    o._type = 'Label'

    windower.text.create(o._id)

    o:SetText(o._text)

    return o
end

--------------------------------------------------------------------------------
function Label:Destroy()
    Component.Destroy(self)
    windower.text.delete(self._id)
end

--------------------------------------------------------------------------------
function Label:MoveTo(x, y)
    Component.MoveTo(self, x, y)
    local p = self:Position()
    windower.text.set_location(self._id, p.x, p.y)
end

--------------------------------------------------------------------------------
function Label:DragBy(dx, dy)
    Component.DragBy(self, dx, dy)
    local p = self:Position()
    windower.text.set_location(self._id, p.x, p.y)
end

--------------------------------------------------------------------------------
function Label:Show()
    Component.Show(self)
    windower.text.set_visibility(self._id, self:IsVisible())
    windower.text.set_bg_visibility(self._id, self:IsVisible())
end

--------------------------------------------------------------------------------
function Label:Hide()
    Component.Hide(self)
    windower.text.set_visibility(self._id, self:IsVisible())
    windower.text.set_bg_visibility(self._id, self:IsVisible())
end

--------------------------------------------------------------------------------
function Label:SetPalatte(palatte)
    Component.SetPalatte(self, palatte)
    local color = self:Palatte():Color('bg')
    windower.text.set_bg_color(self._id, color.a, color.r, color.g, color.b)
    color = self:Palatte():Color('fg')
    windower.text.set_color(self._id, color.a, color.r, color.g, color.b)
    windower.text.set_font(self._id, self:Palatte():Font('defualt').fn)
    windower.text.set_font_size(self._id, self:Palatte():Font('defualt').fs)
end

--------------------------------------------------------------------------------
function Label:SetText(text)
    self._text = text
    windower.text.set_text(self._id, self._text)
end

--------------------------------------------------------------------------------
function Label:Text()
    return self._text
end

return Label
