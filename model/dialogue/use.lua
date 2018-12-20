local NilDialogue = require('model/dialogue/nil')
local NilMenu = require('model/menu/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local UseDialogue = NilDialogue:NilDialogue()
UseDialogue.__index = UseDialogue

--------------------------------------------------------------------------------
function UseDialogue:UseDialogue(target, player, item_id)
    local o = NilDialogue:NilDialogue()
    setmetatable(o, self)
    o._target = target
    o._player = player
    o._item_id = item_id
    o._type = 'UseDialogue'
    return o
end

return UseDialogue