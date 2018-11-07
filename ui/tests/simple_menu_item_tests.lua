local LuaUnit = require('luaunit')
local SimpleMenuItem = require('ui/simple_menu_item')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
SimpleMenuItemTests = {}

--------------------------------------------------------------------------------
function SimpleMenuItemTests:SetUp()
    windower = {}
    windower.text = {}

    windower.text.createcount = 0
    function windower.text.create()
        windower.text.createcount = windower.text.createcount + 1
    end

    windower.text.deletecount = 0
    function windower.text.delete()
        windower.text.deletecount = windower.text.deletecount + 1
    end

    windower.text.settextcount = 0
    function windower.text.set_text()
        windower.text.settextcount = windower.text.settextcount + 1
    end

    windower.text.setlocationcount = 0
    function windower.text.set_location()
        windower.text.setlocationcount = windower.text.setlocationcount + 1
    end

    windower.text.setvisibilitycount = 0
    function windower.text.set_visibility()
        windower.text.setvisibilitycount = windower.text.setvisibilitycount + 1
    end

    windower.text.setbgvisibilitycount = 0
    function windower.text.set_bg_visibility()
        windower.text.setbgvisibilitycount = windower.text.setbgvisibilitycount + 1
    end

    windower.text.setbgcolorcount = 0
    function windower.text.set_bg_color()
        windower.text.setbgcolorcount = windower.text.setbgcolorcount + 1
    end

    windower.text.setfontcount = 0
    function windower.text.set_font()
        windower.text.setfontcount = windower.text.setfontcount + 1
    end

    windower.text.setfontsizecount = 0
    function windower.text.set_font_size()
        windower.text.setfontsizecount = windower.text.setfontsizecount + 1
    end

    windower.text.setcolorcount = 0
    function windower.text.set_color()
        windower.text.setcolorcount = windower.text.setcolorcount + 1
    end

    windower.text.setstrokewidthcount = 0
    function windower.text.set_stroke_width()
        windower.text.setstrokewidthcount = windower.text.setstrokewidthcount + 1
    end

    windower.text.setstrokecolorcount = 0
    function windower.text.set_stroke_color()
        windower.text.setstrokecolorcount = windower.text.setstrokecolorcount + 1
    end
end

--------------------------------------------------------------------------------
function SimpleMenuItemTests:TestSimpleMenuItemDestroy()
    local i = SimpleMenuItem:SimpleMenuItem()
    LuaUnit.assertEquals(windower.text.deletecount, 0)
    LuaUnit.assertEquals(windower.text.createcount, 1)
    LuaUnit.assertEquals(windower.text.settextcount, 1)
    i:Destroy()
    LuaUnit.assertEquals(windower.text.deletecount, 1)
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
    LuaUnit.assertEquals(windower.text.setlocationcount, 1)
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
    LuaUnit.assertEquals(windower.text.setlocationcount, 2)
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