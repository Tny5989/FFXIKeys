local Unlock = {}
Unlock.__index = Unlock

function Unlock:Unlock()
    local o = {}
    setmetatable(o, self)
    return o
end

function Unlock:__call()
    return false
end

return Unlock
