local Component = require('ui/component')
local Palatte = require('ui/style/palatte')
local Label = require('ui/label')
local Scrollbar = require('ui/scrollbar')

--------------------------------------------------------------------------------
local ITEM_HEIGHT = 20 -- Windower can't measure text before showing it

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local ListView = Component:Component()
ListView.__index = ListView

--------------------------------------------------------------------------------
function ListView:ListView()
    local o = {}
    setmetatable(o, self)
    o._palatte = Palatte:Palatte()
    o._type = 'ListView'

    o._items = {}

    o._scrollbar = Scrollbar:Scrollbar()
    o._scrollbar:SetSize(10, 1)

    o._header = Label:Label('FFXIKeys')
    o._header:SetSize(0, ITEM_HEIGHT)

    o:MoveTo(0, 0)
    o:SetSize(0, 0)

    local bg = o:BackgroundColor()
    o:SetBackgroundColor(bg.a, bg.r, bg.g, bg.b)

    local fg = o:ForegroundColor()
    o:SetForegroundColor(fg.a, fg.r, fg.g, fg.b)

    o:SetFont(o:Font())
    o:SetFontSize(o:FontSize())

    return o
end

--------------------------------------------------------------------------------
function ListView:Destroy()
    self:Clear()
    self._scrollbar:Destroy()
    self._header:Destroy()
end

--------------------------------------------------------------------------------
function ListView:MoveTo(x, y)
    Component.MoveTo(self, x, y)
    local p = self:Position()
    local s = self:Size()
    self._header:MoveTo(p.x, p.y)
    self._scrollbar:MoveTo(p.x + s.w, p.y)
    self:Update()
end

--------------------------------------------------------------------------------
function ListView:DragBy(dx, dy)
    Component.DragBy(self, dx, dy)
    local p = self:Position()
    local s = self:Size()
    self._header:Moveto(p.x, p.y)
    self._scrollbar:MoveTo(p.x + s.w, p.y)
    self:Update()
end

--------------------------------------------------------------------------------
function ListView:SetSize(w, h)
    Component.SetSize(self, w, h)
    local p = self:Position()
    local s = self:Size()
    self._header:SetSize(s.w, ITEM_HEIGHT)
    self._scrollbar:SetSize(self._scrollbar:Size().w, s.h)
    self._scrollbar:MoveTo(p.x + s.w, p.y)
    self:Update()
end

--------------------------------------------------------------------------------
function ListView:Show()
    Component.Show(self)
    for i = 1, #self._items, 1 do
        self._items[i]:Show()
    end
    self._scrollbar:Show()
    self._header:Show()
end

--------------------------------------------------------------------------------
function ListView:Hide()
    Component.Hide(self)
    for i = 1, #self._items, 1 do
        self._items[i]:Hide()
    end
    self._scrollbar:Hide()
    self._header:Hide()
end

--------------------------------------------------------------------------------
function ListView:SetForegroundColor(alpha, red, green, blue)
    Component.SetForegroundColor(self, alpha, red, green, blue)
    local color = self:ForegroundColor()
    for i = 1, #self._items, 1 do
        self._items[i]:SetForegroundColor(color.a, color.r, color.g, color.b)
    end
    self._scrollbar:SetForegroundColor(color.a, color.r, color.g, color.b)
    self._header:SetForegroundColor(color.a, color.r, color.g, color.b)
end

--------------------------------------------------------------------------------
function ListView:SetBackgroundColor(alpha, red, green, blue)
    Component.SetBackgroundColor(self, alpha, red, green, blue)
    local color = self:BackgroundColor()
    for i = 1, #self._items, 1 do
        self._items[i]:SetBackgroundColor(color.a, color.r, color.g, color.b)
    end
    self._scrollbar:SetBackgroundColor(color.a, color.r, color.g, color.b)
    self._header:SetBackgroundColor(color.a, color.r, color.g, color.b)
end

--------------------------------------------------------------------------------
function ListView:SetFont(font_name)
    Component.SetFont(self, font_name)
    for i = 1, #self._items, 1 do
        self._items[i]:SetFont(font_name)
    end
    self:Update()
end

--------------------------------------------------------------------------------
function ListView:SetFontSize(font_size)
    Component.SetFontSize(self, font_size)
    for i = 1, #self._items, 1 do
        self._items[i]:SetFontSize(font_size)
    end
    self:Update()
end

--------------------------------------------------------------------------------
function ListView:AppendItem(item_text)
    local item = Label:Label(item_text)
    self:_style_item(item)
    table.insert(self._items, item)
    self:Update()
end

--------------------------------------------------------------------------------
function ListView:Clear()
    while #self._items > 0 do
        table.remove(self._items):Destroy()
    end
    self:Update()
end

--------------------------------------------------------------------------------
function ListView:_style_item(item)
    local bg = self:BackgroundColor()
    item:SetBackgroundColor(bg.a, bg.r, bg.g, bg.b)
    local fg = self:ForegroundColor()
    item:SetForegroundColor(fg.a, fg.r, fg.g, fg.b)
    item:SetFontSize(self:FontSize())
    item:SetFont(self:Font())
    item:SetSize(self:Size().w, ITEM_HEIGHT)
    item:Hide()
end

--------------------------------------------------------------------------------
function ListView:Update()
    local items_per_page = self:Size().h / ITEM_HEIGHT - 1
    self._scrollbar:SetPageCount(math.ceil(#self._items / items_per_page))

    local starting_idx = (self._scrollbar:CurrentPage() - 1) * items_per_page + 1
    local stopping_idx = math.min(starting_idx + items_per_page - 1, #self._items)

    for i = 1, #self._items, 1 do
        self._items[i]:Hide()
    end

    local p = self:Position()
    p.y = p.y + self._header:Size().h + 1
    for i = starting_idx, stopping_idx, 1 do
        self._items[i]:MoveTo(p.x, p.y)
        self._items[i]:Show()
        p.y = p.y + self._items[i]:Size().h
    end
end

return ListView
