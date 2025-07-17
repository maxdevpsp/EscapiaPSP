GAME_PATH = "mods/inverse/"

GUI = require("escapia/gui")
LANG = require(GAME_PATH .. "assets/lang/en")

CONFIG = require("config")

red = Color.new(255, 0, 0)
green = Color.new(0, 255, 0)
WHITE = Color.new(255, 255, 255)
BLACK = Color.new(0, 0, 0)

while true do
    dofile("escapia/room.lua")
    System.GC()
end