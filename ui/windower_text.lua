local default_dimensions = { width = 50, height = 20 } -- BOOOOO!

--------------------------------------------------------------------------------
local Modes = { Pressed = 1, New = 2, Old = 3, Hovor = 4 }

local default_settings = {}
default_settings[Modes.Pressed] = {}
default_settings[Modes.Pressed].bg = { alpha = 255, red = 50, green = 50, blue = 50 }
default_settings[Modes.Pressed].text = { size = 12, font = 'Consolas', alpha = 255, red = 225, green = 225, blue = 225 }
default_settings[Modes.Pressed].stroke = { width = 0, alpha = 255, red = 0, green = 0, blue = 0 }

default_settings[Modes.New] = {}
default_settings[Modes.New].bg = { alpha = 255, red = 100, green = 100, blue = 100 }
default_settings[Modes.New].text = { size = 12, font = 'Consolas', alpha = 255, red = 255, green = 255, blue = 255 }
default_settings[Modes.New].stroke = { width = 0, alpha = 255, red = 0, green = 0, blue = 0 }

default_settings[Modes.Old] = {}
default_settings[Modes.Old].bg = { alpha = 255, red = 100, green = 100, blue = 100 }
default_settings[Modes.Old].text = { size = 12, font = 'Consolas', alpha = 255, red = 225, green = 225, blue = 225 }
default_settings[Modes.Old].stroke = { width = 0, alpha = 255, red = 0, green = 0, blue = 0 }

default_settings[Modes.Hovor] = {}
default_settings[Modes.Hovor].bg = { alpha = 255, red = 150, green = 150, blue = 150 }
default_settings[Modes.Hovor].text = { size = 12, font = 'Consolas', alpha = 255, red = 255, green = 255, blue = 255 }
default_settings[Modes.Hovor].stroke = { width = 0, alpha = 255, red = 0, green = 0, blue = 0 }

--------------------------------------------------------------------------------
local function uuid()
    local random = math.random
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local WindowerText = {}
WindowerText.__index = WindowerText

--------------------------------------------------------------------------------
function WindowerText:WindowerText(text)
    local o = {}
    setmetatable(o, self)
    o._id = uuid()
    o._text = ''
    o._pressed = false
    o._highlighted = false
    o._new = true
    o._visible = false

    windower.text.create(o._id)
    o:SetDisplayText(text)
    o:ApplyPalette()

    return o
end

--------------------------------------------------------------------------------
function WindowerText:Destroy()
    windower.text.delete(self._id)
end

--------------------------------------------------------------------------------
function WindowerText:DisplayText()
    return self._text
end

--------------------------------------------------------------------------------
function WindowerText:SetDisplayText(text)
    self._text = text
    windower.text.set_text(self._id, text)
end

--------------------------------------------------------------------------------
function WindowerText:Position()
    local x, y = windower.text.get_location(self._id)
    return { x = x, y = y }
end

--------------------------------------------------------------------------------
function WindowerText:Size()
    local w, h = windower.text.get_extents(self._id)
    if w == h == 0 then
        return { width = default_dimensions.width, height = default_dimensions.height }
    else
        return { width = w, height = h }
    end
end

--------------------------------------------------------------------------------
function WindowerText:MoveTo(x, y)
    windower.text.set_location(self._id, x, y)
end

--------------------------------------------------------------------------------
function WindowerText:SetPressed(pressed)
    self._pressed = (pressed == true)
    if self._pressed then
        self._new = false
    end
    self:ApplyPalette()
end

--------------------------------------------------------------------------------
function WindowerText:IsPressed()
    return self._pressed
end

--------------------------------------------------------------------------------
function WindowerText:SetHighlighted(highlighted)
    self._highlighted = (highlighted == true)
    self:ApplyPalette()
end

--------------------------------------------------------------------------------
function WindowerText:IsHighlighted()
    return self._highlighted
end

--------------------------------------------------------------------------------
function WindowerText:Show()
    self._visible = true
    windower.text.set_visibility(self._id, true)
    windower.text.set_bg_visibility(self._id, true)
end

--------------------------------------------------------------------------------
function WindowerText:Hide()
    self._visible = false
    windower.text.set_visibility(self._id, false)
    windower.text.set_bg_visibility(self._id, false)
end

--------------------------------------------------------------------------------
function WindowerText:IsVisible()
    return self._visible
end

--------------------------------------------------------------------------------
function WindowerText:ContainsPoint(x, y)
    local pos = self:Position()
    local size = self:Size()

    local valid_x = x >= pos.x and x <= (pos.x + size.width)
    local valid_y = y >= pos.y and y <= (pos.y + size.height)

    return valid_x and valid_y
end

--------------------------------------------------------------------------------
function WindowerText:ApplyPalette()
    local settings
    if self._pressed then
        settings = default_settings[Modes.Pressed]
    elseif self._highlighted then
        settings = default_settings[Modes.Hovor]
    elseif self._new then
        settings = default_settings[Modes.New]
    else
        settings = default_settings[Modes.Old]
    end

    windower.text.set_bg_color(self._id, settings.bg.alpha, settings.bg.red,
        settings.bg.green, settings.bg.blue)
    windower.text.set_font(self._id, settings.text.font)
    windower.text.set_font_size(self._id, settings.text.size)
    windower.text.set_color(self._id, settings.text.alpha, settings.text.red,
        settings.text.green, settings.text.blue)
    windower.text.set_stroke_width(self._id, settings.stroke.width)
    windower.text.set_stroke_color(self._id, settings.stroke.alpha,
        settings.stroke.red, settings.stroke.green, settings.stroke.blue)
end

return WindowerText
