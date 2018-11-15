local LuaUnit = require('luaunit')
local ListView = require('ui/listview')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ListViewTests = {}

--------------------------------------------------------------------------------
function ListViewTests:TestDefaultPositionIs00()
    local bg = ListView:ListView()
    LuaUnit.assertEquals(bg:Position(), { x = 0, y = 0 })
end

--------------------------------------------------------------------------------
function ListViewTests:TestDefaultSizeIs00()
    local bg = ListView:ListView()
    LuaUnit.assertEquals(bg:Size(), { w = 0, h = 0 })
end
--------------------------------------------------------------------------------
function ListViewTests:TestDefaultVisibilityIsFalse()
    local bg = ListView:ListView()
    LuaUnit.assertFalse(bg:IsVisible())
end

--------------------------------------------------------------------------------
function ListViewTests:TestDefaultBackgroundColorIsBlack()
    local bg = ListView:ListView()
    LuaUnit.assertEquals(bg:BackgroundColor(), { a = 255, r = 0, g = 0, b = 0 })
end

--------------------------------------------------------------------------------
function ListViewTests:TestDefaultForegroundColorIsBlack()
    local bg = ListView:ListView()
    LuaUnit.assertEquals(bg:ForegroundColor(), { a = 255, r = 0, g = 0, b = 0 })
end

--------------------------------------------------------------------------------
function ListViewTests:TestDefaultFontIsConsolas()
    local bg = ListView:ListView()
    LuaUnit.assertEquals(bg:Font(), 'Consolas')
end

--------------------------------------------------------------------------------
function ListViewTests:TestDefaultFontSizeIs12()
    local bg = ListView:ListView()
    LuaUnit.assertEquals(bg:FontSize(), 12)
end

--------------------------------------------------------------------------------
function ListViewTests:TestMoveToUpdatesPosition()
    local bg = ListView:ListView()
    bg:MoveTo(11, 12)
    LuaUnit.assertEquals(bg:Position(), { x = 11, y = 12 })
end

--------------------------------------------------------------------------------
function ListViewTests:TestDragByUpdatesPosition()
    local bg = ListView:ListView()
    bg:MoveTo(11, 12)
    bg:DragBy(2, 1)
    LuaUnit.assertEquals(bg:Position(), { x = 13, y = 13 })
end

--------------------------------------------------------------------------------
function ListViewTests:TestSetSizeUpdatesSize()
    local bg = ListView:ListView()
    bg:SetSize(50, 100)
    LuaUnit.assertEquals(bg:Size(), { w = 50, h = 100 })
end

--------------------------------------------------------------------------------
function ListViewTests:TestShowUpdatesVisibility()
    local bg = ListView:ListView()
    bg:Show()
    LuaUnit.assertTrue(bg:IsVisible())
end

--------------------------------------------------------------------------------
function ListViewTests:TestHideUpdatesVisibility()
    local bg = ListView:ListView()
    bg:Show()
    bg:Hide()
    LuaUnit.assertFalse(bg:IsVisible())
end

--------------------------------------------------------------------------------
function ListViewTests:TestSetBackgroundColorUpdatesColor()
    local bg = ListView:ListView()
    bg:SetBackgroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(bg:BackgroundColor(), { a = 100, r = 101, g = 102, b = 103 })
end

--------------------------------------------------------------------------------
function ListViewTests:TestSetForegroundColorUpdatesColor()
    local bg = ListView:ListView()
    bg:SetForegroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(bg:ForegroundColor(), { a = 100, r = 101, g = 102, b = 103 })
end

--------------------------------------------------------------------------------
function ListViewTests:TestSetFontUpdatesFont()
    local bg = ListView:ListView()
    bg:SetFont('Arial')
    LuaUnit.assertEquals(bg:Font(), 'Arial')
end

--------------------------------------------------------------------------------
function ListViewTests:TestSetFontSizeUpdatesFontSize()
    local bg = ListView:ListView()
    bg:SetFontSize(20)
    LuaUnit.assertEquals(bg:FontSize(), 20)
end

--------------------------------------------------------------------------------
function ListViewTests:TestContainsPointReturnsFalseWhenOutsideBounds()
    local bg = ListView:ListView()
    bg:MoveTo(10, 10)
    bg:SetSize(10, 10)
    LuaUnit.assertFalse(bg:ContainsPoint(21, 21))
end

--------------------------------------------------------------------------------
function ListViewTests:TestContainsPointReturnsTrueWhenInsideBounds()
    local bg = ListView:ListView()
    bg:MoveTo(10, 10)
    bg:SetSize(10, 10)
    LuaUnit.assertTrue(bg:ContainsPoint(20, 20))
end

--------------------------------------------------------------------------------
function ListViewTests:TestTypeIsListView()
    local bg = ListView:ListView()
    LuaUnit.assertEquals(bg:Type(), 'ListView')
end

LuaUnit.LuaUnit.run('ListViewTests')