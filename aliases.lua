local Locks = require('data/locks')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Aliases = {}

--------------------------------------------------------------------------------
function Aliases.Update()
    local zone_id = Aliases._get_current_zone_id()
    windower.send_command('alias buykeys input //keys buy spgobbiekey ' .. Locks.GetLockIndexForZone(zone_id, true))
    windower.send_command('alias usekeys input //keys unlock spgobbiekey ' .. Locks.GetLockIndexForZone(zone_id, false))
end

--------------------------------------------------------------------------------
function Aliases._get_current_zone_id()
    local info = windower.ffxi.get_info()
    return info and info.zone or 0
end

return Aliases