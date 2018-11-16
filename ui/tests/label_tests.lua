local LuaUnit = require('luaunit')
local Label = require('ui/label')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
LabelTests = {}

--------------------------------------------------------------------------------
function LabelTests:SetUp()
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
function LabelTests:TestDefaultPositionIs00()
    local bg = Label:Label()
    LuaUnit.assertEquals(bg:Position(), { x = 0, y = 0 })
end

--------------------------------------------------------------------------------
function LabelTests:TestDefaultSizeIs00()
    local bg = Label:Label()
    LuaUnit.assertEquals(bg:Size(), { w = 0, h = 0 })
end
--------------------------------------------------------------------------------
function LabelTests:TestDefaultVisibilityIsFalse()
    local bg = Label:Label()
    LuaUnit.assertFalse(bg:IsVisible())
end

--------------------------------------------------------------------------------
function LabelTests:TestDefaultBackgroundColorIsBlack()
    local bg = Label:Label()
    LuaUnit.assertEquals(bg:BackgroundColor(), { a = 255, r = 0, g = 0, b = 0 })
end

--------------------------------------------------------------------------------
function LabelTests:TestDefaultForegroundColorIsWhite()
    local bg = Label:Label()
    LuaUnit.assertEquals(bg:ForegroundColor(), { a = 255, r = 255, g = 255, b = 255 })
end

--------------------------------------------------------------------------------
function LabelTests:TestDefaultFontIsConsolas()
    local bg = Label:Label()
    LuaUnit.assertEquals(bg:Font(), 'Consolas')
end

--------------------------------------------------------------------------------
function LabelTests:TestDefaultFontSizeIs12()
    local bg = Label:Label()
    LuaUnit.assertEquals(bg:FontSize(), 12)
end

--------------------------------------------------------------------------------
function LabelTests:TestDefaultTextIsEmpty()
    local bg = Label:Label()
    LuaUnit.assertEquals(bg:Text(), '')
end

--------------------------------------------------------------------------------
function LabelTests:TestMoveToUpdatesPosition()
    local bg = Label:Label()
    bg:MoveTo(11, 12)
    LuaUnit.assertEquals(bg:Position(), { x = 11, y = 12 })
end

--------------------------------------------------------------------------------
function LabelTests:TestDragByUpdatesPosition()
    local bg = Label:Label()
    bg:MoveTo(11, 12)
    bg:DragBy(2, 1)
    LuaUnit.assertEquals(bg:Position(), { x = 13, y = 13 })
end

--------------------------------------------------------------------------------
function LabelTests:TestSetSizeUpdatesSize()
    local bg = Label:Label()
    bg:SetSize(50, 100)
    LuaUnit.assertEquals(bg:Size(), { w = 50, h = 100 })
end

--------------------------------------------------------------------------------
function LabelTests:TestShowUpdatesVisibility()
    local bg = Label:Label()
    bg:Show()
    LuaUnit.assertTrue(bg:IsVisible())
end

--------------------------------------------------------------------------------
function LabelTests:TestHideUpdatesVisibility()
    local bg = Label:Label()
    bg:Show()
    bg:Hide()
    LuaUnit.assertFalse(bg:IsVisible())
end

--------------------------------------------------------------------------------
function LabelTests:TestSetBackgroundColorUpdatesColor()
    local bg = Label:Label()
    bg:SetBackgroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(bg:BackgroundColor(), { a = 100, r = 101, g = 102, b = 103 })
end

--------------------------------------------------------------------------------
function LabelTests:TestSetForegroundColorUpdatesColor()
    local bg = Label:Label()
    bg:SetForegroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(bg:ForegroundColor(), { a = 100, r = 101, g = 102, b = 103 })
end

--------------------------------------------------------------------------------
function LabelTests:TestSetFontUpdatesFont()
    local bg = Label:Label()
    bg:SetFont('Arial')
    LuaUnit.assertEquals(bg:Font(), 'Arial')
end

--------------------------------------------------------------------------------
function LabelTests:TestSetFontSizeUpdatesFontSize()
    local bg = Label:Label()
    bg:SetFontSize(20)
    LuaUnit.assertEquals(bg:FontSize(), 20)
end

--------------------------------------------------------------------------------
function LabelTests:TestSetTextUpdatesDisplayText()
    local bg = Label:Label()
    bg:SetText('Testing')
    LuaUnit.assertEquals(bg:Text(), 'Testing')
end

--------------------------------------------------------------------------------
function LabelTests:TestContainsPointReturnsFalseWhenOutsideBounds()
    local bg = Label:Label()
    bg:MoveTo(10, 10)
    bg:SetSize(10, 10)
    LuaUnit.assertFalse(bg:ContainsPoint(21, 21))
end

--------------------------------------------------------------------------------
function LabelTests:TestContainsPointReturnsTrueWhenInsideBounds()
    local bg = Label:Label()
    bg:MoveTo(10, 10)
    bg:SetSize(10, 10)
    LuaUnit.assertTrue(bg:ContainsPoint(20, 20))
end

--------------------------------------------------------------------------------
function LabelTests:TestTypeIsLabel()
    local bg = Label:Label()
    LuaUnit.assertEquals(bg:Type(), 'Label')
end

--------------------------------------------------------------------------------
function LabelTests:TestTextIsCreatedInConstructor()
    Label:Label()
    LuaUnit.assertEquals(windower.text.createcount, 1)
end

--------------------------------------------------------------------------------
function LabelTests:TestTextIsDestroyedInDestructor()
    local bg = Label:Label()
    bg:Destroy()
    LuaUnit.assertEquals(windower.text.deletecount, 1)
end

--------------------------------------------------------------------------------
function LabelTests:TestMoveToUpdatesText()
    local bg = Label:Label()
    windower.text.setlocationcount = 0
    bg:MoveTo(11, 12)
    LuaUnit.assertEquals(windower.text.setlocationcount, 1)
end

--------------------------------------------------------------------------------
function LabelTests:TestDragByUpdatesText()
    local bg = Label:Label()
    windower.text.setlocationcount = 0
    bg:MoveTo(11, 12)
    bg:DragBy(2, 1)
    LuaUnit.assertEquals(windower.text.setlocationcount, 2)
end

--------------------------------------------------------------------------------
function LabelTests:TestShowUpdatesText()
    local bg = Label:Label()
    windower.text.setvisibilitycount = 0
    windower.text.setbgvisibilitycount = 0
    bg:Show()
    LuaUnit.assertEquals(windower.text.setvisibilitycount, 1)
    LuaUnit.assertEquals(windower.text.setbgvisibilitycount, 1)
end

--------------------------------------------------------------------------------
function LabelTests:TestHideUpdatesText()
    local bg = Label:Label()
    windower.text.setvisibilitycount = 0
    windower.text.setbgvisibilitycount = 0
    bg:Hide()
    LuaUnit.assertEquals(windower.text.setvisibilitycount, 1)
    LuaUnit.assertEquals(windower.text.setbgvisibilitycount, 1)
end

--------------------------------------------------------------------------------
function LabelTests:TestSetBackgroundColorUpdatesText()
    local bg = Label:Label()
    windower.text.setbgcolorcount = 0
    bg:SetBackgroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(windower.text.setbgcolorcount, 1)
end

--------------------------------------------------------------------------------
function LabelTests:TestSetForegroundColorUpdatesText()
    local bg = Label:Label()
    windower.text.setcolorcount = 0
    bg:SetForegroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(windower.text.setcolorcount, 1)
end

--------------------------------------------------------------------------------
function LabelTests:TestSetFontUpdatesText()
    local bg = Label:Label()
    windower.text.setfontcount = 0
    bg:SetFont('Arial')
    LuaUnit.assertEquals(windower.text.setfontcount, 1)
end

--------------------------------------------------------------------------------
function LabelTests:TestSetFontSizeUpdatesText()
    local bg = Label:Label()
    windower.text.setfontsizecount = 0
    bg:SetFontSize(20)
    LuaUnit.assertEquals(windower.text.setfontsizecount, 1)
end

--------------------------------------------------------------------------------
function LabelTests:TestSetTextUpdatesText()
    local bg = Label:Label()
    windower.text.settextcount = 0
    bg:SetText('Testing')
    LuaUnit.assertEquals(windower.text.settextcount, 1)
end

LuaUnit.LuaUnit.run('LabelTests')