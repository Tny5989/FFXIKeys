local LuaUnit = require('luaunit')
local DialogueFactory = require('model/dialogue/factory')
local NilEntity = require('model/entity/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local MockEntity = NilEntity:NilEntity()
MockEntity.__index = MockEntity

--------------------------------------------------------------------------------
function MockEntity:MockEntity(id, idx, distance)
    local o = NilEntity:NilEntity()
    setmetatable(o, self)
    o._id = id
    o._index = idx
    o._distance = distance
    o._type = 'MockEntity'
    return o
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
DialogueFactoryTests = {}

--------------------------------------------------------------------------------
function DialogueFactoryTests:SetUp()
    settings = {}
    settings.config = {}
    settings.config.maxdistance = 20

    function log()
    end
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenBadNpc()
    local npc = DialogueFactory.CreateUseDialogue(nil, MockEntity:MockEntity(1234, 4321, 0), 2)
    LuaUnit.assertEquals(npc:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenBadPlayer()
    local npc = DialogueFactory.CreateUseDialogue(MockEntity:MockEntity(1234, 4321, 0), nil, 2)
    LuaUnit.assertEquals(npc:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenNilNpc()
    local npc = DialogueFactory.CreateUseDialogue(NilEntity:NilEntity(), MockEntity:MockEntity(1234, 4321, 0), 2)
    LuaUnit.assertEquals(npc:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenNilPlayer()
    local npc = DialogueFactory.CreateUseDialogue(MockEntity:MockEntity(1234, 4321, 0), NilEntity:NilEntity(), 2)
    LuaUnit.assertEquals(npc:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenFarAway()
    local npc = DialogueFactory.CreateUseDialogue(MockEntity:MockEntity(1, 2, 30), MockEntity:MockEntity(3, 4, 0), 2)
    LuaUnit.assertEquals(npc:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenBadItemId()
    local npc = DialogueFactory.CreateUseDialogue(MockEntity:MockEntity(1, 2, 5), MockEntity:MockEntity(3, 4, 0), nil)
    LuaUnit.assertEquals(npc:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestUseDialogueCreatedWhenValidParams()
    local npc = DialogueFactory.CreateUseDialogue(MockEntity:MockEntity(1, 2, 5), MockEntity:MockEntity(3, 4, 0), 2)
    LuaUnit.assertEquals(npc:Type(), 'UseDialogue')
end

LuaUnit.LuaUnit.run('DialogueFactoryTests')