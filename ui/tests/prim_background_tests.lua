local LuaUnit = require('luaunit')
local PrimBackground = require('ui/prim_background')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
PrimBackgroundTests = {}

--------------------------------------------------------------------------------
function PrimBackgroundTests:SetUp()
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

    windower.prim.setlocationcount = 0
    function windower.prim.set_location()
        windower.prim.setlocationcount = windower.prim.setlocationcount + 1
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
function PrimBackgroundTests:TestDefaultPositionIs00()
    local bg = PrimBackground:PrimBackground()
    LuaUnit.assertEquals(bg:Position(), { x = 0, y = 0 })
end

--------------------------------------------------------------------------------
function PrimBackgroundTests:TestDefaultSizeIs00()
    local bg = PrimBackground:PrimBackground()
    LuaUnit.assertEquals(bg:Size(), { w = 0, h = 0 })
end
--------------------------------------------------------------------------------
function PrimBackgroundTests:TestDefaultVisibilityIsFalse()
    local bg = PrimBackground:PrimBackground()
    LuaUnit.assertFalse(bg:IsVisible())
end

--------------------------------------------------------------------------------
function PrimBackgroundTests:TestDefaultColorIsBlack()
    local bg = PrimBackground:PrimBackground()
    LuaUnit.assertEquals(bg:Color(), { a = 255, r = 0, g = 0, b = 0 })
end

--------------------------------------------------------------------------------
function PrimBackgroundTests:TestMoveToUpdatesPosition()
    local bg = PrimBackground:PrimBackground()
    bg:MoveTo(11, 12)
    LuaUnit.assertEquals(bg:Position(), { x = 11, y = 12 })
end

--------------------------------------------------------------------------------
function PrimBackgroundTests:TestDragByUpdatesPosition()
    local bg = PrimBackground:PrimBackground()
    bg:MoveTo(11, 12)
    bg:DragBy(2, 1)
    LuaUnit.assertEquals(bg:Position(), { x = 13, y = 13 })
end

--------------------------------------------------------------------------------
function PrimBackgroundTests:TestSetSizeUpdatesSize()
    local bg = PrimBackground:PrimBackground()
    bg:SetSize(50, 100)
    LuaUnit.assertEquals(bg:Size(), { w = 50, h = 100 })
end

--------------------------------------------------------------------------------
function PrimBackgroundTests:TestShowUpdatesVisibility()
    local bg = PrimBackground:PrimBackground()
    bg:Show()
    LuaUnit.assertTrue(bg:IsVisible())
end

--------------------------------------------------------------------------------
function PrimBackgroundTests:TestHideUpdatesVisibility()
    local bg = PrimBackground:PrimBackground()
    bg:Show()
    bg:Hide()
    LuaUnit.assertFalse(bg:IsVisible())
end

--------------------------------------------------------------------------------
function PrimBackgroundTests:TestSetColorUpdatesColor()
    local bg = PrimBackground:PrimBackground()
    bg:SetColor(100, 101, 102, 103)
    LuaUnit.assertEquals(bg:Color(), { a = 100, r = 101, g = 102, b = 103 })
end

--------------------------------------------------------------------------------
function PrimBackgroundTests:TestContainsPointReturnsFalseWhenOutsideBounds()
    local bg = PrimBackground:PrimBackground()
    bg:MoveTo(10, 10)
    bg:SetSize(10, 10)
    LuaUnit.assertFalse(bg:ContainsPoint(21, 21))
end

--------------------------------------------------------------------------------
function PrimBackgroundTests:TestContainsPointReturnsTrueWhenInsideBounds()
    local bg = PrimBackground:PrimBackground()
    bg:MoveTo(10, 10)
    bg:SetSize(10, 10)
    LuaUnit.assertTrue(bg:ContainsPoint(20, 20))
end

--------------------------------------------------------------------------------
function PrimBackgroundTests:TestTypeIsPrimBackground()
    local bg = PrimBackground:PrimBackground()
    LuaUnit.assertEquals(bg:Type(), 'PrimBackground')
end

--------------------------------------------------------------------------------
function PrimBackgroundTests:TestPrimIsCreatedInConstructor()
    PrimBackground:PrimBackground()
    LuaUnit.assertEquals(windower.prim.createcount, 1)
end

--------------------------------------------------------------------------------
function PrimBackgroundTests:TestPrimIsDestroyedInDesstructor()
    local bg = PrimBackground:PrimBackground()
    bg:Destroy()
    LuaUnit.assertEquals(windower.prim.deletecount, 1)
end

--------------------------------------------------------------------------------
function PrimBackgroundTests:TestMoveToUpdatesPrim()
    local bg = PrimBackground:PrimBackground()
    bg:MoveTo(11, 12)
    LuaUnit.assertEquals(windower.prim.setlocationcount, 1)
end

--------------------------------------------------------------------------------
function PrimBackgroundTests:TestDragByUpdatesPrim()
    local bg = PrimBackground:PrimBackground()
    bg:MoveTo(11, 12)
    bg:DragBy(2, 1)
    LuaUnit.assertEquals(windower.prim.setlocationcount, 2)
end

--------------------------------------------------------------------------------
function PrimBackgroundTests:TestSetSizeUpdatesPrim()
    local bg = PrimBackground:PrimBackground()
    bg:SetSize(10, 10)
    LuaUnit.assertEquals(windower.prim.setsizecount, 1)
end

--------------------------------------------------------------------------------
function PrimBackgroundTests:TestShowUpdatesPrim()
    local bg = PrimBackground:PrimBackground()
    bg:Show()
    LuaUnit.assertEquals(windower.prim.setvisibilitycount, 1)
end

--------------------------------------------------------------------------------
function PrimBackgroundTests:TestHideUpdatesPrim()
    local bg = PrimBackground:PrimBackground()
    bg:Hide()
    LuaUnit.assertEquals(windower.prim.setvisibilitycount, 1)
end

--------------------------------------------------------------------------------
function PrimBackgroundTests:TestSetColorUpdatesPrim()
    local bg = PrimBackground:PrimBackground()
    bg:SetColor(100, 101, 102, 103)
    LuaUnit.assertEquals(windower.prim.setcolorcount, 1)
end

LuaUnit.LuaUnit.run('PrimBackgroundTests')