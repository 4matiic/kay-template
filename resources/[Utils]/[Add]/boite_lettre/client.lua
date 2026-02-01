ESX = exports["framework"]:getSharedObject()

local boxes = {
    vector3(-1019.2432, 504.0881, 79.4119),
    vector3(-956.4469, 460.8245, 79.8110),
    vector3(-999.4105, 512.5085, 79.5860),
    vector3(-1010.2391, 497.4715, 79.5787),
    vector3(-1078.3291, 427.8975, 72.2083),
    vector3(-1128.6362, 555.4545, 102.0148),
    vector3(950.8717, -475.2882, 61.1820),
    vector3(976.1749, -458.4592, 62.7467),
    vector3(999.7284, -440.7775, 64.0948),
    vector3(924.2045, -514.9076, 58.9600),
    vector3(940.9622, -506.7697, 59.9211),
    vector3(1014.7456, -458.2024, 64.1710),
    vector3(1032.2129, -416.0236, 65.9412),
    vector3(1068.2727, -384.9712, 67.1504),
    vector3(1094.3859, -415.6041, 67.1289),
    vector3(1089.4083, -449.7021, 65.7166),
    vector3(1086.5450, -463.9856, 64.9487),
    vector3(1082.6144, -485.2245, 63.7852),
    vector3(1251.2751, -566.7633, 69.1055),
    vector3(1256.3713, -598.4510, 69.0072),
    vector3(1262.1681, -614.3405, 68.8831),
    vector3(1275.0874, -636.2177, 68.5416),

}

local isLockpicking = false

Citizen.CreateThread(function()
    while true do
        local waitTime = 500
        local playerPed = PlayerPedId()
        local pCoords   = GetEntityCoords(playerPed)

        for _, boxCoords in ipairs(boxes) do
            local dist = #(pCoords - boxCoords)
            if dist < 2.5 then
                waitTime = 0
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour braquer la boîte aux lettres")
                if IsControlJustReleased(0, 38) and not isLockpicking then
                    isLockpicking = true

                    Citizen.CreateThread(function()
                        local success = exports['lockpick']:startLockpick(3)

                        if success then
                            TriggerServerEvent('boite:reward')
                        else
                            ESX.ShowNotification('Échec du crochetage.')
                        end

                        isLockpicking = false
                    end)
                end
                break
            end
        end

        Citizen.Wait(waitTime)
    end
end)