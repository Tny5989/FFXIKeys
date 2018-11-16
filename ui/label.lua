local Component = require('ui/component')
local Palatte = require('ui/style/palatte')
local UUID = require('util/uuid')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Label = Component:Component()
Label.__index = Label

--------------------------------------------------------------------------------
function Label:Label(t)
    local o = {}
    setmetatable(o, self)
    o._id = UUID.uuid()
    o._text = t and t or ''
    o._palatte = Palatte:Palatte()
    o._type = 'Label'

    windower.text.create(o._id)

    o:MoveTo(0, 0)
    o:SetSize(0, 0)

    local color = o:BackgroundColor()
    o:SetBackgroundColor(color.a, color.r, color.g, color.b)

    color = o:ForegroundColor()
    o:SetForegroundColor(color.a, color.r, color.g, color.b)

    o:SetFont(o:Font())
    o:SetFontSize(o:FontSize())

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
function Label:SetBackgroundColor(alpha, red, green, blue)
    Component.SetBackgroundColor(self, alpha, red, green, blue)
    local color = self:BackgroundColor()
    windower.text.set_bg_color(self._id, color.a, color.r, color.g, color.b)
end

--------------------------------------------------------------------------------
function Label:SetForegroundColor(alpha, red, green, blue)
    Component.SetForegroundColor(self, alpha, red, green, blue)
    local color = self:ForegroundColor()
    windower.text.set_color(self._id, color.a, color.r, color.g, color.b)
end

--------------------------------------------------------------------------------
function Label:SetFont(font_name)
    Component.SetFont(self, font_name)
    windower.text.set_font(self._id, self:Font('default'))
end

--------------------------------------------------------------------------------
function Label:SetFontSize(font_size)
    Component.SetFontSize(self, font_size)
    windower.text.set_font_size(self._id, self:FontSize('default'))
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
