local LuaUnit = require('luaunit')
local ListMenu = require('ui/list_menu')
local NilMenuItem = require('ui/nil_menu_item')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local TestMenuItem = NilMenuItem:NilMenuItem()
TestMenuItem.__index = TestMenuItem

--------------------------------------------------------------------------------
function TestMenuItem:TestMenuItem()
    local o = {}
    setmetatable(o, self)
    o._type = 'TestMenuItem'
    o._destroy_count = 0
    o._active = false
    o._position = { x = 0, y = 0 }
    return o
end

--------------------------------------------------------------------------------
function TestMenuItem:Destroy()
    self._destroy_count = self._destroy_count + 1
end

--------------------------------------------------------------------------------
function TestMenuItem:DestroyCount()
    return self._destroy_count
end

--------------------------------------------------------------------------------
function TestMenuItem:Size()
    return { width = 10, height = 20 }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ListMenuTests = {}

--------------------------------------------------------------------------------
function ListMenuTests:TestListMenuDefaultPosition()
    local i = ListMenu:ListMenu()
    LuaUnit.assertEquals(i:Position(), { x = 0, y = 0 })
end

--------------------------------------------------------------------------------
function ListMenuTests:TestListMenuDefaultItemsIsEmpty()
    local i = ListMenu:ListMenu()
    LuaUnit.assertEquals(i:Size(), 0)
end

--------------------------------------------------------------------------------
function ListMenuTests:TestListMenuMoveToUpdatesPosition()
    local i = ListMenu:ListMenu()
    i:MoveTo(10, 11)
    LuaUnit.assertEquals(i:Position(), { x = 10, y = 11 })
end

--------------------------------------------------------------------------------
function ListMenuTests:TestListMenuMoveToUpdatesItems()
    local i = ListMenu:ListMenu()
    local item1 = TestMenuItem:TestMenuItem()
    i:Append(item1)
    i:MoveTo(10, 11)
    LuaUnit.assertEquals(item1:Position(), { x = 10, y = 11 })
end

--------------------------------------------------------------------------------
function ListMenuTests:TestListMenuDragByUpdatesPosition()
    local i = ListMenu:ListMenu()
    i:MoveTo(10, 11)
    i:DragBy(1, 1)
    LuaUnit.assertEquals(i:Position(), { x = 11, y = 12 })
end

--------------------------------------------------------------------------------
function ListMenuTests:TestListMenuDragByUpdatesItems()
    local i = ListMenu:ListMenu()
    local item1 = TestMenuItem:TestMenuItem()
    i:Append(item1)
    i:MoveTo(10, 11)
    i:DragBy(1, 1)
    LuaUnit.assertEquals(item1:Position(), { x = 11, y = 12 })
end

--------------------------------------------------------------------------------
function ListMenuTests:TestListMenuAppendAddsNewItem()
    local i = ListMenu:ListMenu()
    i:Append(TestMenuItem:TestMenuItem())
    LuaUnit.assertEquals(i:Size(), 1)
end

--------------------------------------------------------------------------------
function ListMenuTests:TestListMenuAppendAddsNewItemsAtCorrectPosition()
    local i = ListMenu:ListMenu()
    local item1 = TestMenuItem:TestMenuItem()
    local item2 = TestMenuItem:TestMenuItem()
    i:Append(item1)
    i:Append(item2)
    LuaUnit.assertEquals(item1:Position(), { x = 0, y = 0 })
    LuaUnit.assertEquals(item2:Position(), { x = 0, y = 20 })
end

--------------------------------------------------------------------------------
function ListMenuTests:TestListMenuClearClearsAllItems()
    local i = ListMenu:ListMenu()
    i:Append(TestMenuItem:TestMenuItem())
    i:Append(TestMenuItem:TestMenuItem())
    i:Clear()
    LuaUnit.assertEquals(i:Size(), 0)
end

--------------------------------------------------------------------------------
function ListMenuTests:TestListMenuDestroysItems()
    local i = ListMenu:ListMenu()
    local item1 = TestMenuItem:TestMenuItem()
    local item2 = TestMenuItem:TestMenuItem()
    i:Append(item1)
    i:Append(item2)
    i:Clear()
    LuaUnit.assertEquals(item1:DestroyCount(), 1)
    LuaUnit.assertEquals(item2:DestroyCount(), 1)
end

--------------------------------------------------------------------------------
function ListMenuTests:TestListMenuTypeIsListMenu()
    local i = ListMenu:ListMenu()
    LuaUnit.assertEquals(i:Type(), 'ListMenu')
end

LuaUnit.LuaUnit.run('ListMenuTests')