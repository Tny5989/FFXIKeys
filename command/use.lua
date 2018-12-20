local NilCommand = require('command/nil')
local EntityFactory = require('model/entity/factory')
local DialogueFactory = require('model/dialogue/factory')


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local UseCommand = NilCommand:NilCommand()
UseCommand.__index = UseCommand

--------------------------------------------------------------------------------
function UseCommand:UseCommand(id, item_id)
    local o = NilCommand:NilCommand()
    setmetatable(o, self)
    o._dialogue = DialogueFactory.CreateUseDialogue(EntityFactory.CreateMob(id),
        EntityFactory.CreatePlayer(), item_id)
    o._dialogue:SetSuccessCallback(function() o._on_success() end)
    o._dialogue:SetFailureCallback(function() o._on_failure() end)
    o._type = 'UseCommand'
    return o
end

--------------------------------------------------------------------------------
function UseCommand:OnIncomingData(id, pkt)
    return self._dialogue:OnIncomingData(id, pkt)
end

--------------------------------------------------------------------------------
function UseCommand:__call()
    self._dialogue:Start()
end

return UseCommand