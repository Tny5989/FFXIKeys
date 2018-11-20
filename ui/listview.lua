local Component = require('ui/component')
local Label = require('ui/label')
local List = require('ui/list')
local Scrollbar = require('ui/scrollbar')

--------------------------------------------------------------------------------
local ITEM_HEIGHT = 20

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local ListView = Component:Component()
ListView.__index = ListView

--------------------------------------------------------------------------------
function ListView:ListView()
    local o = Component:Component()
    setmetatable(o, self)
    o._mouse_button = false
    o._type = 'ListView'

    o._header = Label:Label('FFXIKeys')
    o._header:SetSize(0, ITEM_HEIGHT)

    o._scrollbar = Scrollbar:Scrollbar()
    o._scrollbar:SetSize(10, 0)

    o._list = List:List()

    return o
end

--------------------------------------------------------------------------------
function ListView:Destroy()
    Component.Destroy(self)
    self._header:Destroy()
    self._scrollbar:Destroy()
    self._list:Destroy()
end

--------------------------------------------------------------------------------
function ListView:MoveTo(x, y)
    Component.MoveTo(self, x, y)
    local p = self:Position()
    local s = self:Size()
    self._header:MoveTo(p.x, p.y)
    self._list:MoveTo(p.x, p.y + self._header:Size().h)
    self._scrollbar:MoveTo(p.x + s.w - self._scrollbar:Size().w, p.y)
end

--------------------------------------------------------------------------------
function ListView:DragBy(dx, dy)
    Component.DragBy(self, dx, dy)
    local p = self:Position()
    local s = self:Size()
    self._header:MoveTo(p.x, p.y)
    self._list:MoveTo(p.x, p.y + self._header:Size().h)
    self._scrollbar:MoveTo(p.x + s.w - self._scrollbar:Size().w, p.y)
end

--------------------------------------------------------------------------------
function ListView:SetSize(w, h)
    Component.SetSize(self, w, h)
    local p = self:Position()
    local s = self:Size()
    self._header:SetSize(s.w, self._header:Size().h)
    self._scrollbar:SetSize(self._scrollbar:Size().w, s.h)
    self._list:SetSize(s.w, s.h - self._header:Size().h)
    self:MoveTo(p.x, p.y)

    self._scrollbar:SetPageCount(self._list:PageCount())
    self._scrollbar:SetCurrentPage(self._list:CurrentPage())
end

--------------------------------------------------------------------------------
function ListView:Show()
    Component.Show(self)
    self._header:Show()
    self._scrollbar:Show()
    self._list:Show()
end

--------------------------------------------------------------------------------
function ListView:Hide()
    Component.Hide(self)
    self._header:Hide()
    self._scrollbar:Hide()
    self._list:Hide()
end

--------------------------------------------------------------------------------
function ListView:SetForegroundColor(alpha, red, green, blue)
    Component.SetForegroundColor(self, alpha, red, green, blue)
    local color = self:ForegroundColor()
    self._header:SetForegroundColor(color.a, color.r, color.g, color.b)
    self._scrollbar:SetForegroundColor(color.a, color.r, color.g, color.b)
    self._list:SetForegroundColor(color.a, color.r, color.g, color.b)
end

--------------------------------------------------------------------------------
function ListView:SetBackgroundColor(alpha, red, green, blue)
    Component.SetBackgroundColor(self, alpha, red, green, blue)
    local color = self:BackgroundColor()
    self._header:SetBackgroundColor(color.a, color.r, color.g, color.b)
    self._scrollbar:SetBackgroundColor(color.a, color.r, color.g, color.b)
    self._list:SetBackgroundColor(color.a, color.r, color.g, color.b)
end

--------------------------------------------------------------------------------
function ListView:SetFont(font_name)
    Component.SetFont(self, font_name)
    self._header:SetFont(font_name)
    self._scrollbar:SetFont(font_name)
    self._list:SetFont(font_name)
end

--------------------------------------------------------------------------------
function ListView:SetFontSize(font_size)
    Component.SetFontSize(self, font_size)
    self._header:SetFontSize(font_size)
    self._scrollbar:SetFontSize(font_size)
    self._list:SetFontSize(font_size)
end

--------------------------------------------------------------------------------
function ListView:AppendItem(item_text)
    self._list:Append(item_text)

    self._scrollbar:SetPageCount(self._list:PageCount())
    self._scrollbar:SetCurrentPage(self._list:CurrentPage())
end

--------------------------------------------------------------------------------
function ListView:Clear()
    self._list:Clear()

    self._scrollbar:SetPageCount(self._list:PageCount())
    self._scrollbar:SetCurrentPage(self._list:CurrentPage())
end

--------------------------------------------------------------------------------
function ListView:OnMouseMove(x, y, dx, dy)
    if self._mouse_button then
        self:DragBy(dx, dy)
    end
    return false
end

--------------------------------------------------------------------------------
function ListView:OnMouseLeftClick(x, y)
    if self._header:ContainsPoint(x, y) then
        self._mouse_button = true
        self:OnMouseMove(x, y, 0, 0)
        return true
    else
        self._mouse_button = false
        return false
    end
end

--------------------------------------------------------------------------------
function ListView:OnMouseLeftRelease(x, y)
    if self._mouse_button then
        self._mouse_button = false
        return true
    else
        return false
    end
end

--------------------------------------------------------------------------------
function ListView:OnMouseWheelUp(x, y)
    if self:ContainsPoint(x, y) then
        self._list:SetCurrentPage(self._list:CurrentPage() - 1)
        self._scrollbar:SetCurrentPage(self._list:CurrentPage())
        return true
    else
        return false
    end
end

--------------------------------------------------------------------------------
function ListView:OnMouseWheelDown(x, y)
    if self:ContainsPoint(x, y) then
        self._list:SetCurrentPage(self._list:CurrentPage() + 1)
        self._scrollbar:SetCurrentPage(self._list:CurrentPage())
        return true
    else
        return false
    end
end

return ListView
