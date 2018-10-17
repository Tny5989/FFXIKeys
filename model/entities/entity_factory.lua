local Entity = require('model/entities/entity')
local MobEntity = require('model/entities/mob_entity')
local PlayerEntity = require('model/entities/player_entity')

local EntityFactory = {}

function EntityFactory.GetPlayer()
    local player = windower.ffxi.get_player()
    if not player then
        return Entity:Entity()
    else
        return PlayerEntity:PlayerEntity(windower.ffxi.get_mob_by_id(player.id))
    end
end

function EntityFactory.GetTarget(target_name)
    local mob = windower.ffxi.get_mob_by_name(target_name)
    if not mob then
        return Entity:Entity()
    else
        return MobEntity:MobEntity(mob)
    end
end

return EntityFactory
