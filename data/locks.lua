local Locks = {}
Locks.Values = {}
Locks.Values[''] = {id = 0, menu = 0}
Locks.Values['habitox'] = {id = 0, menu = 0}
Locks.Values['mystrix'] = {id = 17719641, menu = 0}
Locks.Values['Bountibox'] = {id = 0, menu = 0}
Locks.Values['specilox'] = {id = 0, menu = 0}
Locks.Values['arbitrix'] = {id = 0, menu = 0}
Locks.Values['funtrox'] = {id = 17764606, menu = 0}
Locks.Values['sweepstox'] = {id = 17780998, menu = 0}
Locks.Values['priztrix'] = {id = 0, menu = 0}
Locks.Values['wondrix'] = {id = 0, menu = 0}
Locks.Values['rewardox'] = {id = 0, menu = 0}
Locks.Values['winrix'] = {id = 0, menu = 0}

--------------------------------------------------------------------------------
function Locks.GetLock(lock_str)
    if not lock_str then
        return 0
    end

    local value = Locks.Values[lock_str]
    if not value then
        return Locks.Values['']
    end

    return value
end

return Locks
