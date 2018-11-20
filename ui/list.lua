local Component = require('ui/component')
local Label = require('ui/label')
local PalatteFactory = require('u/style/palatte_factory')

--------------------------------------------------------------------------------
local ITEM_HEIGHT = 20

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local List = Component:Component()
List.__index = List

--------------------------------------------------------------------------------
function List:List()
    local o = Component:Component()
    setmetatable(o, self)
    o._items = {}
    o._display_items = {}
    o._current_page = 1
    o._page_count = 1
    o._type = 'List'
    return o
end

--------------------------------------------------------------------------------
function List:Destroy()
    Component.Destroy(self)
    self:Clear()
end

--------------------------------------------------------------------------------
function List:MoveTo(x, y)
    Component.MoveTo(self, x, y)
    local p = self:Position()
    for i = 1, #self._display_items, 1 do
        self._display_items[i]:MoveTo(p.x, p.y)
        p.y = p.y + self._display_items[i]:Size().h
    end
end

--------------------------------------------------------------------------------
function List:DragBy(dx, dy)
    Component.DragBy(self, dx, dy)
    local p = self:Position()
    for i = 1, #self._display_items, 1 do
        self._display_items[i]:MoveTo(p.x, p.y)
        p.y = p.y + self._display_items[i]:Size().h
    end
end

--------------------------------------------------------------------------------
function List:SetSize(w, h)
    Component.SetSize(self, w, h)
    self:Update()
end

--------------------------------------------------------------------------------
function List:Show()
    Component.Show(self)
    for i = 1, #self._display_items, 1 do
        self._display_items[i]:Show()
    end
end

--------------------------------------------------------------------------------
function List:Hide()
    Component.Hide(self)
    for i = 1, #self._display_items, 1 do
        self._display_items[i]:Hide()
    end
end

--------------------------------------------------------------------------------
function List:Append(text)
    self:Insert(self:Count() + 1, text)
end

--------------------------------------------------------------------------------
function List:Insert(idx, text)
    table.insert(self._items, idx, text)
    self:Update()
end

--------------------------------------------------------------------------------
function List:Remove(idx)
    self:RemoveAt(idx)
    self:Update()
end

--------------------------------------------------------------------------------
function List:Clear()
    while self:Count() > 0 do
        self:RemoveAt(1)
    end
    while #self._display_items > 0 do
        table.remove(self._display_items):Destroy()
    end
end

--------------------------------------------------------------------------------
function List:Count()
    return #self._items
end

--------------------------------------------------------------------------------
function List:ItemAt(idx)
    return self._items[idx]
end

--------------------------------------------------------------------------------
function List:RemoveAt(idx)
    table.remove(self._items, idx)
end

--------------------------------------------------------------------------------
function List:SetCurrentPage(idx)
    self._current_page = math.max(1, idx)
    self._current_page = math.min(self._page_count, self._current_page)
    self:Update()
end

--------------------------------------------------------------------------------
function List:PageCount()
    return self._page_count
end

--------------------------------------------------------------------------------
function List:CurrentPage()
    return self._current_page
end

--------------------------------------------------------------------------------
function List:Update()
    local items_per_page = self:Size().h / ITEM_HEIGHT
    while #self._display_items > items_per_page do
        table.remove(self._display_items):Destroy()
    end
    while #self._display_items < items_per_page do
        table.insert(self._display_items, Label:Label())
    end
    for i = 1, #self._display_items, 1 do
        self._display_items[i]:Hide()
    end

    self._page_count = math.max(math.ceil(#self._items / items_per_page), 1)
    self._current_page = math.max(math.min(self._page_count, self._current_page), 1)

    local start_idx = (self._current_page - 1) * items_per_page + 1
    local stop_idx = math.min(start_idx + items_per_page - 1, #self._items)

    local p = self:Position()
    local idx = start_idx
    for i = 1, #self._display_items, 1 do
        if idx <= stop_idx then
            self._display_items[i]:SetText(self._items[idx])
            self._display_items[i]:SetPalatte(PalatteFactory.Get('list_normal'))
            self._display_items[i]:MoveTo(p.x, p.y)
            self._display_items[i]:SetSize(self:Size().w, ITEM_HEIGHT)
            if self:IsVisible() then
                self._display_items[i]:Show()
            end

            p.y = p.y + ITEM_HEIGHT
        end
        idx = idx + 1
    end

end

return List
