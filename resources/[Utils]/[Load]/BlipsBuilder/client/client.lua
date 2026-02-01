ESX = exports["framework"]:getSharedObject()


local display = false
local blips = {}
local initialStatesLoaded = false

local function SaveBlipStateToKVP(blipId, isHidden)
    SetResourceKvp('blip_state_' .. blipId, tostring(isHidden))
end

local function LoadBlipStateFromKVP(blipId)
    local state = GetResourceKvpString('blip_state_' .. blipId)
    return state == 'true'
end

local function CloseUI()
    display = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        source = 'blips',
        type = 'setVisible',
        status = false
    })
end

local function CreateBlipForCoord(data)
    local blip = AddBlipForCoord(data.x, data.y, data.z or 0.0)
    local size = tonumber(data.size) or 100
    local opacity = tonumber(data.opacity) or 100
    SetBlipSprite(blip, tonumber(data.type))
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, size / 100.0)
    SetBlipAlpha(blip, math.floor((opacity / 100) * 255))
    SetBlipColour(blip, tonumber(data.color))
    SetBlipAsShortRange(blip, true)

    if data.outlined then
        SetBlipSecondaryColour(blip, 255, 255, 255)
    end

    if data.isCommerce then
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Commerce : " .. data.name)
        EndTextCommandSetBlipName(blip)
    else
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(data.name)
        EndTextCommandSetBlipName(blip)
    end

    return blip
end

local function UpdateAllBlips(blipsData)
    if not blipsData or type(blipsData) ~= 'table' then return end
    
    for _, blip in pairs(blips) do
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end
    blips = {}
    
    local updatedBlips = {}
    for _, blipData in ipairs(blipsData) do
        local isHidden = LoadBlipStateFromKVP(blipData.id)
        if isHidden == nil then
            isHidden = blipData.hidden
            SaveBlipStateToKVP(blipData.id, isHidden)
        end
        
        local updatedBlip = json.decode(json.encode(blipData))
        updatedBlip.hidden = isHidden
        table.insert(updatedBlips, updatedBlip)
        
        if not isHidden then
            Citizen.Wait(0)
            blips[blipData.id] = CreateBlipForCoord(blipData)
        end
    end
    
    Citizen.Wait(0)
    SendNUIMessage({
        source = 'blips',
        type = 'updateBlips',
        blips = updatedBlips
    })
end

RegisterCommand('blips', function()
    if display then
        CloseUI()
    else
        TriggerServerEvent('blips:checkPermission')
        TriggerServerEvent('blips:requestBlips')
    end
end)

RegisterNetEvent('blips:openUI')
AddEventHandler('blips:openUI', function()
    if not display then
        display = true
        SetNuiFocus(true, true)
        SendNUIMessage({
            source = 'blips',
            type = 'setVisible',
            status = true
        })
    end
end)

RegisterNUICallback('getPosition', function(data, cb)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    cb({
        x = coords.x,
        y = coords.y
    })
end)

RegisterNUICallback('saveBlip', function(data, cb)
    SaveBlipStateToKVP(data.settings.id, data.settings.hidden)
    TriggerServerEvent('blips:saveBlip', data.settings)
    cb({success = true})
end)

RegisterNUICallback('deleteBlip', function(data, cb)
    TriggerServerEvent('blips:deleteBlip', data.id)
    if blips[data.id] then
        RemoveBlip(blips[data.id])
        blips[data.id] = nil
    end
    DeleteResourceKvp('blip_state_' .. data.id)
    cb({success = true})
end)

RegisterNUICallback('toggleBlipVisibility', function(data, cb)
    local currentState = LoadBlipStateFromKVP(data.id)
    local newState = not currentState
    
    SaveBlipStateToKVP(data.id, newState)
    
    if blips[data.id] then
        RemoveBlip(blips[data.id])
        blips[data.id] = nil
    end
    
    if not newState then
        Citizen.Wait(0)
        SendNUIMessage({
            source = 'blips',
            type = 'updateBlipVisibility',
            blipId = data.id,
            hidden = newState
        })
        
        TriggerServerEvent('blips:toggleVisibility', data.id)
    else
        TriggerServerEvent('blips:toggleVisibility', data.id)
        SendNUIMessage({
            source = 'blips',
            type = 'updateBlipVisibility',
            blipId = data.id,
            hidden = newState
        })
    end
    
    cb({success = true})
end)

RegisterNetEvent('blips:visibilityUpdated')
AddEventHandler('blips:visibilityUpdated', function(blipId, isHidden)
    SaveBlipStateToKVP(blipId, isHidden)
    
    SendNUIMessage({
        source = 'blips',
        type = 'updateBlipVisibility',
        blipId = blipId,
        hidden = isHidden
    })

    if not isHidden then
        Citizen.Wait(0)
        TriggerServerEvent('blips:requestSingleBlip', blipId)
    end
end)

RegisterNetEvent('blips:receiveSingleBlip')
AddEventHandler('blips:receiveSingleBlip', function(blipData)
    if blipData then
        local isHidden = LoadBlipStateFromKVP(blipData.id)
        if isHidden == nil then
            isHidden = blipData.hidden
            SaveBlipStateToKVP(blipData.id, isHidden)
        end
        
        if not isHidden then
            if blips[blipData.id] and DoesBlipExist(blips[blipData.id]) then
                RemoveBlip(blips[blipData.id])
            end
            blips[blipData.id] = CreateBlipForCoord(blipData)
        end
    end
end)

RegisterNUICallback('exit', function(data, cb)
    display = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        source = 'blips',
        type = 'setVisible',
        status = false
    })
    cb({})
end)

RegisterNetEvent('blips:updateBlips')
AddEventHandler('blips:updateBlips', function(blipsData)
    if blipsData then
        UpdateAllBlips(blipsData)
    end
end)

RegisterNetEvent('blips:showMapNotification')
AddEventHandler('blips:showMapNotification', function()
    SendNUIMessage({
        source = 'blips',
        type = 'showNotification'
    })
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if display then
            if IsControlJustReleased(0, 177) then
                CloseUI()
            end
            DisableControlAction(0, 1, true)
            DisableControlAction(0, 2, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 18, true)
            DisableControlAction(0, 322, true)
            DisableControlAction(0, 106, true)
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        if display then
            CloseUI()
        end
    end
end)

AddEventHandler('onClientResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    TriggerServerEvent('blips:requestBlips')
end)