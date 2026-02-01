ESX = nil
local isDead = false
local deathTime = 0
local deathCause = 'unknown'
local playerCoords = nil
local isMinimized = true
local hasCalledEMS = false
local hasProvidedDetails = false
local PlayerLoaded = false

CreateThread(function()
    while ESX == nil do
        ESX = exports["framework"]:getSharedObject()
        Wait(0)
    end

    while ESX.GetPlayerData().identifier == nil do 
        Wait(10)
    end

    PlayerLoaded = true
    PlayerData = ESX.GetPlayerData()

    ESX.TriggerServerCallback('death:getDeathStatus', function(dead)
        if dead then
            TriggerEvent('death:applyDeath')
        end
    end)
end)

CreateThread(function()
    while true do
        Wait(1000)
        if isDead and deathTime > 0 then
            deathTime = deathTime - 1
            SendNUIMessage({
                source = 'deathscreen',
                type = 'updateTimer',
                time = deathTime
            })
            
            if deathTime == 0 then
                TriggerServerEvent('death:timerEnded')
            end
        end
    end
end)

CreateThread(function()
    while true do
        if isDead then
            Wait(0)
            DisableAllControlActions(0)
            EnableControlAction(0, 1, true)     -- Camera horizontale
            EnableControlAction(0, 2, true)     -- Camera verticale
            EnableControlAction(0, 47, true)    -- G
            EnableControlAction(0, 246, true)   -- Y
            EnableControlAction(0, 249, true)   -- N
            EnableControlAction(0, 245, true)   -- T
            EnableControlAction(0, 0, true)     -- V
            EnableControlAction(0, 22, true)    -- ESPACE
            
            if IsControlJustPressed(0, 22) then 
                isMinimized = not isMinimized
                SendNUIMessage({
                    source = 'deathscreen',
                    type = 'setMinimized',
                    value = isMinimized,
                    forceUpdate = true
                })
            end

            if IsControlJustPressed(0, 47) then 
                if not isMinimized and not hasCalledEMS then
                    SendNUIMessage({
                        source = 'deathscreen',
                        type = 'callEMS'
                    })
                end
            end

            if IsControlJustPressed(0, 246) then
                if not isMinimized and not hasProvidedDetails then
                    SendNUIMessage({
                        source = 'deathscreen',
                        type = 'detailsInput'
                    })
                end
            end
            
            SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
        else
            Wait(1000)
        end
    end
end)

local function ResetDeathSystem()
    isDead = false
    deathTime = 0
    isMinimized = true
    hasCalledEMS = false
    hasProvidedDetails = false
    
    SendNUIMessage({
        source = 'deathscreen',
        type = 'fullReset',
        data = {
            visible = false,
            minimized = true,
            time = 0,
            buttonsState = {
                ems = false,
                details = false
            }
        }
    })
end

AddEventHandler('esx:onPlayerDeath', function(data)
    if not PlayerLoaded then return end

    if isDead then
        ResetDeathSystem()
        Wait(100)
    end
    
    isDead = true
    isMinimized = true
    hasCalledEMS = false
    hasProvidedDetails = false
    playerCoords = GetEntityCoords(PlayerPedId())
    deathTime = Config.Settings.DeathTime
    deathCause = GetDeathReason()
    
    SendNUIMessage({
        source = 'deathscreen',
        type = 'fullReset',
        data = {
            visible = true,
            minimized = true,
            time = Config.Settings.DeathTime,
            buttonsState = {
                ems = false,
                details = false
            }
        }
    })
    
    TriggerServerEvent('death:playerDied', deathCause, playerCoords)
end)

RegisterNetEvent('death:applyDeath')
AddEventHandler('death:applyDeath', function()
    while not PlayerLoaded do Wait(100) end

    isDead = true
    deathTime = Config.Settings.DeathTime
    isMinimized = true
    hasCalledEMS = false
    hasProvidedDetails = false
    
    SendNUIMessage({
        source = 'deathscreen',
        type = 'fullReset',
        data = {
            visible = true,
            minimized = true,
            time = Config.Settings.DeathTime,
            buttonsState = {
                ems = false,
                details = false
            }
        }
    })
end)

RegisterNetEvent('death:revivePlayer')
AddEventHandler('death:revivePlayer', function(useSpawnPoint)
    while not PlayerLoaded do Wait(100) end

    DoScreenFadeOut(1000)
    Wait(1000)

    local playerPed = PlayerPedId()
    local coords
    local heading
    
    if useSpawnPoint then
        coords = Config.Settings.SpawnPoint.coords
        heading = Config.Settings.SpawnPoint.heading
    else
        coords = GetEntityCoords(playerPed)
        heading = GetEntityHeading(playerPed)
    end
    
    ResetDeathSystem()
    
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
    SetEntityHealth(playerPed, 200)
    ClearPedBloodDamage(playerPed)
    ClearPedTasksImmediately(playerPed)
    SetPlayerInvincible(PlayerId(), false)
    ClearPedSecondaryTask(playerPed)
    SetPedCanRagdoll(playerPed, true)

    if useSpawnPoint then
        SetEntityCoords(playerPed, coords.x, coords.y, coords.z, false, false, false, false)
        SetEntityHeading(playerPed, heading)
    end

    LocalPlayer.state:set('dead', false, true)
    TriggerEvent('esx:onPlayerSpawn')
    ESX.PlayerData.dead = false
    TriggerEvent('ox_inventory:updateInventory')
    
    TriggerServerEvent('death:playerRevived')
    Wait(1000)
    DoScreenFadeIn(1000)
end)

RegisterNUICallback('callEMS', function(data, cb)
    if isDead and not hasCalledEMS then
        hasCalledEMS = true
        TriggerServerEvent('death:requestEMS', {
            coords = playerCoords,
            reason = deathCause
        })
        
        SendNUIMessage({
            source = 'deathscreen',
            type = 'updateEMSButton',
            disabled = true
        })
    end
    cb({})
end)

RegisterNUICallback('detailsInput', function(data, cb)
    if isDead and not hasProvidedDetails then
        hasProvidedDetails = true
        TriggerServerEvent('death:sendDetails', {
            coords = playerCoords,
            details = data.details or "Aucun détail fourni"
        })
        
        SendNUIMessage({
            source = 'deathscreen',
            type = 'updateDetailsButton',
            disabled = true
        })
    end
    cb({})
end)

function GetDeathReason()
    local ped = PlayerPedId()
    
    if HasEntityBeenDamagedByWeapon(ped, 0, 2) then
        return 'weapon'
    elseif IsPedInAnyVehicle(ped, false) then
        return 'accident'
    elseif IsEntityInWater(ped) then
        return 'drown'
    elseif GetEntityHeightAboveGround(ped) > 4.0 then
        return 'fall'
    end
    
    return 'unknown'
end

RegisterNetEvent('death:setWaypoint')
AddEventHandler('death:setWaypoint', function(coords)
    SetNewWaypoint(coords.x, coords.y)
end)

RegisterNetEvent('death:doctorNotification')
AddEventHandler('death:doctorNotification', function(message)
    if isDead then
        SendNUIMessage({
            source = 'deathscreen',
            type = 'showDoctor',
            value = true,
            message = message
        })
    end
end)

exports('isDead', function()
    return isDead
end)

exports('revivePlayer', function()
    TriggerEvent('death:revivePlayer', false)
end)