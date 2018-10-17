local LuaUnit = require('luaunit')
local Unlock = require('model/actions/unlock')

UnlockTests = {}

function UnlockTests:TestsUnlockDoesNothing()
    local unlock = Unlock:Unlock()
    LuaUnit.assertFalse(unlock())
end

LuaUnit.LuaUnit.run('UnlockTests')