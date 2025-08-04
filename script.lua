GAME_PATH = "mods/inverse/"

GUI = require("escapia/gui")
CORE = require("escapia/core")
LANG = {}

PROJECT = {}

CONFIG = require("config")

red = Color.new(255, 0, 0)
green = Color.new(0, 255, 0)
WHITE = Color.new(255, 255, 255)
WHITE_SEMI = Color.new(255, 255, 255, 125)
BLACK = Color.new(0, 0, 0)

FRAME = {ISESC = true, ID = "menu"}

while true do
    if FRAME.ISESC then
        if FRAME.ID == "room" then
            PROJECT = require(GAME_PATH .. "project")
            LANG = require(GAME_PATH .. PROJECT.LANG[CONFIG.LANGUAGE])
        end
        dofile("escapia/" .. FRAME.ID .. ".lua")
    else
        dofile(GAME_PATH .. FRAME.ID .. ".lua")
    end
    System.GC()
end