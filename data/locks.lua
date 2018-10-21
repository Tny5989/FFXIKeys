local Locks = {}
Locks.Values = {}
Locks.Values['habitox'] = 0
Locks.Values['mystrix'] = 17719641
Locks.Values['Bountibox'] = 0
Locks.Values['specilox'] = 0
Locks.Values['arbitrix'] = 0
Locks.Values['funtrox'] = 0
Locks.Values['sweepstox'] = 17780998
Locks.Values['priztrix'] = 0
Locks.Values['wondrix'] = 0
Locks.Values['rewardox'] = 0
Locks.Values['winrix'] = 0

--------------------------------------------------------------------------------
function Locks.GetLock(lock_str)
    if not lock_str then
        return 0
    end

    local value = Locks.Values[lock_str]
    if not value then
        return 0
    end

    return value
end

return Locks
