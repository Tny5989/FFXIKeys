local NilMenuItem = require('ui/nil_menu_item')

local default_settings = { flags = { draggable = false } }

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local SimpleMenuItem = NilMenuItem:NilMenuItem()
SimpleMenuItem.__index = SimpleMenuItem

--------------------------------------------------------------------------------
function SimpleMenuItem:SimpleMenuItem()
    local o = {}
    setmetatable(o, self)
    o._type = 'SimpleMenuItem'
    o._text_obj = texts.new('${display_name}', default_settings)
    o._text_obj.display_name = 'DefaultText'
    return o
end

--------------------------------------------------------------------------------
function SimpleMenuItem:Destroy()
    self._text_obj:destroy()
end

--------------------------------------------------------------------------------
function SimpleMenuItem:DisplayText()
    return self._text_obj.display_name
end

--------------------------------------------------------------------------------
function SimpleMenuItem:Size()
    local w, h = self._text_obj:extents()
    return { width = w, height = h }
end

--------------------------------------------------------------------------------
function SimpleMenuItem:MoveTo(x, y)
    NilMenuItem.MoveTo(self, x, y)
    self._text_obj:pos(self._position.x, self._position.y)
end

--------------------------------------------------------------------------------
function SimpleMenuItem:DragBy(dx, dy)
    NilMenuItem.DragBy(self, dx, dy)
    self._text_obj:pos(self._position.x, self._position.y)
end

--------------------------------------------------------------------------------
function SimpleMenuItem:Activate()
    self._active = not self._active
end

return SimpleMenuItem
