GUI = {}

function GUI.init()
    img_cursor = Image.load(GAME_PATH .. PROJECT.GUI_CURSOR.IMG)
    img_dialoguebox = Image.load(GAME_PATH .. PROJECT.GUI_DIALOGUE.IMG)

    pointIMG = {}
    for i = 1, 4 do
        pointIMG[i] = Image.load(GAME_PATH .. PROJECT.GUI_POINTERS[i].IMG)
    end

    CONTROLS = {
        "l",
        "circle",
        "triangle",
        "r"
    }

    SND_SWITCH = sound.cloud(GAME_PATH .. PROJECT.SND_SWITCH.SRC, sound.WAV_1)
    SND_QUIT = sound.cloud(GAME_PATH .. PROJECT.SND_DISCARD.SRC, sound.WAV_2)
    sound.volume(sound.WAV_1, PROJECT.SND_SWITCH.VOLUME, PROJECT.SND_SWITCH.VOLUME)
    sound.volume(sound.WAV_2, PROJECT.SND_DISCARD.VOLUME, PROJECT.SND_DISCARD.VOLUME)

    GAME_FONT = intraFont.load(GAME_PATH .. PROJECT.GUI_FONT)

    dialogueText = ""
end

function GUI.update(cursorPos, hitbox)
    if buttons.Lx() > 120 and (cursorPos.x <= PROJECT.GUI_CURSOR.PROPERTIES.BOUND[2] - hitbox.W) then
        cursorPos.x = cursorPos.x + PROJECT.GUI_CURSOR.PROPERTIES.SPEED
    end
    if buttons.Lx() < -120 and (PROJECT.GUI_CURSOR.PROPERTIES.BOUND[1] <= cursorPos.x) then
        cursorPos.x = cursorPos.x - PROJECT.GUI_CURSOR.PROPERTIES.SPEED
    end
    if buttons.Ly() > 120 and (cursorPos.y <= PROJECT.GUI_CURSOR.PROPERTIES.BOUND[4] - hitbox.H) then
        cursorPos.y = cursorPos.y + PROJECT.GUI_CURSOR.PROPERTIES.SPEED
    end
    if buttons.Ly() < -120 and (PROJECT.GUI_CURSOR.PROPERTIES.BOUND[3] <= cursorPos.y) then
        cursorPos.y = cursorPos.y - PROJECT.GUI_CURSOR.PROPERTIES.SPEED
    end
end

function GUI.draw(cursorPos, hitbox)
    -- Your draw code here
    Image.draweasy(img_cursor, cursorPos.x, cursorPos.y)
    if CONFIG.DEBUG_MODE then
        screen.filledRect(cursorPos.x + hitbox.X, cursorPos.y + hitbox.Y, hitbox.W, hitbox.H, green, 0)
    end
    if dialogueText ~= "" then 
        Image.draweasy(img_dialoguebox, PROJECT.GUI_DIALOGUE.PROPERTIES.X, PROJECT.GUI_DIALOGUE.PROPERTIES.Y)
        intraFont.print(240, 6, dialogueText, WHITE, GAME_FONT, 0.95, 0, intraFont.ALIGN_CENTER)
    end
end

return GUI