local settings = {}

local config = require('config')

--------------------------------------------------------------------------------
-- Load and validate addon configuration.
--
-- Returns a table with the loaded settings.
--
function settings.load()
    -- Setup deafults
    local defaults = {}
    defaults.printlinks = false
    defaults.openlinks = false
    defaults.maxdistance = 25.0

    -- Load settings
    return config.load('data\\settings.xml', defaults)
end

--------------------------------------------------------------------------------
-- Saves addon configuration.
--
-- param [in] settings - The settings to save.
--
function settings.save(settings)
    config.save(settings)
end

return settings