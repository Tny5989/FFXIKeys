local LuaUnit = require('luaunit')
local Background = require('ui/background')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
BackgroundTests = {}

--------------------------------------------------------------------------------
function BackgroundTests:SetUp()
    windower = {}
    windower.prim = {}

    windower.prim.createcount = 0
    function windower.prim.create()
        windower.prim.createcount = windower.prim.createcount + 1
    end

    windower.prim.deletecount = 0
    function windower.prim.delete()
        windower.prim.deletecount = windower.prim.deletecount + 1
    end

    windower.prim.setpositioncount = 0
    function windower.prim.set_position()
        windower.prim.setpositioncount = windower.prim.setpositioncount + 1
    end

    windower.prim.setsizecount = 0
    function windower.prim.set_size()
        windower.prim.setsizecount = windower.prim.setsizecount + 1
    end

    windower.prim.setvisibilitycount = 0
    function windower.prim.set_visibility()
        windower.prim.setvisibilitycount = windower.prim.setvisibilitycount + 1
    end

    windower.prim.setcolorcount = 0
    function windower.prim.set_color()
        windower.prim.setcolorcount = windower.prim.setcolorcount + 1
    end
end

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
function BackgroundTests:TestDefaultBackgroundColorIsBlack()
    local bg = Background:Background()
    LuaUnit.assertEquals(bg:BackgroundColor(), { a = 255, r = 0, g = 0, b = 0 })
end

--------------------------------------------------------------------------------
function BackgroundTests:TestDefaultForegroundColorIsBlack()
    local bg = Background:Background()
    LuaUnit.assertEquals(bg:ForegroundColor(), { a = 255, r = 0, g = 0, b = 0 })
end

--------------------------------------------------------------------------------
function BackgroundTests:TestDefaultFontIsConsolas()
    local bg = Background:Background()
    LuaUnit.assertEquals(bg:Font(), 'Consolas')
end

--------------------------------------------------------------------------------
function BackgroundTests:TestDefaultFontSizeIs12()
    local bg = Background:Background()
    LuaUnit.assertEquals(bg:FontSize(), 12)
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
function BackgroundTests:TestSetBackgroundColorUpdatesColor()
    local bg = Background:Background()
    bg:SetBackgroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(bg:BackgroundColor(), { a = 100, r = 101, g = 102, b = 103 })
end

--------------------------------------------------------------------------------
function BackgroundTests:TestSetForegroundColorUpdatesColor()
    local bg = Background:Background()
    bg:SetForegroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(bg:ForegroundColor(), { a = 100, r = 101, g = 102, b = 103 })
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

--------------------------------------------------------------------------------
function BackgroundTests:TestPrimIsCreatedInConstructor()
    Background:Background()
    LuaUnit.assertEquals(windower.prim.createcount, 1)
end

--------------------------------------------------------------------------------
function BackgroundTests:TestPrimIsDestroyedInDesstructor()
    local bg = Background:Background()
    bg:Destroy()
    LuaUnit.assertEquals(windower.prim.deletecount, 1)
end

--------------------------------------------------------------------------------
function BackgroundTests:TestMoveToUpdatesPrim()
    local bg = Background:Background()
    bg:MoveTo(11, 12)
    LuaUnit.assertEquals(windower.prim.setpositioncount, 1)
end

--------------------------------------------------------------------------------
function BackgroundTests:TestDragByUpdatesPrim()
    local bg = Background:Background()
    bg:MoveTo(11, 12)
    bg:DragBy(2, 1)
    LuaUnit.assertEquals(windower.prim.setpositioncount, 2)
end

--------------------------------------------------------------------------------
function BackgroundTests:TestSetSizeUpdatesPrim()
    local bg = Background:Background()
    bg:SetSize(10, 10)
    LuaUnit.assertEquals(windower.prim.setsizecount, 1)
end

--------------------------------------------------------------------------------
function BackgroundTests:TestShowUpdatesPrim()
    local bg = Background:Background()
    bg:Show()
    LuaUnit.assertEquals(windower.prim.setvisibilitycount, 1)
end

--------------------------------------------------------------------------------
function BackgroundTests:TestHideUpdatesPrim()
    local bg = Background:Background()
    bg:Hide()
    LuaUnit.assertEquals(windower.prim.setvisibilitycount, 1)
end

--------------------------------------------------------------------------------
function BackgroundTests:TestSetBackgroundColorUpdatesPrim()
    local bg = Background:Background()
    bg:SetBackgroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(windower.prim.setcolorcount, 1)
end

--------------------------------------------------------------------------------
function BackgroundTests:TestSetForegroundColorDoesNotUpdatePrim()
    local bg = Background:Background()
    bg:SetForegroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(windower.prim.setcolorcount, 0)
end

LuaUnit.LuaUnit.run('BackgroundTests')