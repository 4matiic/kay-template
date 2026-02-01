-- Variables pour stocker les informations de l'avertissement
local warnReason = nil
local warnPlayerId = nil

-- Événement pour ouvrir l'interface d'avertissement avec la raison fournie
RegisterNetEvent('fb:warn:setReason', function(playerId, reason)
    warnPlayerId = playerId
    warnReason = reason
    -- Assurez-vous que l'ID du joueur et la raison sont envoyés à l'interface utilisateur
    TriggerClientEvent('fb:warn:showUI', playerId, reason)
end)

-- Commande pour ouvrir l'interface d'avertissement
RegisterCommand('openwarn', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)

    -- Vérifie si le joueur appartient aux groupes "admin" ou "mod"
    if xPlayer and (xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "mod") then
        -- Vérifie si un ID de joueur est fourni
        local playerId = tonumber(args[1])
        local reason = table.concat(args, " ", 2) or "No reason specified"

        if playerId then
            -- Appelle l'événement pour ouvrir l'interface d'avertissement avec l'ID du joueur et la raison
            TriggerEvent('fb:warn:setReason', playerId, reason)
            -- Optionnel : Notification pour confirmer l'action
            xPlayer.showNotification("~g~Avertissement envoyé au joueur ID " .. playerId .. " avec la raison : " .. reason)
        else
            -- Avertir l'utilisateur que l'ID du joueur est requis
            xPlayer.showNotification("~r~Usage: /openwarn [playerId] [reason]")
        end
    else
        -- Notification pour les joueurs sans permissions
        xPlayer.showNotification("~r~Vous n'avez pas la permission d'utiliser cette commande.")
    end
end, false)

