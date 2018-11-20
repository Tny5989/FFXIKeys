local Palatte = require('ui/style/palatte')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local PalatteFactory = {}
PalatteFactory.palattes = {}

--------------------------------------------------------------------------------
function PalatteFactory.Insert(name, p)
    PalatteFactory.palattes[name] = p
end

--------------------------------------------------------------------------------
function PalatteFactory.Get(name)
    if PalatteFactory.palattes[name] then
        return PalatteFactory.palattes[name]
    else
        return Palatte:Palatte()
    end
end

return PalatteFactory
