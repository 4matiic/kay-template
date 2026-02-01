ESX = exports["framework"]:getSharedObject()

local isUiOpen = false
local cam = nil
local initialOutfit = {}
local inMarker = false
local currentShop = nil
local lastCategory = 'torso_1'

local currentAccessorySubcategory = 'all'

local tempOutfit = nil

local function SaveCurrentClothes()
    local playerPed = PlayerPedId()
    local currentSkin = {}
    
    local components = {3, 4, 6, 7, 8, 11}
    
    for _, componentId in ipairs(components) do
        local drawable = GetPedDrawableVariation(playerPed, componentId)
        local texture = GetPedTextureVariation(playerPed, componentId)
        
        currentSkin['comp'..componentId] = drawable
        currentSkin['comp'..componentId..'_2'] = texture
    end
    
    TriggerServerEvent('clotheshop:saveEquippedClothes', currentSkin)
    return currentSkin
end

local categorySelections = {
    torso_1 = nil,
    tshirt_1 = nil,
    arms = nil,
    pants_1 = nil,
    shoes_1 = nil,
    accessories = nil
}

local selectedOutfit = {
    torso_1 = nil,
    tshirt_1 = nil,
    arms = nil,
    pants_1 = nil,
    shoes_1 = nil,
    accessories = nil
}

local componentConfig = {
    torso_1 = { component = 11, item = 'cloth_torso', label = 'Veste' },
    tshirt_1 = { component = 8, item = 'cloth_tshirt', label = 'T-shirt' },
    arms = { component = 3, item = 'cloth_arms', label = 'Bras' },
    pants_1 = { component = 4, item = 'cloth_pants', label = 'Pantalon' },
    shoes_1 = { component = 6, item = 'cloth_shoes', label = 'Chaussures' },
    accessories = { component = 7, item = 'cloth_chain', label = 'Collier' },
    bags_1 = { component = 5, item = 'cloth_bags', label = 'Sac' }
}

local cameraConfig = {
    default = {
        offset = vector3(0.0, 1.5, 0.2),
        pointOffset = vector3(0.0, 0.0, 0.2),
        rotation = vector3(0.0, 0.0, 250.0)
    },
    pants = {
        offset = vector3(0.0, 1.5, -0.4),
        pointOffset = vector3(0.0, 0.0, -0.4),
        rotation = vector3(0.0, 0.0, 250.0)
    },
    torso = {
        offset = vector3(0.0, 1.5, 0.2),
        pointOffset = vector3(0.0, 0.0, 0.2),
        rotation = vector3(0.0, 0.0, 250.0)
    },
    shoes = {
        offset = vector3(0.0, 1.5, -0.8),
        pointOffset = vector3(0.0, 0.0, -0.8),
        rotation = vector3(0.0, 0.0, 250.0)
    },
    chain = {
        offset = vector3(0.0, 1.5, 0.2),
        pointOffset = vector3(0.0, 0.0, 0.2),
        rotation = vector3(0.0, 0.0, 250.0)
    }
}

local function SaveInitialOutfit()
    local playerPed = PlayerPedId()
    initialOutfit = {
        torso_1 = { GetPedDrawableVariation(playerPed, 11), GetPedTextureVariation(playerPed, 11) },
        tshirt_1 = { GetPedDrawableVariation(playerPed, 8), GetPedTextureVariation(playerPed, 8) },
        arms = { GetPedDrawableVariation(playerPed, 3), GetPedTextureVariation(playerPed, 3) },
        pants_1 = { GetPedDrawableVariation(playerPed, 4), GetPedTextureVariation(playerPed, 4) },
        shoes_1 = { GetPedDrawableVariation(playerPed, 6), GetPedTextureVariation(playerPed, 6) },
        chain_1 = { GetPedDrawableVariation(playerPed, 7), GetPedTextureVariation(playerPed, 7) },
        
        helmet_1 = { GetPedPropIndex(playerPed, 0), GetPedPropTextureIndex(playerPed, 0) },
        glasses_1 = { GetPedPropIndex(playerPed, 1), GetPedPropTextureIndex(playerPed, 1) },
        ears_1 = { GetPedPropIndex(playerPed, 2), GetPedPropTextureIndex(playerPed, 2) },
        watches_1 = { GetPedPropIndex(playerPed, 6), GetPedPropTextureIndex(playerPed, 6) },
        bracelets_1 = { GetPedPropIndex(playerPed, 7), GetPedPropTextureIndex(playerPed, 7) },
        
        bproof_1 = { GetPedDrawableVariation(playerPed, 9), GetPedTextureVariation(playerPed, 9) },
        decals_1 = { GetPedDrawableVariation(playerPed, 10), GetPedTextureVariation(playerPed, 10) },
        mask_1 = { GetPedDrawableVariation(playerPed, 1), GetPedTextureVariation(playerPed, 1) },
        bags_1 = { GetPedDrawableVariation(playerPed, 5), GetPedTextureVariation(playerPed, 5) }
    }
    
end

local function RestoreInitialOutfit()
    local playerPed = PlayerPedId()
    
    local componentConfig = {
        torso_1 = 11,
        tshirt_1 = 8,
        arms = 3,
        pants_1 = 4,
        shoes_1 = 6,
        chain_1 = 7,
        bproof_1 = 9,
        decals_1 = 10,
        mask_1 = 1,
        bags_1 = 5
    }
    
    local propConfig = {
        helmet_1 = 0,
        glasses_1 = 1,
        ears_1 = 2,
        watches_1 = 6,
        bracelets_1 = 7
    }
    
    for type, componentId in pairs(componentConfig) do
        local data = initialOutfit[type]
        if data then
            SetPedComponentVariation(playerPed, componentId, data[1], data[2], 0)
            Wait(10)
        end
    end
    
    for type, propId in pairs(propConfig) do
        local data = initialOutfit[type]
        if data then
            if data[1] == -1 then
                ClearPedProp(playerPed, propId)
            else
                SetPedPropIndex(playerPed, propId, data[1], data[2], true)
            end
            Wait(10)
        end
    end
    
end

local function CreateClothingCam()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    
    if not DoesCamExist(cam) then
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    end
    
    local config = cameraConfig.default
    local angle = math.rad(config.rotation.z)
    local camX = pedCoords.x + config.offset.x * math.cos(angle)
    local camY = pedCoords.y + config.offset.y * math.sin(angle)
    
    SetCamCoord(cam, camX, camY, pedCoords.z + config.offset.z)
    PointCamAtCoord(cam, pedCoords.x + config.pointOffset.x, pedCoords.y + config.pointOffset.y, pedCoords.z + config.pointOffset.z)
    
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1000, true, true)
    
    SetEntityHeading(ped, config.rotation.z - 90.0)
end

local function UpdateCameraPosition(type)
    if not cam or not DoesCamExist(cam) then return end
    
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local config = cameraConfig.default
    
    if type == "pants_1" then
        config = cameraConfig.pants
    elseif type == "torso_1" or type == "tshirt_1" then
        config = cameraConfig.torso
    elseif type == "shoes_1" then
        config = cameraConfig.shoes
    elseif type == "chain_1" then
        config = cameraConfig.chain
    end
    
    local angle = math.rad(config.rotation.z)
    local camX = pedCoords.x + config.offset.x * math.cos(angle)
    local camY = pedCoords.y + config.offset.y * math.sin(angle)
    
    SetCamCoord(cam, camX, camY, pedCoords.z + config.offset.z)
    PointCamAtCoord(cam, pedCoords.x + config.pointOffset.x, pedCoords.y + config.pointOffset.y, pedCoords.z + config.pointOffset.z)
end

local function DestroyClothingCam()
    if cam and DoesCamExist(cam) then
        SetCamActive(cam, false)
        RenderScriptCams(false, true, 1000, true, true)
        DestroyCam(cam, true)
        cam = nil
    end
end

local function CloseMenu()
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, false)
    DestroyClothingCam()
    isUiOpen = false
    SetNuiFocus(false, false)
    
    SendNUIMessage({
        source = 'clotheshop',
        type = 'setVisible',
        status = false
    })
end

function OpenClothesShop()
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, true)
    CreateClothingCam()
    
    SaveInitialOutfit()
    lastCategory = 'torso_1'
    currentAccessorySubcategory = 'all'
    
    tempOutfit = nil
    selectedOutfit = {
        torso_1 = nil,
        tshirt_1 = nil,
        arms = nil,
        pants_1 = nil,
        shoes_1 = nil,
        chain_1 = nil,
        mask_1 = nil,
        helmet_1 = nil,
        glasses_1 = nil,
        ears_1 = nil,
        watches_1 = nil,
        bracelets_1 = nil,
        bags_1 = nil,
        bproof_1 = nil
    }
    
    categorySelections = {
        torso_1 = nil,
        tshirt_1 = nil,
        arms = nil,
        pants_1 = nil,
        shoes_1 = nil,
        chain_1 = nil,
        mask_1 = nil,
        helmet_1 = nil,
        glasses_1 = nil,
        ears_1 = nil,
        watches_1 = nil,
        bracelets_1 = nil,
        bags_1 = nil,
        bproof_1 = nil
    }
    
    isUiOpen = true
    SetNuiFocus(true, true)
    
    ESX.TriggerServerCallback('clotheshop:getSavedOutfits', function(outfits)
        
        savedOutfits = outfits
        
        SendNUIMessage({
            source = 'clotheshop',
            type = 'setVisible',
            status = true,
            resetCategory = 'torso_1',
            savedOutfits = outfits
        })
    end)

    Citizen.CreateThread(function()
        while isUiOpen do
            DisableControlAction(0, 1, true)
            DisableControlAction(0, 2, true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 200, true)
            DisableControlAction(0, 202, true)
            DisableControlAction(0, 322, true)
            SetNuiFocus(true, true)
            Citizen.Wait(0)
        end
    end)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    Citizen.Wait(1500)
    
    ESX.TriggerServerCallback('clotheshop:getOutfit', function(skin)
        ESX.TriggerServerCallback('clotheshop:getActiveOutfit', function(outfit)
            if skin then
                TriggerEvent('clotheshop:loadPlayerSkin', skin, outfit)
                
                Citizen.CreateThread(function()
                    Citizen.Wait(5000)
                    SaveCurrentClothes()
                end)
            end
        end)
    end)
end)

local function ConvertComponentNameToID(name)
    local componentMap = {
        ['torso_1'] = 'comp11',
        ['tshirt_1'] = 'comp8',
        ['arms'] = 'comp3',
        ['pants_1'] = 'comp4',
        ['shoes_1'] = 'comp6',
        ['accessories'] = 'comp7',
        
        ['helmet_1'] = 'prop0',
        ['glasses_1'] = 'prop1',
        ['ears_1'] = 'prop2',
        ['watches_1'] = 'prop6',
        ['bracelets_1'] = 'prop7',
        
        ['mask_1'] = 'comp1',
        ['bags_1'] = 'comp5',
        ['bproof_1'] = 'comp9'
    }
    
    local result = componentMap[name]
    if not result then
    end
    return result
end

RegisterNetEvent('ox_inventory:updateInventory')
AddEventHandler('ox_inventory:updateInventory', function(changes)
    if not changes then return end
    
    Citizen.Wait(1000)
    SaveCurrentClothes()
end)

RegisterNetEvent('ox_inventory:setPlayerInventory')
AddEventHandler('ox_inventory:setPlayerInventory', function(currentInventory)
    Citizen.Wait(1500)
    SaveCurrentClothes()
end)

RegisterNUICallback('requestClothesCount', function(data, cb)
    local type = data.type
    local playerPed = PlayerPedId()
    local config = componentConfig[type]
    local count = 0
    local variants = 0
    
    if config then
        count = GetNumberOfPedDrawableVariations(playerPed, config.component)
        local currentDrawable = GetPedDrawableVariation(playerPed, config.component)
        variants = GetNumberOfPedTextureVariations(playerPed, config.component, currentDrawable)
    end
    
    cb({
        total = count,
        maxVariants = variants
    })
end)

RegisterNUICallback('filter_accessories', function(data, cb)
    local subcategory = data.subcategory
    currentAccessorySubcategory = subcategory
    
    
    local playerPed = PlayerPedId()
    if subcategory ~= 'all' then
        if subcategory == 'chapeau' then
            ClearPedProp(playerPed, 0)
        elseif subcategory == 'lunettes' then
            ClearPedProp(playerPed, 1)
        elseif subcategory == 'oreilles' then
            ClearPedProp(playerPed, 2)
        elseif subcategory == 'montres' then
            ClearPedProp(playerPed, 6)
        elseif subcategory == 'bracelet' then
            ClearPedProp(playerPed, 7)
        elseif subcategory == 'masque' then
            SetPedComponentVariation(playerPed, 1, 0, 0, 0)
        elseif subcategory == 'sac' then
            SetPedComponentVariation(playerPed, 5, 0, 0, 0)
        elseif subcategory == 'gilet' then
            SetPedComponentVariation(playerPed, 9, 0, 0, 0)
        end
    else
        SetPedComponentVariation(playerPed, 7, 0, 0, 0)
    end
    
    if cb then cb('ok') end
end)

RegisterNUICallback('change', function(data, cb)
    local type = data.type
    local newValue = data.new
    local playerPed = PlayerPedId()
    
    

    
    local isVariation = string.match(type, "_2$")
    local baseType = isVariation and string.gsub(type, "_2$", "") or type
    local config = componentConfig[baseType]
    
    if isVariation then
        if baseType == "accessories" and currentAccessorySubcategory ~= 'all' then
            if currentAccessorySubcategory == 'chapeau' then
                SetPedPropIndex(playerPed, 0, GetPedPropIndex(playerPed, 0), newValue, true)
            elseif currentAccessorySubcategory == 'lunettes' then
                SetPedPropIndex(playerPed, 1, GetPedPropIndex(playerPed, 1), newValue, true)
            elseif currentAccessorySubcategory == 'oreilles' then
                SetPedPropIndex(playerPed, 2, GetPedPropIndex(playerPed, 2), newValue, true)
            elseif currentAccessorySubcategory == 'montres' then
                SetPedPropIndex(playerPed, 6, GetPedPropIndex(playerPed, 6), newValue, true)
            elseif currentAccessorySubcategory == 'bracelet' then
                SetPedPropIndex(playerPed, 7, GetPedPropIndex(playerPed, 7), newValue, true)
            elseif currentAccessorySubcategory == 'masque' then
                SetPedComponentVariation(playerPed, 1, GetPedDrawableVariation(playerPed, 1), newValue, 0)
            elseif currentAccessorySubcategory == 'sac' then
                SetPedComponentVariation(playerPed, 5, GetPedDrawableVariation(playerPed, 5), newValue, 0)
            elseif currentAccessorySubcategory == 'gilet' then
                SetPedComponentVariation(playerPed, 9, GetPedDrawableVariation(playerPed, 9), newValue, 0)
            else
                if config then
                    SetPedComponentVariation(playerPed, config.component, GetPedDrawableVariation(playerPed, config.component), newValue, 0)
                end
            end
        else
            if config then
                SetPedComponentVariation(playerPed, config.component, GetPedDrawableVariation(playerPed, config.component), newValue, 0)
            end
        end
    else
        if baseType == "helmet_1" then
            if newValue == -1 then
                ClearPedProp(playerPed, 0)
            else
                ClearPedProp(playerPed, 0)
                Wait(50)
                SetPedPropIndex(playerPed, 0, newValue, 0, true)
            end
        elseif baseType == "glasses_1" then
            if newValue == -1 then
                ClearPedProp(playerPed, 1)
            else
                ClearPedProp(playerPed, 1)
                Wait(50)
                SetPedPropIndex(playerPed, 1, newValue, 0, true)
            end
        elseif baseType == "ears_1" then
            if newValue == -1 then
                ClearPedProp(playerPed, 2)
            else
                ClearPedProp(playerPed, 2)
                Wait(50)
                SetPedPropIndex(playerPed, 2, newValue, 0, true)
            end
        elseif baseType == "watches_1" then
            if newValue == -1 then
                ClearPedProp(playerPed, 6)
            else
                ClearPedProp(playerPed, 6)
                Wait(50)
                SetPedPropIndex(playerPed, 6, newValue, 0, true)
            end
        elseif baseType == "bracelets_1" then
            if newValue == -1 then
                ClearPedProp(playerPed, 7)
            else
                ClearPedProp(playerPed, 7)
                Wait(50)
                SetPedPropIndex(playerPed, 7, newValue, 0, true)
            end
        elseif baseType == "mask_1" then
            if newValue == -1 then
                SetPedComponentVariation(playerPed, 1, 0, 0, 0)
            else
                SetPedComponentVariation(playerPed, 1, 0, 0, 0)
                Wait(50)
                SetPedComponentVariation(playerPed, 1, newValue, 0, 0)
                Wait(10)
                SetPedComponentVariation(playerPed, 1, newValue, 1, 0)
                Wait(10)
                SetPedComponentVariation(playerPed, 1, newValue, 0, 0)
            end
        elseif baseType == "bags_1" then
            SetPedComponentVariation(playerPed, 5, newValue, 0, 0)
        elseif baseType == "bproof_1" then
            SetPedComponentVariation(playerPed, 9, newValue, 0, 0)
        elseif type == "accessories" and currentAccessorySubcategory ~= 'all' then
            if currentAccessorySubcategory == 'chapeau' then
                if newValue == -1 then
                    ClearPedProp(playerPed, 0)
                else
                    ClearPedProp(playerPed, 0) 
                    Wait(50)
                    SetPedPropIndex(playerPed, 0, newValue, 0, true)
                end
                selectedOutfit['helmet_1'] = { newValue, 0 }
            elseif currentAccessorySubcategory == 'lunettes' then
                if newValue == -1 then
                    ClearPedProp(playerPed, 1)
                else
                    ClearPedProp(playerPed, 1)
                    Wait(50)
                    SetPedPropIndex(playerPed, 1, newValue, 0, true)
                end
                selectedOutfit['glasses_1'] = { newValue, 0 }
            elseif currentAccessorySubcategory == 'oreilles' then
                if newValue == -1 then
                    ClearPedProp(playerPed, 2)
                else
                    ClearPedProp(playerPed, 2)
                    Wait(50)
                    SetPedPropIndex(playerPed, 2, newValue, 0, true)
                end
                selectedOutfit['ears_1'] = { newValue, 0 }
            elseif currentAccessorySubcategory == 'montres' then
                if newValue == -1 then
                    ClearPedProp(playerPed, 6)
                else
                    ClearPedProp(playerPed, 6)
                    Wait(50)
                    SetPedPropIndex(playerPed, 6, newValue, 0, true)
                end
                selectedOutfit['watches_1'] = { newValue, 0 }
            elseif currentAccessorySubcategory == 'bracelet' then
                if newValue == -1 then
                    ClearPedProp(playerPed, 7)
                else
                    ClearPedProp(playerPed, 7)
                    Wait(50)
                    SetPedPropIndex(playerPed, 7, newValue, 0, true)
                end
                selectedOutfit['bracelets_1'] = { newValue, 0 }
            elseif currentAccessorySubcategory == 'masque' then
                if newValue == -1 then
                    SetPedComponentVariation(playerPed, 1, 0, 0, 0)
                else
                    SetPedComponentVariation(playerPed, 1, 0, 0, 0)
                    Wait(50)
                    SetPedComponentVariation(playerPed, 1, newValue, 0, 0)
                    Wait(10)
                    SetPedComponentVariation(playerPed, 1, newValue, 1, 0) 
                    Wait(10)
                    SetPedComponentVariation(playerPed, 1, newValue, 0, 0) 
                end
                selectedOutfit['mask_1'] = { newValue, 0 }
            elseif currentAccessorySubcategory == 'sac' then
                SetPedComponentVariation(playerPed, 5, newValue, 0, 0)
                selectedOutfit['bags_1'] = { newValue, 0 }
            elseif currentAccessorySubcategory == 'gilet' then
                SetPedComponentVariation(playerPed, 9, newValue, 0, 0)
                selectedOutfit['bproof_1'] = { newValue, 0 }
            else
                if config then
                    SetPedComponentVariation(playerPed, config.component, newValue, 0, 0)
                end
            end
        else
            if config then
                SetPedComponentVariation(playerPed, config.component, newValue, 0, 0)
            end
        end
    end
    
    if cb then cb('ok') end
end)

RegisterNUICallback('save', function(data, cb)
    local selections = data.selections or {}
    
    local itemsToBuy = {}
    
    local currentSkin = {}
    local playerPed = PlayerPedId()
    
    local playerModel = GetEntityModel(playerPed)
    local sex = "male"
    
    if playerModel == GetHashKey("mp_f_freemode_01") then
        sex = "female"
    end
    
    for type, selection in pairs(selections) do
        if selection.index > 0 then
            local itemData = {
                type = type,
                drawable = selection.index - 1,
                texture = selection.texture
            }
            
            if type == 'accessories' and currentAccessorySubcategory ~= 'all' then
                if currentAccessorySubcategory == 'sac' then
                    itemData.type = 'bags_1'
                    itemData.specificType = 'cloth_bags'
                    itemData.component = 5
                    itemData.accessoryType = 'sac'
                elseif currentAccessorySubcategory == 'chapeau' then
                    itemData.type = 'helmet_1'
                    itemData.specificType = 'cloth_helmet'
                    itemData.component = 0
                    itemData.isProp = true
                    itemData.accessoryType = 'chapeau'
                elseif currentAccessorySubcategory == 'lunettes' then
                    itemData.type = 'glasses_1'
                    itemData.specificType = 'cloth_glasses'
                    itemData.component = 1
                    itemData.isProp = true
                    itemData.accessoryType = 'lunettes'
                elseif currentAccessorySubcategory == 'oreilles' then
                    itemData.type = 'ears_1'
                    itemData.specificType = 'cloth_ears'
                    itemData.component = 2
                    itemData.isProp = true
                    itemData.accessoryType = 'oreilles'
                elseif currentAccessorySubcategory == 'montres' then
                    itemData.type = 'watches_1'
                    itemData.specificType = 'cloth_watches'
                    itemData.component = 6
                    itemData.isProp = true
                    itemData.accessoryType = 'montres'
                elseif currentAccessorySubcategory == 'bracelet' then
                    itemData.type = 'bracelets_1'
                    itemData.specificType = 'cloth_bracelets'
                    itemData.component = 7
                    itemData.isProp = true
                    itemData.accessoryType = 'bracelet'
                elseif currentAccessorySubcategory == 'gilet' then
                    itemData.type = 'bproof_1'
                    itemData.specificType = 'cloth_bproof'
                    itemData.component = 9
                    itemData.accessoryType = 'gilet'
                elseif currentAccessorySubcategory == 'masque' then
                    itemData.type = 'mask_1'
                    itemData.specificType = 'cloth_mask'
                    itemData.component = 1
                    itemData.accessoryType = 'masque'
                end
            end
            
            table.insert(itemsToBuy, itemData)
            
            local componentID = ConvertComponentNameToID(type)
            if componentID then
                currentSkin[componentID] = selection.index - 1
                currentSkin[componentID .. '_2'] = selection.texture
            end
        end
    end
    
    local totalPrice = 0
    for _, item in ipairs(itemsToBuy) do
        if item.type == 'accessories' and currentAccessorySubcategory ~= 'all' and Config.AccessoryPrices[currentAccessorySubcategory] then
            totalPrice = totalPrice + Config.AccessoryPrices[currentAccessorySubcategory]
        elseif Config.ComponentPrices[item.type] then
            totalPrice = totalPrice + Config.ComponentPrices[item.type]
        end
    end
    
    if #itemsToBuy > 0 then
        RestoreInitialOutfit()
        TriggerServerEvent('clotheshop:buyItem', itemsToBuy, currentSkin, totalPrice, sex, currentAccessorySubcategory, false)
        
        SendNUIMessage({
            source = 'clotheshop',
            type = 'purchaseInProgress'
        })
        
        cb({success = true})
    else
        cb({success = false, message = "Aucun article sélectionné"})
    end
end)

RegisterNUICallback('saveTenue', function(data, cb)
    local name = data.name
    local selections = data.selections or {}
    
    local currentSkin = {}
    local playerPed = PlayerPedId()
    
    local playerModel = GetEntityModel(playerPed)
    local sex = "male"
    
    if playerModel == GetHashKey("mp_f_freemode_01") then
        sex = "female"
    end
    
    
    if currentAccessorySubcategory ~= 'all' and selections['accessories'] then
        local accessoryData = selections['accessories']
        
        if currentAccessorySubcategory == 'masque' then
            selections['mask_1'] = { 
                index = accessoryData.index, 
                texture = accessoryData.texture 
            }
        elseif currentAccessorySubcategory == 'chapeau' then
            selections['helmet_1'] = { 
                index = accessoryData.index, 
                texture = accessoryData.texture 
            }
        elseif currentAccessorySubcategory == 'lunettes' then
            selections['glasses_1'] = { 
                index = accessoryData.index, 
                texture = accessoryData.texture 
            }
        elseif currentAccessorySubcategory == 'oreilles' then
            selections['ears_1'] = { 
                index = accessoryData.index, 
                texture = accessoryData.texture 
            }
        elseif currentAccessorySubcategory == 'montres' then
            selections['watches_1'] = { 
                index = accessoryData.index, 
                texture = accessoryData.texture 
            }
        elseif currentAccessorySubcategory == 'bracelet' then
            selections['bracelets_1'] = { 
                index = accessoryData.index, 
                texture = accessoryData.texture 
            }
        elseif currentAccessorySubcategory == 'sac' then
            selections['bags_1'] = { 
                index = accessoryData.index,
                texture = accessoryData.texture 
            }
        elseif currentAccessorySubcategory == 'gilet' then
            selections['bproof_1'] = { 
                index = accessoryData.index, 
                texture = accessoryData.texture 
            }
        end
    end
    
    for type, selection in pairs(selections) do
    end
    
    if selectedOutfit['mask_1'] then
        selections['mask_1'] = {
            index = selectedOutfit['mask_1'][1] + 1,
            texture = selectedOutfit['mask_1'][2]
        }
    end
    
    if selectedOutfit['helmet_1'] then
        selections['helmet_1'] = {
            index = selectedOutfit['helmet_1'][1] + 1,
            texture = selectedOutfit['helmet_1'][2]
        }
    end
    
    if selectedOutfit['glasses_1'] then
        selections['glasses_1'] = {
            index = selectedOutfit['glasses_1'][1] + 1,
            texture = selectedOutfit['glasses_1'][2]
        }
    end
    
    if selectedOutfit['ears_1'] then
        selections['ears_1'] = {
            index = selectedOutfit['ears_1'][1] + 1,
            texture = selectedOutfit['ears_1'][2]
        }
    end
    
    if selectedOutfit['watches_1'] then
        selections['watches_1'] = {
            index = selectedOutfit['watches_1'][1] + 1,
            texture = selectedOutfit['watches_1'][2]
        }
    end
    
    if selectedOutfit['bracelets_1'] then
        selections['bracelets_1'] = {
            index = selectedOutfit['bracelets_1'][1] + 1,
            texture = selectedOutfit['bracelets_1'][2]
        }
    end
    
    if selectedOutfit['bags_1'] then
        selections['bags_1'] = {
            index = selectedOutfit['bags_1'][1] + 1,
            texture = selectedOutfit['bags_1'][2]
        }
    end
    
    if selectedOutfit['bproof_1'] then
        selections['bproof_1'] = {
            index = selectedOutfit['bproof_1'][1] + 1,
            texture = selectedOutfit['bproof_1'][2]
        }
    end
    
    for type, selection in pairs(selections) do
        if selection.index > 0 then
            if type == 'helmet_1' or type == 'glasses_1' or type == 'ears_1' or type == 'watches_1' or type == 'bracelets_1' then
                local propId = nil
                if type == 'helmet_1' then propId = 0
                elseif type == 'glasses_1' then propId = 1
                elseif type == 'ears_1' then propId = 2
                elseif type == 'watches_1' then propId = 6
                elseif type == 'bracelets_1' then propId = 7
                end
                
                if propId ~= nil then
                    currentSkin['prop' .. propId] = selection.index - 1
                    currentSkin['prop' .. propId .. '_2'] = selection.texture or 0
                end
            elseif type == 'bags_1' then
                currentSkin['comp5'] = selection.index - 1
                currentSkin['comp5_2'] = selection.texture or 0
            elseif type == 'mask_1' then
                currentSkin['comp1'] = selection.index - 1
                currentSkin['comp1_2'] = selection.texture or 0
            elseif type == 'bproof_1' then
                currentSkin['comp9'] = selection.index - 1
                currentSkin['comp9_2'] = selection.texture or 0
            else
                local componentId = ConvertComponentNameToID(type)
                if componentId then
                    currentSkin[componentId] = selection.index - 1
                    currentSkin[componentId .. '_2'] = selection.texture or 0
                end
            end
        end
    end
    
    
    ESX.TriggerServerCallback('clotheshop:saveTenue', function(success, savedOutfit)
        if cb then
            cb(success)
        end
        
        if success and savedOutfit then
            currentOutfit = savedOutfit
        end
    end, selections, name or "Tenue personnalisée", sex)
end)

RegisterNUICallback('change_camera', function(data, cb)
    lastCategory = data.type
    UpdateCameraPosition(data.type)
    
    SendNUIMessage({
        source = 'clotheshop',
        type = 'resetSelection',
        keepLastCategory = lastCategory
    })
    
    if cb then cb('ok') end
end)

RegisterNUICallback('reset', function(data, cb)
    if tempOutfit then
        for componentId, data in pairs(tempOutfit.components) do
            SetPedComponentVariation(PlayerPedId(), componentId, data.drawable, data.texture, 0)
            Citizen.Wait(10)
        end
        
        for propId, data in pairs(tempOutfit.props) do
            if data.drawable == -1 then
                ClearPedProp(PlayerPedId(), propId)
            else
                SetPedPropIndex(PlayerPedId(), propId, data.drawable, data.texture, true)
            end
            Citizen.Wait(10)
        end
        
        tempOutfit = nil
    else
        RestoreInitialOutfit()
    end
    
    CloseMenu()
    if cb then cb('ok') end
end)

RegisterNUICallback('getTotalPrice', function(data, cb)
    local total = 0
    for k, item in pairs(data.items) do
        local component = item.type
        if Config.ComponentPrices[component] then
            total = total + Config.ComponentPrices[component]
        end
    end
    
    cb({
        price = total
    })
end)

RegisterNetEvent('clotheshop:loadPlayerSkin')
AddEventHandler('clotheshop:loadPlayerSkin', function(skin, outfit)
    if not skin then return end

    local model = skin.model or GetHashKey('mp_m_freemode_01')
    if not IsPedModel(PlayerPedId(), model) then
        RequestModel(model)
        while not HasModelLoaded(model) do Wait(0) end
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
    end
    
    local playerPed = PlayerPedId()
    
    if skin.components then
        for _, comp in ipairs(skin.components) do
            SetPedComponentVariation(playerPed, comp.component_id, comp.drawable, comp.texture, 0)
        end
    end
    
    if skin.props then
        for _, prop in ipairs(skin.props) do
            if prop.drawable == -1 then
                ClearPedProp(playerPed, prop.prop_id)
            else
                SetPedPropIndex(playerPed, prop.prop_id, prop.drawable, prop.texture, true)
            end
        end
    end
    
    if skin.headBlend then
        SetPedHeadBlendData(
            playerPed,
            skin.headBlend.shapeFirst, 
            skin.headBlend.shapeSecond, 
            skin.headBlend.shapeThird,
            skin.headBlend.skinFirst, 
            skin.headBlend.skinSecond, 
            skin.headBlend.skinThird,
            skin.headBlend.shapeMix, 
            skin.headBlend.skinMix, 
            skin.headBlend.thirdMix,
            false
        )
    end
    
    if skin.faceFeatures then
        for k, v in pairs(skin.faceFeatures) do
            local index = ({
                ["noseWidth"] = 0,
                ["nosePeakHigh"] = 1,
                ["nosePeakSize"] = 2,
                ["noseBoneHigh"] = 3,
                ["nosePeakLowering"] = 4,
                ["noseBoneTwist"] = 5,
                ["eyeBrownHigh"] = 6,
                ["eyeBrownForward"] = 7,
                ["cheeksBoneHigh"] = 8,
                ["cheeksBoneWidth"] = 9,
                ["cheeksWidth"] = 10,
                ["eyesOpening"] = 11,
                ["lipsThickness"] = 12,
                ["jawBoneWidth"] = 13,
                ["jawBoneBackSize"] = 14,
                ["chinBoneLowering"] = 15,
                ["chinBoneLenght"] = 16,
                ["chinBoneSize"] = 17,
                ["chinHole"] = 18,
                ["neckThickness"] = 19
            })[k]
            
            if index then
                SetPedFaceFeature(playerPed, index, v)
            end
        end
    end
    
    if skin.headOverlays then
        for k, v in pairs(skin.headOverlays) do
            local index = ({
                ["blemishes"] = 0,
                ["beard"] = 1,
                ["eyebrows"] = 2,
                ["ageing"] = 3,
                ["makeup"] = 4,
                ["blush"] = 5,
                ["complexion"] = 6,
                ["sunDamage"] = 7,
                ["lipstick"] = 8,
                ["moleAndFreckles"] = 9,
                ["chestHair"] = 10,
                ["bodyBlemishes"] = 11
            })[k]
            
            if index then
                SetPedHeadOverlay(playerPed, index, v.style, v.opacity)
                
                if v.color and v.color > 0 then
                    local colorType = ({
                        [1] = 1,
                        [2] = 1,
                        [4] = 2,
                        [5] = 2,
                        [8] = 2
                    })[index] or 1
                    
                    SetPedHeadOverlayColor(playerPed, index, colorType, v.color, v.secondColor or 0)
                end
            end
        end
    end
    
    if skin.eyeColor then
        SetPedEyeColor(playerPed, skin.eyeColor)
    end
    
    if skin.hair then
        SetPedComponentVariation(playerPed, 2, skin.hair.style, 0, 0)
        SetPedHairColor(playerPed, skin.hair.color, skin.hair.highlight)
    end
    
    if outfit then
        local hasClothing = false
        local appliedOutfit = {}
        
        
        for comp, value in pairs(outfit) do
            if comp:match('^comp') and not comp:match('_2$') then
                local componentId = tonumber(comp:match('comp(%d+)'))
                if componentId and (value > 0 or outfit['comp'..componentId..'_2'] > 0) then
                    hasClothing = true
                    break
                end
            end
        end
        
        if hasClothing then
            for comp, value in pairs(outfit) do
                if comp:match('^comp') and not comp:match('_2$') then
                    local componentId = tonumber(comp:match('comp(%d+)'))
                    if componentId then
                        local texture = outfit['comp'..componentId..'_2'] or 0
                        
                        SetPedComponentVariation(playerPed, componentId, value, texture, 0)
                        appliedOutfit['comp'..componentId] = value
                        appliedOutfit['comp'..componentId..'_2'] = texture
                        
                    end
                end
            end
            
            Citizen.Wait(100)
            for comp, value in pairs(appliedOutfit) do
                if not comp:match('_2$') then
                    local componentId = tonumber(comp:match('comp(%d+)'))
                    if componentId then
                        local texture = appliedOutfit['comp'..componentId..'_2'] or 0
                        SetPedComponentVariation(playerPed, componentId, value, texture, 0)
                    end
                end
            end
        end
    end
    
    Citizen.Wait(500)
    local currentOutfit = SaveCurrentClothes()
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
    Citizen.Wait(500)
    
    ESX.TriggerServerCallback('clotheshop:getOutfit', function(skin)
        ESX.TriggerServerCallback('clotheshop:getActiveOutfit', function(outfit)
            if skin then
                TriggerEvent('clotheshop:loadPlayerSkin', skin, outfit)
            end
        end)
    end)
end)

RegisterNetEvent('clotheshop:syncOutfit')
AddEventHandler('clotheshop:syncOutfit', function()
    Citizen.Wait(1000)
    SaveCurrentClothes()
end)

local function CreateBlips()
    for k, v in pairs(Config.Shops) do
        if v.blipEnabled then
            local blip = AddBlipForCoord(v.position)
            SetBlipSprite(blip, v.blipSprite)
            SetBlipColour(blip, v.blipColor)
            SetBlipScale(blip, v.blipScale)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.blipLabel)
            EndTextCommandSetBlipName(blip)
        end
    end
end

local function DrawShopMarker(shop)
    if shop.markerEnabled then
        DrawMarker(
            shop.markerType,
            shop.position.x, shop.position.y, shop.position.z - 1.0,
            0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
            shop.markerSizeX, shop.markerSizeY, shop.markerSizeZ,
            shop.markerColorR, shop.markerColorG, shop.markerColorB, shop.markerColorA,
            shop.markerBobUpAndDown, shop.markerFaceCamera, 2, shop.markerRotate, nil, nil, false
        )
    end
end

CreateThread(function()
    CreateBlips()
    
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local sleep = 1000
        local isInMarkerArea = false
        local currentShopData = nil
        
        for k, shop in pairs(Config.Shops) do
            local distance = #(playerCoords - shop.position)
            
            if distance < Config.DrawDistance then
                sleep = 0
                DrawShopMarker(shop)
                
                if distance < 1.5 then
                    isInMarkerArea = true
                    currentShopData = shop
                    
                    ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour accéder au magasin de vêtements')
                    
                    if IsControlJustReleased(0, Config.KeyToOpen) then
                        OpenClothesShop()
                    end
                end
            end
        end
        
        inMarker = isInMarkerArea
        currentShop = currentShopData
        
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        local sleep = 500
        if isUiOpen then 
            sleep = 0
            DisableControlAction(0, 200, true)
            SetNuiFocus(true, true)
        end
        Wait(sleep)
    end
end)

RegisterNUICallback('request_accessory_items', function(data, cb)
    local subcategory = data.subcategory
    local playerPed = PlayerPedId()
    local count = 0
    local variants = 0
    
    if subcategory ~= 'all' then
        if subcategory == 'chapeau' then
            count = GetNumberOfPedPropDrawableVariations(playerPed, 0)
            local currentProp = GetPedPropIndex(playerPed, 0)
            variants = GetNumberOfPedPropTextureVariations(playerPed, 0, currentProp >= 0 and currentProp or 0)
        elseif subcategory == 'lunettes' then
            count = GetNumberOfPedPropDrawableVariations(playerPed, 1)
            local currentProp = GetPedPropIndex(playerPed, 1)
            variants = GetNumberOfPedPropTextureVariations(playerPed, 1, currentProp >= 0 and currentProp or 0)
        elseif subcategory == 'oreilles' then
            count = GetNumberOfPedPropDrawableVariations(playerPed, 2)
            local currentProp = GetPedPropIndex(playerPed, 2)
            variants = GetNumberOfPedPropTextureVariations(playerPed, 2, currentProp >= 0 and currentProp or 0)
        elseif subcategory == 'montres' then
            count = GetNumberOfPedPropDrawableVariations(playerPed, 6)
            local currentProp = GetPedPropIndex(playerPed, 6)
            variants = GetNumberOfPedPropTextureVariations(playerPed, 6, currentProp >= 0 and currentProp or 0)
        elseif subcategory == 'bracelet' then
            count = GetNumberOfPedPropDrawableVariations(playerPed, 7)
            local currentProp = GetPedPropIndex(playerPed, 7)
            variants = GetNumberOfPedPropTextureVariations(playerPed, 7, currentProp >= 0 and currentProp or 0)
        elseif subcategory == 'masque' then
            count = GetNumberOfPedDrawableVariations(playerPed, 1)
            local currentDrawable = GetPedDrawableVariation(playerPed, 1)
            variants = GetNumberOfPedTextureVariations(playerPed, 1, currentDrawable)
        elseif subcategory == 'sac' then
            count = GetNumberOfPedDrawableVariations(playerPed, 5)
            local currentDrawable = GetPedDrawableVariation(playerPed, 5)
            variants = GetNumberOfPedTextureVariations(playerPed, 5, currentDrawable)
        elseif subcategory == 'gilet' then
            count = GetNumberOfPedDrawableVariations(playerPed, 9)
            local currentDrawable = GetPedDrawableVariation(playerPed, 9)
            variants = GetNumberOfPedTextureVariations(playerPed, 9, currentDrawable)
        end
    else
        count = GetNumberOfPedDrawableVariations(playerPed, 7)
        variants = GetNumberOfPedTextureVariations(playerPed, 7, 0)
    end
    
    
    cb({
        total = count,
        maxVariants = variants
    })
end)

RegisterNUICallback('deleteOutfit', function(data, cb)
    local outfitId = data.outfitId
    TriggerServerEvent('clotheshop:deleteOutfit', outfitId)
    if cb then cb('ok') end
end)

RegisterNUICallback('buyOutfit', function(data, cb)
    local outfitId = data.outfitId
    local selections = data.selections
    
    local playerPed = PlayerPedId()

    local playerModel = GetEntityModel(playerPed)
    local sex = "male"
    
    if playerModel == GetHashKey("mp_f_freemode_01") then
        sex = "female"
    end
    
    
    for type, selection in pairs(selections) do
        if selection.index > 0 then
            local propMap = {
                ['helmet_1'] = 0,   
                ['glasses_1'] = 1,  
                ['ears_1'] = 2,     
                ['watches_1'] = 6,  
                ['bracelets_1'] = 7 
            }
            
            if propMap[type] ~= nil then
                SetPedPropIndex(
                    playerPed,
                    propMap[type],
                    selection.index - 1,
                    selection.texture or 0,
                    true
                )
            else
                local config = componentConfig[type]
                if config then
                    SetPedComponentVariation(
                        playerPed,
                        config.component,
                        selection.index - 1,
                        selection.texture or 0,
                        0
                    )
                end
            end
        end
    end
    
    TriggerServerEvent('clotheshop:buyOutfit', outfitId, selections, sex)
    if cb then cb('ok') end
end)

RegisterNUICallback('playerSex', function(data, cb)
    local playerPed = PlayerPedId()
    
    local playerModel = GetEntityModel(playerPed)
    local sex = "male"
    
    if playerModel == GetHashKey("mp_f_freemode_01") then
        sex = "female"
    end
    
    cb({
        sex = sex
    })
end)

RegisterNetEvent('clotheshop:outfitSaved')
AddEventHandler('clotheshop:outfitSaved', function(outfitData)
    if outfitData and outfitData.id then
        SendNUIMessage({
            source = 'clotheshop',
            type = 'outfitSaved',
            outfit = {
                id = tostring(outfitData.id),
                name = outfitData.name,
                selections = outfitData.data,
                price = outfitData.price
            }
        })
        
        ESX.TriggerServerCallback('clotheshop:getSavedOutfits', function(outfits)

            
            savedOutfits = outfits
            
            SendNUIMessage({
                source = 'clotheshop',
                type = 'updateSavedOutfits',
                savedOutfits = outfits
            })
        end)
    end
end)

RegisterNetEvent('clotheshop:outfitDeleted')
AddEventHandler('clotheshop:outfitDeleted', function(outfitId)
    if outfitId then
        SendNUIMessage({
            source = 'clotheshop',
            type = 'outfitDeleted',
            outfitId = outfitId
        })
    end
end)

RegisterNetEvent('clotheshop:storeTempOutfit')
AddEventHandler('clotheshop:storeTempOutfit', function()
    tempOutfit = {
        components = {},
        props = {}
    }
    
    for i = 0, 11 do
        tempOutfit.components[i] = {
            drawable = GetPedDrawableVariation(PlayerPedId(), i),
            texture = GetPedTextureVariation(PlayerPedId(), i)
        }
    end
    
    for i = 0, 7 do
        local propIndex = GetPedPropIndex(PlayerPedId(), i)
        tempOutfit.props[i] = {
            drawable = propIndex,
            texture = propIndex ~= -1 and GetPedPropTextureIndex(PlayerPedId(), i) or 0
        }
    end
end)

RegisterNetEvent('clotheshop:restoreOriginalOutfit')
AddEventHandler('clotheshop:restoreOriginalOutfit', function()
    if tempOutfit then
        for componentId, data in pairs(tempOutfit.components) do
            SetPedComponentVariation(PlayerPedId(), componentId, data.drawable, data.texture, 0)
            Citizen.Wait(10)
        end
        
        for propId, data in pairs(tempOutfit.props) do
            if data.drawable == -1 then
                ClearPedProp(PlayerPedId(), propId)
            else
                SetPedPropIndex(PlayerPedId(), propId, data.drawable, data.texture, true)
            end
            Citizen.Wait(10)
        end
        
        tempOutfit = nil
    end
end)

RegisterNetEvent('clotheshop:equipPurchasedItems')
AddEventHandler('clotheshop:equipPurchasedItems', function(items)
    return 
end)

function SaveEquippedClothes()
    local playerPed = PlayerPedId()
    
    local currentSkin = {}
    
    for i = 0, 11 do
        currentSkin['comp' .. i] = GetPedDrawableVariation(playerPed, i)
        currentSkin['comp' .. i .. '_2'] = GetPedTextureVariation(playerPed, i)
    end
    
    for i = 0, 7 do
        local propIndex = GetPedPropIndex(playerPed, i)
        currentSkin['prop' .. i] = propIndex
        if propIndex ~= -1 then
            currentSkin['prop' .. i .. '_2'] = GetPedPropTextureIndex(playerPed, i)
        end
    end
    
    TriggerServerEvent('clotheshop:saveEquippedClothes', currentSkin)
    
end

RegisterNetEvent('clotheshop:loadFullOutfit')
AddEventHandler('clotheshop:loadFullOutfit', function(baseSkin, outfit)
    if not baseSkin then return end
    
    local playerPed = PlayerPedId()
    
    if outfit then
        for key, value in pairs(baseSkin) do
            if key ~= 'sex' and key ~= 'face' and key ~= 'skin' and key ~= 'age_1' and key ~= 'age_2' then
                if key:match('^comp(%d+)$') then
                    local compId = tonumber(key:match('comp(%d+)'))
                    local textureKey = 'comp' .. compId .. '_2'
                    local texture = baseSkin[textureKey] or 0
                    SetPedComponentVariation(playerPed, compId, value, texture, 0)
                elseif key:match('^prop(%d+)$') then
                    local propId = tonumber(key:match('prop(%d+)'))
                    local textureKey = 'prop' .. propId .. '_2'
                    local texture = baseSkin[textureKey] or 0
                    if value == -1 then
                        ClearPedProp(playerPed, propId)
                    else
                        SetPedPropIndex(playerPed, propId, value, texture, true)
                    end
                end
            end
        end
        
        for key, value in pairs(outfit) do
            if key:match('^comp(%d+)$') then
                local compId = tonumber(key:match('comp(%d+)'))
                local textureKey = 'comp' .. compId .. '_2'
                local texture = outfit[textureKey] or 0
                SetPedComponentVariation(playerPed, compId, value, texture, 0)
            elseif key:match('^prop(%d+)$') then
                local propId = tonumber(key:match('prop(%d+)'))
                local textureKey = 'prop' .. propId .. '_2'
                local texture = outfit[textureKey] or 0
                if value == -1 then
                    ClearPedProp(playerPed, propId)
                else
                    SetPedPropIndex(playerPed, propId, value, texture, true)
                end
            end
        end
    else
        for key, value in pairs(baseSkin) do
            if key ~= 'sex' and key ~= 'face' and key ~= 'skin' and key ~= 'age_1' and key ~= 'age_2' then
                if key:match('^comp(%d+)$') then
                    local compId = tonumber(key:match('comp(%d+)'))
                    local textureKey = 'comp' .. compId .. '_2'
                    local texture = baseSkin[textureKey] or 0
                    SetPedComponentVariation(playerPed, compId, value, texture, 0)
                elseif key:match('^prop(%d+)$') then
                    local propId = tonumber(key:match('prop(%d+)'))
                    local textureKey = 'prop' .. propId .. '_2'
                    local texture = baseSkin[textureKey] or 0
                    if value == -1 then
                        ClearPedProp(playerPed, propId)
                    else
                        SetPedPropIndex(playerPed, propId, value, texture, true)
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('clotheshop:purchaseResult')
AddEventHandler('clotheshop:purchaseResult', function(success, items)
    RestoreInitialOutfit()
    
    if success then
        SendNUIMessage({
            source = 'clotheshop',
            type = 'purchaseSuccess',
            items = items
        })
        
        CloseMenu()
    else
        SendNUIMessage({
            source = 'clotheshop',
            type = 'purchaseFailure'
        })
        
        CloseMenu()
    end
end)