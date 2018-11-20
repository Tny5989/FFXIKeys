local Component = require('ui/component')
local Label = require('ui/label')
local List = require('ui/list')
local Scrollbar = require('ui/scrollbar')
local PalatteFactory = require('ui/style/palatte_factory')

--------------------------------------------------------------------------------
local ITEM_HEIGHT = 20

local MOUSE_ACTIONS = { Drag = 1, Select = 2, None = 3 }

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local ListView = Component:Component()
ListView.__index = ListView

--------------------------------------------------------------------------------
function ListView:ListView(header_text)
    local o = Component:Component()
    setmetatable(o, self)
    o._mouse = MOUSE_ACTIONS.None
    o._type = 'ListView'

    o._header = Label:Label(header_text)
    o._header:SetSize(0, ITEM_HEIGHT)
    o._header:SetPalatte(PalatteFactory.Get('header'))

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
    self._list:Highlight(x, y)

    if self._mouse == MOUSE_ACTIONS.Drag then
        self:DragBy(dx, dy)
    elseif self._mouse == MOUSE_ACTIONS.Select then
        self._list:Select(x, y)
    end

    return false
end

--------------------------------------------------------------------------------
function ListView:OnMouseLeftClick(x, y)
    if self._mouse ~= MOUSE_ACTIONS.None then
        return false
    end
    
    if self._header:ContainsPoint(x, y) then
        self._mouse = MOUSE_ACTIONS.Drag
        self:OnMouseMove(x, y, 0, 0)
        return true
    elseif self._list:ContainsPoint(x, y) then
        self._mouse = MOUSE_ACTIONS.Select
        self:OnMouseMove(x, y, 0, 0)
        return true
    else
        self._mouse = MOUSE_ACTIONS.None
        return false
    end
end

--------------------------------------------------------------------------------
function ListView:OnMouseLeftRelease(x, y)
    if self._mouse == MOUSE_ACTIONS.Drag then
        self._mouse = MOUSE_ACTIONS.None
        return true
    elseif self._mouse == MOUSE_ACTIONS.Select then
        self._mouse = MOUSE_ACTIONS.None
        self._list:Activate(x, y)
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
