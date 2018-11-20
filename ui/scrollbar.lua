local Background = require('ui/background')
local Component = require('ui/component')
local PalatteFactory = require('u/style/palatte_factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Scrollbar = Component:Component()
Scrollbar.__index = Scrollbar

--------------------------------------------------------------------------------
function Scrollbar:Scrollbar()
    local o = Component:Component()
    setmetatable(o, self)
    o._page_count = 1
    o._page_idx = 1
    o._type = 'Scrollbar'

    o._background = Background:Background()
    o._background:SetPalatte(PalatteFactory.Get('scrollbar_bg'))
    o._foreground = Background:Background()
    o._foreground.SetPalatte(PalatteFactory.Get('scrollbar_fg'))

    o:SetPageCount(o:PageCount())

    return o
end

--------------------------------------------------------------------------------
function Scrollbar:Destroy()
    self._background:Destroy()
    self._foreground:Destroy()
end

--------------------------------------------------------------------------------
function Scrollbar:MoveTo(x, y)
    Component.MoveTo(self, x, y)
    self._background:MoveTo(x, y)
    self._foreground:MoveTo(x, y)
end

--------------------------------------------------------------------------------
function Scrollbar:DragBy(dx, dy)
    Component.DragBy(self, dx, dy)
    self._background:DragBy(dx, dy)
    self._foreground:DragBy(dx, dy)
end

--------------------------------------------------------------------------------
function Scrollbar:SetSize(w, h)
    Component.SetSize(self, w, h)
    self._background:SetSize(w, h)
    self:_update_bar()
end

--------------------------------------------------------------------------------
function Scrollbar:Show()
    Component.Show(self)
    self._background:Show()
    self._foreground:Show()
end

--------------------------------------------------------------------------------
function Scrollbar:Hide()
    Component.Hide(self)
    self._background:Hide()
    self._foreground:Hide()
end

----------------------------------------------------------------------------------
--function Scrollbar:SetBackgroundColor(alpha, red, green, blue)
--    Component.SetBackgroundColor(self, alpha, red, green, blue)
--    self._background:SetBackgroundColor(alpha, red, green, blue)
--end
--
----------------------------------------------------------------------------------
--function Scrollbar:SetForegroundColor(alpha, red, green, blue)
--    Component.SetForegroundColor(self, alpha, red, green, blue)
--    self._foreground:SetBackgroundColor(alpha, red, green, blue)
--end

--------------------------------------------------------------------------------
function Scrollbar:SetPageCount(count)
    self._page_count = math.max(1, count)
    self:SetCurrentPage(self:CurrentPage())
end

--------------------------------------------------------------------------------
function Scrollbar:SetCurrentPage(idx)
    self._page_idx = math.max(1, idx)
    self._page_idx = math.min(self._page_count, self._page_idx)
    self:_update_bar()
end

--------------------------------------------------------------------------------
function Scrollbar:PageCount()
    return self._page_count
end

--------------------------------------------------------------------------------
function Scrollbar:CurrentPage()
    return self._page_idx
end

--------------------------------------------------------------------------------
function Scrollbar:_update_bar()
    local max_height = self._background:Size().h
    local bar_height = max_height / self:PageCount()
    local min_y = self._background:Position().y
    local bar_y = min_y + (bar_height * (self:CurrentPage() - 1))
    self._foreground:SetSize(self._background:Size().w, bar_height)
    self._foreground:MoveTo(self._background:Position().x, bar_y)
end

return Scrollbar
