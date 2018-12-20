local LuaUnit = require('luaunit')
local UseCommand = require('command/use')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
UseCommandTests = {}

--------------------------------------------------------------------------------
function UseCommandTests:SetUp()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_mob_by_id(id)
        return { id = id, index = 4321, distance = 9999, valid_target = true }
    end

    function windower.ffxi.get_player()
        return { id = 9999, index = 8888, distance = 0 }
    end

    function windower.ffxi.get_items()
        return { max = 0, count = 0 }
    end

    function log()
    end
end

--------------------------------------------------------------------------------
function UseCommandTests:TestSuccessCallbackCalled()
    local sc = 0
    function success()
        sc = sc + 1
    end

    local fc = 0
    function failure()
        fc = fc + 1
    end

    local c = UseCommand:UseCommand() -- Don't pass parameters to force a NilDialogue to be created.
    c:SetSuccessCallback(success)
    c:SetFailureCallback(failure)
    c()

    LuaUnit.assertEquals(sc, 1)
    LuaUnit.assertEquals(fc, 0)
end

--------------------------------------------------------------------------------
function UseCommandTests:TestSuccessCallbackOnlyCalledOnce()
    local sc = 0
    function success()
        sc = sc + 1
    end

    local fc = 0
    function failure()
        fc = fc + 1
    end

    local c = UseCommand:UseCommand() -- Don't pass parameters to force a NilDialogue to be created.
    c:SetSuccessCallback(success)
    c:SetFailureCallback(failure)
    c()
    c()
    c()

    LuaUnit.assertEquals(sc, 1)
    LuaUnit.assertEquals(fc, 0)
end

--------------------------------------------------------------------------------
function UseCommandTests:TestTypeIsUseCommand()
    local c = UseCommand:UseCommand()
    LuaUnit.assertEquals(c:Type(), 'UseCommand')
end

LuaUnit.LuaUnit.run('UseCommandTests')