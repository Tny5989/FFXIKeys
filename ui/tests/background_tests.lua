local LuaUnit = require('luaunit')
local Background = require('ui/background')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
BackgroundTests = {}

--------------------------------------------------------------------------------
function BackgroundTests:TestDefaultPositionIs00()
    local bg = Background:Background()
    LuaUnit.assertEquals(bg:Position(), { x = 0, y = 0 })
end

--------------------------------------------------------------------------------
function BackgroundTests:TestDefaultSizeIs00()
    local bg = Background:Background()
    LuaUnit.assertEquals(bg:Size(), { w = 0, h = 0 })
end
--------------------------------------------------------------------------------
function BackgroundTests:TestDefaultVisibilityIsFalse()
    local bg = Background:Background()
    LuaUnit.assertFalse(bg:IsVisible())
end

--------------------------------------------------------------------------------
function BackgroundTests:TestDefaultColorIsBlack()
    local bg = Background:Background()
    LuaUnit.assertEquals(bg:Color(), { a = 255, r = 0, g = 0, b = 0 })
end

--------------------------------------------------------------------------------
function BackgroundTests:TestMoveToUpdatesPosition()
    local bg = Background:Background()
    bg:MoveTo(11, 12)
    LuaUnit.assertEquals(bg:Position(), { x = 11, y = 12 })
end

--------------------------------------------------------------------------------
function BackgroundTests:TestDragByUpdatesPosition()
    local bg = Background:Background()
    bg:MoveTo(11, 12)
    bg:DragBy(2, 1)
    LuaUnit.assertEquals(bg:Position(), { x = 13, y = 13 })
end

--------------------------------------------------------------------------------
function BackgroundTests:TestSetSizeUpdatesSize()
    local bg = Background:Background()
    bg:SetSize(50, 100)
    LuaUnit.assertEquals(bg:Size(), { w = 50, h = 100 })
end

--------------------------------------------------------------------------------
function BackgroundTests:TestShowUpdatesVisibility()
    local bg = Background:Background()
    bg:Show()
    LuaUnit.assertTrue(bg:IsVisible())
end

--------------------------------------------------------------------------------
function BackgroundTests:TestHideUpdatesVisibility()
    local bg = Background:Background()
    bg:Show()
    bg:Hide()
    LuaUnit.assertFalse(bg:IsVisible())
end

--------------------------------------------------------------------------------
function BackgroundTests:TestSetColorUpdatesColor()
    local bg = Background:Background()
    bg:SetColor(100, 101, 102, 103)
    LuaUnit.assertEquals(bg:Color(), { a = 100, r = 101, g = 102, b = 103 })
end

--------------------------------------------------------------------------------
function BackgroundTests:TestContainsPointReturnsFalseWhenOutsideBounds()
    local bg = Background:Background()
    bg:MoveTo(10, 10)
    bg:SetSize(10, 10)
    LuaUnit.assertFalse(bg:ContainsPoint(21, 21))
end

--------------------------------------------------------------------------------
function BackgroundTests:TestContainsPointReturnsTrueWhenInsideBounds()
    local bg = Background:Background()
    bg:MoveTo(10, 10)
    bg:SetSize(10, 10)
    LuaUnit.assertTrue(bg:ContainsPoint(20, 20))
end

--------------------------------------------------------------------------------
function BackgroundTests:TestTypeIsBackground()
    local bg = Background:Background()
    LuaUnit.assertEquals(bg:Type(), 'Background')
end

LuaUnit.LuaUnit.run('BackgroundTests')