--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Keys = {}
Keys.Values = {}
Keys.Values['spgobbiekey'] = 8973

--------------------------------------------------------------------------------
function Keys.GetKey(key_str)
    if not key_str then
        return 0
    end

    local value = Keys.Values[key_str]
    if not value then
        return 0
    end

    return value
end

return Keys