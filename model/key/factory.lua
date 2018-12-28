local GameKey = require('model/key/game')
local EntityFactory = require('model/entity/factory')
local NilKey = require('model/key/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local KeyFactory = {}

--------------------------------------------------------------------------------
function KeyFactory.CreateKey(id, option)
    if not id or id == 0 then
        return NilKey:NilKey()
    end

    return GameKey:GameKey(id, option, EntityFactory.CreatePlayer())
end

return KeyFactory
