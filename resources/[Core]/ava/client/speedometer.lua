if IS_RDR2 then return end
local showHud = true
local currentHud = false

function HideSpeedometer(_showHud)
    showHud = not _showHud
end



CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed)

        if vehicle > 0 and showHud and GetPedInVehicleSeat(vehicle, -1) == playerPed then
            local fuelLevel = GetVehicleFuelLevel(vehicle) or 0
            local maxInTank = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fPetrolTankVolume')

            if fuelLevel > maxInTank then fuelLevel = maxInTank end

            currentHud = true
            SendReactMessage('setSpeedometer', {
                km = showKM,
                fuel = maxInTank ~= 0 and math.ceil((fuelLevel / maxInTank) * 100) or nil,
                speed = math.ceil(GetEntitySpeed(vehicle) * 3.6)
            })
        else
            if currentHud then
                currentHud = false
                SendReactMessage('setSpeedometer', nil)
            end
            Wait(1000)
        end

        Wait(100)
    end
end)