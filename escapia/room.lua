
-- Getting the required section
local section = require(GAME_PATH .. "sections/" .. PROJECT.SECTIONS[PROJECT.STARTING_SECTION])
-- Getting the special script
local special = require(GAME_PATH .. "special")
-- The room ID is set in the config file (TODO)
local ROOM_ID = PROJECT.STARTING_ROOM_ID

-- Initializing an inventory for the game
inventory = require("escapia/inventory")
-- Getting the items catalogue/database
inventory.db = require(GAME_PATH .. "items")

-- Room cut-ins - images on top of the main one which can have different states
ROOMSTATES = {IMG = {}, VAR = {}}

-- Functions definition
local draweasy = Image.draweasy

-- Current room (table)
local currentRoom = section.rooms[ROOM_ID]
-- Current image to show
local currentImg = nil
-- The image buffer which holds all images with load = 1
local IMGBUFFER = {}
-- Getting the cursor position
local cursorPos = {x = PROJECT.GUI_CURSOR.PROPERTIES.X, y = PROJECT.GUI_CURSOR.PROPERTIES.Y}

-- If the cursor is colliding with anything
local colliding = false

-- Blocks the controls:
-- 0: None
-- 1: Cursor moves but can't interact with the main game
-- 2: Total block
BLOCKED = 0

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
    -- Drawing the states for the room
    for i = 1, #currentRoom.states do
        draweasy(ROOMSTATES.IMG[i], currentRoom.states[i].x, currentRoom.states[i].y)
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
    -- Reloading the states for the next room, resetting the values
    for i = 1, #currentRoom.states do
        if not ROOMSTATES.VAR[i] then
            ROOMSTATES.VAR[i] = 1
        end
        ROOMSTATES.IMG[i] = Image.load(GAME_PATH .. currentRoom.states[i].variants[1].img)
    end
    -- Playing the switch sound
    sound.play(sound.WAV_1)
end

-- Changes the state of a cut-in
local function changeState(slotID, newValue)
    ROOMSTATES.VAR[slotID] = newValue
    ROOMSTATES.IMG[slotID] = Image.load(GAME_PATH .. currentRoom.states[slotID].variants[newValue].img)
end

-- Does an action (usually when clicking on an interaction)
local function doAction(action)
    -- Show Dialogue + Move
    if action[1] == "dialogue_move" then
        dialogueText = LANG[action[2]]
        switchRoom(action[3])
    -- Show Dialogue
    elseif action[1] == "dialogue" then
        dialogueText = LANG[action[2]]
    -- Move
    elseif action[1] == "move" then
        switchRoom(action[2])
    -- Add to inventory
    elseif action[1] == "add_item" then
        inventory:addItem(action[2])
    -- Remove from inventory
    elseif action[1] == "remove_item" then
        inventory:removeItem(action[2])
    -- Change the state of a cut-in
    elseif action[1] == "change_state" then
        changeState(action[2], action[3])
    end
end

-- Room updating (controls and other)
local function updateRoom()
    -- Showing the indicators and checking button input
    for i = 1, 4 do
        if currentRoom.canMove[i] ~= nil then
           draweasy(pointIMG[i], PROJECT.GUI_POINTERS[i].X, PROJECT.GUI_POINTERS[i].Y)
        if buttons.pressed(buttons[CONTROLS[i]]) and BLOCKED < 2 then switchRoom(currentRoom.canMove[i]) end 
        end
    end
    -- Hiding the dialogue box (experimental)
    if buttons.pressed(buttons.square) and BLOCKED == 0 then 
        dialogueText = "" 
        sound.play(sound.WAV_2)
    end
end

-- Collisions handling
local function handleCollisions(hitbox)
    for i = 1, #currentRoom.interact do
        -- Getting the rectangle for collision
        local curInteract = currentRoom.interact[i]
        -- If such collision exists, proceed
        if curInteract ~= nil then
            -- Typical box collision
            colliding = ((cursorPos.x + hitbox.X)  < curInteract.x + curInteract.w and
            (cursorPos.x + hitbox.X) + hitbox.W > curInteract.x and
            (cursorPos.y + hitbox.Y) < curInteract.y + curInteract.h and
            (cursorPos.y + hitbox.Y) + hitbox.H > curInteract.y)
            if colliding then
                -- DEBUG ONLY!
                if CONFIG.DEBUG_MODE then
                    LUA.print(0, 20, "Colliding!")
                end
                -- Action on collision
                if buttons.pressed(buttons.cross) then
                    for i, v in ipairs(curInteract.action) do
                        -- Special case: check state and check item
                        if v[1] == "check_state" then
                            -- If the state is not what expected, doing the dedicated block of actions
                            if ROOMSTATES.VAR[v[2]] ~= v[3] then 
                                if v[4] ~= {} then
                                    for n, z in ipairs(v[4]) do
                                        doAction(z)
                                    end
                                    break
                                end
                            end
                        end
                        if v[1] == "check_item" then
                            -- If the player doesn't have the required item, doing the dedicated block of actions
                            if not inventory.items[v[2]] then
                                if #v[3] > 0 then
                                    for n, z in ipairs(v[3]) do
                                        doAction(z)
                                    end
                                    break
                                end
                            end
                        end
                        doAction(v)
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
special.init()

while true do
    buttons.read()
    screen.clear()

    renderRoom()
    updateRoom()
    if CONFIG.DEBUG_MODE then
        LUA.print(0, 0, LUA.getRAM())
    end
    handleCollisions(PROJECT.GUI_CURSOR.HITBOX)

    special.draw(ROOM_ID)

    GUI.update(cursorPos, PROJECT.GUI_CURSOR.HITBOX)

    screen.flip()
end