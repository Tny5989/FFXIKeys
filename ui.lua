local ListView = require('ui/listview')

--------------------------------------------------------------------------------
local MainMenu
local LastMousePos = { x = 0, y = 0 }

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Ui = {}

--------------------------------------------------------------------------------
function Ui.Create()
    MainMenu = ListView:ListView()
    MainMenu:MoveTo(1000, 500)
    MainMenu:SetSize(191, 200)
    MainMenu:SetFontSize(12)
    MainMenu:SetFont('Consolas')
    MainMenu:SetForegroundColor(255, 255, 255, 255)
    MainMenu:SetBackgroundColor(255, 0, 0, 0)
end

--------------------------------------------------------------------------------
function Ui.Destroy()
    MainMenu:Hide()
    MainMenu:Destroy()
end

--------------------------------------------------------------------------------
function Ui.Clear()
    MainMenu:Hide()
    MainMenu:Clear()
end

--------------------------------------------------------------------------------
function Ui.AppendItem(text)
    MainMenu:AppendItem(text)
    MainMenu:Show()
end

--------------------------------------------------------------------------------
function Ui.OnMouseAction(type, x, y, delta, blocked)
    local last_pos = { x = LastMousePos.x, y = LastMousePos.y }
    LastMousePos = { x = x, y = y }

    if blocked then
        return false
    end

    if type == 0 then
        return MainMenu:OnMouseMove(x, y, LastMousePos.x - last_pos.x,
            LastMousePos.y - last_pos.y)
    elseif type == 1 then
        return MainMenu:OnMouseLeftClick(x, y)
    elseif type == 2 then
        return MainMenu:OnMouseLeftRelease(x, y)
    elseif type == 10 and delta > 0 then
        return MainMenu:OnMouseWheelUp(x, y)
    elseif type == 10 and delta < 0 then
        return MainMenu:OnMouseWheelDown(x, y)
    else
        -- Not interested in other events
        return false
    end
end

return Ui