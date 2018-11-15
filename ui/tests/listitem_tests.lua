local LuaUnit = require('luaunit')
local ListItem = require('ui/listitem')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ListItemTests = {}

--------------------------------------------------------------------------------
function ListItemTests:SetUp()
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

    windower.text.setcolorcount = 0
    function windower.text.set_color()
        windower.text.setcolorcount = windower.text.setcolorcount + 1
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

    windower.text.settextcount = 0
    function windower.text.set_text()
        windower.text.settextcount = windower.text.settextcount + 1
    end
end

--------------------------------------------------------------------------------
function ListItemTests:TestDefaultPositionIs00()
    local bg = ListItem:ListItem()
    LuaUnit.assertEquals(bg:Position(), { x = 0, y = 0 })
end

--------------------------------------------------------------------------------
function ListItemTests:TestDefaultSizeIs00()
    local bg = ListItem:ListItem()
    LuaUnit.assertEquals(bg:Size(), { w = 0, h = 0 })
end
--------------------------------------------------------------------------------
function ListItemTests:TestDefaultVisibilityIsFalse()
    local bg = ListItem:ListItem()
    LuaUnit.assertFalse(bg:IsVisible())
end

--------------------------------------------------------------------------------
function ListItemTests:TestDefaultBackgroundColorIsBlack()
    local bg = ListItem:ListItem()
    LuaUnit.assertEquals(bg:BackgroundColor(), { a = 255, r = 0, g = 0, b = 0 })
end

--------------------------------------------------------------------------------
function ListItemTests:TestDefaultForegroundColorIsBlack()
    local bg = ListItem:ListItem()
    LuaUnit.assertEquals(bg:ForegroundColor(), { a = 255, r = 0, g = 0, b = 0 })
end

--------------------------------------------------------------------------------
function ListItemTests:TestDefaultFontIsConsolas()
    local bg = ListItem:ListItem()
    LuaUnit.assertEquals(bg:Font(), 'Consolas')
end

--------------------------------------------------------------------------------
function ListItemTests:TestDefaultFontSizeIs12()
    local bg = ListItem:ListItem()
    LuaUnit.assertEquals(bg:FontSize(), 12)
end

--------------------------------------------------------------------------------
function ListItemTests:TestDefaultTextIsEmpty()
    local bg = ListItem:ListItem()
    LuaUnit.assertEquals(bg:Text(), '')
end

--------------------------------------------------------------------------------
function ListItemTests:TestMoveToUpdatesPosition()
    local bg = ListItem:ListItem()
    bg:MoveTo(11, 12)
    LuaUnit.assertEquals(bg:Position(), { x = 11, y = 12 })
end

--------------------------------------------------------------------------------
function ListItemTests:TestDragByUpdatesPosition()
    local bg = ListItem:ListItem()
    bg:MoveTo(11, 12)
    bg:DragBy(2, 1)
    LuaUnit.assertEquals(bg:Position(), { x = 13, y = 13 })
end

--------------------------------------------------------------------------------
function ListItemTests:TestSetSizeUpdatesSize()
    local bg = ListItem:ListItem()
    bg:SetSize(50, 100)
    LuaUnit.assertEquals(bg:Size(), { w = 50, h = 100 })
end

--------------------------------------------------------------------------------
function ListItemTests:TestShowUpdatesVisibility()
    local bg = ListItem:ListItem()
    bg:Show()
    LuaUnit.assertTrue(bg:IsVisible())
end

--------------------------------------------------------------------------------
function ListItemTests:TestHideUpdatesVisibility()
    local bg = ListItem:ListItem()
    bg:Show()
    bg:Hide()
    LuaUnit.assertFalse(bg:IsVisible())
end

--------------------------------------------------------------------------------
function ListItemTests:TestSetBackgroundColorUpdatesColor()
    local bg = ListItem:ListItem()
    bg:SetBackgroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(bg:BackgroundColor(), { a = 100, r = 101, g = 102, b = 103 })
end

--------------------------------------------------------------------------------
function ListItemTests:TestSetForegroundColorUpdatesColor()
    local bg = ListItem:ListItem()
    bg:SetForegroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(bg:ForegroundColor(), { a = 100, r = 101, g = 102, b = 103 })
end

--------------------------------------------------------------------------------
function ListItemTests:TestSetFontUpdatesFont()
    local bg = ListItem:ListItem()
    bg:SetFont('Arial')
    LuaUnit.assertEquals(bg:Font(), 'Arial')
end

--------------------------------------------------------------------------------
function ListItemTests:TestSetFontSizeUpdatesFontSize()
    local bg = ListItem:ListItem()
    bg:SetFontSize(20)
    LuaUnit.assertEquals(bg:FontSize(), 20)
end

--------------------------------------------------------------------------------
function ListItemTests:TestSetTextUpdatesDisplayText()
    local bg = ListItem:ListItem()
    bg:SetText('Testing')
    LuaUnit.assertEquals(bg:Text(), 'Testing')
end

--------------------------------------------------------------------------------
function ListItemTests:TestContainsPointReturnsFalseWhenOutsideBounds()
    local bg = ListItem:ListItem()
    bg:MoveTo(10, 10)
    bg:SetSize(10, 10)
    LuaUnit.assertFalse(bg:ContainsPoint(21, 21))
end

--------------------------------------------------------------------------------
function ListItemTests:TestContainsPointReturnsTrueWhenInsideBounds()
    local bg = ListItem:ListItem()
    bg:MoveTo(10, 10)
    bg:SetSize(10, 10)
    LuaUnit.assertTrue(bg:ContainsPoint(20, 20))
end

--------------------------------------------------------------------------------
function ListItemTests:TestTypeIsListItem()
    local bg = ListItem:ListItem()
    LuaUnit.assertEquals(bg:Type(), 'ListItem')
end

--------------------------------------------------------------------------------
function ListItemTests:TestTextIsCreatedInConstructor()
    ListItem:ListItem()
    LuaUnit.assertEquals(windower.text.createcount, 1)
end

--------------------------------------------------------------------------------
function ListItemTests:TestTextIsDestroyedInDestructor()
    local bg = ListItem:ListItem()
    bg:Destroy()
    LuaUnit.assertEquals(windower.text.deletecount, 1)
end

--------------------------------------------------------------------------------
function ListItemTests:TestMoveToUpdatesText()
    local bg = ListItem:ListItem()
    windower.text.setlocationcount = 0
    bg:MoveTo(11, 12)
    LuaUnit.assertEquals(windower.text.setlocationcount, 1)
end

--------------------------------------------------------------------------------
function ListItemTests:TestDragByUpdatesText()
    local bg = ListItem:ListItem()
    windower.text.setlocationcount = 0
    bg:MoveTo(11, 12)
    bg:DragBy(2, 1)
    LuaUnit.assertEquals(windower.text.setlocationcount, 2)
end

--------------------------------------------------------------------------------
function ListItemTests:TestShowUpdatesText()
    local bg = ListItem:ListItem()
    windower.text.setvisibilitycount = 0
    windower.text.setbgvisibilitycount = 0
    bg:Show()
    LuaUnit.assertEquals(windower.text.setvisibilitycount, 1)
    LuaUnit.assertEquals(windower.text.setbgvisibilitycount, 1)
end

--------------------------------------------------------------------------------
function ListItemTests:TestHideUpdatesText()
    local bg = ListItem:ListItem()
    windower.text.setvisibilitycount = 0
    windower.text.setbgvisibilitycount = 0
    bg:Hide()
    LuaUnit.assertEquals(windower.text.setvisibilitycount, 1)
    LuaUnit.assertEquals(windower.text.setbgvisibilitycount, 1)
end

--------------------------------------------------------------------------------
function ListItemTests:TestSetBackgroundColorUpdatesText()
    local bg = ListItem:ListItem()
    windower.text.setbgcolorcount = 0
    bg:SetBackgroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(windower.text.setbgcolorcount, 1)
end

--------------------------------------------------------------------------------
function ListItemTests:TestSetForegroundColorUpdatesText()
    local bg = ListItem:ListItem()
    windower.text.setcolorcount = 0
    bg:SetForegroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(windower.text.setcolorcount, 1)
end

--------------------------------------------------------------------------------
function ListItemTests:TestSetFontUpdatesText()
    local bg = ListItem:ListItem()
    windower.text.setfontcount = 0
    bg:SetFont('Arial')
    LuaUnit.assertEquals(windower.text.setfontcount, 1)
end

--------------------------------------------------------------------------------
function ListItemTests:TestSetFontSizeUpdatesText()
    local bg = ListItem:ListItem()
    windower.text.setfontsizecount = 0
    bg:SetFontSize(20)
    LuaUnit.assertEquals(windower.text.setfontsizecount, 1)
end

--------------------------------------------------------------------------------
function ListItemTests:TestSetTextUpdatesText()
    local bg = ListItem:ListItem()
    windower.text.settextcount = 0
    bg:SetText('Testing')
    LuaUnit.assertEquals(windower.text.settextcount, 1)
end

LuaUnit.LuaUnit.run('ListItemTests')