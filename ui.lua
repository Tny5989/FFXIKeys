local ListMenu = require('ui/list_menu')
local SimpleMenuItem = require('ui/simple_menu_item')

--------------------------------------------------------------------------------
local MainMenu = ListMenu:ListMenu()
local LastMousePos = { x = 0, y = 0 }

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Ui = {}

--------------------------------------------------------------------------------
function Ui.Destory()
    MainMenu:Hide()
    MainMenu:Destory()
end

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
function Ui.OnMouseEvent(type, x, y, _, blocked)
    if blocked then
        return false
    end

    local last_pos = { x = LastMousePos.x, y = LastMousePos.y }
    LastMousePos = { x = x, y = y }

    if type == 0 then
        return MainMenu:OnMouseMove(x, y, LastMousePos.x - last_pos.x,
            LastMousePos.y - last_pos.y)
    elseif type == 1 then
        return MainMenu:OnMouseLeftClick(x, y)
    elseif type == 2 then
        return MainMenu:OnMouseLeftRelease(x, y)
    else
        -- Not interested in other events
        return false
    end
end

return Ui
