GUI = {}

function GUI.init()
    img_cursor = Image.load(GAME_PATH .. "assets/png/gui/cursor.png")
    img_dialoguebox = Image.load(GAME_PATH .. "assets/png/gui/messageBoardBack.png")

    directionPointers = {
        {
            img = Image.load(GAME_PATH .. 'assets/png/gui/left.png'),
            x = 0, 
            y = 110
        },
        {
            img = Image.load(GAME_PATH .. 'assets/png/gui/back.png'),
            x = 325, 
            y = 210
        },
        {
            img = Image.load(GAME_PATH .. 'assets/png/gui/up.png'),
            x = 325, 
            y = 42
        },
        {
            img = Image.load(GAME_PATH .. 'assets/png/gui/right.png'),
            x = 420, 
            y = 110
        }
    }

    CONTROLS = {
        "l",
        "circle",
        "triangle",
        "r"
    }

    SND_SWITCH = sound.cloud(GAME_PATH .. "assets/sfx/click_x.wav", sound.WAV_1)
    SND_QUIT = sound.cloud(GAME_PATH .. "assets/sfx/error.wav", sound.WAV_2)
    sound.volume(sound.WAV_1, 50, 50)
    sound.volume(sound.WAV_2, 50, 50)

    GAME_FONT = intraFont.load(GAME_PATH .. "assets/font.pgf")
    --intraFont.setStyle(GAME_FONT, 1.5, Color.new(255, 255, 255), 0, intraFont.ALIGN_CENTER)

    cursorObj = {x = 30, y = 30, speed = 4, bound = {0, 480, 0, 272}}
    cursorHitbox = {x = 5, y = 3, w = 11, h = 11}
    dialogueText = ""
end

function GUI.update()
    if buttons.Lx() > 120 and (cursorObj.x <= cursorObj.bound[2] - cursorHitbox.w) then
        cursorObj.x = cursorObj.x + cursorObj.speed
    end
    if buttons.Lx() < -120 and (cursorObj.bound[1] <= cursorObj.x) then
        cursorObj.x = cursorObj.x - cursorObj.speed
    end
    if buttons.Ly() > 120 and (cursorObj.y <= cursorObj.bound[4] - cursorHitbox.h) then
        cursorObj.y = cursorObj.y + cursorObj.speed
    end
    if buttons.Ly() < -120 and (cursorObj.bound[3] <= cursorObj.y) then
        cursorObj.y = cursorObj.y - cursorObj.speed
    end
end

function GUI.draw()
    -- Your draw code here
    Image.draweasy(img_cursor, cursorObj.x, cursorObj.y)
    if CONFIG.DEBUG_MODE then
        screen.filledRect(cursorObj.x + cursorHitbox.x, cursorObj.y + cursorHitbox.y, cursorHitbox.w, cursorHitbox.h, green, 0)
    end
    if dialogueText ~= "" then 
        Image.draweasy(img_dialoguebox, 26, 0)
        intraFont.print(50, 6, dialogueText, WHITE, GAME_FONT, 0.95)
    end
end

return GUI