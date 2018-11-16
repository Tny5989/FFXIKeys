local Component = require('ui/component')
local ListItem = require('ui/listitem')
local Scrollbar = require('ui/scrollbar')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local ListView = Component:Component()
ListView.__index = ListView

--------------------------------------------------------------------------------
function ListView:ListView()
    local o = {}
    setmetatable(o, self)
    o._position = { x = 0, y = 0 }
    o._size = { w = 0, h = 0 }
    o._visible = false
    o._fg_color = { a = 255, r = 0, g = 0, b = 0 }
    o._bg_color = { a = 255, r = 0, g = 0, b = 0 }
    o._font = 'Consolas'
    o._font_size = 12
    o._type = 'ListView'

    o._item_height = 20
    o._items = {}
    o._items_per_page = 1
    o._scrollbar = Scrollbar:Scrollbar()

    o:MoveTo(o._position.x, o._position.y)
    o:SetSize(o._size.w, o._size.h)
    o:SetBackgroundColor(o._bg_color.a, o._bg_color.r, o._bg_color.g, o._bg_color.b)
    o:SetForegroundColor(o._fg_color.a, o._fg_color.r, o._fg_color.g, o._fg_color.b)
    o:SetFont(o._font)
    o:SetFontSize(o._font_size)

    return o
end

--------------------------------------------------------------------------------
function ListView:Destroy()
    self:Clear()
end

--------------------------------------------------------------------------------
function ListView:MoveTo(x, y)
    Component.MoveTo(self, x, y)
    self._scrollbar:MoveTo(self._position.x + self._size.w, self._position.y)
    self:Update()
end

--------------------------------------------------------------------------------
function ListView:DragBy(dx, dy)
    Component.DragBy(self, dx, dy)
    self._scrollbar:MoveTo(self._position.x + self._size.w, self._position.y)
    self:Update()
end

--------------------------------------------------------------------------------
function ListView:SetSize(w, h)
    Component.SetSize(self, w, h)
    self._scrollbar:SetSize(self._scrollbar:Size().w, self._size.h)
    self._scrollbar:MoveTo(self._position.x + self._size.w, self._position.y)
    self:Update()
end

--------------------------------------------------------------------------------
function ListView:Show()
    Component.Show(self)
    for i = 1, #self._items, 1 do
        self._items[i]:Show()
    end
end

--------------------------------------------------------------------------------
function ListView:Hide()
    Component.Hide(self)
    for i = 1, #self._items, 1 do
        self._items[i]:Hide()
    end
end

--------------------------------------------------------------------------------
function ListView:SetForegroundColor(alpha, red, green, blue)
    Component.SetForegroundColor(self, alpha, red, green, blue)
    local color = self:ForegroundColor()
    for i = 1, #self._items, 1 do
        self._items:SetForegroundColor(color.a, color.r, color.g, color.b)
    end
    self._scrollbar:SetForegroundColor(color.a, color.r, color.g, color.b)
end

--------------------------------------------------------------------------------
function ListView:SetBackgroundColor(alpha, red, green, blue)
    Component.SetBackgroundColor(self, alpha, red, green, blue)
    local color = self:BackgroundColor()
    for i = 1, #self._items, 1 do
        self._items:SetBackgroundColor(color.a, color.r, color.g, color.b)
    end
    self._scrollbar:SetBackgroundColor(color.a, color.r, color.g, color.b)
end

--------------------------------------------------------------------------------
function ListView:SetFont(font_name)
    Component.SetFont(self, font_name)
    for i = 1, #self._items, 1 do
        self._items:SetFont(font_name)
    end
    self:Update()
end

--------------------------------------------------------------------------------
function ListView:SetFontSize(font_size)
    Component.SetFontSize(self, font_size)
    for i = 1, #self._items, 1 do
        self._items:SetFontSize(font_size)
    end
    self:Update()
end

--------------------------------------------------------------------------------
function ListView:AppendItem(item_text)
    local item = ListItem:ListItem(item_text)
    self:_style_item(item)
    table.insert(self._items, item)
    self:Update()
end

--------------------------------------------------------------------------------
function ListView:Clear()
    while #self._items > 0 do
        table.remove(self._items):Destroy()
    end
end

--------------------------------------------------------------------------------
function ListView:_style_item(item)
    local color = self:ForegroundColor()
    item:SetForegroundColor(color.a, color.r, color.g, color.b)
    color = self:BackgroundColor()
    item:SetBackgroundColor(color.a, color.r, color.g, color.b)
    item:SetFontSize(self:FontSize())
    item:SetFont(self:Font())
    item:Hide()
end

--------------------------------------------------------------------------------
function ListView:Update()
    local items_per_page = self:Size().h / self._item_height
    self._scrollbar:SetPageCount(math.ceil(#self._items / items_per_page))

    local starting_idx = (self._scrollbar:CurrentPage() - 1) * items_per_page + 1
    local stopping_idx = math.min(starting_idx + items_per_page - 1, #self._items)

    for i = 1, #self._items, 1 do
        self._items[i]:Hide()
    end

    local y = self._position.y
    for i = starting_idx, stopping_idx, 1 do
        self._items[i]:MoveTo(self._position.x, y)
        self._items[i]:Show()
        y = y + self._item_height
    end
end

return ListView
