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
    o._visible = false
    o._contains = false
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
function TestMenuItem:Show()
    self._visible = true
end

--------------------------------------------------------------------------------
function TestMenuItem:Hide()
    self._visible = false
end

--------------------------------------------------------------------------------
function TestMenuItem:SetVisibility(visibility)
    if visibility then
        self:Show()
    else
        self:Hide()
    end
end

--------------------------------------------------------------------------------
function TestMenuItem:IsVisible()
    return self._visible
end

--------------------------------------------------------------------------------
function TestMenuItem:ContainsPoint(_, _)
    return self._contains
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
function ListMenuTests:TestListMenuAppendAddsNewItemsWithCorrectVisibility()
    local i = ListMenu:ListMenu()
    local item1 = TestMenuItem:TestMenuItem()
    local item2 = TestMenuItem:TestMenuItem()
    i:Append(item1)
    LuaUnit.assertFalse(item1:IsVisible())
    i:Show()
    i:Append(item2)
    LuaUnit.assertTrue(item1:IsVisible())
    LuaUnit.assertTrue(item2:IsVisible())
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
function ListMenuTests:TestListMenuShowMakesItemsVisible()
    local i = ListMenu:ListMenu()
    i:Show()
    LuaUnit.assertTrue(i:IsVisible())
end

--------------------------------------------------------------------------------
function ListMenuTests:TestListMenuHideMakesItemsInvisible()
    local i = ListMenu:ListMenu()
    i:Show()
    i:Hide()
    LuaUnit.assertFalse(i:IsVisible())
end

--------------------------------------------------------------------------------
function ListMenuTests:TestListMenuContainsNoPointsWhenEmpty()
    local i = ListMenu:ListMenu()
    LuaUnit.assertFalse(i:ContainsPoint(0, 0))
end

--------------------------------------------------------------------------------
function ListMenuTests:TestListMenuContainsPointWhenChildContainsPoint()
    local i = ListMenu:ListMenu()
    local item = TestMenuItem:TestMenuItem()
    item._contains = true
    i:Append(item)
    LuaUnit.assertTrue(i:ContainsPoint(0, 0))
end

--------------------------------------------------------------------------------
function ListMenuTests:TestListMenuContainsPointIsFalseWhenChildDoesNot()
    local i = ListMenu:ListMenu()
    local item = TestMenuItem:TestMenuItem()
    i:Append(item)
    LuaUnit.assertFalse(i:ContainsPoint(0, 0))
end

--------------------------------------------------------------------------------
function ListMenuTests:TestListMenuTypeIsListMenu()
    local i = ListMenu:ListMenu()
    LuaUnit.assertEquals(i:Type(), 'ListMenu')
end

LuaUnit.LuaUnit.run('ListMenuTests')