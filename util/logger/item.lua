local Logger = require('util/logger/logger')
local Resources = require('resources')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local ItemLogger = Logger:Logger()
ItemLogger.__index = ItemLogger

--------------------------------------------------------------------------------
function ItemLogger:ItemLogger(character)
    local o = Logger:Logger(character, 'items.log', 'a+')
    setmetatable(o, self)
    o._type = 'ItemLogger'
    return o
end

--------------------------------------------------------------------------------
function ItemLogger:_WriteCache(handle)
    for i = 1, #self._cache do
        local dt = os.date('[%H:%M:%S]', self._cache[i].time)
        local item = Resources.items:with('id', self._cache[i])
        local line = dt .. ' ' .. tostring(item.en) .. '\n'
        handle:write(line)
    end
end

--------------------------------------------------------------------------------
function ItemLogger:_WriteHeader(handle)
    local dt = os.date('%m/%d/%Y - %H:%M:%S', self._cache[1].time)
    local sc = string.format('%03d', #self._cache)
    local header = '\n'
    header = header .. '//////////////////////////////////////\n'
    header = header .. '// ' .. dt .. ' - ' .. sc .. ' Keys //\n'
    header = header .. '//////////////////////////////////////\n'
    handle:write(header)
end

return ItemLogger
