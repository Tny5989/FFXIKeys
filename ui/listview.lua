local Component = require('ui/component')
local ListItem = require('ui/listitem')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local ListView = Component:Component()
ListView.__index = ListView

--------------------------------------------------------------------------------
function ListView:ListView(scrollbar)
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

    o._item_height = 12
    o._items = {}
    o._items_per_page = 1
    o._scrollbar = scrollbar

    return o
end

--------------------------------------------------------------------------------
function ListView:Destroy()
    self:Clear()
end

--------------------------------------------------------------------------------
function ListView:MoveTo(x, y)
    Component.MoveTo(self, x, y)
    self:_scrollbar:MoveTo(self._position.x + self._size.w, self._position.y)
    -- TODO update item positions
end

--------------------------------------------------------------------------------
function ListView:DragBy(dx, dy)
    Component.DragBy(self, dx, dy)
    self:_scrollbar:MoveTo(self._position.x + self._size.w, self._position.y)
    -- TODO update item positions
end

--------------------------------------------------------------------------------
function ListView:SetSize(w, h)
    Component.SetSize(self, w, h)
    self:_scrollbar:SetSize(self:_scrollbar:Size().w, self._size.h)
    self:_scrollbar:MoveTo(self._position.x + self._size.w, self._position.y)
    -- TODO update list
end

--------------------------------------------------------------------------------
function ListView:Show()
    Component.Show(self)
    for i = 1, #self._items, 1 do
        self._items:Show()
    end
end

--------------------------------------------------------------------------------
function ListView:Hide()
    Component.Hide(self)
    for i = 1, #self._items, 1 do
        self._items:Hide()
    end
end

--------------------------------------------------------------------------------
function ListView:SetForegroundColor(alpha, red, green, blue)
    Component.SetForegroundColor(self, alpha, red, green, blue)
    for i = 1, #self._items, 1 do
        self._items:SetForegroundColor(alpha, red, green, blue)
    end
end

--------------------------------------------------------------------------------
function ListView:SetBackgroundColor(alpha, red, green, blue)
    Component.SetBackgroundColor(self, alpha, red, green, blue)
    for i = 1, #self._items, 1 do
        self._items:SetBackgroundColor(alpha, red, green, blue)
    end
end

--------------------------------------------------------------------------------
function ListView:SetFont(font_name)
    Component.SetFont(self, font_name)
    for i = 1, #self._items, 1 do
        self._items:SetFont(font_name)
    end
    -- TODO update list
end

--------------------------------------------------------------------------------
function ListView:SetFontSize(font_size)
    Component.SetFontSize(self, font_size)
    for i = 1, #self._items, 1 do
        self._items:SetFontSize(font_size)
    end
    -- TODO update list
end

--------------------------------------------------------------------------------
function ListView:AppendItem(item_text)
    local item = ListItem:ListItem(item_text)
    self:_style_item(item)
    table.insert(self._items, item)
    -- TODO update list
end

--------------------------------------------------------------------------------
function ListView:Clear()
    while #self._items > 0 do
        table.remove(self._items):Destroy()
    end
end

--------------------------------------------------------------------------------
function ListView:_style_item(item)
    item:SetForegroundColor(self:ForegroundColor())
    item:SetBackgroundColor(self:BackgroundColor())
    item:SetFontSize(self:FontSize())
    item:SetFont(self:Font())
    item:Hide()
end

--------------------------------------------------------------------------------
function ListView:_update_item_list()
    local h = self:Size().h
end

return ListView
