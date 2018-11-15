local Component = require('ui/component')
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
    o._position = { x = 0, y = 0 }
    o._size = { w = 0, h = 0 }
    o._visible = false
    o._fg_color = { a = 255, r = 0, g = 0, b = 0 }
    o._bg_color = { a = 255, r = 0, g = 0, b = 0 }
    o._font = 'Consolas'
    o._font_size = 12
    o._text = t and t or ''
    o._type = 'ListItem'

    windower.text.create(o._id)
    o:MoveTo(o._position.x, o._position.y)
    o:SetSize(o._size.w, o._size.h)
    o:SetBackgroundColor(o._bg_color.a, o._bg_color.r, o._bg_color.g, o._bg_color.b)
    o:SetForegroundColor(o._fg_color.a, o._fg_color.r, o._fg_color.g, o._fg_color.b)
    o:SetFont(o._font)
    o:SetFontSize(o._font_size)
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
    windower.text.set_location(self._id, self._position.x, self._position.y)
end

--------------------------------------------------------------------------------
function ListItem:DragBy(dx, dy)
    Component.DragBy(self, dx, dy)
    windower.text.set_location(self._id, self._position.x, self._position.y)
end

--------------------------------------------------------------------------------
function ListItem:Show()
    Component.Show(self)
    windower.text.set_visibility(self._id, self._visible)
    windower.text.set_bg_visibility(self._id, self._visible)
end

--------------------------------------------------------------------------------
function ListItem:Hide()
    Component.Hide(self)
    windower.text.set_visibility(self._id, self._visible)
    windower.text.set_bg_visibility(self._id, self._visible)
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
    windower.text.set_font(self._id, self._font)
end

--------------------------------------------------------------------------------
function ListItem:SetFontSize(font_size)
    Component.SetFontSize(self, font_size)
    windower.text.set_font_size(self._id, self._font_size)
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
