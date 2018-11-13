local NilMenu = require('ui/nil_menu')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local ListMenu = NilMenu:NilMenu()
ListMenu.__index = ListMenu

--------------------------------------------------------------------------------
function ListMenu:ListMenu()
    local o = {}
    setmetatable(o, self)
    o._type = 'ListMenu'
    o._position = { x = 0, y = 0 }
    o._items = {}
    o._visible = false
    o._selected = 0
    return o
end

--------------------------------------------------------------------------------
function ListMenu:MoveTo(x, y)
    NilMenu.MoveTo(self, x, y)
    local x = x
    local y = y
    for i = 1, #self._items, 1 do
        self._items[i]:MoveTo(x, y)
        x = x + self._items[i]:Size().height
    end
end

--------------------------------------------------------------------------------
function ListMenu:DragBy(dx, dy)
    NilMenu.DragBy(self, dx, dy)
    for i = 1, #self._items, 1 do
        self._items[i]:DragBy(dx, dy)
    end
end

--------------------------------------------------------------------------------
function ListMenu:Size()
    return #self._items
end

--------------------------------------------------------------------------------
function ListMenu:Append(item)
    local pos = self:Position()
    for i = 1, #self._items, 1 do
        local dim = self._items[i]:Size()
        pos.y = pos.y + dim.height
    end
    item:MoveTo(pos.x, pos.y)
    item:SetVisibility(self._visible)
    table.insert(self._items, item)
end

--------------------------------------------------------------------------------
function ListMenu:Clear()
    for i = 1, #self._items, 1 do
        self._items[i]:Destroy()
    end
    self._items = {}
end

--------------------------------------------------------------------------------
function ListMenu:Show()
    self._visible = true
    for i = 1, #self._items, 1 do
        self._items[i]:Show()
    end
end

--------------------------------------------------------------------------------
function ListMenu:Hide()
    self._visible = false
    for i = 1, #self._items, 1 do
        self._items[i]:Hide()
    end
end

--------------------------------------------------------------------------------
function ListMenu:IsVisible()
    return self._visible
end

--------------------------------------------------------------------------------
function ListMenu:ContainsPoint(x, y)
    for i = 1, #self._items, 1 do
        if self._items[i]:ContainsPoint(x, y) then
            return i
        end
    end

    return 0
end

--------------------------------------------------------------------------------
function ListMenu:OnMouseMove(x, y, dx, dy)
    if self._selected > 0 then
        self:DragBy(dx, dy)
    else
        for i = 1, #self._items, 1 do
            self._items[i]:Activate(self._items[i]:ContainsPoint(x, y))
        end
    end
    return self._selected > 0
end

--------------------------------------------------------------------------------
function ListMenu:OnMouseLeftClick(x, y)
    local idx = self:ContainsPoint(x, y)
    if idx > 0 then
        self._selected = idx
        return true
    else
        self._selected = idx
        return false
    end
end

--------------------------------------------------------------------------------
function ListMenu:OnMouseLeftRelease(x, y)
    if self._selected > 0 then
        self._selected = 0
        return true
    else
        return false
    end
end

return ListMenu
