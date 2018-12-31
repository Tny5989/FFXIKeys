--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Aliases = {}

--------------------------------------------------------------------------------
function Aliases.Update()
    windower.send_command('alias buykeys input //keys buy "SP Gobbie Key" ')
    windower.send_command('alias usekeys input //keys use "SP Gobbie Key"')
    windower.send_command('alias getscroll input //keys buy "Warp Scroll" 1')
end

return Aliases