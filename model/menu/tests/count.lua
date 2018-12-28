local LuaUnit = require('luaunit')
local CountMenu = require('model/menu/count')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
CountMenuTests = {}

--------------------------------------------------------------------------------
function CountMenuTests:TestIdIsCorrect()
    local menu = CountMenu:CountMenu(1234, 1, 6)
    LuaUnit.assertEquals(menu:Id(), 1234)
end

--------------------------------------------------------------------------------
function CountMenuTests:TestOptionForResult()
    local menu = CountMenu:CountMenu(1234, 1, 6)
    LuaUnit.assertEquals(menu:OptionFor(), { option = 49188, automated = true })
end

--------------------------------------------------------------------------------
function CountMenuTests:TestTypeIsCountMenu()
    local menu = CountMenu:CountMenu(1234, 1, 6)
    LuaUnit.assertEquals(menu:Type(), 'CountMenu')
end

LuaUnit.LuaUnit.run('CountMenuTests')