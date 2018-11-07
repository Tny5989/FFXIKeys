local default_dimensions = { width = 50, height = 20 } -- BOOOOO!

--------------------------------------------------------------------------------
local default_settings = {}
default_settings[true] = {}
default_settings[true].bg = { alpha = 255, red = 0, green = 0, blue = 0 }
default_settings[true].text = { size = 12, font = 'Arial', alpha = 255, red = 255, green = 255, blue = 255 }
default_settings[true].stroke = { width = 0, alpha = 255, red = 0, green = 0, blue = 0 }

default_settings[false] = {}
default_settings[false].bg = { alpha = 255, red = 0, green = 0, blue = 0 }
default_settings[false].text = { size = 12, font = 'Arial', alpha = 255, red = 255, green = 255, blue = 255 }
default_settings[false].stroke = { width = 0, alpha = 255, red = 0, green = 0, blue = 0 }

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
    o._active = true -- Will be false after constructor finishes
    o._visible = false

    windower.text.create(o._id)
    o:SetDisplayText(text)
    o:Activate()

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
    return { width = default_dimensions.width, height = default_dimensions.height }
end

--------------------------------------------------------------------------------
function WindowerText:MoveTo(x, y)
    windower.text.set_location(self._id, x, y)
end

--------------------------------------------------------------------------------
function WindowerText:Activate()
    self._active = not self._active
    local settings = default_settings[self._active]

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

--------------------------------------------------------------------------------
function WindowerText:IsActive()
    return self._active
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

return WindowerText
