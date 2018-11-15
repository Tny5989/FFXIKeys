local Background = require('ui/background')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Scrollbar = {}
Scrollbar.__index = Scrollbar

--------------------------------------------------------------------------------
function Scrollbar:Scrollbar()
    local o = {}
    setmetatable(o, self)
    o._background = Background:Background()
    o._foreground = Background:Background()
    o._page_count = 1
    o._page_idx = 1
    o._type = 'Scrollbar'
    return o
end

--------------------------------------------------------------------------------
function Scrollbar:Destroy()
    self._background:Destroy()
    self._foreground:Destroy()
end

--------------------------------------------------------------------------------
function Scrollbar:MoveTo(x, y)
    local last_bg_pos = self._background:Position()
    self._background:DragBy(x - last_bg_pos.x, y - last_bg_pos.y)
    local last_fg_pos = self._foreground:Position()
    self._foreground:DragBy(x - last_fg_pos.x, y - last_fg_pos.y)
end

--------------------------------------------------------------------------------
function Scrollbar:DragBy(dx, dy)
    self._background:DragBy(dx, dy)
    self._foreground:DragBy(dx, dy)
end

--------------------------------------------------------------------------------
function Scrollbar:SetSize(w, h)
    self._background:SetSize(w, h)
    self:_update_bar()
end

--------------------------------------------------------------------------------
function Scrollbar:Show()
    self._background:Show()
    self._foreground:Show()
end

--------------------------------------------------------------------------------
function Scrollbar:Hide()
    self._background:Hide()
    self._foreground:Hide()
end

--------------------------------------------------------------------------------
function Scrollbar:SetBackgroundColor(alpha, red, green, blue)
    self._background:SetBackgroundColor(alpha, red, green, blue)
end

--------------------------------------------------------------------------------
function Scrollbar:SetForegroundColor(alpha, red, green, blue)
    self._foreground:SetBackgroundColor(alpha, red, green, blue)
end

--------------------------------------------------------------------------------
function Scrollbar:SetPageCount(count)
    self._page_count = math.max(1, count)
    self:_update_bar()
end

--------------------------------------------------------------------------------
function Scrollbar:SetCurrentPage(idx)
    self._page_idx = math.max(1, idx)
    self._page_idx = math.min(self._page_count, self._page_idx)
    self:_update_bar()
end

--------------------------------------------------------------------------------
function Scrollbar:Position()
    return self._background:Position()
end

--------------------------------------------------------------------------------
function Scrollbar:Size()
    return self._background:Size()
end

--------------------------------------------------------------------------------
function Scrollbar:IsVisible()
    return self._background:IsVisible() or self._foreground:IsVisible()
end

--------------------------------------------------------------------------------
function Scrollbar:BackgroundColor()
    return self._background:BackgroundColor()
end

--------------------------------------------------------------------------------
function Scrollbar:ForegroundColor()
    return self._foreground:BackgroundColor()
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
function Scrollbar:ContainsPoint(x, y)
    return self._background:ContainsPoint(x, y) or self._foreground:ContainsPoint(x, y)
end

--------------------------------------------------------------------------------
function Scrollbar:Type()
    return self._type
end

--------------------------------------------------------------------------------
function Scrollbar:_update_bar()
    local max_height = self._background:Size().h
    local bar_height = max_height / self._page_count
    local min_y = self._background:Position().y
    local bar_y = min_y + (bar_height * (self._page_idx - 1))
    self._foreground:SetSize(self._background:Size().w, bar_height)
    self._foreground:MoveTo(self._background:Position().x, bar_y)
end

return Scrollbar
