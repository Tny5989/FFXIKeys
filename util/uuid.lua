--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local UUID = {}
math.randomseed(os.time())

--------------------------------------------------------------------------------
function UUID.uuid()
    local random = math.random
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    local s, _ = string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
    return s
end

return UUID
