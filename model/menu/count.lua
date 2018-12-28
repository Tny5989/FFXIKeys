local SimpleMenu = require('model/menu/simple')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local CountMenu = SimpleMenu:SimpleMenu()
CountMenu.__index = CountMenu

--------------------------------------------------------------------------------
function CountMenu:CountMenu(id, idx, count)
    local o = SimpleMenu:SimpleMenu(id, (count * (2^13) + (idx * (2^5) + 3) + 1), true)
    setmetatable(o, self)
    o._type = 'CountMenu'

    return o
end

return CountMenu
