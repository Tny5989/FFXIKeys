local LuaUnit = require('luaunit')
local StopCommand = require('command/stop')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
StopCommandTests = {}

--------------------------------------------------------------------------------
function StopCommandTests:SetUp()
    function log()
    end
end

--------------------------------------------------------------------------------
function StopCommandTests:TestStateIsUpdated()
    local sc = 0
    local function OnSuccess()
        sc = sc + 1
    end

    local fc = 0
    local function OnFailure()
        fc = fc + 1
    end

    local state = {}
    state.command = StopCommand:StopCommand()
    state.command:SetSuccessCallback(OnSuccess)
    state.command:SetFailureCallback(OnFailure)
    state.command(state)
    LuaUnit.assertTrue(state.command._on_success == state.command._on_failure)
end

--------------------------------------------------------------------------------
function StopCommandTests:TestTypeIsStopCommand()
    local c = StopCommand:StopCommand()
    LuaUnit.assertEquals(c:Type(), 'StopCommand')
end

LuaUnit.LuaUnit.run('StopCommandTests')