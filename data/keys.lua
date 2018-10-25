--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Keys = {}
Keys.Values = {}

-- Null Key
Keys.Values[''] = {id = 0, option = 0 }

-- Keys
Keys.Values['spgobbiekey'] = {id = 8973, option = 35}

--------------------------------------------------------------------------------
function Keys.GetKey(key_str)
    if not key_str then
        return Keys.Values['']
    end

    local value = Keys.Values[key_str]
    return value and value or Keys.Values['']
end

return Keys