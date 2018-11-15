--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local ListPage = {}
ListPage.__index = ListPage

--------------------------------------------------------------------------------
function ListPage:ListPage()
    local o = {}
    setmetatable(o, self)
    o._items = {}
    o._type = 'ListPage'
    return o
end

--------------------------------------------------------------------------------
function ListPage:Destroy()
    self:Clear()
end

--------------------------------------------------------------------------------
function ListPage:Show()
    for i = 1, #self._items, 1 do
        self._items[i]:Show()
    end
end

--------------------------------------------------------------------------------
function ListPage:Hide()
    for i = 1, #self._items, 1 do
        self._items[i]:Hide()
    end
end

--------------------------------------------------------------------------------
function ListPage:Count()
    return #self._items
end

--------------------------------------------------------------------------------
function ListPage:Clear()
    while #self._items > 0 do
        self:RemoveItem(1)
    end
end

--------------------------------------------------------------------------------
function ListPage:InsertItem(item, idx)
    table.insert(self._items, idx, item)
end

--------------------------------------------------------------------------------
function ListPage:AppendItem(item)
    self:InsertItem(item, self:Count() + 1)
end

--------------------------------------------------------------------------------
function ListPage:RemoveItem(idx)
    table.remove(self._items, idx):Destroy()
end

--------------------------------------------------------------------------------
function ListPage:GetItem(idx)
    return self._items[idx]
end

--------------------------------------------------------------------------------
function ListPage:Type()
    return self._type
end

return ListPage
