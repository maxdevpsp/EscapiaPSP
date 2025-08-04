local inventory = {items = {}, db = {}}

function inventory:addItem(ID)
    inventory.items[ID] = 1
end

function inventory:removeItem(ID)
    inventory.items[ID] = 0
end

return inventory