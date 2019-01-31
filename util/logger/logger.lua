--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Logger = {}
Logger.__index = Logger

--------------------------------------------------------------------------------
function Logger:Logger(character, file, write_mode)
    local o = {}
    setmetatable(o, self)
    o._cache = {}
    o._write_mode = write_mode
    o._path = { windower.addon_path, character, file }
    o._type = 'Logger'
    return o
end

--------------------------------------------------------------------------------
function Logger:Log(...)
    local time = os.time()
    for i = 1, #arg do
        table.insert(self._cache, { time = time, item = arg[i] })
    end
end

--------------------------------------------------------------------------------
function Logger:ClearCache()
    self._cache = {}
end

--------------------------------------------------------------------------------
function Logger:Flush()
    if #self._cache > 0 then
        self._CreatePath()
        local file = io.open(self._path, self._write_mode)
        self:_WriteHeader(file)
        self:_WriteCache(file)
        file:close()
        self:ClearCache()
    end
end

--------------------------------------------------------------------------------
function Logger:Type()
    return self._type
end

--------------------------------------------------------------------------------
function Logger:_WriteCache(handle)
end

--------------------------------------------------------------------------------
function Logger:_WriteHeader(handle)
end

--------------------------------------------------------------------------------
function Logger:_CreatePath()
    local path = self._path[1]
    windower.create_dir(path)
    path = path .. self._path[2]
    windower.create_dir(path)
end

return Logger
