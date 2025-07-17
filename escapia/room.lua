
-- Getting the required section
local section = require(GAME_PATH .. "sections/1")
-- Getting the special script
local special = require(GAME_PATH .. "special")
-- The room ID is set in the config file (TODO)
local ROOM_ID = 1

-- Functions definition
local draweasy = Image.draweasy

-- Current room (table)
local currentRoom = section.rooms[ROOM_ID]
-- Current image to show
local currentImg = nil
-- The image buffer which holds all images with load = 1
local IMGBUFFER = {}

local colliding = false

-- Initializing the current SECTION. 
-- This function loads all images with load = 1 into the IMGBUFFER
local function initSection()
    for i = 1, #section.rooms do
        if section.rooms[i].load == 1 then
            IMGBUFFER[i] = Image.load(GAME_PATH .. section.rooms[i].img)
        end
    end
end

-- Room rendering
-- TODO: Add objects and states
local function renderRoom()
    -- 0 - draw currentImg, 1 - draw from IMGBUFFER
    if currentRoom.load == 0 then
        draweasy(currentImg, 0, 0)
    else
        draweasy(IMGBUFFER[ROOM_ID], 0, 0)
    end
end

-- Room swtiching (ID1 -> ID2)
local function switchRoom(id)
    -- Changing the room
    ROOM_ID = id
    currentRoom = section.rooms[ROOM_ID]
    -- Resetting the dialogue box
    dialogueText = ""

    -- If the image needs to be loaded, freeing the current image and loading the new one
    if currentRoom.load == 0 then
        if currentImg then Image.unload(currentImg) end
        currentImg = Image.load(GAME_PATH .. currentRoom.img)
    end
    sound.play(sound.WAV_1)
end

-- Room updating (controls and other)
local function updateRoom()
    -- Showing the indicators and checking button input
    for i = 1, 4 do
        if currentRoom.canMove[i] ~= nil then
           draweasy(directionPointers[i].img, directionPointers[i].x, directionPointers[i].y)
        if buttons.pressed(buttons[CONTROLS[i]]) then switchRoom(currentRoom.canMove[i]) end 
        end
    end
    -- Hiding the dialogue box (experimental)
    if buttons.pressed(buttons.square) then 
        dialogueText = "" 
        sound.play(sound.WAV_2)
    end
end

-- Collisions handling
local function handleCollisions()
    for i = 1, #currentRoom.interact do
        -- Getting the rectangle for collision
        local curInteract = currentRoom.interact[i]
        -- If such collision exists, proceed
        if curInteract ~= nil then
            -- Typical box collision
            colliding = ((cursorObj.x + cursorHitbox.x)  < curInteract.x + curInteract.w and
            (cursorObj.x + cursorHitbox.x) + cursorHitbox.w > curInteract.x and
            (cursorObj.y + cursorHitbox.y) < curInteract.y + curInteract.h and
            (cursorObj.y + cursorHitbox.y) + cursorHitbox.h > curInteract.y)
            if colliding then
                -- DEBUG ONLY!
                if CONFIG.DEBUG_MODE then
                    LUA.print(0, 0, "Colliding!")
                end
                -- Action on collision
                if buttons.pressed(buttons.cross) then
                    -- Dialogue + Move
                    if curInteract.action[1] == "dialogue_move" then
                        switchRoom(curInteract.action[2])
                        dialogueText = LANG[curInteract.action[3]]
                    -- Move
                    elseif curInteract.action[1] == "move" then
                        switchRoom(curInteract.action[2])
                    -- Dialogue
                    elseif curInteract.action[1] == "dialogue" then
                        dialogueText = LANG[curInteract.action[2]]
                    end
                end
            end
            -- DEBUG ONLY!
            if CONFIG.DEBUG_MODE then
                screen.filledRect(curInteract.x, curInteract.y, curInteract.w, curInteract.h, red, 0, 128)
            end
        end
    end
end

GUI.init()
initSection()
switchRoom(ROOM_ID)

while true do
    buttons.read()
    screen.clear()

    renderRoom()
    updateRoom()
    if CONFIG.DEBUG_MODE then
        LUA.print(0, 0, LUA.getRAM())
    end
    handleCollisions()

    special.draw(ROOM_ID)

    GUI.update()
    GUI.draw()

    screen.flip()
end