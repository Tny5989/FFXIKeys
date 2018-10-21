local GameKey = require('model/key/game_key')
local EntityFactory = require('model/entity/entity_factory')
local NilKey = require('model/key/nil_key')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local KeyFactory = {}

--------------------------------------------------------------------------------
function KeyFactory.CreateKey(id)
    if not id then
        return NilKey:NilKey()
    end

    return GameKey:GameKey(id, EntityFactory.CreatePlayer())
end

return KeyFactory
