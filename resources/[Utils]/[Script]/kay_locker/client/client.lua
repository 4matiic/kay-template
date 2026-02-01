-- client.lua

local casierData = {}
local lastCasierId = nil

function DisplayHelpText(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, -1)
end


-- Fonction pour afficher les markers
local function drawCasierMarkers()
    while true do
        local waitTime = 1000 -- Intervalle par défaut
        local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed)

        for _, casier in ipairs(casierData) do
            if casier.position then
                local casierPos = vector3(casier.position.x, casier.position.y, casier.position.z)
                local dist = #(playerPos - casierPos)

                if dist < 3.5 then
                    waitTime = 0 -- Réduit l'attente pour une réactivité accrue
               
                    if dist < 1.5 then
                        DisplayHelpText("Appuyez sur ~INPUT_CONTEXT~ pour interagir avec le casier")
                        if IsControlJustPressed(0, 38) then -- Touche 'E'
                            if casier.job ~= "free" and ESX.GetPlayerData().job.name == casier.job or casier.job == "free" then 
                                SetNuiFocus(true, true)
                                SendNUIMessage({
                                    type = "updateCasiers",
                                    casiers = casier.casierData
                                })

                                lastCasierId = casier.id_u
                                SendNUIMessage({ action = "open" })
                                SendNUIMessage({
                                    action = 'setVisible',
                                    data = true
                                })
                            else 
                                TriggerEvent("casier:notify", "Vous n'avez pas accès à ce casier, jobs requis (" .. casier.job .. ")")
                            end
                        end
                    end
                end
            end
        end

        Citizen.Wait(waitTime)
    end
end


-- Gestion de la bascule de verrouillage
RegisterNUICallback('toggleLock', function(data, cb)
    local casierId = tonumber(data.id)
    for _, casier in ipairs(casierData) do
        if casier.id_u == lastCasierId then
            for _, lock in ipairs(casier.casierData) do
                if lock.id == casierId then
                    if lock.status == 'locked' then
                        -- Demander le PIN
                        SendNUIMessage({
                            type = "requestPIN",
                            casierId = casierId
                        })
                    else
                        -- Verrouiller le casier
                        TriggerServerEvent('casier:status', lastCasierId, casierId, 'locked')
                        lock.status = 'locked'
                        SendNUIMessage({
                            type = "updateCasiers",
                            casiers = casier.casierData
                        })
                    end
                    break
                end
            end
            break
        end
    end

    cb('ok')
end)

-- Gestion de la soumission du PIN
RegisterNUICallback('submitPIN', function(data, cb)
    local casierId = tonumber(data.id)
    local enteredPin = tonumber(data.pin)

    for _, casier in ipairs(casierData) do
        if casier.id_u == lastCasierId then
            for _, lock in ipairs(casier.casierData) do
                if lock.id == casierId then
                    if lock.pin == enteredPin then
                        -- Déverrouiller le casier
                        lock.status = 'unlocked'
                        TriggerServerEvent('casier:status', lastCasierId, casierId, 'unlocked')
                        TriggerEvent("openCasier", lastCasierId..casierId .. "open")
                        SendNUIMessage({
                            type = "updateCasiers",
                            casiers = casier.casierData
                        })
                        SendNUIMessage({ type = "pinSuccess", casierId = casierId })
                    else
                        -- PIN incorrect
                        SendNUIMessage({ type = "pinError", casierId = casierId })
                    end
                    break
                end
            end
            break
        end
    end

    cb('ok')
end)

-- Événement pour mettre à jour les casiers depuis le serveur
RegisterNetEvent('casier:updateCasiers')
AddEventHandler('casier:updateCasiers', function(data)
    casierData = data or {}
end)

-- Événement pour rafraîchir les casiers
RegisterNetEvent('casier:refresh')
AddEventHandler('casier:refresh', function(refresh, casierId)
    if casierId == lastCasierId then
        SendNUIMessage({
            type = "updateCasiers",
            casiers = refresh.casierData
        })
    end
end)

-- Demande initiale des casiers au serveur
Citizen.CreateThread(function()
    TriggerServerEvent('casier:requestCasiers')
end)

-- Démarrage du thread pour dessiner les markers
Citizen.CreateThread(drawCasierMarkers)

-- Gestion de l'ajout d'un nouveau casier via commande
RegisterCommand("addlocker", function()
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)

    local input = lib.inputDialog('Ajouter un Casier', {
        {type = 'input', label = 'Job associé', description = 'Job associé au casier "free" pour tout le monde', default = 'police'},
        {type = 'checkbox', label = 'Tout le monde peut créer un casier', description = 'Permet à tout le monde de créer un casier si non, seuls les chefs peuvent', default = false},
    })

    if input then
        local job = input[1]
        local everyOneCanCreate = input[2]

        local data = {
            position = { x = playerPos.x, y = playerPos.y, z = playerPos.z },
            job = job,
            everyOneCanCreate = everyOneCanCreate,
            casierData = {}
        }

        -- Initialisation des casiers avec des statuts libres
        for i = 1, 15 do
            table.insert(data.casierData, {
                name = "Casier " .. i,
                pin = 0000,
                id = i,
                status = 'free'
            })
        end

        TriggerServerEvent('casier:addCasier', data)
    end
end)

-- Commande pour ouvrir l'interface des casiers
RegisterCommand('openCasiers', function()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "open" })
    -- Mise à jour des casiers affichés dans l'UI
    for _, casier in ipairs(casierData) do
        if casier.id_u == lastCasierId then
            SendNUIMessage({
                type = "updateCasiers",
                casiers = casier.casierData
            })
            break
        end
    end
end)

-- Gestion de la fermeture de l'UI
RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Gestion de la requête de cacher l'UI
RegisterNUICallback('hideUI', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Fonction pour gérer l'affichage des casiers dans l'UI
RegisterNUICallback("toggleNew", function(data, cb)
    local casierId = tonumber(data.id)
    local input = lib.inputDialog('Configurer Casier', {
        {type = 'input', label = 'Nom du casier', description = 'Nom du casier', default = 'Nom du casier'},
        {type = 'number', label = 'PIN', description = 'PIN du casier', min = 0, max = 9999999999999999},
    })

    if input then
        local casierName = input[1]
        local casierPin = tonumber(input[2])

        TriggerServerEvent('casier:toggleNew', lastCasierId, casierId, casierName, casierPin)
    end

    cb('ok')
end)



-- Gestion de la gestion des casiers (changer PIN et nom)
RegisterNUICallback('toggleGestion', function(data, cb)
    local casierId = tonumber(data.id)

    for _, casier in ipairs(casierData) do
        if casier.id_u == lastCasierId then
            for _, lock in ipairs(casier.casierData) do
                if lock.id == casierId then
                    local input = lib.inputDialog('Configurer Casier', {
                        {type = 'number', label = 'PIN', description = 'PIN du casier', min = 0, max = 9999999999999999},
                    })

                    if input[1] == lock.pin then
                        local input = lib.inputDialog('Configurer Casier', {
                            {type = 'input', label = 'Nom du casier', description = 'Nom du casier', default = lock.name},
                            {type = 'number', label = 'PIN', description = 'Nouveau PIN du casier', default = lock.pin, min = 0, max = 9999999999999999},
                        })
                        casierName = input[1]
                        casierPin = tonumber(input[2])
                        TriggerServerEvent('casier:toggleNew', lastCasierId, casierId, casierName, casierPin)
                   
                    end

       
                end
            end
        end
    end
end)

RegisterNUICallback('viewContent', function(data, cb)
    local casierId = tonumber(data.id)
    for _, casier in ipairs(casierData) do
        if casier.id_u == lastCasierId then
            for _, lock in ipairs(casier.casierData) do
                if lock.id == casierId then
                    TriggerEvent("openCasier", lastCasierId..casierId .. "open")
                    break
                end
            end
        end
    end
    cb('ok')
end)

RegisterNUICallback('newCasier', function(data, cb)
    TriggerServerEvent('casier:addNewCasierInCasier', lastCasierId)
    cb('ok')
end)


RegisterNetEvent("casier:notify")
AddEventHandler("casier:notify", function(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end)


RegisterNetEvent("openCasier")
AddEventHandler("openCasier", function(casier)
    casier = tostring(casier)
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
    SetNuiFocus(false, false)

    exports.ox_inventory:openInventory('stash', {id=casier, owner=lastCasierId})
end)