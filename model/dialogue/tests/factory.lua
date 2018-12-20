local LuaUnit = require('luaunit')
local DialogueFactory = require('model/dialogue/factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
DialogueFactoryTests = {}

--------------------------------------------------------------------------------
function DialogueFactoryTests:SetUp()
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreated()
    local npc = DialogueFactory.CreateItemDialogue()
    LuaUnit.assertEquals(npc:Type(), 'NilDialogue')
end

LuaUnit.LuaUnit.run('DialogueFactoryTests')