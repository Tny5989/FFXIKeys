local ListView = require('ui/listview')
local Palatte = require('ui/style/palatte')
local PalatteFactory = require('ui/style/palatte_factory')
local Resources = require('resources')

--------------------------------------------------------------------------------
local MainMenu
local LastMousePos = { x = 0, y = 0 }
local MaxItem = ''

for _, value in pairs(Resources.items) do
    if #value.en > #MaxItem then
        MaxItem = value.en
    end
end

local function PadString(str, len)
    return str .. string.rep(' ', math.max(len - #str, 0))
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Ui = {}

--------------------------------------------------------------------------------
function Ui.Create()
    local p = Palatte:Palatte()
    p:SetColor('bg', { a = 155, r = 0, g = 0, b = 0 })
    p:SetColor('fg', { a = 255, r = 255, g = 255, b = 255 })
    PalatteFactory.Insert('list_normal', p)

    p = Palatte:Palatte()
    p:SetColor('bg', { a = 155, r = 100, g = 100, b = 100 })
    p:SetColor('fg', { a = 255, r = 255, g = 255, b = 255 })
    PalatteFactory.Insert('list_highlight', p)

    p = Palatte:Palatte()
    p:SetColor('bg', { a = 155, r = 50, g = 50, b = 50 })
    p:SetColor('fg', { a = 255, r = 255, g = 255, b = 255 })
    PalatteFactory.Insert('list_select', p)

    p = Palatte:Palatte()
    p:SetColor('bg', { a = 155, r = 255, g = 255, b = 255 })
    p:SetColor('fg', { a = 155, r = 255, g = 255, b = 255 })
    PalatteFactory.Insert('scrollbar_fg', p)

    p = Palatte:Palatte()
    p:SetColor('bg', { a = 155, r = 0, g = 0, b = 0 })
    p:SetColor('fg', { a = 155, r = 0, g = 0, b = 0 })
    PalatteFactory.Insert('scrollbar_bg', p)

    p = Palatte:Palatte()
    p:SetColor('bg', { a = 155, r = 255, g = 255, b = 255 })
    p:SetColor('fg', { a = 155, r = 0, g = 0, b = 0 })
    PalatteFactory.Insert('header', p)

    MainMenu = ListView:ListView(PadString('FFXIKeys', #MaxItem))
    MainMenu:MoveTo(1000, 500)
    MainMenu:SetSize(191, 200)
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
    MainMenu:AppendItem(PadString(text, #MaxItem))
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