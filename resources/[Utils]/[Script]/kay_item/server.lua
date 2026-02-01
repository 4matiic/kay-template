local dropItems = {
    burger = "prop_cs_burger_01",
    water = "prop_ld_flow_bottle",
    money = "bkr_prop_money_unsorted_01",
    WEAPON_PISTOL = "xm3_prop_xm3_pistol_xm3",
    WEAPON_ASSAULTRIFLE = "xm3_prop_xm3_bag_01a",
    carkeys = "m23_2_prop_m32_carkey_fob_01a",
    bread = "prop_sandwich_01",
    phone = "sf_prop_sf_art_phone_01a",
    pioche = "xm3_prop_xm3_bag_01a",
    pietra = "prop_rock_5_smash1",
    pietra2 = "prop_rock_5_smash1",
    pomme = "sf_prop_sf_apple_01b",
}

local DEFAULT_MODEL = "xm3_prop_xm3_bag_01a"

exports.ox_inventory:registerHook('swapItems', function(payload)
    if payload.toInventory ~= 'newdrop' then return end

    local item   = payload.fromSlot
    local coords = GetEntityCoords(GetPlayerPed(payload.source))
    local items  = { { item.name, payload.count, item.metadata } }

    -- modèle choisi ou fallback
    local modelName = dropItems[item.name] or DEFAULT_MODEL
    local model = GetHashKey(modelName)       -- ou garde des backticks si tu préfères les hashes directs

    local dropId = exports.ox_inventory:CustomDrop(item.label, items, coords, 1, item.weight, nil, model)
    if not dropId then return end

    TriggerClientEvent('drops:addLabel', -1, dropId, coords,
        ("%s x%s"):format(item.label, payload.count), model)

    CreateThread(function()
        exports.ox_inventory:RemoveItem(payload.source, item.name, item.count, nil, item.slot)
        Wait(0)
        exports.ox_inventory:forceOpenInventory(payload.source, 'drop', dropId)
    end)

    return false
end, {
    -- itemFilter supprimé pour laisser passer tous les items
    typeFilter = { player = true }
})


-- Détecte quand un joueur prend un item depuis un drop
AddEventHandler('ox_inventory:removeItem', function(source, inventoryId, item, count, slot, metadata)
    if type(inventoryId) == 'string' and inventoryId:sub(1,4) == 'drop' then
        TriggerClientEvent('drops:playPickupAnim', source)
    end
end)

-- Anim pickup quand on prend un item d'un drop (ne rien retourner)
exports.ox_inventory:registerHook('swapItems', function(payload)
    -- fromInventory = "drop-<id>" et toType = "player"
    if type(payload.fromInventory) == 'string'
    and payload.fromInventory:sub(1,4) == 'drop'
    and payload.toType == 'player' then
        TriggerClientEvent('drops:playPickupAnim', payload.source)
    end
end)