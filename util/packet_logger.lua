local function CreateItem(parsed_packet)
    local item = {}
    for k, v in ipairs(parsed_packet) do
        item[#item + 1] = tostring(k) .. ' : ' .. tostring(v)
    end
    return table.concat(item, '\n')
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Logger = {}

--------------------------------------------------------------------------------
function Logger.AddPacket(parsed_packet)
    windower.create_dir(windower.addon_path .. '/' .. windower.ffxi.get_player().name)
    local file = io.open(windower.addon_path .. '/' .. windower.ffxi.get_player().name .. 'data/packets.log', 'a+')
    file:write(CreateItem(parsed_packet))
    file:close()
end

return Logger
