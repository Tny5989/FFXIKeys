local LuaUnit = require('luaunit')
local Lock = require('model/lock')

LockTests = {}

function LockTests:TestGetValidLockName()
    local lock = Lock:Lock('habitox')
    LuaUnit.assertEquals(lock:GetName(), 'Habitox')
end

function LockTests:TestGetNullLockName()
    local lock = Lock:Lock('')
    LuaUnit.assertEquals(lock:GetName(), '')
end

function LockTests:TestGetInvalidLockName()
    local lock = Lock:Lock('test 1 2 3')
    LuaUnit.assertEquals(lock:GetName(), '')
end

LuaUnit.LuaUnit.run('LockTests')