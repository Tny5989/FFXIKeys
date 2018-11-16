local Palatte = {}
Palatte.__index = Palatte

function Palatte:Palatte()
    local o = {}
    setmetatable(o, self)
    o._colors = {}
    o._fonts = {}

    o:SetColor('fg', { a = 255, r = 255, g = 255, b = 255 })
    o:SetColor('bg', { a = 255, r = 0, g = 0, b = 0 })
    o:SetFont('default', 'Consolas', 12)

    return o
end

function Palatte:SetColor(idx, color)
    self._colors[idx] = color
end

function Palatte:Color(idx)
    return self._colors[idx]
end

function Palatte:SetFont(idx, font_name, font_size)
    self._fonts[idx] = { fn = font_name, fs = font_size }
end

function Palatte:Font(idx)
    return self._fonts[idx]
end

return Palatte
