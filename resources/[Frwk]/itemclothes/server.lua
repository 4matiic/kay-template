ESX = exports["framework"]:getSharedObject()

local clothesComponentID = { 
    1,  -- Masques
    0,  -- Chapeaux
    2,  -- Oreilles (accessoires)
    1,  -- Lunettes
    7,  -- Chaînes (colliers)
    8,  -- T-Shirts
    11, -- Vêtements supérieurs (torses)
    9,  -- Gilets pare-balles
    7,  -- Bracelets
    6,  -- Montres
    5,  -- Sacs
    4,  -- Pantalons
    6,  -- Chaussures
    3,   -- Bras (torses ou accessoires visibles)
    12,   -- Tenue

    
}

local clothesComponentNames = { 
    "cloth_mask",       -- Masques
    "cloth_helmet",        -- Chapeaux
    "cloth_ears",       -- Accessoires pour les oreilles
    "cloth_glasses",    -- Lunettes
    "cloth_chain",      -- Chaînes (colliers)
    "cloth_tshirt",     -- T-Shirts
    "cloth_torso",      -- Vêtements supérieurs
    "cloth_bproof",     -- Gilets pare-balles
    "cloth_bracelets",  -- Bracelets
    "cloth_watches",    -- Montres
    "cloth_bags",       -- Sacs
    "cloth_pants",      -- Pantalons
    "cloth_shoes",      -- Chaussures
    "cloth_arms",       -- Bras (accessoires visibles ou torses)
    "cloth_outfit",       -- Tenue

}

local clothesSlotID = { 
    31, -- Masques
    30, -- Chapeaux
    40, -- Oreilles (accessoires)
    32, -- Lunettes
    33, -- Chaînes (colliers)
    42, -- T-Shirts
    35, -- Vêtements supérieurs (torses)
    43, -- Gilets pare-balles
    44, -- Bracelets
    36, -- Montres
    41, -- Sacs
    37, -- Pantalons
    45, -- Chaussures
    34,  -- Bras (torses ou accessoires visibles)
    46,  -- Tenue

}

local UseExports = Config.UseExports
local canCC

local defaultClothingWoman = {
    [1] = { draw = 0, text = 0 },
    [2] = { draw = -1, text = -1 },
    [3] = { draw = -1, text = -1 },
    [4] = { draw = -1, text = -1 },
    [5] = { draw = 0, text = 0 },
    [6] = { draw = 15, text = 0 },
    [7] = { draw = 15, text = 0 },
    [8] = { draw = 0, text = 0 },
    [9] = { draw = -1, text = -1 },
    [10] = { draw = -1, text = -1 },
    [11] = { draw = 0, text = 0 },
    [12] = { draw = 15, text = 0 },
    [13] = { draw = 35, text = 0 },
    [14] = { draw = 15, text = 0 }
}

local defaultClothingMen = {
    [1] = { draw = 0, text = 0 },
    [2] = { draw = -1, text = -1 },
    [3] = { draw = -1, text = -1 },
    [4] = { draw = -1, text = -1 },
    [5] = { draw = 0, text = 0 },
    [6] = { draw = 15, text = 0 },
    [7] = { draw = 15, text = 0 },
    [8] = { draw = 0, text = 0 },
    [9] = { draw = -1, text = -1 },
    [10] = { draw = -1, text = -1 },
    [11] = { draw = 0, text = 0 },
    [12] = { draw = 21, text = 0 },
    [13] = { draw = 34, text = 0 },
    [14] = { draw = 15, text = 0 }
}

local checkMovingItems = exports.ox_inventory:registerHook('swapItems', function(payload)
    local source_ = payload.source
    local action = payload.action
    local czSlotsfrom = payload.fromSlot.slot
    local czSlots = payload.toSlot
    if (action == 'swap') then
        local fromSlotMoved = payload.fromSlot.slot
        local toSlotMoved = payload.toSlot.slot

        local CurrentItemNames = { payload.fromSlot.name, payload.toSlot.name }
        local CurrentItemMetadata = { payload.fromSlot.metadata, payload.toSlot.metadata }

        local cItemMoved = false
        local cItemMovedIndex = -1

        local cSlotToDetect = false
        local cSlotToIndex = -1

        local cSlotFromDetect = false
        local cSlotFromIndex = -1

        for index, searchingClothingName in ipairs(clothesComponentNames) do
            if CurrentItemNames[1] == searchingClothingName or CurrentItemNames[2] == searchingClothingName then
                cItemMoved = true
                cItemMovedIndex = index
                break
            end
        end

        for index, searchingClothingSlot in ipairs(clothesSlotID) do
            if toSlotMoved == searchingClothingSlot then
                cSlotToDetect = true
                cSlotToIndex = index
                break
            end
        end

        for index, searchingClothingSlot in ipairs(clothesSlotID) do
            if fromSlotMoved == searchingClothingSlot then
                cSlotFromDetect = true
                cSlotFromIndex = index
                break
            end
        end

        local isComponent
        if cItemMovedIndex == 2 or cItemMovedIndex == 4 or cItemMovedIndex == 3 or cItemMovedIndex == 10 or cItemMovedIndex == 9 then
            isComponent = false
        else
            isComponent = true
        end

        if (cItemMoved) then
            if (UseExports) then
                canCC = Player(source_).state.canChangeClothes
            else
                canCC = true
            end

            if(CurrentItemNames[1] == CurrentItemNames[2]) then
                if (cSlotFromIndex == cItemMovedIndex) then
                    if (canCC) then
                        if clothesComponentID[MovedCitemIndex] == 12 then
                            local item = exports.ox_inventory:GetSlot(source_, 46)
                            if item then
                                CurrentItemMetadata = item.metadata
                            end

                            local components = {
                                Arms = { drawable = CurrentItemMetadata.Arms.drawable, texture = CurrentItemMetadata.Arms.texture },
                                Pants = { drawable = CurrentItemMetadata.Pants.drawable, texture = CurrentItemMetadata.Pants.texture },
                                Shoes = { drawable = CurrentItemMetadata.Shoes.drawable, texture = CurrentItemMetadata.Shoes.texture },
                                Accessories = { drawable = CurrentItemMetadata.Accessories.drawable, texture = CurrentItemMetadata.Accessories.texture },
                                Undershirt = { drawable = CurrentItemMetadata.Undershirt.drawable, texture = CurrentItemMetadata.Undershirt.texture },
                                Decals = { drawable = CurrentItemMetadata.Decals.drawable, texture = CurrentItemMetadata.Decals.texture },
                                Torso = { drawable = CurrentItemMetadata.Torso.drawable, texture = CurrentItemMetadata.Torso.texture },
                                Glasses = { drawable = CurrentItemMetadata.Glasses.drawable, texture = CurrentItemMetadata.Glasses.texture },
                            }
                            TriggerClientEvent('setOutfit', source_, components)
                        else
                        if (isComponent) then
                            if clothesComponentNames[cItemMovedIndex] == 'bag' then
                                local suc = BagAdd(source_, CurrentItemMetadata[1], false)
                                if suc then
                                    local suc2 = BagAdd(source_, CurrentItemMetadata[2], true)
                                    if suc2 == false then
                                        return false
                                    end
                                else
                                    return false
                                end
                            end
                            local components = {
                                texture = CurrentItemMetadata[2].texture,
                                drawable = CurrentItemMetadata[2].drawable,
                                component_id = clothesComponentID[cItemMovedIndex]
                            }
                            TriggerClientEvent('setPedComponent', source_, components)
                        else
                            local props = {
                                texture = CurrentItemMetadata[2].texture,
                                drawable = CurrentItemMetadata[2].drawable,
                                prop_id = clothesComponentID[cItemMovedIndex]
                            }
                            TriggerClientEvent('setPedProp', source_, props)
                        end
                    end
                    else
                        return false
                    end
                elseif(cSlotToIndex == cItemMovedIndex) then
                    if (canCC) then
                        if clothesComponentID[MovedCitemIndex] == 12 then
                            local item = exports.ox_inventory:GetSlot(source_, 46)
                            if item then
                                CurrentItemMetadata = item.metadata
                            end

                            local components = {
                                Arms = { drawable = CurrentItemMetadata.Arms.drawable, texture = CurrentItemMetadata.Arms.texture },
                                Pants = { drawable = CurrentItemMetadata.Pants.drawable, texture = CurrentItemMetadata.Pants.texture },
                                Shoes = { drawable = CurrentItemMetadata.Shoes.drawable, texture = CurrentItemMetadata.Shoes.texture },
                                Accessories = { drawable = CurrentItemMetadata.Accessories.drawable, texture = CurrentItemMetadata.Accessories.texture },
                                Undershirt = { drawable = CurrentItemMetadata.Undershirt.drawable, texture = CurrentItemMetadata.Undershirt.texture },
                                Decals = { drawable = CurrentItemMetadata.Decals.drawable, texture = CurrentItemMetadata.Decals.texture },
                                Torso = { drawable = CurrentItemMetadata.Torso.drawable, texture = CurrentItemMetadata.Torso.texture },
                                Glasses = { drawable = CurrentItemMetadata.Glasses.drawable, texture = CurrentItemMetadata.Glasses.texture },
                            }
                            TriggerClientEvent('setOutfit', source_, components)
                        else
                        if (isComponent) then
                            if clothesComponentNames[cItemMovedIndex] == 'bag' then
                                local suc = BagAdd(source_, CurrentItemMetadata[2], false)
                                if suc then
                                    local suc2 = BagAdd(source_, CurrentItemMetadata[1], true)
                                    if suc2 == false then
                                        return false
                                    end
                                else
                                    return false
                                end
                            end
                            local components = {
                                texture = CurrentItemMetadata[1].texture,
                                drawable = CurrentItemMetadata[1].drawable,
                                component_id = clothesComponentID[cItemMovedIndex]
                            }
                                TriggerClientEvent('setPedComponent', source_, components)
                        else
                            local props = {
                                texture = CurrentItemMetadata[1].texture,
                                drawable = CurrentItemMetadata[1].drawable,
                                prop_id = clothesComponentID[cItemMovedIndex]
                            }
                            TriggerClientEvent('setPedProp', source_, props)
                        end
                    end
                    else
                        return false
                    end
                end
            else
                return false
            end
        else
            if (cSlotFromDetect or cSlotToDetect) then
                return false
            end
        end
    elseif (action == 'move') then
        local fromSlotMoved = payload.fromSlot.slot
        local toSlotMoved = payload.toSlot

        local CurrentItemName = payload.fromSlot.name
        local CurrentItemMetadata = payload.fromSlot.metadata

        local MovedCitem = false
        local MovedCitemIndex = -1


        local MovedToCslot = false
        local MovedToCslotIndex = -1

        local MovedFromCslot = false

        for index, searchingClothingName in ipairs(clothesComponentNames) do
            if CurrentItemName == searchingClothingName then
                MovedCitem = true
                MovedCitemIndex = index
                break
            end
        end

        local isComponent
        if MovedCitemIndex == 2 or MovedCitemIndex == 4 or MovedCitemIndex == 3 or MovedCitemIndex == 10 or MovedCitemIndex == 9 then
            isComponent = false
        else
            isComponent = true
        end

        for index, searchingClothingSlot in ipairs(clothesSlotID) do
            if toSlotMoved == searchingClothingSlot then
                MovedToCslot = true
                MovedToCslotIndex = index
                break
            end
        end

        for _, searchingClothingSlot in ipairs(clothesSlotID) do
            if fromSlotMoved == searchingClothingSlot then
                MovedFromCslot = true
                break
            end
        end

        if (MovedCitem) then
            if (UseExports) then
                canCC = Player(source_).state.canChangeClothes
            else
                canCC = true
            end
            if (MovedToCslot) then
                if (MovedCitemIndex == MovedToCslotIndex) then
                    if (canCC) then
                        if clothesComponentID[MovedCitemIndex] == 12 then
                            local item = exports.ox_inventory:GetSlot(source_, 46)
                            if item then
                                CurrentItemMetadata = item.metadata
                            end

                            local components = {
                                Arms = { drawable = CurrentItemMetadata.Arms.drawable, texture = CurrentItemMetadata.Arms.texture },
                                Pants = { drawable = CurrentItemMetadata.Pants.drawable, texture = CurrentItemMetadata.Pants.texture },
                                Shoes = { drawable = CurrentItemMetadata.Shoes.drawable, texture = CurrentItemMetadata.Shoes.texture },
                                Accessories = { drawable = CurrentItemMetadata.Accessories.drawable, texture = CurrentItemMetadata.Accessories.texture },
                                Undershirt = { drawable = CurrentItemMetadata.Undershirt.drawable, texture = CurrentItemMetadata.Undershirt.texture },
                                Decals = { drawable = CurrentItemMetadata.Decals.drawable, texture = CurrentItemMetadata.Decals.texture },
                                Torso = { drawable = CurrentItemMetadata.Torso.drawable, texture = CurrentItemMetadata.Torso.texture },
                                Glasses = { drawable = CurrentItemMetadata.Glasses.drawable, texture = CurrentItemMetadata.Glasses.texture },
                            }
                            TriggerClientEvent('setOutfit', source_, components)
                        else
                        if (isComponent) then
                            if clothesComponentNames[MovedCitemIndex] == 'bag' then
                                local suc = BagAdd(source_, CurrentItemMetadata, true)
                                if suc == false then
                                    return false
                                end
                            end
                            local components = {
                                texture = CurrentItemMetadata.texture,
                                drawable = CurrentItemMetadata.drawable,
                                component_id = clothesComponentID[MovedCitemIndex]
                            }
                                TriggerClientEvent('setPedComponent', source_, components)
                        else
                            local props = {
                                texture = CurrentItemMetadata.texture,
                                drawable = CurrentItemMetadata.drawable,
                                prop_id = clothesComponentID[MovedCitemIndex]
                            }
                            TriggerClientEvent('setPedProp', source_, props)
                        end
                        end
                    else
                        return false
                    end
                else
                    if payload.toType ~= 'player' then
                        return true
                    else
                        return false
                    end
                end
            elseif (MovedFromCslot) then
                if (payload.fromInventory ~= payload.toInventory and payload.fromType == 'player' and payload.toType == 'player') then
                    local fromSource = payload.fromInventory
                    local ped = GetPlayerPed(fromSource)
                    local hash = GetEntityModel(ped)
                    if (hash == 1885233650) then
                        if clothesComponentID[MovedCitemIndex] == 12 then
                            local components = {
                                Arms = { drawable = 15, texture = 0 },
                                Pants = { drawable = 21, texture = 0 },
                                Shoes = { drawable = 34, texture = 0 },
                                Accessories = { drawable = 0, texture = 0 },
                                Undershirt = { drawable = 15, texture = 0 },
                                Decals = { drawable = 0, texture = 0 },
                                Torso = { drawable = 15, texture = 0 },
                                Glasses = { drawable = -1, texture = 0 },
                            }
                            TriggerClientEvent('setOutfit', source_, components)
                        else
                        if (isComponent) then
                            if clothesComponentNames[MovedCitemIndex] == 'bag' then
                                local suc = BagAdd(fromSource, CurrentItemMetadata, false)
                                if suc == false then
                                    return false
                                end
                            end
                            local components = {
                                texture = defaultClothingMen[MovedCitemIndex].text,
                                drawable = defaultClothingMen[MovedCitemIndex].draw,
                                component_id = clothesComponentID[MovedCitemIndex]
                            }
                        else
                            local props = {
                                texture = defaultClothingMen[MovedCitemIndex].text,
                                drawable = defaultClothingMen[MovedCitemIndex].draw,
                                prop_id = clothesComponentID[MovedCitemIndex]
                            }
                        end
                        end
                    else
                        if clothesComponentID[MovedCitemIndex] == 12 then
                            local components = {
                                Arms = { drawable = 15, texture = 0 },
                                Pants = { drawable = 15, texture = 0 },
                                Shoes = { drawable = 35, texture = 0 },
                                Accessories = { drawable = 0, texture = 0 },
                                Undershirt = { drawable = 15, texture = 0 },
                                Decals = { drawable = 0, texture = 0 },
                                Torso = { drawable = 15, texture = 0 },
                                Glasses = { drawable = -1, texture = 0 },
                            }

                            TriggerClientEvent('setOutfit', source_, components)
                        else
                        if (isComponent) then
                            if clothesComponentNames[MovedCitemIndex] == 'bag' then
                                local suc = BagAdd(fromSource, CurrentItemMetadata, false)
                                if suc == false then
                                    return false
                                end
                            end
                            local components = {
                                texture = defaultClothingWoman[MovedCitemIndex].text,
                                drawable = defaultClothingWoman[MovedCitemIndex].draw,
                                component_id = clothesComponentID[MovedCitemIndex]
                            }
                            TriggerClientEvent('setPedComponent', source_, components)
                        else
                            local props = {
                                texture = defaultClothingWoman[MovedCitemIndex].text,
                                drawable = defaultClothingWoman[MovedCitemIndex].draw,
                                prop_id = clothesComponentID[MovedCitemIndex]
                            }
                            TriggerClientEvent('setPedProp', fromSource, props)
                        end
                    end
                    end
                    return true
                end
                if (canCC) then
                    local ped = GetPlayerPed(source_)
                    local hash = GetEntityModel(ped)
                    if (hash == 1885233650) then
                        if clothesComponentID[MovedCitemIndex] == 12 then
                            local components = {
                                Arms = { drawable = 15, texture = 0 },
                                Pants = { drawable = 21, texture = 0 },
                                Shoes = { drawable = 34, texture = 0 },
                                Accessories = { drawable = 0, texture = 0 },
                                Undershirt = { drawable = 15, texture = 0 },
                                Decals = { drawable = 0, texture = 0 },
                                Torso = { drawable = 15, texture = 0 },
                                Glasses = { drawable = -1, texture = 0 },
                            }
                            TriggerClientEvent('setOutfit', source_, components)
                        else
                        if (isComponent) then
                            if clothesComponentNames[MovedCitemIndex] == 'bag' then
                                local suc = BagAdd(source_, CurrentItemMetadata, false)
                                if suc == false then
                                    return false
                                end
                            end
                            local components = {
                                texture = defaultClothingMen[MovedCitemIndex].text,
                                drawable = defaultClothingMen[MovedCitemIndex].draw,
                                component_id = clothesComponentID[MovedCitemIndex]
                            }
                            TriggerClientEvent('setPedComponent', source_, components)
                        else
                            local props = {
                                texture = defaultClothingMen[MovedCitemIndex].text,
                                drawable = defaultClothingMen[MovedCitemIndex].draw,
                                prop_id = clothesComponentID[MovedCitemIndex]
                            }
                            TriggerClientEvent('setPedProp', source_, props)
                        end
                        end
                    else
                        if clothesComponentID[MovedCitemIndex] == 12 then
                            local components = {
                                Arms = { drawable = 15, texture = 0 },
                                Pants = { drawable = 15, texture = 0 },
                                Shoes = { drawable = 35, texture = 0 },
                                Accessories = { drawable = 0, texture = 0 },
                                Undershirt = { drawable = 15, texture = 0 },
                                Decals = { drawable = 0, texture = 0 },
                                Torso = { drawable = 15, texture = 0 },
                                Glasses = { drawable = -1, texture = 0 },
                            }

                            TriggerClientEvent('setOutfit', source_, components)
                        else
                        if (isComponent) then
                            if clothesComponentNames[MovedCitemIndex] == 'bag' then
                                local suc = BagAdd(source_, CurrentItemMetadata, false)
                                if suc == false then
                                    return false
                                end
                            end
                            local components = {
                                texture = defaultClothingWoman[MovedCitemIndex].text,
                                drawable = defaultClothingWoman[MovedCitemIndex].draw,
                                component_id = clothesComponentID[MovedCitemIndex]
                            }
                            TriggerClientEvent('setPedComponent', source_, components)
                        else
                            local props = {
                                texture = defaultClothingWoman[MovedCitemIndex].text,
                                drawable = defaultClothingWoman[MovedCitemIndex].draw,
                                prop_id = clothesComponentID[MovedCitemIndex]
                            }
                            TriggerClientEvent('setPedProp', source_, props)
                        end
                    end
                    end
                else
                    return false
                end
            end
        else
            if (MovedToCslot) then
                return false
            end
        end
    end
end, {
    print = false,
})


---@param source number
---@param itemMetadata table
---@param isEquip boolean
function BagAdd(source, itemMetadata, isEquip)
    ---@diagnostic disable-next-line: param-type-mismatch
    local inventory = exports.ox_inventory:GetInventory(source, true)
    local SlotAlright = true
    local totalSlots = 0
    if itemMetadata.slot then
        local curSlots = inventory.slots
        if isEquip then
            totalSlots = curSlots + itemMetadata.slot
        else
            totalSlots = curSlots - itemMetadata.slot
            for i = curSlots, curSlots - itemMetadata.slot + 1, -1 do
                local item = exports.ox_inventory:GetSlot(source, i)
                if item then
                    SlotAlright = false
                end
            end
        end
    end
    local WeightAlright = true
    local totalWeight = 0
    if itemMetadata.WeightBag then
        if(SlotAlright) then
            local curMaxWeight = inventory.maxWeight
            local curWeight = inventory.weight
            if not isEquip then
                if curWeight > curMaxWeight - itemMetadata.WeightBag then
                    WeightAlright = false
                end
            end
            if WeightAlright then
                if isEquip then 
                    totalWeight = curMaxWeight + itemMetadata.WeightBag 
                else
                    totalWeight = curMaxWeight - itemMetadata.WeightBag
                end
            end
        end
    end

    if SlotAlright == true and WeightAlright == true then
        if itemMetadata.slot then
            exports.ox_inventory:SetSlotCount(source, totalSlots)
        end
        if itemMetadata.WeightBag  then
            exports.ox_inventory:SetMaxWeight(source, totalWeight)
        end
    end

    if SlotAlright == false or WeightAlright == false then
        return false
    else
        return true
    end
end

if Config.SkinMethod == 'esx_skin' then
    RegisterServerEvent('itemclothes:saveownesx')
    AddEventHandler('itemclothes:saveownesx', function(skin, esxskin)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        SaveSkinESX(esxskin,skin, xPlayer)
    end)

    function SaveSkinESX(esxskin, skin , xPlayer)
        for k,v in pairs(skin) do
            esxskin[k] = v
        end
        MySQL.update('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
		    ['@skin'] = json.encode(esxskin),
		    ['@identifier'] = xPlayer.identifier
	    })
    end
end

local function onPlayerLoaded(source)
    Wait(2500)
    local bagSlot = exports.ox_inventory:GetSlot(source, 41)
    if bagSlot then
        BagAdd(source, bagSlot.metadata, true)
    end
end

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
    local src = source
    if not src then return end

    onPlayerLoaded(src)
end)

RegisterNetEvent('esx:playerLoaded', function(playerId)
    if not playerId then return end

    onPlayerLoaded(playerId)
end)