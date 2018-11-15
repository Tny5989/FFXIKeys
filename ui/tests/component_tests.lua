local LuaUnit = require('luaunit')
local Component = require('ui/component')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ComponentTests = {}

--------------------------------------------------------------------------------
function ComponentTests:TestDefaultPositionIs00()
    local bg = Component:Component()
    LuaUnit.assertEquals(bg:Position(), { x = 0, y = 0 })
end

--------------------------------------------------------------------------------
function ComponentTests:TestDefaultSizeIs00()
    local bg = Component:Component()
    LuaUnit.assertEquals(bg:Size(), { w = 0, h = 0 })
end
--------------------------------------------------------------------------------
function ComponentTests:TestDefaultVisibilityIsFalse()
    local bg = Component:Component()
    LuaUnit.assertFalse(bg:IsVisible())
end

--------------------------------------------------------------------------------
function ComponentTests:TestDefaultBackgroundColorIsBlack()
    local bg = Component:Component()
    LuaUnit.assertEquals(bg:BackgroundColor(), { a = 255, r = 0, g = 0, b = 0 })
end

--------------------------------------------------------------------------------
function ComponentTests:TestDefaultForegroundColorIsBlack()
    local bg = Component:Component()
    LuaUnit.assertEquals(bg:ForegroundColor(), { a = 255, r = 0, g = 0, b = 0 })
end

--------------------------------------------------------------------------------
function ComponentTests:TestMoveToUpdatesPosition()
    local bg = Component:Component()
    bg:MoveTo(11, 12)
    LuaUnit.assertEquals(bg:Position(), { x = 11, y = 12 })
end

--------------------------------------------------------------------------------
function ComponentTests:TestDragByUpdatesPosition()
    local bg = Component:Component()
    bg:MoveTo(11, 12)
    bg:DragBy(2, 1)
    LuaUnit.assertEquals(bg:Position(), { x = 13, y = 13 })
end

--------------------------------------------------------------------------------
function ComponentTests:TestSetSizeUpdatesSize()
    local bg = Component:Component()
    bg:SetSize(50, 100)
    LuaUnit.assertEquals(bg:Size(), { w = 50, h = 100 })
end

--------------------------------------------------------------------------------
function ComponentTests:TestShowUpdatesVisibility()
    local bg = Component:Component()
    bg:Show()
    LuaUnit.assertTrue(bg:IsVisible())
end

--------------------------------------------------------------------------------
function ComponentTests:TestHideUpdatesVisibility()
    local bg = Component:Component()
    bg:Show()
    bg:Hide()
    LuaUnit.assertFalse(bg:IsVisible())
end

--------------------------------------------------------------------------------
function ComponentTests:TestSetBackgroundColorUpdatesColor()
    local bg = Component:Component()
    bg:SetBackgroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(bg:BackgroundColor(), { a = 100, r = 101, g = 102, b = 103 })
end

--------------------------------------------------------------------------------
function ComponentTests:TestSetForegroundColorUpdatesColor()
    local bg = Component:Component()
    bg:SetForegroundColor(100, 101, 102, 103)
    LuaUnit.assertEquals(bg:ForegroundColor(), { a = 100, r = 101, g = 102, b = 103 })
end

--------------------------------------------------------------------------------
function ComponentTests:TestContainsPointReturnsFalseWhenOutsideBounds()
    local bg = Component:Component()
    bg:MoveTo(10, 10)
    bg:SetSize(10, 10)
    LuaUnit.assertFalse(bg:ContainsPoint(21, 21))
end

--------------------------------------------------------------------------------
function ComponentTests:TestContainsPointReturnsTrueWhenInsideBounds()
    local bg = Component:Component()
    bg:MoveTo(10, 10)
    bg:SetSize(10, 10)
    LuaUnit.assertTrue(bg:ContainsPoint(20, 20))
end

--------------------------------------------------------------------------------
function ComponentTests:TestTypeIsComponent()
    local bg = Component:Component()
    LuaUnit.assertEquals(bg:Type(), 'Component')
end

LuaUnit.LuaUnit.run('ComponentTests')