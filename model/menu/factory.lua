local ActionMenu = require('model/menu/action')
local NilMenu = require('model/menu/nil')
local SimpleMenu = require('model/menu/simple')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local MenuFactory = {}

--------------------------------------------------------------------------------
function MenuFactory.CreateMenu(pkt)
    if not pkt or not packets then
        return NilMenu:NilMenu()
    end

    local ppkt = packets.parse('incoming', pkt)
    if not ppkt then
        return NilMenu:NilMenu()
    end

    local menu_id = ppkt['Menu ID']
    if not menu_id or menu_id == 0 then
        return NilMenu:NilMenu()
    end

    local params = ppkt['Menu Parameters']
    if not params then
        return SimpleMenu:SimpleMenu(menu_id, 0, false)
    end

    return ActionMenu:ActionMenu(menu_id)
end

--------------------------------------------------------------------------------
function MenuFactory.CreateExtraMenu(pkt, last_menu, item_id)
    if not pkt or not last_menu or not item_id or not packets then
        return NilMenu:NilMenu()
    end

    -- This isn't really needed until I figure out what is in these packets
    local ppkt = packets.parse('incoming', pkt)
    if not ppkt then
        return NilMenu:NilMenu()
    end

    if last_menu:Type() == 'ActionMenu' then
        return SimpleMenu:SimpleMenu(last_menu:Id(), 2, true)
    end

    return SimpleMenu:SimpleMenu(last_menu:Id(), 2, false);
end

return MenuFactory
