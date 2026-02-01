-- server.lua

-- Tables pour stocker les données dispatch, squads, et wanted
local allowedGroups = {}
local xDispatchCallsData = {}
local xDispatchSquadsData = {}
local xDispatchWantedData = {}

-- Enregistrer les groupes autorisés
RegisterNetEvent('fb:dispatch:allowedGroups')
AddEventHandler('fb:dispatch:allowedGroups', function(playerId, _allowedGroups)
    allowedGroups[playerId] = _allowedGroups
    TriggerClientEvent('fb:dispatch:allowedGroups', playerId, _allowedGroups)
end)

RegisterNetEvent('fb:dispatch:allowedGroup')
AddEventHandler('fb:dispatch:allowedGroup', function(playerId, groupId, _allowedGroup)
    if not allowedGroups[playerId] then
        allowedGroups[playerId] = {}
    end
    allowedGroups[playerId][groupId] = _allowedGroup
    TriggerClientEvent('fb:dispatch:allowedGroup', playerId, groupId, _allowedGroup)
end)

-- Enregistrer les appels dispatch
RegisterNetEvent('fb:dispatch:xDispatchCallsData')
AddEventHandler('fb:dispatch:xDispatchCallsData', function(playerId, _xDispatchCallsData)
    xDispatchCallsData[playerId] = _xDispatchCallsData
    TriggerClientEvent('fb:dispatch:xDispatchCallsData', playerId, _xDispatchCallsData)
end)

RegisterNetEvent('fb:dispatch:xDispatchCallData')
AddEventHandler('fb:dispatch:xDispatchCallData', function(playerId, callId, xDispatchCall)
    if not xDispatchCallsData[playerId] then
        xDispatchCallsData[playerId] = {}
    end

    xDispatchCallsData[playerId][callId] = xDispatchCall
    TriggerClientEvent('fb:dispatch:xDispatchCallData', playerId, callId, xDispatchCall)
end)

-- Enregistrer les squads dispatch
RegisterNetEvent('fb:dispatch:squad:data')
AddEventHandler('fb:dispatch:squad:data', function(playerId, _xDispatchSquadsData)
    xDispatchSquadsData[playerId] = _xDispatchSquadsData
    TriggerClientEvent('fb:dispatch:squad:data', playerId, _xDispatchSquadsData)
end)

RegisterNetEvent('fb:dispatch:squad:new')
AddEventHandler('fb:dispatch:squad:new', function(playerId, groupId, squadId, xSquadData)
    if not xDispatchSquadsData[playerId] then
        xDispatchSquadsData[playerId] = {}
    end
    if not xDispatchSquadsData[playerId][groupId] then
        xDispatchSquadsData[playerId][groupId] = {}
    end

    xDispatchSquadsData[playerId][groupId][squadId] = xSquadData
    TriggerClientEvent('fb:dispatch:squad:new', playerId, groupId, squadId, xSquadData)
end)

RegisterNetEvent('fb:dispatch:squad:destroy')
AddEventHandler('fb:dispatch:squad:destroy', function(playerId, groupId, squadId)
    if xDispatchSquadsData[playerId] and xDispatchSquadsData[playerId][groupId] then
        xDispatchSquadsData[playerId][groupId][squadId] = nil
    end
    TriggerClientEvent('fb:dispatch:squad:destroy', playerId, groupId, squadId)
end)

-- Enregistrer les données wanted
RegisterNetEvent('fb:dispatch:wanted:data')
AddEventHandler('fb:dispatch:wanted:data', function(playerId, _xDispatchWantedData)
    xDispatchWantedData[playerId] = _xDispatchWantedData
    TriggerClientEvent('fb:dispatch:wanted:data', playerId, _xDispatchWantedData)
end)

RegisterNetEvent('fb:dispatch:wanted:update')
AddEventHandler('fb:dispatch:wanted:update', function(playerId, wantedId, xDispatchWanted)
    if not xDispatchWantedData[playerId] then
        xDispatchWantedData[playerId] = {}
    end

    xDispatchWantedData[playerId][wantedId] = xDispatchWanted
    TriggerClientEvent('fb:dispatch:wanted:update', playerId, wantedId, xDispatchWanted)
end)

RegisterNetEvent('fb:dispatch:wanted:delete')
AddEventHandler('fb:dispatch:wanted:delete', function(playerId, wantedId)
    if xDispatchWantedData[playerId] then
        xDispatchWantedData[playerId][wantedId] = nil
    end
    TriggerClientEvent('fb:dispatch:wanted:delete', playerId, wantedId)
end)

-- Gérer les commandes dispatch
RegisterCommand('fb_dispatch', function(source)
    local playerId = source
    TriggerClientEvent('fb:dispatch:open', playerId)
end, false)

-- Gérer l'attribution des squads
RegisterNetEvent('fb:dispatch:changeSquad')
AddEventHandler('fb:dispatch:changeSquad', function(playerId, characterId, groupId, squadId)
    -- Logique pour changer le squad d'un joueur
    -- Exemple : xDispatchSquadsData[playerId][groupId][squadId].characterId = characterId
    TriggerClientEvent('fb:dispatch:squad:changed', playerId, characterId, groupId, squadId)
end)

-- server.lua

-- Exemple de table pour stocker les jobs des joueurs
local playerJobs = {}

-- Définir le statut de service
RegisterNetEvent('fb:duty:setStatus')
AddEventHandler('fb:duty:setStatus', function(groupId, duty)
    local playerId = source
    local job = playerJobs[playerId]

    -- Assurez-vous que le joueur a le job 'police'
    if job == 'burgershot' then
        -- Mettre à jour le statut de service du joueur
        if not allowedGroups[playerId] then
            allowedGroups[playerId] = {}
        end

        if not allowedGroups[playerId][groupId] then
            allowedGroups[playerId][groupId] = {}
        end

        allowedGroups[playerId][groupId].duty = duty

        -- Envoyer les mises à jour aux clients concernés
        TriggerClientEvent('fb:duty:statusSet', playerId, groupId, duty)
    else
        print("Le joueur n'a pas le job 'police'.")
    end
end)

-- Exemple d'événement pour définir le job d'un joueur (à appeler lors de l'attribution du job)
RegisterNetEvent('fb:setPlayerJob')
AddEventHandler('fb:setPlayerJob', function(job)
    local playerId = source
    playerJobs[playerId] = job
end)


-- Autres événements et callbacks pour les fonctionnalités de dispatch
-- server.lua

RegisterCommand('openDispatch', function(source, args, rawCommand)
    -- Vérifiez que la commande est exécutée par un joueur (source > 0)
    if source > 0 then
        -- Envoyer un événement au client pour ouvrir l'interface dispatch
        TriggerClientEvent('fb:dispatch:open', source)
    else
        print("La commande 'openDispatch' ne peut être exécutée que par des joueurs.")
    end
end, false)
