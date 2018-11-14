local LuaUnit = require('luaunit')
local Scrollbar = require('ui/scrollbar')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ScrollbarTests = {}

--------------------------------------------------------------------------------
function ScrollbarTests:SetUp()
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
function ScrollbarTests:TestDefaultPositionIs00()
    local sb = Scrollbar:Scrollbar()
    LuaUnit.assertEquals(sb:Position(), { x = 0, y = 0 })
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestDefaultSizeIs00()
    local sb = Scrollbar:Scrollbar()
    LuaUnit.assertEquals(sb:Size(), { w = 0, h = 0 })
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestDefaultVisibilityIsFalse()
    local sb = Scrollbar:Scrollbar()
    LuaUnit.assertFalse(sb:IsVisible())
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestDefaultPagecountIsOne()
    local sb = Scrollbar:Scrollbar()
    LuaUnit.assertEquals(sb:PageCount(), 1)
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestMoveToUpdatesPosition()
    local sb = Scrollbar:Scrollbar()
    sb:MoveTo(10, 11)
    LuaUnit.assertEquals(sb:Position(), { x = 10, y = 11 })
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestDragByUpdatesPosition()
    local sb = Scrollbar:Scrollbar()
    sb:DragBy(10, 11)
    LuaUnit.assertEquals(sb:Position(), { x = 10, y = 11 })
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestSetSizeUpdatesSize()
    local sb = Scrollbar:Scrollbar()
    sb:SetSize(5, 7)
    LuaUnit.assertEquals(sb:Size(), { w = 5, h = 7 })
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestShowUpdatesVisibility()
    local sb = Scrollbar:Scrollbar()
    sb:Show()
    LuaUnit.assertTrue(sb:IsVisible())
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestHideUpdatesVisibility()
    local sb = Scrollbar:Scrollbar()
    sb:Show()
    sb:Hide()
    LuaUnit.assertFalse(sb:IsVisible())
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestSetBackgroundColorUpdatesColor()
    local sb = Scrollbar:Scrollbar()
    sb:SetBackgroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(sb:BackgroundColor(), { a = 100, r = 101, g = 102, b = 103 })
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestSetForegroundColorUpdatesColor()
    local sb = Scrollbar:Scrollbar()
    sb:SetForegroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(sb:ForegroundColor(), { a = 100, r = 101, g = 102, b = 103 })
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestSetPagecountUpdatesCount()
    local sb = Scrollbar:Scrollbar()
    sb:SetPageCount(2)
    LuaUnit.assertEquals(sb:PageCount(), 2)
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestContainsPointsReturnsFalseWhenOutsideBounds()
    local sb = Scrollbar:Scrollbar()
    sb:MoveTo(10, 10)
    sb:SetSize(10, 10)
    LuaUnit.assertFalse(sb:ContainsPoint(21, 21))
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestContainsPointsReturnsTrueWhenInsideBounds()
    local sb = Scrollbar:Scrollbar()
    sb:MoveTo(10, 10)
    sb:SetSize(10, 10)
    LuaUnit.assertTrue(sb:ContainsPoint(20, 20))
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestPrimsAreCreatedDuringConstructor()
    Scrollbar:Scrollbar()
    LuaUnit.assertEquals(windower.prim.createcount, 2)
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestPrimsAreDestroyedDuringDestrutor()
    local sb = Scrollbar:Scrollbar()
    sb:Destroy()
    LuaUnit.assertEquals(windower.prim.deletecount, 2)
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestMoveToMovesPrims()
    local sb = Scrollbar:Scrollbar()
    sb:MoveTo(10, 11)
    LuaUnit.assertEquals(windower.prim.setlocationcount, 2)
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestDragByMovesPrims()
    local sb = Scrollbar:Scrollbar()
    sb:DragBy(10, 11)
    LuaUnit.assertEquals(windower.prim.setlocationcount, 2)
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestSetSizeUpdatesPrim()
    local sb = Scrollbar:Scrollbar()
    sb:SetSize(5, 7)
    LuaUnit.assertEquals(windower.prim.setsizecount, 2)
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestShowUpdatesPrimVisibility()
    local sb = Scrollbar:Scrollbar()
    sb:Show()
    LuaUnit.assertEquals(windower.prim.setvisibilitycount, 2)
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestHideUpdatesPrimVisibility()
    local sb = Scrollbar:Scrollbar()
    sb:Hide()
    LuaUnit.assertEquals(windower.prim.setvisibilitycount, 2)
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestSetBackgroundColorUpdatesPrim()
    local sb = Scrollbar:Scrollbar()
    sb:SetBackgroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(windower.prim.setcolorcount, 1)
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestSetForegroundColorUpdatesPrim()
    local sb = Scrollbar:Scrollbar()
    sb:SetForegroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(windower.prim.setcolorcount, 1)
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestSetPageCountUpdatesPrim()
    local sb = Scrollbar:Scrollbar()
    sb:SetPageCount(2)
    LuaUnit.assertEquals(windower.prim.setsizecount, 1)
    LuaUnit.assertEquals(windower.prim.setlocationcount, 1)
end

--------------------------------------------------------------------------------
function ScrollbarTests:TestTypeIsScrollbar()
    local sb = Scrollbar:Scrollbar()
    LuaUnit.assertEquals(sb:Type(), 'Scrollbar')
end

LuaUnit.LuaUnit.run('ScrollbarTests')