local LuaUnit = require('luaunit')
local NilMenuItem = require('ui/nil_menu_item')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NilMenuItemTests = {}

--------------------------------------------------------------------------------
function NilMenuItemTests:TestNilMenuItemDestroyNoTextRequirements()
    local i = NilMenuItem:NilMenuItem()
    i:Destroy()
end

--------------------------------------------------------------------------------
function NilMenuItemTests:TestNilMenuItemDisplayText()
    local i = NilMenuItem:NilMenuItem()
    LuaUnit.assertEquals(i:DisplayText(), 'NilMenuItem')
end

--------------------------------------------------------------------------------
function NilMenuItemTests:TestNilMenuItemDefaultPosition()
    local i = NilMenuItem:NilMenuItem()
    LuaUnit.assertEquals(i:Position(), { x = 0, y = 0 })
end

--------------------------------------------------------------------------------
function NilMenuItemTests:TestNilMenuItemMoveToUpdatesPosition()
    local i = NilMenuItem:NilMenuItem()
    i:MoveTo(10, 11)
    LuaUnit.assertEquals(i:Position(), { x = 10, y = 11 })
end

--------------------------------------------------------------------------------
function NilMenuItemTests:TestNilMenuItemDragByUpdatesPosition()
    local i = NilMenuItem:NilMenuItem()
    i:MoveTo(10, 11)
    i:DragBy(1, 1)
    LuaUnit.assertEquals(i:Position(), { x = 11, y = 12 })
end

--------------------------------------------------------------------------------
function NilMenuItemTests:TestNilMenuItemSizeIsZero()
    local i = NilMenuItem:NilMenuItem()
    LuaUnit.assertEquals(i:Size(), { width = 0, height = 0 })
end

--------------------------------------------------------------------------------
function NilMenuItemTests:TestNilMenuItemActivateDoesNothing()
    local i = NilMenuItem:NilMenuItem()
    LuaUnit.assertFalse(i:IsActive())
    i:Activate()
    LuaUnit.assertFalse(i:IsActive())
end

--------------------------------------------------------------------------------
function NilMenuItemTests:TestNilMenuItemShowDoesNothing()
    local i = NilMenuItem:NilMenuItem()
    texts = nil
    i:Show()
    LuaUnit.assertFalse(i:IsVisible())
end

--------------------------------------------------------------------------------
function NilMenuItemTests:TestNilMenuItemHideDoesNothing()
    local i = NilMenuItem:NilMenuItem()
    texts = nil
    i:Show()
    i:Hide()
    LuaUnit.assertFalse(i:IsVisible())
end

--------------------------------------------------------------------------------
function NilMenuItemTests:TestNilMenuItemSetVisibilityDoesNothing()
    local i = NilMenuItem:NilMenuItem()
    texts = nil
    i:SetVisibility(true)
    LuaUnit.assertFalse(i:IsVisible())
end

--------------------------------------------------------------------------------
function NilMenuItemTests:TestNilMenuItemTypeIsNilMenuItem()
    local i = NilMenuItem:NilMenuItem()
    LuaUnit.assertEquals(i:Type(), 'NilMenuItem')
end

LuaUnit.LuaUnit.run('NilMenuItemTests')