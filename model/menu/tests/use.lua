local LuaUnit = require('luaunit')
local UseMenu = require('model/menu/use')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
UseMenuTests = {}

--------------------------------------------------------------------------------
function UseMenuTests:TestIdIsCorrect()
    local menu = UseMenu:UseMenu(1234)
    LuaUnit.assertEquals(menu:Id(), 1234)
end

--------------------------------------------------------------------------------
function UseMenuTests:TestOptionForResult()
    local menu = UseMenu:UseMenu(1234)
    LuaUnit.assertEquals(menu:OptionFor(), { option = 1, automated = true, uk1 = 0 })
end

--------------------------------------------------------------------------------
function UseMenuTests:TestTypeIsUseMenu()
    local menu = UseMenu:UseMenu(1234)
    LuaUnit.assertEquals(menu:Type(), 'UseMenu')
end

LuaUnit.LuaUnit.run('UseMenuTests')