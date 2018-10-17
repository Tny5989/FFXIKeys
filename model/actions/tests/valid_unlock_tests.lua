local Key = require('model/key')
local Lock = require('model/lock')
local LuaUnit = require('luaunit')
local ValidUnlock = require('model/actions/valid_unlock')

packets = {}
packets.new_count = 0
function packets.new()
    packets.new_count = packets.new_count + 1
    return {}
end

packets.inject_count = 0
function packets.inject()
    packets.inject_count = packets.inject_count + 1
    return true
end

windower = {}
windower.ffxi = {}
function windower.ffxi.get_player()
    return {id = 1234}
end

function windower.ffxi.get_mob_by_id()
    return {id = 1234, index = 4321, distance = 0 }
end

function windower.ffxi.get_mob_by_name()
    return {id = 4321, index = 1234, distance = 9999}
end

function windower.ffxi.get_items()
    return {max = 0, count = 0}
end

ValidUnlockTests = {}

function ValidUnlockTests:TestCreateAndSendsPacket()
    local key = Key:Key('spgobbiekey')
    local lock = Lock:Lock('habitox')
    local unlock = ValidUnlock:ValidUnlock(key, lock)
    LuaUnit.assertTrue(unlock())
    LuaUnit.assertEquals(packets.new_count, 1)
    LuaUnit.assertEquals(packets.inject_count, 1)
end

LuaUnit.LuaUnit.run('ValidUnlockTests')