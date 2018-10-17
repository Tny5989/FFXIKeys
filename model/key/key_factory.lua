local ItemKey = require('model/key/item_key')
local NilKey = require('model/key/nil_key')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local KeyFactory = {}

--------------------------------------------------------------------------------
function KeyFactory.CreateKey(id)
    if not id then
        return NilKey:NilKey()
    end

    return ItemKey:ItemKey(id)
end

return KeyFactory
