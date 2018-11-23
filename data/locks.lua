local function ByValue(name, search_value, domain)
    for _, value in pairs(domain) do
        if value[name] == search_value then
            return value
        end
    end

    return domain['']
end

local Locks = {}
Locks.GobbieMysteryBox = {}
Locks.GobbieMysteryBox['']={id = 0, en = '', menu = 0, zone = 0}
Locks.GobbieMysteryBox[17727633]={id = 17727633, en = 'Habitox', menu = 0, zone = 232}
Locks.GobbieMysteryBox[17719641]={id = 17719641, en = 'Mystrix', menu = 0, zone = 230}
Locks.GobbieMysteryBox[17735872]={id = 17735872, en = 'Bountibox', menu = 0, zone = 234}
Locks.GobbieMysteryBox[17739956]={id = 17739956, en = 'Specilox', menu = 0, zone = 235}
Locks.GobbieMysteryBox[17756352]={id = 17756352, en = 'Arbitrix', menu = 0, zone = 239}
Locks.GobbieMysteryBox[17764606]={id = 17764606, en = 'Funtrox', menu = 0, zone = 241}
Locks.GobbieMysteryBox[17780998]={id = 17780998, en = 'Sweepstox', menu = 0, zone = 245}
Locks.GobbieMysteryBox[17776886]={id = 17776886, en = 'Priztrix', menu = 0, zone = 244}
Locks.GobbieMysteryBox[16982639]={id = 16982639, en = 'Wondrix', menu = 0, zone = 50}
Locks.GobbieMysteryBox[17826176]={id = 17826176, en = 'Rewardox', menu = 0, zone = 256}
Locks.GobbieMysteryBox[17830186]={id = 17830186, en = 'Winrix', menu = 0, zone = 257}

Locks.Unity = {}
Locks.Unity['']={id = 0, en = '', menu = 0, zone = 0}
Locks.Unity[17719646]={id = 17719646, en = 'Urbiolaine', menu = 3529, zone = 230}
Locks.Unity[17739961]={id = 17739961, en = 'Igsli', menu = 598,  zone = 235}
Locks.Unity[17764611]={id = 17764611, en = 'Teldro-Kesdrodo', menu = 879,  zone = 241}
Locks.Unity[17764612]={id = 17764612, en = 'Yonolala', menu = 879,  zone = 241}
Locks.Unity[17826181]={id = 17826181, en = 'Nunaarl Bthtrogg', menu = 5149, zone = 256 }

--------------------------------------------------------------------------------
function Locks.GetGobbieMysteryBoxByName(name)
    return ByValue('en', name, Locks.GobbieMysteryBox)
end

--------------------------------------------------------------------------------
function Locks.GetGobbieMysteryBoxByZone(zone)
    return ByValue('zone', zone, Locks.GobbieMysteryBox)
end

--------------------------------------------------------------------------------
function Locks.GetUnityByName(name)
    return ByValue('en', name, Locks.Unity)
end

--------------------------------------------------------------------------------
function Locks.GetUnityByZone(zone)
    return ByValue('zone', zone, Locks.Unity)
end

return Locks