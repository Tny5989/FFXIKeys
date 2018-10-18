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

    local entity = EntityFactory.CreatePlayer()
    if entity:Type() == 'NilEntity' then
        if log then
            log('Unable to find key')
        end
        return NilKey:NilKey()
    end

    if entity:Bag():FreeSlots() <= 0 then
        if log then
            log('Inventory full')
        end
        return NilKey:NilKey()
    end

    if entity:Bag():ItemCount(id) <= 0 then
        if log then
            log('No keys')
        end
        return NilKey:NilKey()
    end

    return GameKey:GameKey(id, entity)
end

return KeyFactory
