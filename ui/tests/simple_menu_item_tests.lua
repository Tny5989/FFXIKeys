local LuaUnit = require('luaunit')
local SimpleMenuItem = require('ui/simple_menu_item')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
SimpleMenuItemTests = {}

--------------------------------------------------------------------------------
function SimpleMenuItemTests:SetUp()
    textobj = {}
    textobj.count = 0
    function textobj.destroy()
        textobj.count = textobj.count + 1
    end

    textobj.v = false
    function textobj.visible()
        return textobj.v
    end

    function textobj.show()
        textobj.v = true
    end

    function textobj.hide()
        textobj.v = false
    end

    textobj.pos_count = 0
    function textobj.pos()
        textobj.pos_count = textobj.pos_count + 1
    end

    texts = {}
    texts.count = 0
    function texts.new()
        texts.count = texts.count + 1
        return textobj
    end
end

--------------------------------------------------------------------------------
function SimpleMenuItemTests:TestSimpleMenuItemDestroy()
    local i = SimpleMenuItem:SimpleMenuItem()
    LuaUnit.assertEquals(textobj.count, 0)
    LuaUnit.assertEquals(texts.count, 1)
    i:Destroy()
    LuaUnit.assertEquals(textobj.count, 1)
end

--------------------------------------------------------------------------------
function SimpleMenuItemTests:TestSubmenuMenuDefaultText()
    local i = SimpleMenuItem:SimpleMenuItem()
    LuaUnit.assertEquals(i:DisplayText(), 'DefaultText')
end

--------------------------------------------------------------------------------
function SimpleMenuItemTests:TestSimpleMenuItemDefaultPosition()
    local i = SimpleMenuItem:SimpleMenuItem()
    LuaUnit.assertEquals(i:Position(), { x = 0, y = 0 })
end

--------------------------------------------------------------------------------
function SimpleMenuItemTests:TestSimpleMenuItemMoveToUpdatesPosition()
    local i = SimpleMenuItem:SimpleMenuItem()
    i:MoveTo(10, 11)
    LuaUnit.assertEquals(i:Position(), { x = 10, y = 11 })
end

--------------------------------------------------------------------------------
function SimpleMenuItemTests:TestSimpleMenuItemMoveToUpdatesTextPosition()
    local i = SimpleMenuItem:SimpleMenuItem()
    i:MoveTo(10, 11)
    LuaUnit.assertEquals(textobj.pos_count, 1)
end

--------------------------------------------------------------------------------
function SimpleMenuItemTests:TestSimpleMenuItemDragByUpdatesPosition()
    local i = SimpleMenuItem:SimpleMenuItem()
    i:MoveTo(10, 11)
    i:DragBy(1, 1)
    LuaUnit.assertEquals(i:Position(), { x = 11, y = 12 })
end

--------------------------------------------------------------------------------
function SimpleMenuItemTests:TestSimpleMenuItemDragByUpdatesTextPosition()
    local i = SimpleMenuItem:SimpleMenuItem()
    i:MoveTo(10, 11)
    i:DragBy(1, 1)
    LuaUnit.assertEquals(textobj.pos_count, 2)
end

--------------------------------------------------------------------------------
function SimpleMenuItemTests:TestSimpleMenuItemSizeIsCorrect()
    local i = SimpleMenuItem:SimpleMenuItem()
    LuaUnit.assertEquals(i:Size(), { width = 50, height = 20 })
end

--------------------------------------------------------------------------------
function SimpleMenuItemTests:TestSimpleMenuItemActivateTogglesState()
    local i = SimpleMenuItem:SimpleMenuItem()
    LuaUnit.assertFalse(i:IsActive())
    i:Activate()
    LuaUnit.assertTrue(i:IsActive())
    i:Activate()
    LuaUnit.assertFalse(i:IsActive())
end

--------------------------------------------------------------------------------
function SimpleMenuItemTests:TestSimpleMenuItemShowMakesTextVisible()
    local i = SimpleMenuItem:SimpleMenuItem()
    i:Show()
    LuaUnit.assertTrue(i:IsVisible())
end

--------------------------------------------------------------------------------
function SimpleMenuItemTests:TestSimpleMenuItemHideMakesTextInvisible()
    local i = SimpleMenuItem:SimpleMenuItem()
    i:Show()
    i:Hide()
    LuaUnit.assertFalse(i:IsVisible())
end

--------------------------------------------------------------------------------
function SimpleMenuItemTests:TestSimpleMenuItemSetVisibilityUpdatesVisibility()
    local i = SimpleMenuItem:SimpleMenuItem()
    i:SetVisibility(true)
    LuaUnit.assertTrue(i:IsVisible())
    i:SetVisibility(false)
    LuaUnit.assertFalse(i:IsVisible())
end

--------------------------------------------------------------------------------
function SimpleMenuItemTests:TestSimpleMenuItemTypeIsSimpleMenuItem()
    local i = SimpleMenuItem:SimpleMenuItem()
    LuaUnit.assertEquals(i:Type(), 'SimpleMenuItem')
end

LuaUnit.LuaUnit.run('SimpleMenuItemTests')