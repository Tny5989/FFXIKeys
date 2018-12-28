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
local Menus = {}

Menus.Values = {}
Menus.Values['']   = { id = 0000, item_claim = false }

-- Igsli
Menus.Values[0598] = { id = 0598, item_claim = false }
Menus.Values[0599] = { id = 0599, item_claim = true  }

-- Urbiolaine
Menus.Values[3529] = { id = 3529, item_claim = false }

-- Teldro-Kesdrodo
Menus.Values[0879] = { id = 0879, item_claim = false }

-- Yonolala
Menus.Values[0879] = { id = 0879, item_claim = false }

-- Nunaarl Bthtrogg
Menus.Values[5149] = { id = 5149, item_claim = false }


--------------------------------------------------------------------------------
function Menus.GetByProperty(key, value)
    return ByValue(tostring(key), value, Menus.Values)
end

--------------------------------------------------------------------------------
function Menus.GetAllByProperty(key, value)
    return AllByValue(tostring(key), value, Menus.Values)
end

--------------------------------------------------------------------------------
function Menus.IsItemClaim(menu_id)
    return ByValue('id', tonumber(menu_id), Menus.Values).item_claim
end

return Menus