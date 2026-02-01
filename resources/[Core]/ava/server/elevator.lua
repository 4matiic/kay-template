local playerElevatorFloors = {}

Config = Config or {}
local elevatorFloorsCoords = Config.ElevatorPoliceFloorsCoords

RegisterServerEvent('fb:action:elevator')
AddEventHandler('fb:action:elevator', function(floor)
    local src = source
    local playerID = GetPlayerIdentifier(src)

    -- Utiliser un thread pour gérer l'opération avec une temporisation
    Citizen.CreateThread(function()
        Wait(0)  -- Petite pause pour s'assurer que tout est bien chargé

        -- Initialiser la table pour le joueur si elle n'existe pas encore
        if not playerElevatorFloors[playerID] then
            playerElevatorFloors[playerID] = {}
        end

        -- Ajouter l'étage à la liste des étages du joueur
        table.insert(playerElevatorFloors[playerID], floor)

        -- Récupérer les coordonnées de l'étage et téléporter le joueur
        local coords = elevatorFloorsCoords[floor]
        if coords then
            Wait(500)  -- Temporisation pour simuler un délai avant la téléportation
            TriggerClientEvent('fb:elevator:teleport', src, coords)
        end
    end)
end)

AddEventHandler('playerDropped', function()
    local src = source
    local playerID = GetPlayerIdentifier(src)

    -- Utiliser un thread pour gérer la suppression des données du joueur
    Citizen.CreateThread(function()
        Wait(100)  -- Petite temporisation avant de supprimer les données
        playerElevatorFloors[playerID] = nil
    end)
end)
