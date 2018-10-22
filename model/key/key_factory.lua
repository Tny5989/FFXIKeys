local GameKey = require('model/key/game_key')
local ItemKey = require('model/key/item_key')
local EntityFactory = require('model/entity/entity_factory')
local NilKey = require('model/key/nil_key')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local KeyFactory = {}

--------------------------------------------------------------------------------
function KeyFactory.CreateKey(id, option)
    if not id then
        return NilKey:NilKey()
    end

    if not option then
        return GameKey:GameKey(id, EntityFactory.CreatePlayer())
    end

    return ItemKey:ItemKey(id, option)
end

return KeyFactory
