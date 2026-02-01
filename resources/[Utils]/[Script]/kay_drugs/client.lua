local isPlacingPot = false
local highlightedObject = nil
local placedPots = {}
local currentScaleform = nil
local closestPotIndex = nil
local ox_inventory = exports.ox_inventory
local instructionalButtonsScaleform = nil
local lightSources = {}
local showScaleform = true


ESX = ESX or nil

CreateThread(function()
    while not ESX do
        pcall(function() ESX = exports["framework"]:getSharedObject() end) 
        Wait(100)
    end
    local tries = 0
    while tries < 200 do
        local pd = ESX.PlayerData or (ESX.GetPlayerData and ESX.GetPlayerData()) or {}
        if pd.job and pd.job.name then break end
        Wait(100)
        tries += 1
    end
end)

local function Notify(msg)
    if ESX and ESX.ShowNotification then
        ESX.ShowNotification(msg)
    else
        print(('[Notify] %s'):format(msg))
    end
end

function IsPlayerPolice()
    if not ESX then return false end
    local data = ESX.PlayerData or (ESX.GetPlayerData and ESX.GetPlayerData()) or {}
    local job = data.job or {}
    return job.name == 'police' or job.name == 'sheriff'
end



if not gtaui then
    gtaui = {}
    local Scaleform = {}
    
    function Scaleform:new(scaleName)
        local id = RequestScaleformMovie(scaleName)
        local data = {id = id}
        setmetatable(data, self)
        self.__index = self
        return data
    end
    
    function Scaleform:load()
        while not HasScaleformMovieLoaded(self.id) do
            Wait(1)
        end
        return true
    end
    
    function Scaleform:callFunction(fnName, ...)
        BeginScaleformMovieMethod(self.id, fnName)
        local arg = {...}
        for _, v in pairs(arg) do
            if type(v) == "number" then
                if math.type and math.type(v) == "integer" then
                    ScaleformMovieMethodAddParamInt(v)
                else
                    ScaleformMovieMethodAddParamFloat(v)
                end
            elseif type(v) == "string" then
                ScaleformMovieMethodAddParamTextureNameString(v)
            elseif type(v) == "boolean" then
                ScaleformMovieMethodAddParamBool(v)
            end
        end
        EndScaleformMovieMethod()
    end
    
    function Scaleform:draw3D(pos, rot, scale)
        DrawScaleformMovie_3d(self.id, pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, 2.0, 2.0, 1.0, scale.x, scale.y, scale.z, 2)
    end
    
    function Scaleform:release()
        SetScaleformMovieAsNoLongerNeeded(self.id)
    end
    
    gtaui.Scaleform = function(scaleName)
        return Scaleform:new(scaleName)
    end
end

function SetupInstructionalButtons()
    if instructionalButtonsScaleform then
        SetScaleformMovieAsNoLongerNeeded(instructionalButtonsScaleform)
    end
    
    instructionalButtonsScaleform = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
    
    while not HasScaleformMovieLoaded(instructionalButtonsScaleform) do
        Wait(0)
    end
    
    PushScaleformMovieFunction(instructionalButtonsScaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(instructionalButtonsScaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(instructionalButtonsScaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(2, 24, true)) 
    PushScaleformMovieFunctionParameterString("Placer un objet")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(instructionalButtonsScaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(2, 73, true)) 
    PushScaleformMovieFunctionParameterString("Arrêter de placer")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(instructionalButtonsScaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(instructionalButtonsScaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
    
    return instructionalButtonsScaleform
end

function CreatePotObjects()
    if not createdPotObjects then
        createdPotObjects = {}
    end
    if not placedPots or not next(placedPots) then
        return
    end

    local defaultModel = Config.PotModel
    if type(defaultModel) == "string" then
        defaultModel = GetHashKey(defaultModel)
    end
    RequestModel(defaultModel)
    Citizen.Wait(100)
    local newPots = {}
    for i, pot in pairs(placedPots) do
        if not createdPotObjects[i] or not DoesEntityExist(createdPotObjects[i]) then
            newPots[i] = pot
        end
    end

    for i, pot in pairs(newPots) do
        local hash = defaultModel
        
        if pot.model then
            if type(pot.model) == "string" then
                if tonumber(pot.model) ~= nil then
                    hash = tonumber(pot.model)
                else
                    hash = GetHashKey(pot.model)
                end
            elseif type(pot.model) == "number" then
                hash = pot.model
            end
        end
        
        if not HasModelLoaded(hash) then
            RequestModel(hash)
            Citizen.Wait(50)
        end
        
        if HasModelLoaded(hash) then
            local zOffset = 0.0
            if pot.stage >= 3 then
                if pot.state == "weed" then
                    if pot.stage == 3 then
                        zOffset = -2.5
                    elseif pot.stage == 4 then
                        zOffset = -2.5
                    end
                elseif pot.state == "coke" then
                    if pot.stage == 3 then
                        zOffset = -2.5
                    elseif pot.stage == 4 then
                        zOffset = -2.5
                    end
                end
            end
            
            local object = CreateObject(hash, pot.x, pot.y, pot.z + zOffset, false, false, true)
            SetEntityHeading(object, pot.heading or 0.0)
            FreezeEntityPosition(object, true)
            SetEntityAsMissionEntity(object, true, true)
            SetEntityDrawOutlineColor(object, 0, 0, 0, 0)
            SetEntityLodDist(object, 500)
            createdPotObjects[i] = object
        elseif HasModelLoaded(defaultModel) then
            local object = CreateObject(defaultModel, pot.x, pot.y, pot.z, false, false, true)
            SetEntityHeading(object, pot.heading or 0.0)
            FreezeEntityPosition(object, true)
            SetEntityAsMissionEntity(object, true, true)
            createdPotObjects[i] = object
        end
    end

    SetModelAsNoLongerNeeded(defaultModel)
end

function IsPotOwnedByPlayer(pot)
    local playerServerId = GetPlayerServerId(PlayerId())
    return pot.owner == playerServerId
end

RegisterNetEvent('kay_growing:syncPots')
AddEventHandler('kay_growing:syncPots', function(pots)
    for potIndex, object in pairs(createdPotObjects) do
        if not pots[potIndex] then
            if DoesEntityExist(object) then
                DeleteEntity(object)
            end
            createdPotObjects[potIndex] = nil
        end
    end
    
    placedPots = pots
    CreatePotObjects()
end)

RegisterNetEvent('kay_growing:updatePot')
AddEventHandler('kay_growing:updatePot', function(index, data)
    if placedPots[index] then
        local x = placedPots[index].x
        local y = placedPots[index].y
        local z = placedPots[index].z
        local heading = placedPots[index].heading
        for k, v in pairs(data) do
            placedPots[index][k] = v
        end
        placedPots[index].x = x
        placedPots[index].y = y
        placedPots[index].z = z
        placedPots[index].heading = heading
        if data.model and createdPotObjects[index] then
            DeleteEntity(createdPotObjects[index])
            createdPotObjects[index] = nil
            local hash = GetHashKey(data.model)
            RequestModel(hash)
            
            Citizen.CreateThread(function()
                local timeout = 1000
                local start = GetGameTimer()
                
                while not HasModelLoaded(hash) and GetGameTimer() - start < timeout do
                    Citizen.Wait(0)
                end
                
                if HasModelLoaded(hash) then
                    local zOffset = 0.0
                    if data.model == "bkr_prop_weed_lrg_01a" then
                        zOffset = -2.5 
                    elseif data.model == "bkr_prop_weed_lrg_01b" then
                        zOffset = -2.5 
                    end
                    
                    local object = CreateObject(hash, x, y, z + zOffset, false, false, true)
                    SetEntityHeading(object, heading or 0.0)
                    FreezeEntityPosition(object, true)
                    SetEntityAsMissionEntity(object, true, true)
                    createdPotObjects[index] = object
                else
                    print(string.format("^1Erreur lors du chargement du modèle %s^7", data.model))
                end
                
                SetModelAsNoLongerNeeded(hash)
            end)
        end
        local existingScaleform = placedPots[index].scaleform
        if existingScaleform and HasScaleformMovieLoaded(existingScaleform.id) then
            UpdatePotScaleform(existingScaleform, placedPots[index])
        else
            local newScaleform = gtaui.Scaleform('mp_car_stats_01')
            if newScaleform:load() then
                placedPots[index].scaleform = newScaleform
                UpdatePotScaleform(newScaleform, placedPots[index])
            end
        end
    end
end)

RegisterNetEvent('kay_drugs:syncPot')
AddEventHandler('kay_drugs:syncPot', function(potIndex, potData)
    if placedPots[potIndex] then
        local oldStage = placedPots[potIndex].stage
        local newStage = potData.stage

        placedPots[potIndex] = potData

        if oldStage ~= newStage or potData.model ~= placedPots[potIndex].model then
            if createdPotObjects[potIndex] and DoesEntityExist(createdPotObjects[potIndex]) then
                DeleteEntity(createdPotObjects[potIndex])
                createdPotObjects[potIndex] = nil
            end
            local hash = potData.model
            if type(hash) == "string" then
                hash = GetHashKey(hash)
            end
            
            if not HasModelLoaded(hash) then
                RequestModel(hash)
                while not HasModelLoaded(hash) do
                    Wait(10)
                end
            end
            local zOffset = 0.0
            if potData.stage >= 3 then
                if potData.state == "weed" then
                    if potData.stage == 3 then
                        zOffset = -2.5
                    elseif potData.stage == 4 then
                        zOffset = -2.5
                    end
                elseif potData.state == "coke" then
                    if potData.stage == 3 then
                        zOffset = -2.5
                    elseif potData.stage == 4 then
                        zOffset = -2.5
                    end
                end
            end
            local object = CreateObject(hash, potData.x, potData.y, potData.z + zOffset, false, false, true)
            SetEntityHeading(object, potData.heading or 0.0)
            FreezeEntityPosition(object, true)
            SetEntityAsMissionEntity(object, true, true)
            createdPotObjects[potIndex] = object
        end
    end
end)

RegisterNetEvent('kay_growing:updatePotWater')
AddEventHandler('kay_growing:updatePotWater', function(potIndex, newWaterLevel)
    if placedPots[potIndex] then
        placedPots[potIndex].waterLevel = newWaterLevel
        TriggerClientEvent('kay_growing:updatePot', -1, potIndex, placedPots[potIndex])
        SavePotsToDatabase()
    end
end)

function StartPlacingLight()
    local playerPed = PlayerPedId()
    local remainingLights = exports.ox_inventory:GetItemCount('purplelight', nil, true) or 0

    if remainingLights <= 0 then
        ESX.ShowNotification("~r~Vous n'avez pas de lumières dans votre inventaire")
        return
    end

    isPlacingLight = true

    local instructionalButtonsScaleform = SetupInstructionalButtons()
    DisableControlActions(true)
    
    Citizen.CreateThread(function()
        local validPlacement = false
        local lightPosition = nil
        local continuePlacing = true
        
        while isPlacingLight and continuePlacing do
            Wait(0)
            DisablePlayerFiring(PlayerId(), true)
            DisableControlAction(0, 24, true) 
            DisableControlAction(0, 25, true) 
            DisableControlAction(0, 140, true) 
            DisableControlAction(0, 141, true) 
            DisableControlAction(0, 142, true) 
            
            DrawScaleformMovieFullscreen(instructionalButtonsScaleform, 255, 255, 255, 255, 0)
            
            local playerCoords = GetEntityCoords(playerPed)
            local playerHeading = GetEntityHeading(playerPed)
            local lightHeading = (playerHeading + 180.0) % 360.0
            local forward = 1.5
            local forwardX = playerCoords.x + forward * math.sin(-math.rad(playerHeading))
            local forwardY = playerCoords.y + forward * math.cos(-math.rad(playerHeading))
            local groundZ = playerCoords.z - 0.95
            local found, groundZ = GetGroundZFor_3dCoord(forwardX, forwardY, playerCoords.z + 1.0, true)
            
            if not found then
                groundZ = playerCoords.z - 0.95
            end
            
            lightPosition = vector3(forwardX, forwardY, groundZ)
            
            if highlightedObject and DoesEntityExist(highlightedObject) then
                DeleteEntity(highlightedObject)
                highlightedObject = nil
            end
            
            highlightedObject = CreateObject(`prop_worklight_01a`, lightPosition.x, lightPosition.y, lightPosition.z, false, false, false)
            SetEntityHeading(highlightedObject, lightHeading)
            SetEntityAlpha(highlightedObject, 150, false)
            SetEntityCollision(highlightedObject, false, false)

            local lightDir = vector3(math.sin(-math.rad(lightHeading)), math.cos(-math.rad(lightHeading)), 0)
            local markerPos = vector3(
                lightPosition.x + lightDir.x * Config.LightRange * 0.5, 
                lightPosition.y + lightDir.y * Config.LightRange * 0.5, 
                lightPosition.z - 0.9
            )
            
            if IsDisabledControlJustPressed(0, 24) then 
                local lightId = "light_" .. math.random(100000, 999999)
                TriggerServerEvent('kay_growing:placeLight', {
                    id = lightId,
                    x = lightPosition.x,
                    y = lightPosition.y, 
                    z = lightPosition.z,
                    heading = lightHeading
                })
                
                Wait(500)
                remainingLights = exports.ox_inventory:GetItemCount('purplelight', nil, true) or 0
                
                if remainingLights <= 0 then
                    continuePlacing = false
                end
            end
            
            if IsControlJustPressed(0, 73) then 
                continuePlacing = false
            end
        end

        if highlightedObject and DoesEntityExist(highlightedObject) then
            DeleteEntity(highlightedObject)
            highlightedObject = nil
        end
        
        isPlacingLight = false
        
        if instructionalButtonsScaleform then
            SetScaleformMovieAsNoLongerNeeded(instructionalButtonsScaleform)
            instructionalButtonsScaleform = nil
        end
        
        DisableControlActions(false)
    end)
end

function DeleteLight(lightId)
    if lightObjects and lightObjects[lightId] and DoesEntityExist(lightObjects[lightId].object) then
        DeleteEntity(lightObjects[lightId].object)
        lightObjects[lightId] = nil
        UpdatePotsLightLevelAfterRemoval()
        TriggerServerEvent('kay_growing:deleteLight', lightId)
    end
end

function UpdatePotScaleform(scaleform, potData)
    local state = potData.state or "empty"
    local stateConfig = Config.PotStates[state]
    local stage = tonumber(potData.stage) or 1

    if not HasScaleformMovieLoaded(scaleform.id) then
        scaleform = gtaui.Scaleform('mp_car_stats_01')
        if not scaleform:load() then
            return
        end
    end

    local textureDict = stateConfig and stateConfig.texture_dict or "kay_pot"
    
    if not HasStreamedTextureDictLoaded(textureDict) then
        RequestStreamedTextureDict(textureDict)
        local timeout = 1000
        local startTime = GetGameTimer()
        
        while not HasStreamedTextureDictLoaded(textureDict) and GetGameTimer() - startTime < timeout do
            Wait(0)
        end
    end

    if state ~= "empty" then
        for i = 1, 4 do
            local textureName = stateConfig.texture_name .. i
            if not HasStreamedTextureDictLoaded(textureDict) then
                RequestStreamedTextureDict(textureDict)
                Wait(50)
            end
        end
    end
    
    if stage < 1 then stage = 1 end
    if stage > 4 then stage = 4 end

    BeginScaleformMovieMethod(scaleform.id, "SET_VEHICLE_INFOR_AND_STATS")
    PushScaleformMovieFunctionParameterString(stateConfig.title)
    if state ~= "empty" and stateConfig.subtitle then
        if stateConfig.subtitle[stage] then
            PushScaleformMovieFunctionParameterString(stateConfig.subtitle[stage])
        else
            PushScaleformMovieFunctionParameterString(stateConfig.subtitle[1] or "")
        end
    else
        PushScaleformMovieFunctionParameterString(stateConfig.subtitle or "")
    end
    
    PushScaleformMovieFunctionParameterString(stateConfig.texture_dict)
    PushScaleformMovieFunctionParameterString(state == "empty" and stateConfig.texture_name or stateConfig.texture_name .. stage)
    
    for _, stat in ipairs(stateConfig.stats) do
        PushScaleformMovieFunctionParameterString(stat)
    end
    if state == "empty" then
        for i = 1, 4 do
            PushScaleformMovieFunctionParameterFloat(0.0)
        end
    else
        local growthValue = stage * 25 / 1.0
        
        PushScaleformMovieFunctionParameterFloat(potData.waterLevel / 1.0)
        PushScaleformMovieFunctionParameterFloat(potData.lightLevel / 1.0)
        PushScaleformMovieFunctionParameterFloat(potData.fertilizerLevel / 1.0)
        PushScaleformMovieFunctionParameterFloat(growthValue)
    end
    
    PushScaleformMovieFunctionParameterBool(true)
    EndScaleformMovieMethod()
end


function UpdatePotsLightLevelAfterRemoval()
    if not placedPots then
        placedPots = {}
        return
    end

    for potIndex, pot in pairs(placedPots) do
        if pot.x and pot.y and pot.z then
            local potCoords = vector3(pot.x, pot.y, pot.z)
            local highestLightLevel = 0

            if lightObjects and next(lightObjects) then
                for _, light in pairs(lightObjects) do
                    if light and light.position then
                        local distance = #(light.position - potCoords)
                        if distance < light.range then
                            local intensity = 100 - (distance / light.range * 100)
                            local lightVector = vector3(
                                math.sin(-math.rad(light.heading)), 
                                math.cos(-math.rad(light.heading)), 
                                0.0
                            )
                            
                            local potVector = vector3(
                                potCoords.x - light.position.x, 
                                potCoords.y - light.position.y, 
                                0.0
                            )
                            local length = math.sqrt(potVector.x * potVector.x + potVector.y * potVector.y)
                            if length > 0 then
                                potVector = vector3(potVector.x / length, potVector.y / length, 0.0)
                            else
                                potVector = vector3(0.0, 0.0, 0.0)
                            end
                            local dotProduct = lightVector.x * potVector.x + lightVector.y * potVector.y
                            if dotProduct > 0 then
                                intensity = intensity * dotProduct
                            else
                                intensity = intensity * 0.2
                            end
                            
                            if intensity > highestLightLevel then
                                highestLightLevel = math.floor(intensity)
                            end
                        end
                    end
                end
            end
            if placedPots[potIndex].lightLevel ~= highestLightLevel then
                placedPots[potIndex].lightLevel = highestLightLevel
                TriggerServerEvent('kay_drugs:updatePotLight', potIndex, highestLightLevel)
            end
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        if lightObjects and next(lightObjects) then
            local closestLightId = nil
            local closestDistance = 2.0 
            for id, light in pairs(lightObjects) do
                if light and light.position then
                    local distance = #(playerCoords - light.position)
                    if distance < closestDistance then
                        closestLightId = id
                        closestDistance = distance
                    end
                end
            end
            if closestLightId then
                DrawText3D(
                    lightObjects[closestLightId].position.x, 
                    lightObjects[closestLightId].position.y, 
                    lightObjects[closestLightId].position.z + 0.5, 
                    "Appuyez sur ~y~E~w~ pour ramasser la lumière"
                )
                if IsControlJustReleased(0, 38) then 
                    TriggerServerEvent('kay_growing:pickupLight', closestLightId)
                    DeleteLight(closestLightId)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        -- Toggle H (overlay)
        if IsControlJustPressed(0, 74) then -- H
            showScaleform = not showScaleform
        end

        for i, pot in pairs(placedPots) do
            if pot.x and pot.y and pot.z then
                local distance = #(playerCoords - vector3(pot.x, pot.y, pot.z))

                if distance < 2.0 then
                    wait = 0

                    local isPolice = IsPlayerPolice()
                    local canHarvest = pot.stage and pot.stage >= 3

                    -- Helptext unique avec ~n~
                    local lines = { "~INPUT_VEH_HEADLIGHT~ pour afficher/cacher l'overlay" }
                    if canHarvest then
                        lines[#lines+1] = "~INPUT_CONTEXT~ pour récolter"
                    end
                    if isPolice then
                        -- On met la confiscation sur G pour éviter le conflit avec E
                        lines[#lines+1] = "~INPUT_DETONATE~ pour confisquer le pot"
                    end
                    local helpText = table.concat(lines, "~n~")
                    BeginTextCommandDisplayHelp('STRING')
                    AddTextComponentSubstringPlayerName(helpText)
                    EndTextCommandDisplayHelp(0, false, true, -1)

                    -- Récolte (E) si la plante est mûre
                    if canHarvest and IsControlJustPressed(0, 38) then -- E
                        local scissors = CreateObject(GetHashKey("prop_scissors"), 0, 0, 0, true, true, true)
                        AttachEntityToEntity(
                            scissors, playerPed, GetPedBoneIndex(playerPed, 28422),
                            0.05, 0.00, 0.00,
                            0.0, 0.0, 0.0,
                            true, true, false, true, 1, true
                        )

                        exports.rprogress:Custom({
                            Duration = 2000,
                            Label = " ",
                            Animation = {
                                animationDictionary = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
                                animationName = "weed_crouch_checkingleaves_idle_01_inspector",
                                flag = 1
                            },
                            DisableControls = { Mouse = false, Player = true, Vehicle = true },
                            onComplete = function(cancelled)
                                DeleteEntity(scissors)
                                ClearPedTasks(playerPed)
                                if not cancelled then
                                    TriggerServerEvent('kay_drugs:tryHarvest', i)
                                end
                            end
                        })
                    end

                    -- Confiscation (G) pour la police
                    -- INPUT_DETONATE (47) = G
                    if isPolice and IsControlJustPressed(0, 47) then
                        TriggerServerEvent('kay_drugs:confiscatePot', i)
                    end
                end
            end
        end

        Wait(wait)
    end
end)


if ownerServerId then
    TriggerClientEvent('esx:showNotification', ownerServerId, "~r~La police a confisqué un de vos pots de culture!")
end

function DisplayHelpTextThisFrame(text, beep)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, beep, 1)
end

function CreateLightObjects()
    if not lightObjects then
        lightObjects = {}
    end
    for _, handle in pairs(lightObjects) do
        if DoesEntityExist(handle.object) then
            DeleteEntity(handle.object)
        end
    end
    
    lightObjects = {}
    if not Config.PlacedLights or not next(Config.PlacedLights) then
        return
    end
    for id, light in pairs(Config.PlacedLights) do
        local object = CreateObject(`prop_worklight_01a`, light.x, light.y, light.z, false, false, true)
        SetEntityHeading(object, light.heading or 0.0)
        FreezeEntityPosition(object, true)
        SetEntityAsMissionEntity(object, true, true)
        local lightHandle = nil
        if DoesEntityExist(object) then
            lightHandle = CreateLightAtCoords(light.x, light.y, light.z + 1.0, 147, 0, 147, Config.LightRange * 3.0, 8.0)
        end
        
        lightObjects[id] = {
            object = object,
            light = lightHandle,
            position = vector3(light.x, light.y, light.z),
            heading = light.heading or 0.0,
            range = Config.LightRange
        }
    end
end

function normalize(vec)
    local length = math.sqrt(vec.x * vec.x + vec.y * vec.y + vec.z * vec.z)
    if length > 0 then
        return vector3(vec.x / length, vec.y / length, vec.z / length)
    else
        return vector3(0, 0, 0)
    end
end

function CreateLightAtCoords(x, y, z, r, g, b, range, intensity)
    return {x = x, y = y, z = z, color = {r = r, g = g, b = b}, range = range, intensity = intensity}
end


function UpdatePotsLightLevel()
    if not placedPots then
        placedPots = {}
        return
    end
    
    for potIndex, pot in pairs(placedPots) do
        if pot.x and pot.y and pot.z then
            local potCoords = vector3(pot.x, pot.y, pot.z)
            local highestLightLevel = 0
            
            if Config.PlacedLights and next(Config.PlacedLights) then
                for lightId, light in pairs(Config.PlacedLights) do
                    local lightCoords = vector3(light.x, light.y, light.z)
                    local distance = #(potCoords - lightCoords)
                    if distance < Config.LightRange then
                        local lightDir = vector3(
                            -math.sin(-math.rad(light.heading)), 
                            -math.cos(-math.rad(light.heading)), 
                            0.0
                        )
                        
                        local lightToPotVector = vector3(
                            potCoords.x - lightCoords.x,
                            potCoords.y - lightCoords.y,
                            0.0
                        )
                        
                        local length = math.sqrt(lightToPotVector.x * lightToPotVector.x + lightToPotVector.y * lightToPotVector.y)
                        if length > 0 then
                            lightToPotVector = vector3(lightToPotVector.x / length, lightToPotVector.y / length, 0.0)
                        end
                        
                        local dot = lightDir.x * lightToPotVector.x + lightDir.y * lightToPotVector.y
                        if dot > Config.LightMinimumDot then
                            highestLightLevel = 100
                            break 
                        end
                    end
                end
            end
            if placedPots[potIndex] then
                placedPots[potIndex].lightLevel = highestLightLevel
                TriggerServerEvent('kay_drugs:updatePotLight', potIndex, highestLightLevel)
            end
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        
        if Config.PlacedLights and next(Config.PlacedLights) then
            local playerCoords = GetEntityCoords(PlayerPedId())
            
            for lightId, light in pairs(Config.PlacedLights) do
                local lightCoords = vector3(light.x, light.y, light.z)
                local distance = #(playerCoords - lightCoords)
                
                if distance < 20.0 then 
                    local lightDir = vector3(
                        -math.sin(-math.rad(light.heading)), 
                        -math.cos(-math.rad(light.heading)), 
                        0.0
                    )
                    local spotPos = vector3(
                        lightCoords.x + lightDir.x * Config.LightRange * 0.5,
                        lightCoords.y + lightDir.y * Config.LightRange * 0.5,
                        lightCoords.z - 0.5
                    )
                    DrawLightWithRange(
                        lightCoords.x + lightDir.x * 0.5, 
                        lightCoords.y + lightDir.y * 0.5, 
                        lightCoords.z + 0.5, 
                        147, 0, 147, -
                        Config.LightRange * 0.8, 
                        0.8 
                    )
                    local coneLength = Config.LightRange
                    local coneWidth = Config.LightRange * 0.8
                    DrawMarker(
                        1, 
                        spotPos.x, spotPos.y, spotPos.z,
                        0, 0, 0,
                        0, 0, 0, 
                        coneWidth, coneWidth, 0.1, 
                        147, 0, 147, 30, 
                        false, false, 2, false, nil, nil, false
                    )
                end
            end
        end
    end
end)

RegisterNetEvent('kay_growing:syncLights')
AddEventHandler('kay_growing:syncLights', function(lights)
    Config.PlacedLights = lights
    CreateLightObjects()
    Citizen.SetTimeout(500, function()
        UpdatePotsLightLevel()
    end)
end)

function StartPlacingPot()
    local playerPed = PlayerPedId()
    local remainingPots = exports.ox_inventory:GetItemCount('flowerpot', nil, true) or 0

    if not placedPots then
        placedPots = {}
    end

    local playerPotCount = 0
    local playerServerId = GetPlayerServerId(PlayerId())

    for _, pot in pairs(placedPots) do
        if pot and pot.owner == playerServerId then
            playerPotCount = playerPotCount + 1
        end
    end

    if playerPotCount >= (Config.MaxPots or 20) then
        ESX.ShowNotification("~r~Vous avez atteint votre limite de " .. (Config.MaxPots or 20) .. " pots")
        return
    end

    if remainingPots <= 0 then
        ESX.ShowNotification("~r~Vous n'avez pas de pot dans votre inventaire")
        return
    end

    isPlacingPot = true
    LoadAnimDict("anim@heists@box_carry@")
    TaskPlayAnim(playerPed, "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
    local pot = CreateObject(`bkr_prop_weed_01_small_01c`, 0, 0, 0, true, true, true)
    AttachEntityToEntity(pot, playerPed, GetPedBoneIndex(playerPed, 60309), 
        0.138, -0.05, 0.23,  
        -50.0, 290.0, 0.0,   
        true, true, false, true, 1, true)

    local instructionalButtonsScaleform = SetupInstructionalButtons()
    DisableControlActions(true)
    
    Citizen.CreateThread(function()
        local validPlacement = false
        local potPosition = nil
        local continuePlacing = true
        
        while isPlacingPot and continuePlacing do
            Wait(0)
            DisablePlayerFiring(PlayerId(), true) 
            DisableControlAction(0, 24, true) 
            DisableControlAction(0, 25, true) 
            DisableControlAction(0, 140, true) 
            DisableControlAction(0, 141, true) 
            DisableControlAction(0, 142, true) 
            DisableControlAction(0, 257, true) 
            DrawScaleformMovieFullscreen(instructionalButtonsScaleform, 255, 255, 255, 255, 0)
            
            local playerCoords = GetEntityCoords(playerPed)
            local playerHeading = GetEntityHeading(playerPed)
            local forward = 1.5 
            local forwardX = playerCoords.x + forward * math.sin(-math.rad(playerHeading))
            local forwardY = playerCoords.y + forward * math.cos(-math.rad(playerHeading))
            local groundZ = playerCoords.z - 0.95
            local found, groundZ = GetGroundZFor_3dCoord(forwardX, forwardY, playerCoords.z + 1.0, true)
            if not found then
                groundZ = playerCoords.z - 0.95 
            end
            potPosition = vector3(forwardX, forwardY, groundZ)
            validPlacement = IsLocationValid(potPosition, placedPots)
            
            if highlightedObject then
                DeleteEntity(highlightedObject)
                highlightedObject = nil
            end
            highlightedObject = CreateHighlightObject(Config.PotModel, potPosition, validPlacement)
            SetEntityHeading(highlightedObject, playerHeading) 
            
            if not validPlacement then
                DrawTextOnScreen(Config.Texts.TooClose, 0.5, 0.70, 0.5, 255, 0, 0, 255)
            end
            
            if IsDisabledControlJustPressed(0, 24) then 
                if validPlacement then
                    TriggerServerEvent('kay_growing:placePot', {
                        x = potPosition.x,
                        y = potPosition.y, 
                        z = potPosition.z,
                        heading = playerHeading,
                        growth = 0,
                        stage = 1,
                        plantTime = GetGameTimer()
                    })
                    Wait(500)
                    remainingPots = exports.ox_inventory:GetItemCount('flowerpot') or 0
                    
                    if remainingPots <= 0 then
                        DeleteObject(pot)
                        if highlightedObject then
                            DeleteEntity(highlightedObject)
                            highlightedObject = nil
                        end
                        ClearPedTasks(PlayerPedId())
                        isPlacingPot = false
                        continuePlacing = false
                    end
                end
            end
        
            if IsControlJustPressed(0, 73) then 
                DeleteObject(pot)
                if highlightedObject then
                    DeleteEntity(highlightedObject)
                    highlightedObject = nil
                end
                ClearPedTasks(playerPed)
                isPlacingPot = false
                continuePlacing = false
            end
        end
        Wait(2000)
        isPlacingPot = false
        if instructionalButtonsScaleform then
            SetScaleformMovieAsNoLongerNeeded(instructionalButtonsScaleform)
            instructionalButtonsScaleform = nil
        end
        
        DisableControlActions(false)
    end)
end

RegisterNetEvent('kay_growing:placePotResponse')
AddEventHandler('kay_growing:placePotResponse', function(success, message)
    if not success then
        ESX.ShowNotification(message)
        isPlacingPot = false
        if highlightedObject then
            DeleteEntity(highlightedObject)
            highlightedObject = nil
        end
        ClearPedTasks(PlayerPedId())
        DisableControlActions(false)
    end
end)

function DisableControlActions(disable)
    if disable then
        SetPlayerCanDoDriveBy(PlayerId(), false)
        DisablePlayerFiring(PlayerId(), true)
    else
        SetPlayerCanDoDriveBy(PlayerId(), true)
        DisablePlayerFiring(PlayerId(), false)
    end
end
function GetClosestPot()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local closestDistance = 999999.0
    local closestPot = nil
    local closestIndex = nil
    
    for i, pot in pairs(placedPots) do
        local distance = GetDistanceBetweenCoords(
            playerCoords.x, playerCoords.y, playerCoords.z,
            pot.x, pot.y, pot.z
        )
        
        if distance < closestDistance and distance < 10.0 then
            closestDistance = distance
            closestPot = pot
            closestIndex = i
        end
    end
    
    return closestPot, closestIndex, closestDistance
end

function CheckYTDLoaded()
    if not HasStreamedTextureDictLoaded("kay_drugs") then
        RequestStreamedTextureDict("kay_drugs")
        local timeout = 1000
        local start = GetGameTimer()
        while not HasStreamedTextureDictLoaded("kay_drugs") and GetGameTimer() - start < timeout do
            Wait(10)
        end
        
        if HasStreamedTextureDictLoaded("kay_drugs") then
            print("YTD kay_drugs chargé avec succès")
            return true
        else
            print("ERREUR: Impossible de charger le dictionnaire de texture kay_drugs")
            return false
        end
    end
    return true
end

Citizen.CreateThread(function()
    for _, dict in ipairs({"kay_drugs", "kay_weed", "kay_pot"}) do
        RequestStreamedTextureDict(dict)
    end
    
    local scaleform = gtaui.Scaleform("mp_car_stats_01")
    scaleform:load()
    
    while true do
        if not isPlacingPot then 
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local interval = 1000
            local closestPot = nil
            local closestDistance = 999999.0
            local closestPotData = nil
            local closestPotIndex = nil
            for i, pot in pairs(placedPots) do
                if pot.x and pot.y and pot.z then
                    local distance = #(playerCoords - vector3(pot.x, pot.y, pot.z))
                    if distance < 5.0 and distance < closestDistance then
                        closestDistance = distance
                        closestPot = i
                        closestPotData = pot
                        closestPotIndex = i
                    end
                end
            end

            if closestPot and closestPotData then
                interval = 0
                for _, dict in ipairs({"kay_drugs", "kay_weed", "kay_pot"}) do
                    if not HasStreamedTextureDictLoaded(dict) then
                        RequestStreamedTextureDict(dict)
                    end
                end
                
                if not HasScaleformMovieLoaded(scaleform.id) then
                    scaleform:load()
                end
                local state = closestPotData.state or "empty"
                local stage = tonumber(closestPotData.stage) or 1
                UpdatePotScaleform(scaleform, closestPotData)

                if showScaleform then
                    local displayHeight = 2.1
                    local displayCoords = vector3(
                        closestPotData.x,
                        closestPotData.y,
                        closestPotData.z + displayHeight
                    )
                    local camCoords = GetGameplayCamCoord()
                    local dir = camCoords - displayCoords
                    local length = #dir
                    
                    if length > 0 then
                        dir = dir / length
                        local rotZ = math.deg(math.atan2(dir.x, dir.y))
                        local forwardOffset = 0.0 
                        if closestPotData.stage >= 3 then
                            forwardOffset = 0.8 
                        end
                
                        displayCoords = vector3(
                            closestPotData.x + (forwardOffset * math.sin(math.rad(rotZ))), 
                            closestPotData.y + (forwardOffset * math.cos(math.rad(rotZ))), 
                            closestPotData.z + displayHeight
                        )
                        
                        DrawScaleformMovie_3dSolid(
                            scaleform.id,
                            displayCoords.x, 
                            displayCoords.y, 
                            displayCoords.z,
                            0.0, 0.0, rotZ + 180.0,
                            2.0, 2.0, 1.0,      
                            5.0, 2.8, 2.2,      
                            2
                        )
                    end
                end
            end
        end
        Wait(interval)
    end
end)

RegisterCommand('checktexture', function()
    if HasStreamedTextureDictLoaded("kay_drugs") then
        DrawSprite("kay_drugs", "pot_stage1", 0.5, 0.5, 0.2, 0.2, 0.0, 255, 255, 255, 255)
        print("^2Texture trouvée et chargée^7")
    else
        print("^1Texture non chargée^7")
        RequestStreamedTextureDict("kay_drugs")
    end
end, false)

function norm(vec)
    local length = #vec
    if length == 0 then
        return vector3(0, 0, 1) 
    end
    return vec / length
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

RegisterCommand("testscaleform", function(source, args, rawCommand)
    local scaleformName = args[1] or "mp_car_stats_01"
    local scale = tonumber(args[2]) or 2.2  
    
    local scaleform = RequestScaleformMovie(scaleformName)
    
    if scaleform == 0 then
        return
    end
    
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    BeginScaleformMovieMethod(scaleform, "SET_VEHICLE_INFOR_AND_STATS")
    PushScaleformMovieFunctionParameterString("Test Scaleform")
    PushScaleformMovieFunctionParameterString("Scale: " .. scale)
    PushScaleformMovieFunctionParameterString("")
    PushScaleformMovieFunctionParameterString("")
    PushScaleformMovieFunctionParameterString("Étape 3")
    PushScaleformMovieFunctionParameterString("")
    PushScaleformMovieFunctionParameterString("Evolution")
    PushScaleformMovieFunctionParameterString("")
    PushScaleformMovieFunctionParameterFloat(0.75)
    PushScaleformMovieFunctionParameterBool(true)
    EndScaleformMovieMethod()
    local startTime = GetGameTimer()
    Citizen.CreateThread(function()
        local rotation = 0

        while GetGameTimer() - startTime < 20000 do
            Wait(0)
            local playerPed = PlayerPedId()
            local playerHeading = GetEntityHeading(playerPed)
            local coords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 3.0, 1.0)
            local playerCoords = GetEntityCoords(playerPed)
            local dirVector = playerCoords - coords
            local rotZ = -math.deg(math.atan2(dirVector.y, dirVector.x))
            DrawScaleformMovie_3d(
                scaleform,
                coords.x, coords.y, coords.z,
                0.0, 0.0, rotZ,  
                2.0, 2.0, 1.0,  
                scale, scale, scale,  
                2
            )

            DrawText3D(coords.x, coords.y, coords.z - 0.5, 
                "Test Scaleform: " .. scaleformName .. 
                "~n~Scale: " .. scale .. 
                "~n~Rotation: " .. math.floor(rotZ))
        end
        
        SetScaleformMovieAsNoLongerNeeded(scaleform)
    end)
end, false)

RegisterNetEvent('ox_inventory:itemUsed')
AddEventHandler('ox_inventory:itemUsed', function(data)
    if data.name == 'flowerpot' then 
        StartPlacingPot()
    elseif data.name == 'purplelight' then
        StartPlacingLight()
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(5000) 
        UpdatePotsLightLevel()
    end
end)
RegisterNetEvent('kay_growing:syncLights')
AddEventHandler('kay_growing:syncLights', function(lights)
    Config.PlacedLights = lights
    CreateLightObjects()
end)

RegisterNetEvent('kay_drugs:syncPot', function(potIndex, potData)
    if placedPots[potIndex] then
        placedPots[potIndex].state = potData.state
        placedPots[potIndex].stage = potData.stage
        placedPots[potIndex].plantTime = potData.plantTime
        placedPots[potIndex].waterLevel = potData.waterLevel
        placedPots[potIndex].lightLevel = potData.lightLevel
        placedPots[potIndex].fertilizerLevel = potData.fertilizerLevel
        placedPots[potIndex].growth = potData.growth
    end
end)

exports('weed_seed', function(data, slot)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local foundPot = false

    for i, pot in pairs(placedPots) do
        if pot.x and pot.y and pot.z then
            local distance = #(playerCoords - vector3(pot.x, pot.y, pot.z))
            
            if distance < 2.0 then
                if not pot.state or pot.state == "empty" then
                    foundPot = true
                    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
                    Wait(3000)
                    ClearPedTasks(playerPed)
                    local newData = {
                        state = "weed",
                        stage = 1,
                        plantTime = GetGameTimer(),
                        waterLevel = 0,
                        lightLevel = 0,
                        fertilizerLevel = 0,
                        growth = 25
                    }
                    TriggerServerEvent('kay_drugs:plantSeed', i, newData)
                    placedPots[i].state = newData.state
                    placedPots[i].stage = newData.stage
                    placedPots[i].plantTime = newData.plantTime
                    placedPots[i].waterLevel = newData.waterLevel
                    placedPots[i].lightLevel = newData.lightLevel
                    placedPots[i].fertilizerLevel = newData.fertilizerLevel
                    placedPots[i].growth = newData.growth
                    
                    exports.ox_inventory:useItem(data)
                    ESX.ShowNotification("~g~Graine plantée avec succès")
                    return
                end
            end
        end
    end
    
    if not foundPot then
        ESX.ShowNotification("~r~Aucun pot vide à proximité")
    end
end)

exports('coke_seed', function(data, slot)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local foundPot = false
    local potIndex = nil

    for i, pot in pairs(placedPots) do
        if pot.x and pot.y and pot.z then
            local distance = #(playerCoords - vector3(pot.x, pot.y, pot.z))
            
            if distance < 2.0 then
                if not pot.state or pot.state == "empty" then
                    foundPot = true
                    potIndex = i
                    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
                    Wait(3000)
                    ClearPedTasks(playerPed)
                    local newData = {
                        state = "coke",
                        stage = 1,
                        plantTime = GetGameTimer(),
                        waterLevel = 0,
                        lightLevel = 0,
                        fertilizerLevel = 0,
                        growth = 25
                    }
                    TriggerServerEvent('kay_drugs:plantSeed', i, newData)
                    exports.ox_inventory:useItem(data)
                    ESX.ShowNotification("~g~Graine plantée avec succès")
                    return
                end
            end
        end
    end
    
    if not foundPot then
        ESX.ShowNotification("~r~Aucun pot vide à proximité")
    end
end)

exports('water', function(data, slot)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    
    local closestPot, closestIndex = nil, nil
    local closestDistance = 2.0
    
    for i, pot in pairs(placedPots) do
        local distance = #(playerCoords - vector3(pot.x, pot.y, pot.z))
        if distance < closestDistance then
            closestDistance = distance
            closestPot = pot
            closestIndex = i
        end
    end

    if closestPot then
        if closestPot.state == "empty" then
            return
        end
        LoadAnimDict(Config.Animations.Watering.Dictionary)
        
        exports.ox_inventory:useItem(data, function(data)
            if data then
                exports.rprogress:Custom({
                    Duration = 2000,
                    Label = " ",
                    DisableControls = {
                        Mouse = false,
                        Player = true,
                        Vehicle = true
                    },
                    Animation = {
                        animationDictionary = Config.Animations.Watering.Dictionary,
                        animationName = Config.Animations.Watering.Clip,
                        flag = Config.Animations.Watering.Flag
                    },
                    onComplete = function(cancelled)
                        if not cancelled then
                            local newWaterLevel = math.min((closestPot.waterLevel or 0) + 20, 100)
                            placedPots[closestIndex].waterLevel = newWaterLevel
                            TriggerServerEvent('kay_drugs:updatePotWater', closestIndex, newWaterLevel)
                            if closestPot.scaleform and HasScaleformMovieLoaded(closestPot.scaleform) then
                                SetScaleformMovieAsNoLongerNeeded(closestPot.scaleform)
                                placedPots[closestIndex].scaleform = nil
                            end
                        end
                        
                        ClearPedTasks(playerPed)
                    end
                })
            end
        end)
    else
        exports.ox_inventory:useItem(data, function(data)
            if data then
                TriggerEvent('esx_status:add', 'thirst', 200000)
            end
        end)
    end
end)

exports('fertilizer', function(data, slot)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    
    local closestPot = nil
    local closestIndex = nil
    local closestDistance = 2.0
    
    for i, pot in pairs(placedPots) do
        local distance = #(playerCoords - vector3(pot.x, pot.y, pot.z))
        if distance < closestDistance then
            closestDistance = distance
            closestPot = pot
            closestIndex = i
        end
    end

    if closestPot then
        if closestPot.state == "empty" then
            return
        end
        LoadAnimDict(Config.Animations.Fertilizing.Dictionary)
        exports.ox_inventory:useItem(data, function(data)
            if data then
                exports.rprogress:Custom({
                    Duration = 2000,
                    Label = " ",
                    DisableControls = {
                        Mouse = false,
                        Player = true,
                        Vehicle = true
                    },
                    Animation = {
                        animationDictionary = Config.Animations.Fertilizing.Dictionary,
                        animationName = Config.Animations.Fertilizing.Clip,
                        flag = Config.Animations.Fertilizing.Flag
                    },
                    onComplete = function(cancelled)
                        if not cancelled then
                            local newFertilizerLevel = math.min((closestPot.fertilizerLevel or 0) + 60, 100)
                            placedPots[closestIndex].fertilizerLevel = newFertilizerLevel
                            TriggerServerEvent('kay_drugs:updatePotFertilizer', closestIndex, newFertilizerLevel)
                            if closestPot.scaleform and HasScaleformMovieLoaded(closestPot.scaleform) then
                                SetScaleformMovieAsNoLongerNeeded(closestPot.scaleform)
                                placedPots[closestIndex].scaleform = nil
                            end
                        end
                        
                        ClearPedTasks(playerPed)
                    end
                })
            end
        end)
    else
        ESX.ShowNotification("~r~Pas de pot à proximité")
    end
end)

function IsPlayerPolice()
    local playerData = ESX.GetPlayerData()
    return playerData.job and (playerData.job.name == 'police' or playerData.job.name == 'sheriff')
end

function DrawTextOnScreen(text, x, y, scale, r, g, b, a)
    SetTextFont(4)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end


AddEventHandler('playerSpawned', function()
    TriggerServerEvent('kay_growing:requestPots')
end)

Citizen.CreateThread(function()
    while true do
        Wait(60000) 
        TriggerServerEvent('kay_growing:updateGrowth')
    end
end)

RegisterNetEvent('kay_drugs:policeNotification')
AddEventHandler('kay_drugs:policeNotification', function(coords)
    ESX.ShowAdvancedNotification(
        'Centrale', 
        'Dispatch', 
        Config.NotificationText,
        'CHAR_CALL911',
        1
    )
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, Config.BlipSprite)
    SetBlipColour(blip, Config.BlipColor)
    SetBlipScale(blip, Config.BlipScale)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Zone suspecte")
    EndTextCommandSetBlipName(blip)
    Citizen.SetTimeout(Config.BlipDuration * 1000, function()
        RemoveBlip(blip)
    end)
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

createdPotObjects = {}

function PreloadAllTextures()
    local textureDicts = {"kay_drugs", "kay_weed", "kay_pot"}
    for _, dict in ipairs(textureDicts) do
        if not HasStreamedTextureDictLoaded(dict) then
            RequestStreamedTextureDict(dict)
            local timeout = 5000 
            local startTime = GetGameTimer()
            
            while not HasStreamedTextureDictLoaded(dict) and GetGameTimer() - startTime < timeout do
                Wait(10)
            end
            
            if HasStreamedTextureDictLoaded(dict) then
                print(string.format("^2Dictionnaire %s chargé avec succès^7", dict))
            else
                print(string.format("^1Erreur lors du chargement du dictionnaire %s^7", dict))
            end
        end
    end
    for state, config in pairs(Config.PotStates) do
        if config.texture_dict then
            if not HasStreamedTextureDictLoaded(config.texture_dict) then
                RequestStreamedTextureDict(config.texture_dict)
                Wait(100)
            end
            if state ~= "empty" and config.texture_name then
                for i = 1, 4 do
                    local textureName = config.texture_name .. i
                    if HasStreamedTextureDictLoaded(config.texture_dict) then
                    else
                        print(string.format("^1Impossible de charger la texture %s:%s^7", config.texture_dict, textureName))
                    end
                end
            end
        end
    end
    Citizen.CreateThread(function()
        while true do
            Wait(10000) 
            
            for _, dict in ipairs(textureDicts) do
                if not HasStreamedTextureDictLoaded(dict) then
                    print(string.format("^3Rechargement du dictionnaire %s^7", dict))
                    RequestStreamedTextureDict(dict)
                    Wait(100)
                end
            end
        end
    end)
end
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        local textureDicts = {"kay_drugs", "kay_weed", "kay_pot"}
        
        for _, dict in ipairs(textureDicts) do
            RequestStreamedTextureDict(dict)
            local timeout = 1000
            local startTime = GetGameTimer()
            
            while not HasStreamedTextureDictLoaded(dict) and GetGameTimer() - startTime < timeout do
                Wait(0)
            end
            
            if HasStreamedTextureDictLoaded(dict) then
                print(string.format("^2Dictionnaire %s chargé avec succès^7", dict))
            else
                print(string.format("^1Erreur lors du chargement du dictionnaire %s^7", dict))
            end
        end
        PreloadAllTextures()
        
        placedPots = {}
        lightObjects = {}
        Wait(1000)
        TriggerServerEvent('kay_growing:requestPots')
        TriggerServerEvent('kay_growing:requestLights')
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for _, handle in pairs(createdPotObjects or {}) do
            if DoesEntityExist(handle) then
                DeleteEntity(handle)
            end
        end

        if gtaui and gtaui.activeScaleform then
            gtaui.activeScaleform:release()
        end
    end
end)

exports('purplelight', function(data, slot)
    StartPlacingLight()
end)