local LuaUnit = require('luaunit')
local PlayerEntity = require('model/entities/player_entity')

PlayerEntityTests = {}
local player = {}
player.id = 1234
player.index = 4321
player.distance = 9999

windower = {}
windower.ffxi = {}

function PlayerEntityTests:TestPlayerId()
    local entity = PlayerEntity:PlayerEntity(player)
    LuaUnit.assertEquals(entity:GetId(), player.id)
end

function PlayerEntityTests:TestPlayerIdWithBadData()
    local entity = PlayerEntity:PlayerEntity({})
    LuaUnit.assertEquals(entity:GetId(), 0)
end

function PlayerEntityTests:TestPlayerIndex()
    local entity = PlayerEntity:PlayerEntity(player)
    LuaUnit.assertEquals(entity:GetIndex(), player.index)
end

function PlayerEntityTests:TestPlayerIndexWithBadData()
    local entity = PlayerEntity:PlayerEntity({})
    LuaUnit.assertEquals(entity:GetIndex(), 0)
end

function PlayerEntityTests:TestPlayerDistance()
    local entity = PlayerEntity:PlayerEntity(player)
    LuaUnit.assertEquals(entity:GetDistance(), 0)
end

function PlayerEntityTests:TestPlayerDistanceWithBadData()
    local entity = PlayerEntity:PlayerEntity({})
    LuaUnit.assertEquals(entity:GetDistance(), 0)
end

function PlayerEntityTests:TestBagType()
    function windower.ffxi.get_items()
        return {max = 0, count = 0}
    end
    local entity = PlayerEntity:PlayerEntity(player)
    LuaUnit.assertEquals(entity:GetBag():BagType(), 'PlayerBag')
end

function PlayerEntityTests:TestBagTypeWithBadData()
    function windower.ffxi.get_items()
        return nil
    end
    local entity = PlayerEntity:PlayerEntity({})
    LuaUnit.assertEquals(entity:GetBag():BagType(), 'Bag')
end

LuaUnit.LuaUnit.run('PlayerEntityTests')