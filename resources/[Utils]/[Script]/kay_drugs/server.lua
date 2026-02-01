local placedPots = {}
local placedLights = {}
local ox_inventory = exports.ox_inventory

ESX = ESX or nil

CreateThread(function()
    while not ESX do
        pcall(function() ESX = exports["framework"]:getSharedObject() end)
        Wait(100)
    end
end)


AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        MySQL.Async.execute([[
            CREATE TABLE IF NOT EXISTS placed_pots (
                id INT AUTO_INCREMENT,
                owner VARCHAR(60) NOT NULL,
                x FLOAT NOT NULL,
                y FLOAT NOT NULL,
                z FLOAT NOT NULL,
                heading FLOAT DEFAULT 0.0,
                model VARCHAR(255),
                plantTime INT NOT NULL,
                waterLevel FLOAT DEFAULT 0,
                lightLevel FLOAT DEFAULT 0,
                fertilizerLevel FLOAT DEFAULT 0,
                growth FLOAT DEFAULT 0,
                stage INT DEFAULT 1,
                state VARCHAR(50) DEFAULT 'empty',
                PRIMARY KEY (id)
            );
        ]], {}, function()
            LoadPotsFromDatabase()
        end)
        MySQL.Async.execute([[
            CREATE TABLE IF NOT EXISTS placed_lights (
                id VARCHAR(60) PRIMARY KEY,
                x FLOAT NOT NULL,
                y FLOAT NOT NULL,
                z FLOAT NOT NULL,
                heading FLOAT DEFAULT 0.0
            );
        ]], {}, function()
            LoadLightsFromDatabase()
        end)
    end
end)

function NotifyPolice(coords)
    if not Config.EnablePoliceNotification then return end
    if math.random(100) > Config.PoliceNotificationChance then return end
    local offsetX = math.random(-Config.NotificationCoordOffset, Config.NotificationCoordOffset)
    local offsetY = math.random(-Config.NotificationCoordOffset, Config.NotificationCoordOffset)
    local blipCoords = vector3(coords.x + offsetX, coords.y + offsetY, coords.z)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer and table.indexOf(Config.PoliceJobs, xPlayer.job.name) then
            TriggerClientEvent('kay_drugs:policeNotification', xPlayer.source, blipCoords)
        end
    end
end

RegisterNetEvent('kay_drugs:confiscatePot')
AddEventHandler('kay_drugs:confiscatePot', function(potIndex)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or (xPlayer.job.name ~= 'police' and xPlayer.job.name ~= 'sheriff') then
        return
    end
    
    if not placedPots[potIndex] then
        return
    end
    exports.ox_inventory:AddItem(source, 'flowerpot', 1)
    local pot = placedPots[potIndex]
    if pot.state ~= "empty" and pot.stage >= 2 then
        local itemToAdd = 'weed'
        if pot.state == "coke" then
            itemToAdd = 'crack'
        end
        
        local amount = math.ceil(pot.stage / 2) 
        exports.ox_inventory:AddItem(source, itemToAdd, amount)
    else
        TriggerClientEvent('esx:showNotification', source, "~g~Vous avez confisqué un pot vide")
    end

    MySQL.Async.execute('DELETE FROM placed_pots WHERE id = @id', {
        ['@id'] = potIndex
    })

    placedPots[potIndex] = nil

    TriggerClientEvent('kay_growing:syncPots', -1, placedPots)
end)

RegisterNetEvent('kay_drugs:plantSeed', function(potIndex, data)
    local source = source
    if placedPots[potIndex] then
        placedPots[potIndex].state = data.state
        placedPots[potIndex].stage = data.stage
        placedPots[potIndex].plantTime = data.plantTime
        placedPots[potIndex].waterLevel = data.waterLevel
        placedPots[potIndex].lightLevel = data.lightLevel
        placedPots[potIndex].fertilizerLevel = data.fertilizerLevel
        placedPots[potIndex].growth = data.growth
        MySQL.Async.execute([[
            UPDATE placed_pots SET 
                state = @state, 
                stage = @stage, 
                plantTime = @plantTime, 
                waterLevel = @waterLevel, 
                lightLevel = @lightLevel, 
                fertilizerLevel = @fertilizerLevel, 
                growth = @growth 
            WHERE id = @id
        ]], {
            ['@id'] = potIndex,
            ['@state'] = data.state,
            ['@stage'] = data.stage,
            ['@plantTime'] = data.plantTime,
            ['@waterLevel'] = data.waterLevel,
            ['@lightLevel'] = data.lightLevel,
            ['@fertilizerLevel'] = data.fertilizerLevel,
            ['@growth'] = data.growth
        })
        TriggerClientEvent('kay_drugs:syncPot', -1, potIndex, placedPots[potIndex])
    end
end)

RegisterNetEvent('kay_growing:deleteLight', function(lightId)
    if placedLights[lightId] then
        placedLights[lightId] = nil
        TriggerClientEvent('kay_growing:syncLights', -1, placedLights)
        MySQL.Async.execute('DELETE FROM placed_lights WHERE id = @id', {
            ['@id'] = lightId
        })
    end
end)
RegisterNetEvent('kay_growing:pickupLight', function(lightId)
    local src = source
    
    if placedLights[lightId] then
        exports.ox_inventory:AddItem(src, 'purplelight', 1)
        placedLights[lightId] = nil
        TriggerClientEvent('kay_growing:syncLights', -1, placedLights)
        MySQL.Async.execute('DELETE FROM placed_lights WHERE id = @id', {
            ['@id'] = lightId
        })
        TriggerClientEvent('esx:showNotification', src, "~g~Vous avez ramassé une lumière violette")
    end
end)



function LoadLightsFromDatabase()
    MySQL.Async.fetchAll('SELECT * FROM placed_lights', {}, function(results)
        placedLights = {} 
        
        if results and #results > 0 then
            for _, light in pairs(results) do
                placedLights[light.id] = {
                    x = tonumber(light.x),
                    y = tonumber(light.y),
                    z = tonumber(light.z),
                    heading = tonumber(light.heading) or 0.0
                }
            end
        end
        TriggerClientEvent('kay_growing:syncLights', -1, placedLights)
    end)
end

RegisterNetEvent('kay_growing:placeLight', function(lightData)
    local src = source
    local hasItem = exports.ox_inventory:GetItem(src, 'purplelight', nil, true) > 0
    
    if hasItem then
        exports.ox_inventory:RemoveItem(src, 'purplelight', 1)
        if not lightData.id then
            lightData.id = "light_" .. math.random(100000, 999999)
        end
        placedLights[lightData.id] = {
            x = lightData.x,
            y = lightData.y,
            z = lightData.z,
            heading = lightData.heading
        }
        TriggerClientEvent('kay_growing:syncLights', -1, placedLights)
        MySQL.Async.execute('INSERT INTO placed_lights (id, x, y, z, heading) VALUES (@id, @x, @y, @z, @heading) ON DUPLICATE KEY UPDATE x = @x, y = @y, z = @z, heading = @heading', {
            ['@id'] = lightData.id,
            ['@x'] = lightData.x,
            ['@y'] = lightData.y,
            ['@z'] = lightData.z,
            ['@heading'] = lightData.heading
        })
    else
        TriggerClientEvent('esx:showNotification', src, "~r~Vous n'avez pas de lumière dans votre inventaire")
    end
end)

RegisterNetEvent('kay_growing:requestLights', function()
    local src = source
    TriggerClientEvent('kay_growing:syncLights', src, placedLights)
end)

RegisterNetEvent('kay_drugs:updatePotLight', function(potIndex, newLightLevel)
    if placedPots[potIndex] then
        newLightLevel = math.max(0, math.min(100, newLightLevel))
        
        placedPots[potIndex].lightLevel = newLightLevel
        MySQL.Async.execute('UPDATE placed_pots SET lightLevel = @level WHERE id = @id', {
            ['@level'] = newLightLevel,
            ['@id'] = potIndex
        })
        TriggerClientEvent('kay_drugs:syncPot', -1, potIndex, placedPots[potIndex])
    end
end)

function SavePotsToDatabase()
    for id, pot in pairs(placedPots) do
        MySQL.Async.execute('INSERT INTO placed_pots (id, owner, x, y, z, heading, model, plantTime, waterLevel, lightLevel, fertilizerLevel, growth, stage) VALUES (@id, @owner, @x, @y, @z, @heading, @model, @plantTime, @waterLevel, @lightLevel, @fertilizerLevel, @growth, @stage) ON DUPLICATE KEY UPDATE waterLevel = @waterLevel, lightLevel = @lightLevel, fertilizerLevel = @fertilizerLevel, growth = @growth, stage = @stage', {
            ['@id'] = id,
            ['@owner'] = pot.owner,
            ['@x'] = pot.x,
            ['@y'] = pot.y,
            ['@z'] = pot.z,
            ['@heading'] = pot.heading,
            ['@model'] = pot.model,
            ['@plantTime'] = pot.plantTime,
            ['@waterLevel'] = pot.waterLevel or 0,
            ['@lightLevel'] = pot.lightLevel or 0,
            ['@fertilizerLevel'] = pot.fertilizerLevel or 0,
            ['@growth'] = pot.growth or 0,
            ['@stage'] = pot.stage or 1
        })
    end
end

RegisterNetEvent('kay_drugs:updatePotWater')
AddEventHandler('kay_drugs:updatePotWater', function(potIndex, newWaterLevel)
    local source = source
    
    if placedPots[potIndex] then
        placedPots[potIndex].waterLevel = newWaterLevel
        MySQL.Async.execute('UPDATE placed_pots SET waterLevel = @water WHERE id = @id', {
            ['@water'] = newWaterLevel,
            ['@id'] = potIndex
        })
        TriggerClientEvent('kay_drugs:syncPot', -1, potIndex, placedPots[potIndex])
    end
end)

RegisterNetEvent('kay_drugs:tryHarvest')
AddEventHandler('kay_drugs:tryHarvest', function(potIndex)
    local source = source
    local pot = placedPots[potIndex]
    
    if pot then
        if pot.stage >= 3 then
            local potState = Config.PotStates[pot.state]
            local rewardConfig = potState.rewards[pot.stage]
            
            if rewardConfig then
                local canCarry = exports.ox_inventory:CanCarryItem(source, rewardConfig.item, rewardConfig.max)
                
                if canCarry then
                    local amount = math.random(rewardConfig.min, rewardConfig.max)
                    if exports.ox_inventory:AddItem(source, rewardConfig.item, amount) then
                        MySQL.Async.execute('DELETE FROM placed_pots WHERE id = @id', {
                            ['@id'] = potIndex
                        })
                        placedPots[potIndex] = nil
                        TriggerClientEvent('kay_growing:syncPots', -1, placedPots)
                        TriggerClientEvent('esx:showNotification', source, string.format("~g~Vous avez récolté %d %s", amount, rewardConfig.item))
                    end
                else
                    TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez de place dans votre inventaire")
                end
            end
        end
    end
end)

RegisterNetEvent('kay_drugs:updatePotFertilizer')
AddEventHandler('kay_drugs:updatePotFertilizer', function(potIndex, newLevel)
    if placedPots[potIndex] then
        placedPots[potIndex].fertilizerLevel = newLevel
        MySQL.Async.execute('UPDATE placed_pots SET fertilizerLevel = @level WHERE id = @id', {
            ['@level'] = newLevel,
            ['@id'] = potIndex
        })
        TriggerClientEvent('kay_drugs:syncPot', -1, potIndex, placedPots[potIndex])
    end
end)

function LoadPotsFromDatabase()
    MySQL.Async.fetchAll('SELECT * FROM placed_pots', {}, function(results)
        placedPots = {}
        
        if results and #results > 0 then
            for _, pot in pairs(results) do
                placedPots[pot.id] = {
                    owner = pot.owner,
                    x = tonumber(pot.x),
                    y = tonumber(pot.y),
                    z = tonumber(pot.z),
                    heading = tonumber(pot.heading) or 0.0,
                    model = pot.model or "bkr_prop_weed_01_small_01c",
                    plantTime = tonumber(pot.plantTime),
                    waterLevel = tonumber(pot.waterLevel) or 0,
                    lightLevel = tonumber(pot.lightLevel) or 0,
                    fertilizerLevel = tonumber(pot.fertilizerLevel) or 0,
                    growth = tonumber(pot.growth) or 0,
                    stage = tonumber(pot.stage) or 1,
                    state = pot.state or "empty"  
                }
            end
        end
        TriggerClientEvent('kay_growing:syncPots', -1, placedPots)
    end)
end

RegisterNetEvent('kay_growing:placePot', function(potData)
    local src = source
    local identifier = GetPlayerIdentifier(src, 0)
    local maxPots = Config.MaxPots or 20 

    local hasItem = exports.ox_inventory:GetItem(src, 'flowerpot', nil, true) > 0
    
    if hasItem then
        local playerPotCount = 0
        for _, pot in pairs(placedPots) do
            if pot.owner == identifier then
                playerPotCount = playerPotCount + 1
            end
        end
        
        if playerPotCount >= maxPots then
            TriggerClientEvent('kay_growing:placePotResponse', src, false, "~r~Vous avez atteint votre limite de " .. maxPots .. " pots")
            return
        end

        exports.ox_inventory:RemoveItem(src, 'flowerpot', 1)
        local potId = #placedPots + 1

        if type(Config.PotModel) == "number" then
            potData.model = tostring(Config.PotModel)
        else
            potData.model = Config.PotModel
        end
        
        potData.owner = identifier 
        potData.waterLevel = 0
        potData.lightLevel = 0
        potData.fertilizerLevel = 0
        potData.growth = 0  
        potData.stage = 1   
        potData.plantTime = GetGameTimer()
        
        placedPots[potId] = potData
        
        TriggerClientEvent('kay_growing:syncPots', -1, placedPots)
        SavePotsToDatabase()
        TriggerClientEvent('kay_growing:placePotResponse', src, true, "")
    else
        TriggerClientEvent('kay_growing:placePotResponse', src, false, "~r~Vous n'avez pas de pot de fleurs dans votre inventaire")
    end
end)

RegisterNetEvent('kay_growing:requestPots', function()
    local src = source
    TriggerClientEvent('kay_growing:syncPots', src, placedPots)
end)
function table.count(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end

RegisterNetEvent('kay_growing:updateGrowth')
AddEventHandler('kay_growing:updateGrowth', function()
    local currentTime = os.time() * 1000 
    
    for i, pot in pairs(placedPots) do
        if pot.waterLevel >= Config.GrowthStages[pot.stage or 1].minWater 
        and pot.lightLevel >= Config.GrowthStages[pot.stage or 1].minLight 
        and pot.fertilizerLevel >= Config.GrowthStages[pot.stage or 1].minFertilizer 
        and pot.state ~= "empty" then
            local elapsedTime = currentTime - (pot.plantTime or 0)
            local currentStage = pot.stage or 1
            if newStage == 3 then
                NotifyPolice(vector3(pot.x, pot.y, pot.z))
            end

            if elapsedTime >= Config.GrowthStages[currentStage].duration then
                local newStage = currentStage + 1
                if newStage <= 4 then
                    pot.stage = newStage
                    pot.plantTime = currentTime

                    if pot.state == "weed" then
                        if newStage == 2 then
                            pot.model = `bkr_prop_weed_01_small_01b`
                        elseif newStage == 3 then
                            pot.model = `bkr_prop_weed_med_01a`
                        elseif newStage == 4 then
                            pot.model = `bkr_prop_weed_lrg_01a`
                        end
                    elseif pot.state == "coke" then
                        if newStage == 2 then
                            pot.model = `bkr_prop_weed_01_small_01b`
                        elseif newStage == 3 then
                            pot.model = `bkr_prop_weed_med_01b`
                        elseif newStage == 4 then
                            pot.model = `bkr_prop_weed_lrg_01b`
                        end
                    end

                    MySQL.Async.execute('UPDATE placed_pots SET stage = @stage, plantTime = @plantTime, model = @model WHERE id = @id', {
                        ['@stage'] = newStage,
                        ['@plantTime'] = currentTime,
                        ['@model'] = pot.model,
                        ['@id'] = i
                    })

                    TriggerClientEvent('kay_drugs:syncPot', -1, i, pot)
                end
            end
        end
    end
end)