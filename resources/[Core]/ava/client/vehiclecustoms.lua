local Customizing = nil

RegisterNUICallback('VehicleCustoms:GetMax', function(data, cb)
    local vehicle = NetworkGetEntityFromNetworkId(Customizing)
    if not DoesEntityExist(vehicle) then return cb({}) end
    SetVehicleModKit(vehicle, 0)

    local maxValues = {}
    for i=0,50 do
        maxValues[i] = GetNumVehicleMods(vehicle, i) - 1
        if i == 48 then
            local liv = GetVehicleLiveryCount(vehicle) - 1
            if liv > 0 then
                maxValues[i] = liv
            end
        end
    end

    cb(maxValues)
end)

local honking = false
RegisterNUICallback('VehicleCustoms:Honk', function(data, cb)
    honking = data.honking

    CreateThread(function()
        while honking do
            SetControlNormal(0, 86, 1.0)
            Wait(0)
        end
    end)

    cb('ok')
end)

local smoking = false
RegisterNUICallback('VehicleCustoms:WheelSmoke', function(data, cb)
    smoking = data.smoking

    CreateThread(function()
        local lastReleased = GetGameTimer()
        while smoking do
            SetControlNormal(0, 72, 1.0)
            SetControlNormal(0, 71, 1.0)

            if GetGameTimer() - lastReleased > 5000 then
                SetControlNormal(0, 72, 0.0)
                SetControlNormal(0, 71, 0.0)
                Wait(1000)
                lastReleased = GetGameTimer()
            end
            Wait(0)
        end
    end)

    cb('ok')
end)

RegisterNUICallback('VehicleCustoms:Close', function(data, cb)
    if data?.confirm then
        TriggerServerEvent('fb:vehiclecustom:confirm', data.properties, data.price)
    else
        TriggerServerEvent('fb:vehiclecustom:cancel')
    end
    Customizing = nil
    cb('ok')
end)

local applyRemote = nil
RegisterNUICallback('VehicleCustoms:Apply', function(data, cb)
    if not Customizing then return cb('ok') end

    data.rotation = nil
    data.brokenWindows = nil
    data.brokenDoors = nil
    data.tyreBurst = nil
    data.tyreBurstCompletly = nil
    data.tyreRepaired = nil
    data.deformationPoints = nil
    data.enveff = nil
    data.dirtLevel = nil
    data.tyresHealth = nil

    if NetworkHasControlOfNetworkId(Customizing) then
        if not FB then return cb('ok') end
        ESX.Game.SetVehicleProperties(NetworkGetEntityFromNetworkId(Customizing), data)
    else
        if applyRemote then ClearTimeout(applyRemote) end
        applyRemote = SetTimeout(200, function()
            applyRemote = nil
            TriggerServerEvent('fb:vehiclecustom:edit', data)
        end)
    end
    cb('ok')
end)

RegisterNetEvent('ava:vehiclecustoms:open', function(customType, vehicleNetId, properties, prices)
    Customizing = vehicleNetId
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
    if not DoesEntityExist(vehicle) then return end
    AddNuiFocus('vehiclecustoms')
    AddNuiFocusKeepInput('vehiclecustoms')

    SendReactMessage('VehicleCustoms:SetVehicleProperties', {
        properties = properties,
        vehicleModel = GetEntityArchetypeName(vehicle),
        prices = prices or {},
        customType = customType,
    })

    SetVehicleDirtLevel(vehicle, 0.0)

    CreateThread(function()
        local pressing = false
        while Customizing do
            local x, y = GetNuiCursorPosition()
            local resX, resY = GetActiveScreenResolution()

            x = x / resX
            y = y / resY

            local allowZone = 0.02
            local isInsideNui = x < 0.31

            if not isInsideNui and IsDisabledControlJustPressed(0, 24) then
                pressing = true
            end

            if IsDisabledControlJustReleased(0, 24) then
                pressing = false
            end

            if not pressing and x < (1 - allowZone) and x > allowZone and y < (1 - allowZone) and y > allowZone then
                DisableControlAction(0, 1, true)
                DisableControlAction(0, 2, true)
            end

            DisableControlAction(0, 12, true)
            DisableControlAction(0, 13, true)
            DisableControlAction(0, 14, true)
            DisableControlAction(0, 15, true)
            DisableControlAction(0, 16, true)
            DisableControlAction(0, 17, true)
            DisableControlAction(0, 21, true)
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 23, true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 30, true)
            DisableControlAction(0, 31, true)
            DisableControlAction(0, 32, true)
            DisableControlAction(0, 33, true)
            DisableControlAction(0, 34, true)
            DisableControlAction(0, 35, true)
            DisableControlAction(0, 36, true)
            DisableControlAction(0, 37, true)
            DisableControlAction(0, 38, true)
            DisableControlAction(0, 44, true)
            DisableControlAction(0, 45, true)
            DisableControlAction(0, 47, true)
            DisableControlAction(0, 50, true)
            DisableControlAction(0, 55, true)
            DisableControlAction(0, 59, true)
            DisableControlAction(0, 60, true)
            DisableControlAction(0, 61, true)
            DisableControlAction(0, 62, true)
            DisableControlAction(0, 63, true)
            DisableControlAction(0, 64, true)
            DisableControlAction(0, 65, true)
            DisableControlAction(0, 69, true)
            if not smoking then
                DisableControlAction(0, 71, true)
                DisableControlAction(0, 72, true)
            end
			DisableControlAction(0, 75, true)
			DisableControlAction(0, 76, true)
			DisableControlAction(0, 81, true)
			DisableControlAction(0, 82, true)
			DisableControlAction(0, 91, true)
			DisableControlAction(0, 92, true)
			DisableControlAction(0, 99, true)
			DisableControlAction(0, 106, true)
			DisableControlAction(0, 114, true)
			DisableControlAction(0, 115, true)
			DisableControlAction(0, 121, true)
			DisableControlAction(0, 122, true)
			DisableControlAction(0, 135, true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 199, true)
			DisableControlAction(0, 200, true)
            DisableControlAction(0, 245, true)
			DisableControlAction(0, 246, true)
			DisableControlAction(0, 257, true)

            Wait(0)
        end

        RemoveNuiFocus('vehiclecustoms')
        RemoveNuiFocusKeepInput('vehiclecustoms')
    end)
end)

RegisterNetEvent('ava:vehiclecustoms:close', function()
    Customizing = nil
    SendReactMessage('VehicleCustoms:Close', {})
end)

AddEventHandler('ava:restartui', function()
    if not Customizing then return end
    Customizing = nil
    TriggerServerEvent('fb:vehiclecustom:cancel')
end)