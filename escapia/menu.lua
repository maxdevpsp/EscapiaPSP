
-- Loading menu images
local IMG_MENUBG = Image.load("escapia/assets/menuBG.png")
local IMG_MENUWINDOW = Image.load("escapia/assets/menuWindow.png")
local IMG_MENUGLOW = Image.load("escapia/assets/menuIconGlow.png")
local IMG_MENUARROW = Image.load("escapia/assets/menuArrow.png")

-- A table for mods information
local LISTED_MODS = {}
-- A table for mods home images
local MODASSETS = {}

-- Loading the fonts
local TAHOMA_BD_18 = intraFont.load("escapia/assets/tahomabd.ttf", 18)
local TAHOMA_BD_14 = intraFont.load("escapia/assets/tahomabd.ttf", 14)

local TAHOMA_12 = intraFont.load("escapia/assets/tahoma.ttf", 12)

-- Menu variables
local SELECT_INDEX = 1
local MENUGLOW_ALPHA = 255
local BLINK = true
local LOADING = false

-- Getting the mods in the directory and loading their config and images
local function getMods()
    local directories = System.listDir("mods")
    -- Removing the ".." directory
    table.remove(directories, 1)
    for i, dir in ipairs(directories) do
        local file_exists = io.open("mods/" .. dir.name .. "/project.lua", "r") ~= nil
        print(file_exists)
        if file_exists then
            -- Loading the project files
            LISTED_MODS[i] = require("mods/" .. dir.name .. "/project")
            -- Loading the pictures
            MODASSETS[i] = {
                IMG_ICON = Image.load("mods/" .. dir.name .. "/menu/icon.png")
            }
        end
    end
end

local function unloadMenu()
    Image.unload(IMG_MENUBG)
    Image.unload(IMG_MENUWINDOW)
    Image.unload(IMG_MENUGLOW)
    Image.unload(IMG_MENUARROW)
end

-- Time required for math.sin
local time = 0

-- Getting the mods
getMods()

while true do
    buttons.read()
    screen.clear()

    time = time + 0.05

    if not LOADING then
        Image.draweasy(IMG_MENUBG, 0, 0)
        Image.draweasy(IMG_MENUWINDOW, 202, 0)
        Image.draweasy(IMG_MENUGLOW, 9, 79, nil, 0, MENUGLOW_ALPHA)
        if SELECT_INDEX > 1 then
            Image.draweasy(IMG_MENUARROW, 34, 0)
            if buttons.pressed(buttons.up) then
                SELECT_INDEX = SELECT_INDEX - 1
            end
        end
        if SELECT_INDEX < #LISTED_MODS then
            Image.draw(IMG_MENUARROW, 34, 272, nil, -23)
            if buttons.pressed(buttons.down) then
                SELECT_INDEX = SELECT_INDEX + 1
            end
        end

        intraFont.print(224, 24, LISTED_MODS[SELECT_INDEX].NAME, WHITE, TAHOMA_BD_18)
        intraFont.print(224, 24 + 24, "by " .. LISTED_MODS[SELECT_INDEX].AUTHOR, WHITE_SEMI, TAHOMA_BD_14)
        intraFont.print(224, 24 + 52, LISTED_MODS[SELECT_INDEX].DESCRIPTION, WHITE, TAHOMA_12)

        MENUGLOW_ALPHA = 150 + math.sin(time * 0.75) * 105

        Image.draweasy(MODASSETS[SELECT_INDEX].IMG_ICON, 33, 96)

        if buttons.pressed(buttons.cross) then
            LOADING = true
            local CURGAME = LISTED_MODS[SELECT_INDEX]
            GAME_PATH = CONFIG.MODS_FOLDER .. "/" .. CURGAME.FOLDER_NAME .. "/"
            CORE.jump((CURGAME.STARTING_FRAME == "room"), CURGAME.STARTING_FRAME)
            unloadMenu()
            break
        end
    else
        LUA.print(8, 254, "Loading...")
    end

    if CONFIG.DEBUG_MODE then
        LUA.print(0, 0, LUA.getRAM())
    end

    screen.flip()
end