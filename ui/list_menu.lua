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
    return o
end

--------------------------------------------------------------------------------
function ListMenu:MoveTo(x, y)
    NilMenu.MoveTo(self, x, y)
    for i = 1, #self._items, 1 do
        self._items[i]:MoveTo(x, y)
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
    table.insert(self._items, item)
end

--------------------------------------------------------------------------------
function ListMenu:Clear()
    for i = 1, #self._items, 1 do
        self._items[i]:Destroy()
    end
    self._items = {}
end

return ListMenu
