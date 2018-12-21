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
        return { id = id, index = 4321, distance = 5, valid_target = true }
    end

    function windower.ffxi.get_player()
        return { id = 9999, index = 8888, distance = 0 }
    end

    function windower.ffxi.get_items()
        return { max = 2, count = 1, [1] = { id = 8973, count = 12 } }
    end

    packets = {}
    function packets.new(dir, id)
        return { dir = dir, id = id }
    end

    function packets.inject()
    end

    function packets.parse(dir, data)
        return {}
    end

    function log()
    end

    settings = {}
    settings.config = {}
    settings.config.maxdistance = 20
end

--------------------------------------------------------------------------------
function UseCommandTests:TestParamsAreCorrect()
    local c = UseCommand:UseCommand('abc')
    LuaUnit.assertEquals(c:RawParams(), 'abc')
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

    local c = UseCommand:UseCommand('', 1234, 8973, 1)
    c:SetSuccessCallback(success)
    c:SetFailureCallback(failure)
    c()

    c:OnIncomingData(0x034, {})
    c:OnIncomingData(0x05C, {})
    c:OnIncomingData(0x052, {})
    c:OnIncomingData(0x05C, {})
    c:OnIncomingData(0x052, {})
    c:OnIncomingData(0x052, {})

    LuaUnit.assertEquals(sc, 1)
    LuaUnit.assertEquals(fc, 0)

    c()
    c()

    LuaUnit.assertEquals(sc, 3)
    LuaUnit.assertEquals(fc, 0)
end

--------------------------------------------------------------------------------
function UseCommandTests:TestTypeIsUseCommand()
    local c = UseCommand:UseCommand('', 1234, 8973, 1)
    LuaUnit.assertEquals(c:Type(), 'UseCommand')
end

LuaUnit.LuaUnit.run('UseCommandTests')