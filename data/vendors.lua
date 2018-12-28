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
local Vendors = {}

Vendors.Values = {}
Vendors.Values['']       = { id = 0,        en = '',                 zone = 000 }
Vendors.Values[17719646] = { id = 17719646, en = 'Urbiolaine',       zone = 230 }
Vendors.Values[17739961] = { id = 17739961, en = 'Igsli',            zone = 235 }
Vendors.Values[17764611] = { id = 17764611, en = 'Teldro-Kesdrodo',  zone = 241 }
Vendors.Values[17764612] = { id = 17764612, en = 'Yonolala',         zone = 241 }
Vendors.Values[17826181] = { id = 17826181, en = 'Nunaarl Bthtrogg', zone = 256 }

--------------------------------------------------------------------------------
function Vendors.GetByProperty(key, value)
    return ByValue(tostring(key), value, Vendors.Values)
end

--------------------------------------------------------------------------------
function Vendors.GetAllByProperty(key, value)
    return AllByValue(tostring(key), value, Vendors.Values)
end

--------------------------------------------------------------------------------
function Vendors.GetClosest()
    local npcs = Vendors.GetAllByProperty('zone', windower.ffxi.get_info().zone)

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

return Vendors