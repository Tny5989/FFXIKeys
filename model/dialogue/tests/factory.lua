local LuaUnit = require('luaunit')
local DialogueFactory = require('model/dialogue/factory')
local NilEntity = require('model/entity/nil')
local NilInventory = require('model/inventory/nil')
local PlayerInventory = require('model/inventory/player')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local MockEntity = NilEntity:NilEntity()
MockEntity.__index = MockEntity

--------------------------------------------------------------------------------
function MockEntity:MockEntity(id, idx, distance, bag)
    local o = NilEntity:NilEntity()
    setmetatable(o, self)
    o._id = id
    o._index = idx
    o._distance = distance
    o._bag = bag
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
    local items = { { id = 2, index = 1 , count = 1 }, max = 2, count = 1 }
    local bag = PlayerInventory:PlayerInventory(items)
    local entity = MockEntity:MockEntity(1234, 4321, 0, bag)
    local npc = DialogueFactory.CreateUseDialogue(nil, entity, 2)
    LuaUnit.assertEquals(npc:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenBadPlayer()
    local bag = NilInventory:NilInventory()
    local entity = MockEntity:MockEntity(1234, 4321, 0, bag)
    local npc = DialogueFactory.CreateUseDialogue(entity, nil, 2)
    LuaUnit.assertEquals(npc:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenNilNpc()
    local items = { { id = 2, index = 1 , count = 1 }, max = 2, count = 1 }
    local bag = PlayerInventory:PlayerInventory(items)
    local entity = MockEntity:MockEntity(1234, 4321, 0, bag)
    local npc = DialogueFactory.CreateUseDialogue(NilEntity:NilEntity(), entity, 2)
    LuaUnit.assertEquals(npc:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenNilPlayer()
    local bag = NilInventory:NilInventory()
    local entity = MockEntity:MockEntity(1234, 4321, 0, bag)
    local npc = DialogueFactory.CreateUseDialogue(entity, NilEntity:NilEntity(), 2)
    LuaUnit.assertEquals(npc:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenFarAway()
    local items = { { id = 2, index = 1 , count = 1 }, max = 2, count = 1 }
    local pbag = PlayerInventory:PlayerInventory(items)
    local player = MockEntity:MockEntity(1234, 4321, 0, pbag)
    local bag = NilInventory:NilInventory()
    local mob = MockEntity:MockEntity(1234, 4321, 30, bag)
    local npc = DialogueFactory.CreateUseDialogue(mob, player, 2)
    LuaUnit.assertEquals(npc:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenBadItemId()
    local items = { { id = 2, index = 1 , count = 1 }, max = 2, count = 1 }
    local pbag = PlayerInventory:PlayerInventory(items)
    local player = MockEntity:MockEntity(1234, 4321, 0, pbag)
    local bag = NilInventory:NilInventory()
    local mob = MockEntity:MockEntity(1234, 4321, 5, bag)
    local npc = DialogueFactory.CreateUseDialogue(mob, player, nil)
    LuaUnit.assertEquals(npc:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenFullInventory()
    local items = { { id = 2, index = 1 , count = 1 }, max = 2, count = 2 }
    local pbag = PlayerInventory:PlayerInventory(items)
    local player = MockEntity:MockEntity(1234, 4321, 0, pbag)
    local bag = NilInventory:NilInventory()
    local mob = MockEntity:MockEntity(1234, 4321, 5, bag)
    local npc = DialogueFactory.CreateUseDialogue(mob, player, 2)
    LuaUnit.assertEquals(npc:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenNoItems()
    local items = { { id = 3, index = 1 , count = 1 }, max = 2, count = 1 }
    local pbag = PlayerInventory:PlayerInventory(items)
    local player = MockEntity:MockEntity(1234, 4321, 0, pbag)
    local bag = NilInventory:NilInventory()
    local mob = MockEntity:MockEntity(1234, 4321, 5, bag)
    local npc = DialogueFactory.CreateUseDialogue(mob, player, 2)
    LuaUnit.assertEquals(npc:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestUseDialogueCreatedWhenValidParams()
    local items = { { id = 2, index = 1 , count = 1 }, max = 2, count = 1 }
    local pbag = PlayerInventory:PlayerInventory(items)
    local player = MockEntity:MockEntity(1234, 4321, 0, pbag)
    local bag = NilInventory:NilInventory()
    local mob = MockEntity:MockEntity(1234, 4321, 5, bag)
    local npc = DialogueFactory.CreateUseDialogue(mob, player, 2)
    local npc = DialogueFactory.CreateUseDialogue(mob, player, 2)
    LuaUnit.assertEquals(npc:Type(), 'UseDialogue')
end

LuaUnit.LuaUnit.run('DialogueFactoryTests')