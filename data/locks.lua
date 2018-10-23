local Locks = {}
Locks.Values = {}

-- Null Key
Locks.Values[''] = {id = 0, menu = 0, zone = 0 }

-- Key Goblins
Locks.Values['habitox'] = {id = 17727633, menu = 0, zone = 0}
Locks.Values['mystrix'] = {id = 17719641, menu = 0, zone = 0}
Locks.Values['bountibox'] = {id = 17735872, menu = 0, zone = 0}
Locks.Values['specilox'] = {id = 17739956, menu = 0, zone = 0}
Locks.Values['arbitrix'] = {id = 17756352, menu = 0, zone = 0}
Locks.Values['funtrox'] = {id = 17764606, menu = 0, zone = 0}
Locks.Values['sweepstox'] = {id = 17780998, menu = 0, zone = 0}
Locks.Values['priztrix'] = {id = 17776886, menu = 0, zone = 0}
Locks.Values['wondrix'] = {id = 16982639, menu = 0, zone = 0}
Locks.Values['rewardox'] = {id = 17826176, menu = 0, zone = 0}
Locks.Values['winrix'] = {id = 17830186, menu = 0, zone = 0}

-- Key Vendors
Locks.Values['urbiolaine'] = {id = 17719646, menu = 3529, zone = 230}
Locks.Values['igsli'] = {id = 17739961, menu = 0, zone = 235}
Locks.Values['teldrokesdrodo'] = {id = 17764611, menu = 879, zone = 241}
Locks.Values['yonolala'] = {id = 17764612, menu = 879, zone = 241}
Locks.Values['nunaarlbthtrogg'] = {id = 17826181, menu = 5149, zone = 256}

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
