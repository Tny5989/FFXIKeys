--------------------------------------------------------------------------------
local function ByValue(name, search_value, domain)
    for _, value in pairs(domain) do
        if value[name] == search_value then
            return value
        end
    end

    return domain['']
end

--------------------------------------------------------------------------------
local function AllByValue(name, search_value, domain)
    local matches = {}
    for _, value in pairs(domain) do
        if value[name] == search_value then
            table.insert(matches, value)
        end
    end

    table.insert(matches, domain[''])
    return matches
end

--------------------------------------------------------------------------------
local Npcs = {}

Npcs.Values = {}
Npcs.Values['']       = { id = 00000000, en = '',          zone = 000 }
Npcs.Values[17727633] = { id = 17727633, en = 'Habitox',   zone = 232 }
Npcs.Values[17719641] = { id = 17719641, en = 'Mystrix',   zone = 230 }
Npcs.Values[17735872] = { id = 17735872, en = 'Bountibox', zone = 234 }
Npcs.Values[17739956] = { id = 17739956, en = 'Specilox',  zone = 235 }
Npcs.Values[17756352] = { id = 17756352, en = 'Arbitrix',  zone = 239 }
Npcs.Values[17764606] = { id = 17764606, en = 'Funtrox',   zone = 241 }
Npcs.Values[17780998] = { id = 17780998, en = 'Sweepstox', zone = 245 }
Npcs.Values[17776886] = { id = 17776886, en = 'Priztrix',  zone = 244 }
Npcs.Values[16982639] = { id = 16982639, en = 'Wondrix',   zone = 500 }
Npcs.Values[17826176] = { id = 17826176, en = 'Rewardox',  zone = 256 }
Npcs.Values[17830186] = { id = 17830186, en = 'Winrix',    zone = 257 }

--------------------------------------------------------------------------------
function Npcs.GetByProperty(key, value)
    return ByValue(tostring(key), value, Npcs.Values)
end

--------------------------------------------------------------------------------
function Npcs.GetAllByProperty(key, value)
    return AllByValue(tostring(key), value, Npcs.Values)
end

--------------------------------------------------------------------------------
function Npcs.GetClosest()
    local npcs = Npcs.GetAllByProperty('zone', windower.ffxi.get_info().zone)

    local mobs = {}
    for key, value in pairs(npcs) do
        mobs[key] = windower.ffxi.get_mob_by_id(value.id)
    end

    local distances = {}
    for key, value in pairs(mobs) do
        distances[key] = value.distance
    end

    local closest_key
    local closest_dis
    for key, value in pairs(distances) do
        if not closest_dis or closest_dis > value then
            closest_key = key
            closest_dis = value
        end
    end

    return closest_key and npcs[closest_key] or npcs[#npcs]
end

return Npcs