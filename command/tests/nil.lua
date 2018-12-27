local LuaUnit = require('luaunit')
local NilCommand = require('command/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NilCommandTests = {}

--------------------------------------------------------------------------------
function NilCommandTests:TestIsSimple()
    LuaUnit.assertTrue(NilCommand:NilCommand():IsSimple())
end

--------------------------------------------------------------------------------
function NilCommandTests:TestOnIncomingDataReturnFalse()
    local c = NilCommand:NilCommand()
    LuaUnit.assertFalse(c:OnIncomingData(0x052, {}))
end

--------------------------------------------------------------------------------
function NilCommandTests:TestOnOutgoingDataReturnFalse()
    local c = NilCommand:NilCommand()
    LuaUnit.assertFalse(c:OnOutgoingData(0x052, {}))
end

--------------------------------------------------------------------------------
function NilCommandTests:TestNilCommandWindowerRequirement()
    windower = nil
    NilCommand:NilCommand()()
end

--------------------------------------------------------------------------------
function NilCommandTests:TestNilCommandSettingsRequirement()
    settings = nil
    NilCommand:NilCommand()()
end

--------------------------------------------------------------------------------
function NilCommandTests:TestFailureCallbackCalled()
    local sc = 0
    function success()
        sc = sc + 1
    end

    local fc = 0
    function failure()
        fc = fc + 1
    end

    local c = NilCommand:NilCommand()
    c:SetSuccessCallback(success)
    c:SetFailureCallback(failure)
    c()

    LuaUnit.assertEquals(sc, 0)
    LuaUnit.assertEquals(fc, 1)
end

--------------------------------------------------------------------------------
function NilCommandTests:TestTypeIsNilCommand()
    local c = NilCommand:NilCommand()
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end

LuaUnit.LuaUnit.run('NilCommandTests')