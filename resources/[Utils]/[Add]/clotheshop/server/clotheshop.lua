ESX = exports["framework"]:getSharedObject()

Citizen.CreateThread(function()
    MySQL.query.await([[
        CREATE TABLE IF NOT EXISTS `user_outfits` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `identifier` varchar(60) NOT NULL,
            `outfit_data` longtext NOT NULL,
            `slot` int(11) NOT NULL DEFAULT 1,
            `active` tinyint(1) NOT NULL DEFAULT 0,
            PRIMARY KEY (`id`),
            KEY `identifier` (`identifier`)
        )
    ]])

    MySQL.query.await([[
        CREATE TABLE IF NOT EXISTS `user_outfit_save` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `identifier` varchar(60) NOT NULL,
            `outfit_data` longtext NOT NULL,
            `name` varchar(255) NOT NULL DEFAULT 'Tenue personnalisée',
            PRIMARY KEY (`id`),
            KEY `identifier` (`identifier`)
        )
    ]])
end)

local clothingMetadata = {
    components = {
        torso = {
            slot = 'torso_1',
            componentId = 11,
            type = 'cloth_torso',
            label = 'Veste',
            cameraView = {
                offset = vector3(0.0, 1.5, 0.2),
                pointOffset = vector3(0.0, 0.0, 0.2),
                rotation = vector3(0.0, 0.0, 250.0)
            }
        },
        tshirt = {
            slot = 'tshirt_1',
            componentId = 8,
            type = 'cloth_tshirt',
            label = 'T-shirt',
            cameraView = {
                offset = vector3(0.0, 1.5, 0.2),
                pointOffset = vector3(0.0, 0.0, 0.2),
                rotation = vector3(0.0, 0.0, 250.0)
            }
        },
        arms = {
            slot = 'arms',
            componentId = 3,
            type = 'cloth_arms',
            label = 'Bras',
            cameraView = {
                offset = vector3(0.0, 1.5, 0.2),
                pointOffset = vector3(0.0, 0.0, 0.2),
                rotation = vector3(0.0, 0.0, 250.0)
            }
        },
        pants = {
            slot = 'pants_1',
            componentId = 4,
            type = 'cloth_pants',
            label = 'Pantalon',
            cameraView = {
                offset = vector3(0.0, 1.5, -0.4),
                pointOffset = vector3(0.0, 0.0, -0.4),
                rotation = vector3(0.0, 0.0, 250.0)
            }
        },
        shoes = {
            slot = 'shoes_1',
            componentId = 6,
            type = 'cloth_shoes',
            label = 'Chaussures',
            cameraView = {
                offset = vector3(0.0, 1.5, -0.8),
                pointOffset = vector3(0.0, 0.0, -0.8),
                rotation = vector3(0.0, 0.0, 250.0)
            }
        },
        accessories = { 
            slot = 'accessories', 
            componentId = 7,
            type = 'cloth_chain', 
            label = 'Collier',
            cameraView = {
                offset = vector3(0.0, 1.5, 0.2),
                pointOffset = vector3(0.0, 0.0, 0.2),
                rotation = vector3(0.0, 0.0, 250.0)
            }
        }
    }
}

local accessoryItemTypes = {
    masque = 'cloth_mask',
    chapeau = 'cloth_helmet',
    lunettes = 'cloth_glasses',
    montres = 'cloth_watches',
    oreilles = 'cloth_ears',
    bracelet = 'cloth_bracelets',
    sac = 'cloth_bags',
    gilet = 'cloth_bproof'
}

local currentAccessorySubcategory = "all"

local function GetImageUrl(componentType, sex, drawable, accessorySubcategory)
    local baseType = componentType:gsub("_1", "")
    
    if sex ~= "male" and sex ~= "female" then
        sex = "male"
    end
    
    local shortSex = (sex == "male") and "m" or "f"
    
    if baseType == "accessories" and accessorySubcategory and accessorySubcategory ~= "all" then
        local accessoryFolder = accessorySubcategory
        
        local folderMap = {
            ["masque"] = "mask",
            ["chapeau"] = "helmet",
            ["lunettes"] = "glasses",
            ["montres"] = "watches",
            ["oreilles"] = "ears",
            ["bracelet"] = "bracelets",
            ["sac"] = "Bags", 
            ["gilet"] = "bproof"
        }
        
        if folderMap[accessoryFolder] then
            accessoryFolder = folderMap[accessoryFolder]
        end
        
        
        local url = string.format(
            "https://raw.githubusercontent.com/toadrouge/library/master/items/%s/%s/%s_.png",
            accessoryFolder,
            shortSex,
            tostring(drawable)
        )
        
        return url
    end
    
    local url = string.format(
        "https://raw.githubusercontent.com/toadrouge/library/master/items/%s/%s/%s_.png",
        baseType,
        shortSex,
        tostring(drawable)
    )
    
    return url
end

local function SaveClothingToInventory(source, component, drawable, texture, sex, accessorySubcategory)
    local itemType = component.type
    
    if component.slot == 'accessories' and accessorySubcategory and accessorySubcategory ~= 'all' then
        if accessoryItemTypes[accessorySubcategory] then
            itemType = accessoryItemTypes[accessorySubcategory]
        end
    end
    
    local imageUrl = GetImageUrl(component.slot, sex, drawable, accessorySubcategory)
    
    local label = component.label
    if accessorySubcategory and accessorySubcategory ~= 'all' and Config.AccessorySubcategories[accessorySubcategory] then
        label = Config.AccessorySubcategories[accessorySubcategory].label
    end
    
    local metadata = {
        component = component.componentId,
        drawable = drawable,
        texture = texture,
        label = string.format("%s #%s", label, drawable),
        description = string.format("Variation %s, Texture %s", drawable, texture),
        imageurl = imageUrl,
        accessoryType = accessorySubcategory
    }
    
    return exports.ox_inventory:AddItem(source, itemType, 1, metadata)
end

RegisterNetEvent('clotheshop:buyOutfit')
AddEventHandler('clotheshop:buyOutfit', function(outfitId, selections, sex)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local OUTFIT_PRICE = Config.OutfitPurchasePrice or 100 
    
    if not OUTFIT_PRICE or type(OUTFIT_PRICE) ~= "number" then
        OUTFIT_PRICE = 100
    end
    
    local playerMoney = exports.ox_inventory:Search(src, 'count', 'money') or 0
    
    if playerMoney >= OUTFIT_PRICE then
        if exports.ox_inventory:RemoveItem(src, 'money', OUTFIT_PRICE) then
            local skinData = {}
            for componentType, selection in pairs(selections) do
                if type(selection) == "table" and selection.index and selection.index > 0 then
                    local componentId = nil
                    local baseType = componentType:gsub("_1", "")
                    
                    for id, comp in pairs(clothingMetadata.components) do
                        if comp.slot == componentType then
                            componentId = comp.componentId
                            break
                        end
                    end
                    
                    if componentId then
                        skinData['comp'..componentId] = selection.index - 1
                        skinData['comp'..componentId..'_2'] = selection.texture or 0
                    end
                end
            end
            
            local outfitName = "Tenue achetée"
            MySQL.scalar('SELECT name FROM user_outfit_save WHERE id = ?', {outfitId}, function(name)
                if name then outfitName = name end
                
                local metadata = {
                    outfit = skinData,
                    label = outfitName,
                    description = "Une tenue complète personnalisée",
                    components = selections
                }
                
                local success = exports.ox_inventory:AddItem(src, 'cloth', 1, metadata)
                
                if success then
                    TriggerClientEvent('ox_lib:notify', src, {
                        description = 'Tenue "' .. outfitName .. '" achetée pour ' .. OUTFIT_PRICE .. '$',
                        type = 'success'
                    })
                else
                    exports.ox_inventory:AddItem(src, 'money', OUTFIT_PRICE)
                    TriggerClientEvent('ox_lib:notify', src, {
                        description = 'Erreur lors de l\'achat de la tenue',
                        type = 'error'
                    })
                end
            end)
        end
    else
        TriggerClientEvent('ox_lib:notify', src, {
            description = 'Vous n\'avez pas assez d\'argent',
            type = 'error'
        })
    end
end)

RegisterNetEvent('clotheshop:buyTenue')
AddEventHandler('clotheshop:buyTenue', function(selections, skinData, sex)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local TENUE_PRICE = Config.OutfitPrice or 750 
    
    if not TENUE_PRICE or type(TENUE_PRICE) ~= "number" then
        TENUE_PRICE = 750 
    end
    
    local playerMoney = exports.ox_inventory:Search(src, 'count', 'money') or 0 
    
    if playerMoney >= TENUE_PRICE then
        if exports.ox_inventory:RemoveItem(src, 'money', TENUE_PRICE) then
            local metadata = {
                outfit = skinData,
                label = "Tenue complète",
                description = "Une tenue complète personnalisée",
                components = selections
            }
            
            local success = exports.ox_inventory:AddItem(src, 'cloth', 1, metadata)
            
            if success then
                TriggerClientEvent('ox_lib:notify', src, {
                    description = 'Tenue achetée pour ' .. TENUE_PRICE .. '$',
                    type = 'success'
                })
                TriggerClientEvent('clotheshop:tenuePurchaseResult', src, true)
            else
                exports.ox_inventory:AddItem(src, 'money', TENUE_PRICE)
                TriggerClientEvent('ox_lib:notify', src, {
                    description = 'Erreur lors de l\'achat de la tenue',
                    type = 'error'
                })
                TriggerClientEvent('clotheshop:tenuePurchaseResult', src, false)
            end
        end
    else
        TriggerClientEvent('ox_lib:notify', src, {
            description = 'Vous n\'avez pas assez d\'argent',
            type = 'error'
        })
        TriggerClientEvent('clotheshop:tenuePurchaseResult', src, false)
    end
end)

ESX.RegisterServerCallback('clotheshop:saveTenue', function(source, cb, selections, name, sex)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local TENUE_PRICE = Config.OutfitPrice or 750 
    
    if not TENUE_PRICE or type(TENUE_PRICE) ~= "number" then
        TENUE_PRICE = 750 
    end
    
    local playerMoney = exports.ox_inventory:Search(src, 'count', 'money') or 0
    
    if playerMoney >= TENUE_PRICE then
        if exports.ox_inventory:RemoveItem(src, 'money', TENUE_PRICE) then
            local skinData = {}
            
            for componentType, selection in pairs(selections) do
                
                if type(selection) == "table" and selection.index and selection.index > 0 then
                    local componentId = nil
                    local isProp = false
                    local propId = nil
                    
                    if componentType == 'helmet_1' then
                        isProp = true
                        propId = 0
                    elseif componentType == 'glasses_1' then
                        isProp = true
                        propId = 1
                    elseif componentType == 'ears_1' then
                        isProp = true
                        propId = 2
                    elseif componentType == 'watches_1' then
                        isProp = true
                        propId = 6
                    elseif componentType == 'bracelets_1' then
                        isProp = true
                        propId = 7
                    elseif componentType == 'bags_1' then
                        componentId = 5
                    elseif componentType == 'mask_1' then
                        componentId = 1
                    elseif componentType == 'bproof_1' then
                        componentId = 9
                    else
                        for id, comp in pairs(clothingMetadata.components) do
                            if comp.slot == componentType then
                                componentId = comp.componentId
                                break
                            end
                        end
                    end
                    
                    if componentId then
                        skinData['comp'..componentId] = selection.index - 1
                        skinData['comp'..componentId..'_2'] = selection.texture or 0
                    elseif isProp and propId ~= nil then
                        skinData['prop'..propId] = selection.index - 1
                        skinData['prop'..propId..'_2'] = selection.texture or 0
                    end
                end
            end
            
            local outfitName = name or "Tenue personnalisée"
            
            MySQL.insert('INSERT INTO user_outfit_save (identifier, outfit_data, name) VALUES (?, ?, ?)', {
                xPlayer.identifier,
                json.encode(skinData),
                outfitName
            }, function(outfitId)
                if outfitId and outfitId > 0 then
                    TriggerClientEvent('ox_lib:notify', src, {
                        description = 'Tenue "' .. outfitName .. '" sauvegardée pour ' .. TENUE_PRICE .. '$',
                        type = 'success'
                    })
                    
                    local metadata = {
                        outfit = skinData,
                        label = outfitName,
                        description = "Une tenue complète personnalisée",
                        components = selections
                    }
                    
                    
                    local success = exports.ox_inventory:AddItem(src, 'cloth', 1, metadata)
                    
                    cb(true, {
                        id = outfitId,
                        name = outfitName,
                        data = selections,
                        price = TENUE_PRICE
                    })
                else
                    exports.ox_inventory:AddItem(src, 'money', TENUE_PRICE)
                    TriggerClientEvent('ox_lib:notify', src, {
                        description = 'Erreur lors de la sauvegarde de la tenue',
                        type = 'error'
                    })
                    cb(false)
                end
            end)
        else
            cb(false)
        end
    else
        TriggerClientEvent('ox_lib:notify', src, {
            description = 'Vous n\'avez pas assez d\'argent',
            type = 'error'
        })
        cb(false)
    end
end)

RegisterNetEvent('clotheshop:deleteOutfit')
AddEventHandler('clotheshop:deleteOutfit', function(outfitId)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    MySQL.scalar('SELECT identifier FROM user_outfit_save WHERE id = ?', {outfitId}, function(identifier)
        if identifier and identifier == xPlayer.identifier then
            MySQL.update('DELETE FROM user_outfit_save WHERE id = ?', {outfitId}, function(rowsChanged)
                if rowsChanged > 0 then
                    TriggerClientEvent('ox_lib:notify', src, {
                        description = 'Tenue supprimée avec succès',
                        type = 'success'
                    })
                    
                    TriggerClientEvent('clotheshop:outfitDeleted', src, outfitId)
                else
                    TriggerClientEvent('ox_lib:notify', src, {
                        description = 'Erreur lors de la suppression de la tenue',
                        type = 'error'
                    })
                end
            end)
        else
            TriggerClientEvent('ox_lib:notify', src, {
                description = 'Vous ne pouvez pas supprimer cette tenue',
                type = 'error'
            })
        end
    end)
end)

ESX.RegisterServerCallback('clotheshop:getOutfit', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    MySQL.scalar('SELECT skin FROM users WHERE identifier = ?', {xPlayer.identifier}, function(result)
        if result then
            cb(json.decode(result))
        else
            cb(nil)
        end
    end)
end)

RegisterNetEvent('clotheshop:saveEquippedClothes')
AddEventHandler('clotheshop:saveEquippedClothes', function(currentSkin)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if currentSkin then
        
        local hasNonDefaultClothing = false
        for key, value in pairs(currentSkin) do
            if (key:match('^comp') and not key:match('_2$')) or 
               (key:match('^prop') and not key:match('_2$')) then
                if value > 0 or (key:match('^prop') and value ~= -1) then
                    hasNonDefaultClothing = true
                    break
                end
            end
        end
        
        if not hasNonDefaultClothing then
            return
        end
        
        MySQL.scalar('SELECT id FROM user_outfits WHERE identifier = ? AND active = 1', {
            xPlayer.identifier
        }, function(outfitId)
            if outfitId then
                MySQL.update('UPDATE user_outfits SET outfit_data = ? WHERE id = ?', {
                    json.encode(currentSkin),
                    outfitId
                }, function(affectedRows)
                    if affectedRows > 0 then
                    end
                end)
            else
                MySQL.insert('INSERT INTO user_outfits (identifier, outfit_data, active) VALUES (?, ?, 1)', {
                    xPlayer.identifier,
                    json.encode(currentSkin)
                }, function(insertId)
                    if insertId and insertId > 0 then
                    else
                        print("pas bon")
                    end
                end)
            end
        end)       
    end
end)

ESX.RegisterServerCallback('clotheshop:getActiveOutfit', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    MySQL.scalar('SELECT outfit_data FROM user_outfits WHERE identifier = ? AND active = 1', {
        xPlayer.identifier
    }, function(outfitData)
        if outfitData then
            local decodedOutfit = json.decode(outfitData)
            cb(decodedOutfit)
        else
            cb(nil)
        end
    end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    MySQL.single('SELECT skin FROM users WHERE identifier = ?', {xPlayer.identifier}, function(result)
        if result and result.skin then
            local baseSkin = json.decode(result.skin)
            
            MySQL.scalar('SELECT outfit_data FROM user_outfits WHERE identifier = ? AND active = 1', {
                xPlayer.identifier
            }, function(outfitData)
                if outfitData then
                    local outfit = json.decode(outfitData)
                    TriggerClientEvent('clotheshop:loadFullOutfit', src, baseSkin, outfit)
                else
                    TriggerClientEvent('clotheshop:loadFullOutfit', src, baseSkin, nil)
                end
            end)
        end
    end)
end)

function GetComponentMetadata(componentType)
    return clothingMetadata.components[componentType]
end

function CanEquipClothing(itemMetadata)
    local componentData = nil
    for _, comp in pairs(clothingMetadata.components) do
        if comp.slot == itemMetadata.slot then
            componentData = comp
            break
        end
    end
    
    return componentData ~= nil
end

exports('GetComponentMetadata', GetComponentMetadata)
exports('CanEquipClothing', CanEquipClothing)

AddEventHandler('ox:inventoryUpdated', function(payload)
    local source = payload.source
    if source and payload.inventoryId == ('player-%s'):format(source) then
        Citizen.Wait(500)
        TriggerClientEvent('clotheshop:syncOutfit', source)
    end
end)

ESX.RegisterServerCallback('clotheshop:getSavedOutfits', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    MySQL.query('SELECT id, outfit_data, name FROM user_outfit_save WHERE identifier = ?', {
        xPlayer.identifier
    }, function(results)
        if results and #results > 0 then
            local outfits = {}
            for _, outfit in ipairs(results) do
                local outfitData = json.decode(outfit.outfit_data)
                
                local selections = {}
                
                for comp, value in pairs(outfitData) do
                    if comp:match('^comp(%d+)$') and not comp:match('_2$') then
                        local compId = tonumber(comp:match('comp(%d+)'))
                        local textureKey = 'comp' .. compId .. '_2'
                        local texture = outfitData[textureKey] or 0
                        
                        local typeKey = nil
                        for type, compData in pairs(clothingMetadata.components) do
                            if compData.componentId == compId then
                                typeKey = compData.slot
                                break
                            end
                        end
                        
                        if typeKey then
                            selections[typeKey] = {
                                index = value + 1,
                                texture = texture
                            }
                        end
                    end
                end
                
                for prop, value in pairs(outfitData) do
                    if prop:match('^prop(%d+)$') and not prop:match('_2$') and value ~= -1 then
                        local propId = tonumber(prop:match('prop(%d+)'))
                        local textureKey = 'prop' .. propId .. '_2'
                        local texture = outfitData[textureKey] or 0
                        
                        local propTypeMap = {
                            [0] = 'helmet_1',
                            [1] = 'glasses_1',
                            [2] = 'ears_1',
                            [6] = 'watches_1',
                            [7] = 'bracelets_1'
                        }
                        
                        local typeKey = propTypeMap[propId]
                        
                        if typeKey then
                            selections[typeKey] = {
                                index = value + 1,
                                texture = texture
                            }
                        end
                    end
                end
                
                local requiredComponents = {'torso_1', 'pants_1', 'shoes_1'}
                local hasRequiredComponents = true
                
                for _, comp in ipairs(requiredComponents) do
                    if not selections[comp] then
                        selections[comp] = {
                            index = 1,
                            texture = 0
                        }
                    end
                end
                
                if not selections['tshirt_1'] then selections['tshirt_1'] = { index = 1, texture = 0 } end
                if not selections['arms'] then selections['arms'] = { index = 1, texture = 0 } end
                if not selections['accessories'] then selections['accessories'] = { index = 0, texture = 0 } end
                                
                local outfitPrice = Config.OutfitPurchasePrice or 750
                if type(outfitPrice) == 'number' then
                    outfitPrice = '$' .. outfitPrice
                end
                
                table.insert(outfits, {
                    id = tostring(outfit.id),
                    name = outfit.name,
                    selections = selections,
                    price = outfitPrice,
                    preview = nil
                })
            end
            
            cb(outfits)
        else
            cb({})
        end
    end)
end)

RegisterNetEvent('clotheshop:buyItem')
AddEventHandler('clotheshop:buyItem', function(items, currentSkin, totalPrice, sex, accessorySubcategory, shouldEquip)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if shouldEquip == nil then shouldEquip = true end
    
    local calculatedPrice = 0
    for _, item in ipairs(items) do
        local specificAccessoryType = item.accessoryType
        
        if specificAccessoryType and Config.AccessoryPrices[specificAccessoryType] then
            calculatedPrice = calculatedPrice + Config.AccessoryPrices[specificAccessoryType]
        elseif accessorySubcategory and accessorySubcategory ~= 'all' and Config.AccessoryPrices[accessorySubcategory] then
            calculatedPrice = calculatedPrice + Config.AccessoryPrices[accessorySubcategory]
        elseif Config.ComponentPrices[item.type] then
            calculatedPrice = calculatedPrice + Config.ComponentPrices[item.type]
        else
            calculatedPrice = calculatedPrice + 100
        end
    end
    
    if calculatedPrice > 0 then
        totalPrice = calculatedPrice
    end
    
    TriggerClientEvent('clotheshop:storeTempOutfit', src)
    
    local playerMoney = exports.ox_inventory:Search(src, 'count', 'money') or 0
    
    if totalPrice <= 0 then
        totalPrice = 0
    end
    
    if playerMoney >= totalPrice or totalPrice == 0 then
        local success = true
        if totalPrice > 0 then
            success = exports.ox_inventory:RemoveItem(src, 'money', totalPrice)
        end
        
        if success then
            local purchasedItems = {}
            local allSuccess = true
            
            for i, item in ipairs(items) do
                local componentType = item.type
                local drawable = item.drawable
                local texture = item.texture
                local specificAccessoryType = item.accessoryType
                local itemType = item.specificType
                
                
                local componentInfo = nil
                for id, comp in pairs(clothingMetadata.components) do
                    if comp.slot == componentType then
                        componentInfo = comp
                        break
                    end
                end
                
                if not itemType and componentInfo then
                    itemType = componentInfo.type
                end
                
                local isPropItem = item.isProp
                local propId = nil
                
                if isPropItem then
                    if componentType == 'helmet_1' then 
                        propId = 0
                        itemType = 'cloth_helmet'
                    elseif componentType == 'glasses_1' then 
                        propId = 1 
                        itemType = 'cloth_glasses'
                    elseif componentType == 'ears_1' then 
                        propId = 2
                        itemType = 'cloth_ears'
                    elseif componentType == 'watches_1' then 
                        propId = 6
                        itemType = 'cloth_watches'
                    elseif componentType == 'bracelets_1' then 
                        propId = 7
                        itemType = 'cloth_bracelets'
                    end
                end
                
                if componentType == 'bags_1' or specificAccessoryType == 'sac' then
                    itemType = 'cloth_bags'
                elseif componentType == 'mask_1' or specificAccessoryType == 'masque' then
                    itemType = 'cloth_mask'
                elseif componentType == 'bproof_1' or specificAccessoryType == 'gilet' then
                    itemType = 'cloth_bproof'
                end
                
                if accessorySubcategory and accessorySubcategory ~= 'all' and accessoryItemTypes[accessorySubcategory] then
                    itemType = accessoryItemTypes[accessorySubcategory]
                end
                
                if specificAccessoryType and accessoryItemTypes[specificAccessoryType] then
                    itemType = accessoryItemTypes[specificAccessoryType]
                end
                
                if Config.ItemDefinitions and itemType and Config.ItemDefinitions[itemType] then
                    itemType = Config.ItemDefinitions[itemType]
                end
                
                if not itemType then
                    itemType = 'cloth_torso'
                end
                
                
                local label = componentInfo and componentInfo.label or "Accessoire"
                if specificAccessoryType and Config.AccessorySubcategories and Config.AccessorySubcategories[specificAccessoryType] then
                    label = Config.AccessorySubcategories[specificAccessoryType].label
                elseif accessorySubcategory and accessorySubcategory ~= 'all' and Config.AccessorySubcategories and Config.AccessorySubcategories[accessorySubcategory] then
                    label = Config.AccessorySubcategories[accessorySubcategory].label
                end
                
                local imageUrl = GetImageUrl(componentType, sex, drawable, specificAccessoryType or accessorySubcategory)
                
                local metadata = {
                    drawable = drawable,
                    texture = texture,
                    label = string.format("%s #%s", label, drawable),
                    description = string.format("Variation %s, Texture %s", drawable, texture),
                    imageurl = imageUrl,
                    accessoryType = specificAccessoryType or accessorySubcategory
                }
                
                if accessorySubcategory and accessorySubcategory ~= 'all' then
                    if accessorySubcategory == 'masque' then
                        metadata.component = 1
                        metadata.isProp = false
                        componentType = 'mask_1'
                    elseif accessorySubcategory == 'chapeau' then
                        metadata.component = 0
                        metadata.isProp = true
                        componentType = 'helmet_1'
                    elseif accessorySubcategory == 'lunettes' then
                        metadata.component = 1
                        metadata.isProp = true
                        componentType = 'glasses_1'
                    elseif accessorySubcategory == 'oreilles' then
                        metadata.component = 2
                        metadata.isProp = true
                        componentType = 'ears_1'
                    elseif accessorySubcategory == 'montres' then
                        metadata.component = 6
                        metadata.isProp = true
                        componentType = 'watches_1'
                    elseif accessorySubcategory == 'bracelet' then
                        metadata.component = 7
                        metadata.isProp = true
                        componentType = 'bracelets_1'
                    elseif accessorySubcategory == 'sac' then
                        metadata.component = 5
                        metadata.isProp = false
                        componentType = 'bags_1'
                    elseif accessorySubcategory == 'gilet' then
                        metadata.component = 9
                        metadata.isProp = false
                        componentType = 'bproof_1'
                    end
                end
                
                if isPropItem and propId ~= nil then
                    metadata.prop = propId
                    metadata.isProp = true
                elseif componentType == 'bags_1' or specificAccessoryType == 'sac' then
                    metadata.component = 5 
                elseif componentType == 'mask_1' or specificAccessoryType == 'masque' then
                    metadata.component = 1
                elseif componentType == 'bproof_1' or specificAccessoryType == 'gilet' then
                    metadata.component = 9
                elseif componentInfo then
                    metadata.component = componentInfo.componentId
                end
                
                if not metadata.isProp and specificAccessoryType then
                    if specificAccessoryType == 'chapeau' then
                        metadata.component = 0
                        metadata.isProp = true
                    elseif specificAccessoryType == 'lunettes' then
                        metadata.component = 1
                        metadata.isProp = true
                    elseif specificAccessoryType == 'oreilles' then
                        metadata.component = 2
                        metadata.isProp = true
                    elseif specificAccessoryType == 'montres' then
                        metadata.component = 6
                        metadata.isProp = true
                    elseif specificAccessoryType == 'bracelet' then
                        metadata.component = 7
                        metadata.isProp = true
                    end
                end
                
                if itemType == 'cloth_helmet' or itemType == 'cloth_hat' then
                    metadata.component = 0
                    metadata.isProp = true
                elseif itemType == 'cloth_glasses' then
                    metadata.component = 1
                    metadata.isProp = true
                elseif itemType == 'cloth_ears' then
                    metadata.component = 2
                    metadata.isProp = true
                elseif itemType == 'cloth_watches' or itemType == 'cloth_watch' then
                    metadata.component = 6
                    metadata.isProp = true
                elseif itemType == 'cloth_bracelets' or itemType == 'cloth_bracelet' then
                    metadata.component = 7
                    metadata.isProp = true
                end
                
                local itemSuccess = exports.ox_inventory:AddItem(src, itemType, 1, metadata)
                
                if itemSuccess then
                    table.insert(purchasedItems, {
                        type = itemType,
                        metadata = metadata
                    })
                else
                    Wait(100)
                    itemSuccess = exports.ox_inventory:AddItem(src, itemType, 1, metadata)
                    
                    if itemSuccess then
                        table.insert(purchasedItems, {
                            type = itemType,
                            metadata = metadata
                        })
                    else
                        allSuccess = false
                    end
                end
            end
            
            if allSuccess and #purchasedItems > 0 then
                TriggerClientEvent('ox_lib:notify', src, {
                    description = 'Article(s) acheté(s) pour ' .. totalPrice .. '$',
                    type = 'success'
                })
                
                TriggerClientEvent('clotheshop:purchaseResult', src, true, purchasedItems)
            else
                if totalPrice > 0 then
                    exports.ox_inventory:AddItem(src, 'money', totalPrice)
                end
                TriggerClientEvent('ox_lib:notify', src, {
                    description = 'Erreur lors de l\'ajout des articles',
                    type = 'error'
                })
                
                TriggerClientEvent('clotheshop:purchaseResult', src, false, {})
            end
        else
            TriggerClientEvent('ox_lib:notify', src, {
                description = 'Erreur lors du paiement',
                type = 'error'
            })
            TriggerClientEvent('clotheshop:purchaseResult', src, false, {})
        end
    else
        TriggerClientEvent('ox_lib:notify', src, {
            description = 'Vous n\'avez pas assez d\'argent',
            type = 'error'
        })
        
        TriggerClientEvent('clotheshop:purchaseResult', src, false, {})
    end
end)

if not Config then Config = {} end

Config.AccessorySubcategories = {
    masque = { 
        component = 1, 
        label = "Masque",
        props = false
    },
    chapeau = { 
        component = 0, 
        label = "Chapeau",
        props = true
    },
    lunettes = { 
        component = 1, 
        label = "Lunettes",
        props = true
    },
    montres = { 
        component = 6, 
        label = "Montre",
        props = true
    },
    oreilles = { 
        component = 2, 
        label = "Oreilles",
        props = true
    },
    bracelet = { 
        component = 7, 
        label = "Bracelet",
        props = true
    },
    sac = { 
        component = 5, 
        label = "Sac",
        props = false
    },
    gilet = { 
        component = 9, 
        label = "Gilet",
        props = false
    }
}

Config.AccessoryPrices = {
    masque = 50,
    chapeau = 30,
    lunettes = 25,
    montres = 75,
    oreilles = 20,
    bracelet = 30,
    sac = 60,
    gilet = 100
}

Config.ComponentPrices = {
    torso_1 = 100,
    tshirt_1 = 50,
    arms = 50,
    pants_1 = 100,
    shoes_1 = 75,
    accessories = 100
}