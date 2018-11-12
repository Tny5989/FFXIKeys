local ListMenu = require('ui/list_menu')
local SimpleMenuItem = require('ui/simple_menu_item')

local MainMenu = ListMenu:ListMenu()

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Ui = {}

--------------------------------------------------------------------------------
function Ui.Clear()
    MainMenu:Hide()
    MainMenu:Clear()
end

--------------------------------------------------------------------------------
function Ui.AppendItem()
    MainMenu:Append(SimpleMenuItem:SimpleMenuItem())
    MainMenu:Show()
end

--------------------------------------------------------------------------------
local function handle_mouse(type, x, y, _, blocked)
    if blocked then
        return false
    end

    if type == 0 then
        return MainMenu:OnMouseMove(x, y)
    elseif type == 1 then
        return MainMenu:OnMouseLeftClick(x, y)
    elseif type == 2 then
        return MainMenu:OnMouseLeftRelease(x, y)
    else
        -- Not interested in other events
        return false
    end
end

--------------------------------------------------------------------------------
windower.register_event('mouse', handle_mouse)

return Ui
