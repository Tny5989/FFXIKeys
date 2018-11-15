local LuaUnit = require('luaunit')
local ListPage = require('ui/listpage')
local ListItem = require('ui/listitem')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ListPageTests = {}

--------------------------------------------------------------------------------
function ListPageTests:SetUp()
    windower = {}
    windower.text = {}

    windower.text.createcount = 0
    function windower.text.create()
        windower.text.createcount = windower.text.createcount + 1
    end

    windower.text.deletecount = 0
    function windower.text.delete()
        windower.text.deletecount = windower.text.deletecount + 1
    end

    windower.text.setlocationcount = 0
    function windower.text.set_location()
        windower.text.setlocationcount = windower.text.setlocationcount + 1
    end

    windower.text.setvisibilitycount = 0
    function windower.text.set_visibility()
        windower.text.setvisibilitycount = windower.text.setvisibilitycount + 1
    end

    windower.text.setbgvisibilitycount = 0
    function windower.text.set_bg_visibility()
        windower.text.setbgvisibilitycount = windower.text.setbgvisibilitycount + 1
    end

    windower.text.setcolorcount = 0
    function windower.text.set_color()
        windower.text.setcolorcount = windower.text.setcolorcount + 1
    end

    windower.text.setbgcolorcount = 0
    function windower.text.set_bg_color()
        windower.text.setbgcolorcount = windower.text.setbgcolorcount + 1
    end

    windower.text.setfontcount = 0
    function windower.text.set_font()
        windower.text.setfontcount = windower.text.setfontcount + 1
    end

    windower.text.setfontsizecount = 0
    function windower.text.set_font_size()
        windower.text.setfontsizecount = windower.text.setfontsizecount + 1
    end

    windower.text.settextcount = 0
    function windower.text.set_text()
        windower.text.settextcount = windower.text.settextcount + 1
    end
end

--------------------------------------------------------------------------------
function ListPageTests:TestListStartsEmpty()
    local bg = ListPage:ListPage()
    LuaUnit.assertEquals(bg:Count(), 0)
end

--------------------------------------------------------------------------------
function ListPageTests:TestInsertItemAddsItemAtCorrectIndex()
    local bg = ListPage:ListPage()
    bg:InsertItem(ListItem:ListItem('a'), 1)
    bg:InsertItem(ListItem:ListItem('b'), 1)
    bg:InsertItem(ListItem:ListItem('c'), 3)
    LuaUnit.assertEquals(bg:Count(), 3)
    LuaUnit.assertEquals(bg:GetItem(1):Text(), 'b')
    LuaUnit.assertEquals(bg:GetItem(2):Text(), 'a')
    LuaUnit.assertEquals(bg:GetItem(3):Text(), 'c')
end

--------------------------------------------------------------------------------
function ListPageTests:TestRemoveItemRemovesCorrectItem()
    local bg = ListPage:ListPage()
    bg:InsertItem(ListItem:ListItem('a'), 1)
    bg:InsertItem(ListItem:ListItem('b'), 1)
    bg:InsertItem(ListItem:ListItem('c'), 3)
    bg:RemoveItem(2)
    LuaUnit.assertEquals(bg:Count(), 2)
    LuaUnit.assertEquals(bg:GetItem(1):Text(), 'b')
    LuaUnit.assertEquals(bg:GetItem(2):Text(), 'c')
end

--------------------------------------------------------------------------------
function ListPageTests:TestRemoveItemDestroysItem()
    local bg = ListPage:ListPage()
    bg:InsertItem(ListItem:ListItem('a'), 1)
    bg:InsertItem(ListItem:ListItem('b'), 1)
    bg:InsertItem(ListItem:ListItem('c'), 3)
    windower.text.deletecount = 0
    bg:RemoveItem(2)
    LuaUnit.assertEquals(windower.text.deletecount, 1)
end

--------------------------------------------------------------------------------
function ListPageTests:TestClearRemovesAllItems()
    local bg = ListPage:ListPage()
    bg:InsertItem(ListItem:ListItem('a'), 1)
    bg:InsertItem(ListItem:ListItem('b'), 1)
    bg:InsertItem(ListItem:ListItem('c'), 3)
    bg:Clear()
    LuaUnit.assertEquals(bg:Count(), 0)
end

--------------------------------------------------------------------------------
function ListPageTests:TestClearDestroysItems()
    local bg = ListPage:ListPage()
    bg:InsertItem(ListItem:ListItem('a'), 1)
    bg:InsertItem(ListItem:ListItem('b'), 1)
    bg:InsertItem(ListItem:ListItem('c'), 3)
    windower.text.deletecount = 0
    bg:Clear()
    LuaUnit.assertEquals(windower.text.deletecount, 3)
end

--------------------------------------------------------------------------------
function ListPageTests:TestClearRemovesAllItems()
    local bg = ListPage:ListPage()
    bg:InsertItem(ListItem:ListItem('a'), 1)
    bg:InsertItem(ListItem:ListItem('b'), 1)
    bg:InsertItem(ListItem:ListItem('c'), 3)
    bg:Destroy()
    LuaUnit.assertEquals(bg:Count(), 0)
end

--------------------------------------------------------------------------------
function ListPageTests:TestClearDestroysItems()
    local bg = ListPage:ListPage()
    bg:InsertItem(ListItem:ListItem('a'), 1)
    bg:InsertItem(ListItem:ListItem('b'), 1)
    bg:InsertItem(ListItem:ListItem('c'), 3)
    windower.text.deletecount = 0
    bg:Destroy()
    LuaUnit.assertEquals(windower.text.deletecount, 3)
end

--------------------------------------------------------------------------------
function ListPageTests:TestShowMakesAllItemsVisible()
    local bg = ListPage:ListPage()
    bg:InsertItem(ListItem:ListItem('a'), 1)
    bg:InsertItem(ListItem:ListItem('b'), 1)
    bg:InsertItem(ListItem:ListItem('c'), 3)
    windower.text.setvisibilitycount = 0
    windower.text.setbgvisibilitycount = 0
    bg:Show()
    LuaUnit.assertEquals(windower.text.setvisibilitycount, 3)
    LuaUnit.assertEquals(windower.text.setbgvisibilitycount, 3)
end

--------------------------------------------------------------------------------
function ListPageTests:TestHideMakesAllItemsInvisible()
    local bg = ListPage:ListPage()
    bg:InsertItem(ListItem:ListItem('a'), 1)
    bg:InsertItem(ListItem:ListItem('b'), 1)
    bg:InsertItem(ListItem:ListItem('c'), 3)
    windower.text.setvisibilitycount = 0
    windower.text.setbgvisibilitycount = 0
    bg:Hide()
    LuaUnit.assertEquals(windower.text.setvisibilitycount, 3)
    LuaUnit.assertEquals(windower.text.setbgvisibilitycount, 3)
end

--------------------------------------------------------------------------------
function ListPageTests:TestTypeIsListPage()
    local bg = ListPage:ListPage()
    LuaUnit.assertEquals(bg:Type(), 'ListPage')
end

LuaUnit.LuaUnit.run('ListPageTests')