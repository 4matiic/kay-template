AddEventHandler('fb:sprite:setImageConfig', function(data)
    SendReactMessage('fb:sprite:setImageConfig', data or {})
end)

AddEventHandler('fb:sprite:showImage', function()
    SendReactMessage('fb:sprite:showImage')
end)

AddEventHandler('fb:sprite:hideImage', function()
    SendReactMessage('fb:sprite:hideImage')
end)

RegisterNetEvent('3dme:shareDisplay', function(text, sourceId)
    local player = GetPlayerFromServerId(sourceId)
    if player == -1 then return end

    local ped = GetPlayerPed(player)
    local displayTime = 5000 

    CreateThread(function()
        local timer = GetGameTimer() + displayTime
        while GetGameTimer() < timer do
            local pedCoords = GetEntityCoords(ped)
            local dist = #(GetEntityCoords(PlayerPedId()) - pedCoords)
            if dist < 250.0 then 
                DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z + 1.0, text)
            end
            Wait(0)
        end
    end)
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px, py, pz) - vector3(x, y, z))

    local scale = (1 / dist) * dmeC.scale * 1.0
    if scale > 0.45 then scale = 0.45 end
    if scale < 0.20 then scale = 0.20 end

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(dmeC.font)
        SetTextProportional(1)
        SetTextColour(dmeC.color.r, dmeC.color.g, dmeC.color.b, dmeC.color.a)
        SetTextCentre(true)
        SetTextOutline()
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(_x, _y)
    end
end

