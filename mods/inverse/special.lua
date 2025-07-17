local special = {}

function special.init()
end

function special.update()
end

function special.draw(ROOM_ID)
    if ROOM_ID == 16 then
        intraFont.print(40, 40, LANG[16], BLACK, GAME_FONT, 1.2)
    end
end

return special