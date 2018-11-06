local LuaUnit = require('luaunit')
local NilMenu = require('ui/nil_menu')
local NilMenuItem = require('ui/nil_menu_item')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NilMenuTests = {}

--------------------------------------------------------------------------------
function NilMenuTests:TestNilMenuDefaultPosition()
    local i = NilMenu:NilMenu()
    LuaUnit.assertEquals(i:Position(), { x = 0, y = 0 })
end

--------------------------------------------------------------------------------
function NilMenuTests:TestNilMenuDefaultItemsIsEmpty()
    local i = NilMenu:NilMenu()
    LuaUnit.assertEquals(i:Size(), 0)
end

--------------------------------------------------------------------------------
function NilMenuTests:TestNilMenuMoveToUpdatesPosition()
    local i = NilMenu:NilMenu()
    i:MoveTo(10, 11)
    LuaUnit.assertEquals(i:Position(), { x = 10, y = 11 })
end

--------------------------------------------------------------------------------
function NilMenuTests:TestNilMenuDragByUpdatesPosition()
    local i = NilMenu:NilMenu()
    i:MoveTo(10, 11)
    i:DragBy(1, 1)
    LuaUnit.assertEquals(i:Position(), { x = 11, y = 12 })
end

--------------------------------------------------------------------------------
function NilMenuTests:TestNilMenuAppendDoesNotAddNewItem()
    local i = NilMenu:NilMenu()
    i:Append(NilMenuItem:NilMenuItem())
    LuaUnit.assertEquals(i:Size(), 0)
end

--------------------------------------------------------------------------------
function NilMenuTests:TestNilMenuClearDoesNothing()
    local i = NilMenu:NilMenu()
    i:Clear()
    LuaUnit.assertEquals(i:Size(), 0)
end

--------------------------------------------------------------------------------
function NilMenuTests:TestNilMenuTypeIsNilMenu()
    local i = NilMenu:NilMenu()
    LuaUnit.assertEquals(i:Type(), 'NilMenu')
end

LuaUnit.LuaUnit.run('NilMenuTests')