local Component = require('ui/component')
local Palatte = require('ui/style/palatte')
local UUID = require('util/uuid')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local ListItem = Component:Component()
ListItem.__index = ListItem

--------------------------------------------------------------------------------
function ListItem:ListItem(t)
    local o = {}
    setmetatable(o, self)
    o._id = UUID.uuid()
    o._text = t and t or ''
    o._palatte = Palatte:Palatte()
    o._type = 'ListItem'

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
function ListItem:Destroy()
    Component.Destroy(self)
    windower.text.delete(self._id)
end

--------------------------------------------------------------------------------
function ListItem:MoveTo(x, y)
    Component.MoveTo(self, x, y)
    local p = self:Position()
    windower.text.set_location(self._id, p.x, p.y)
end

--------------------------------------------------------------------------------
function ListItem:DragBy(dx, dy)
    Component.DragBy(self, dx, dy)
    local p = self:Position()
    windower.text.set_location(self._id, p.x, p.y)
end

--------------------------------------------------------------------------------
function ListItem:Show()
    Component.Show(self)
    windower.text.set_visibility(self._id, self:IsVisible())
    windower.text.set_bg_visibility(self._id, self:IsVisible())
end

--------------------------------------------------------------------------------
function ListItem:Hide()
    Component.Hide(self)
    windower.text.set_visibility(self._id, self:IsVisible())
    windower.text.set_bg_visibility(self._id, self:IsVisible())
end

--------------------------------------------------------------------------------
function ListItem:SetBackgroundColor(alpha, red, green, blue)
    Component.SetBackgroundColor(self, alpha, red, green, blue)
    local color = self:BackgroundColor()
    windower.text.set_bg_color(self._id, color.a, color.r, color.g, color.b)
end

--------------------------------------------------------------------------------
function ListItem:SetForegroundColor(alpha, red, green, blue)
    Component.SetForegroundColor(self, alpha, red, green, blue)
    local color = self:ForegroundColor()
    windower.text.set_color(self._id, color.a, color.r, color.g, color.b)
end

--------------------------------------------------------------------------------
function ListItem:SetFont(font_name)
    Component.SetFont(self, font_name)
    windower.text.set_font(self._id, self:Font('default'))
end

--------------------------------------------------------------------------------
function ListItem:SetFontSize(font_size)
    Component.SetFontSize(self, font_size)
    windower.text.set_font_size(self._id, self:FontSize('default'))
end

--------------------------------------------------------------------------------
function ListItem:SetText(text)
    self._text = text
    windower.text.set_text(self._id, self._text)
end

--------------------------------------------------------------------------------
function ListItem:Text()
    return self._text
end

return ListItem
