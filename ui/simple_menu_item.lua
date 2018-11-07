local NilMenuItem = require('ui/nil_menu_item')
local WindowerText = require('ui/windower_text')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local SimpleMenuItem = NilMenuItem:NilMenuItem()
SimpleMenuItem.__index = SimpleMenuItem

--------------------------------------------------------------------------------
function SimpleMenuItem:SimpleMenuItem()
    local o = {}
    setmetatable(o, self)
    o._type = 'SimpleMenuItem'
    o._text = WindowerText:WindowerText('DefaultText')
    return o
end

--------------------------------------------------------------------------------
function SimpleMenuItem:Destroy()
    self._text:Destroy()
end

--------------------------------------------------------------------------------
function SimpleMenuItem:DisplayText()
    return self._text:DisplayText()
end

--------------------------------------------------------------------------------
function SimpleMenuItem:Size()
    return self._text:Size()
end

--------------------------------------------------------------------------------
function SimpleMenuItem:MoveTo(x, y)
    NilMenuItem.MoveTo(self, x, y)
    self._text:MoveTo(self._position.x, self._position.y)
end

--------------------------------------------------------------------------------
function SimpleMenuItem:DragBy(dx, dy)
    NilMenuItem.DragBy(self, dx, dy)
    self._text:MoveTo(self._position.x, self._position.y)
end

--------------------------------------------------------------------------------
function SimpleMenuItem:Activate()
    self._text:Activate()
end

--------------------------------------------------------------------------------
function SimpleMenuItem:IsActive()
    return self._text:IsActive()
end

--------------------------------------------------------------------------------
function SimpleMenuItem:Show()
    self._text:Show()
end

--------------------------------------------------------------------------------
function SimpleMenuItem:Hide()
    self._text:Hide()
end

--------------------------------------------------------------------------------
function SimpleMenuItem:SetVisibility(visibility)
    if visibility then
        self:Show()
    else
        self:Hide()
    end
end

--------------------------------------------------------------------------------
function SimpleMenuItem:IsVisible()
    return self._text:IsVisible()
end

return SimpleMenuItem
