RegisterNetEvent('useAmmoBox')
AddEventHandler('useAmmoBox', function(boxItem)
    local playerPed = PlayerPedId()

    RequestAnimDict("mp_arresting")
    while not HasAnimDictLoaded("mp_arresting") do
        Wait(0)
    end

    TaskPlayAnim(playerPed, "mp_arresting", "a_uncuff", 8.0, -8.0, 5000, 48, 0, false, false, false)

    exports.rprogress:Custom({
        Duration = 5000,
        Label = "Ouverture en cours....",
        DisableControls = { Mouse = false, Player = false, Vehicle = true },
        Position = "bottomCenter",
        Animation = { type = "linear", direction = "right" },
        Width = 400,
        Height = 40,
        Radius = 58 -- Taille du rond progress
    })

    Citizen.Wait(5000)
    ClearPedTasks(playerPed)
    TriggerServerEvent('giveAmmo', boxItem)
end)
