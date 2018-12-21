local LuaUnit = require('luaunit')
local UseDialogue = require('model/dialogue/use')
local NilEntity = require('model/entity/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local MockEntity = NilEntity:NilEntity()
MockEntity.__index = MockEntity

--------------------------------------------------------------------------------
function MockEntity:MockEntity(id, idx)
    local o = NilEntity:NilEntity()
    setmetatable(o, self)
    o._id = id
    o._index = idx
    return o
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
UseDialogueTests = {}

--------------------------------------------------------------------------------
function UseDialogueTests:SetUp()
    packets = {}
    function packets.new(dir, id)
        return { dir = dir, id = id }
    end

    packets.injected = {}
    function packets.inject(pkt)
        table.insert(packets.injected, pkt)
    end

    function packets.parse(dir, data)
        return {}
    end
end

--------------------------------------------------------------------------------
function UseDialogueTests:TestOnOutgoingDataReturnTrueFor015()
    local c = UseDialogue:UseDialogue(MockEntity:MockEntity(1234, 4), MockEntity:MockEntity(4321, 3), 2)
    LuaUnit.assertTrue(c:OnOutgoingData(0x015, {}))
end

--------------------------------------------------------------------------------
function UseDialogueTests:TestPacketsSent()
    local dialogue = UseDialogue:UseDialogue(MockEntity:MockEntity(1234, 4), MockEntity:MockEntity(4321, 3), 2)

    local fc = 0
    function failure()
        fc = fc + 1
    end

    local sc = 0
    function success()
        sc = sc + 1
    end

    dialogue:SetSuccessCallback(success)
    dialogue:SetFailureCallback(failure)

    dialogue:Start()
    LuaUnit.assertEquals(#packets.injected, 1)
    LuaUnit.assertEquals(packets.injected[1].id, 0x036)

    packets.injected = {}
    dialogue:OnIncomingData(0x034, {})
    LuaUnit.assertEquals(#packets.injected, 1)
    LuaUnit.assertEquals(packets.injected[1].id, 0x05B)

    packets.injected = {}
    dialogue:OnIncomingData(0x05C, {})
    dialogue:OnIncomingData(0x052, {})
    LuaUnit.assertEquals(#packets.injected, 1)
    LuaUnit.assertEquals(packets.injected[1].id, 0x05B)

    packets.injected = {}
    dialogue:OnIncomingData(0x05C, {})
    dialogue:OnIncomingData(0x052, {})
    LuaUnit.assertEquals(#packets.injected, 1)
    LuaUnit.assertEquals(packets.injected[1].id, 0x05B)

    packets.injected = {}
    dialogue:OnIncomingData(0x052, {})
    LuaUnit.assertEquals(#packets.injected, 0)

    LuaUnit.assertEquals(fc, 0)
    LuaUnit.assertEquals(sc, 1)
end

--------------------------------------------------------------------------------
function UseDialogueTests:TestSuccessCallback()
    local dialogue = UseDialogue:UseDialogue(MockEntity:MockEntity(1234, 4), MockEntity:MockEntity(4321, 3), 2)

    local fc = 0
    function failure()
        fc = fc + 1
    end

    local sc = 0
    function success()
        sc = sc + 1
    end

    dialogue:SetSuccessCallback(success)
    dialogue:SetFailureCallback(failure)

    dialogue:Start()

    packets.injected = {}
    dialogue:OnIncomingData(0x034, {})
    dialogue:OnIncomingData(0x05C, {})
    dialogue:OnIncomingData(0x052, {})
    dialogue:OnIncomingData(0x05C, {})
    dialogue:OnIncomingData(0x052, {})
    dialogue:OnIncomingData(0x052, {})

    dialogue:Start()

    LuaUnit.assertEquals(fc, 0)
    LuaUnit.assertEquals(sc, 2)
end

--------------------------------------------------------------------------------
function UseDialogueTests:TestDialogueFailsOnEarly52()
    local dialogue = UseDialogue:UseDialogue(MockEntity:MockEntity(1234, 4), MockEntity:MockEntity(4321, 3), 2)

    local fc = 0
    function failure()
        fc = fc + 1
    end

    local sc = 0
    function success()
        sc = sc + 1
    end

    dialogue:SetSuccessCallback(success)
    dialogue:SetFailureCallback(failure)

    dialogue:Start()
    LuaUnit.assertEquals(#packets.injected, 1)
    LuaUnit.assertEquals(packets.injected[1].id, 0x036)

    packets.injected = {}
    dialogue:OnIncomingData(0x052, {})
    LuaUnit.assertEquals(#packets.injected, 0)

    LuaUnit.assertEquals(fc, 1)
    LuaUnit.assertEquals(sc, 0)
end

--------------------------------------------------------------------------------
function UseDialogueTests:TestTypeIsUseDialogue()
    local dialogue = UseDialogue:UseDialogue()
    LuaUnit.assertEquals(dialogue:Type(), 'UseDialogue')
end

LuaUnit.LuaUnit.run('UseDialogueTests')