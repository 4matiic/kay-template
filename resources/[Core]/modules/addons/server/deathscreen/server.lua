ESX = exports["framework"]:getSharedObject()

local function SendToDiscord(webhook, title, message, color)
    if not Config.Logs.enabled or not webhook then return end
    
    local embed = {
        {
            ["title"] = title,
            ["description"] = message,
            ["color"] = color,
            ["footer"] = {
                ["text"] = "Logs - " .. os.date("%d/%m/%Y %H:%M:%S")
            }
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
        username = "Système de mort",
        embeds = embed
    }), { ['Content-Type'] = 'application/json' })
end

ESX.RegisterServerCallback('death:getDeathStatus', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return cb(false) end
    
    MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(isDead)
        cb(isDead == 1)
    end)
end)

RegisterServerEvent('death:playerDied')
AddEventHandler('death:playerDied', function(reason, coords)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    
    MySQL.Async.execute('UPDATE users SET is_dead = 1 WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    })
    
    if Config.Logs.enabled then
        local logMessage = string.format("Joueur: %s [%s]\nRaison: %s\nPosition: vector3(%.2f, %.2f, %.2f)",
            xPlayer.getName(), xPlayer.identifier,
            Config.DeathReasons[reason] or "Inconnue",
            coords.x, coords.y, coords.z
        )
        
        SendToDiscord(
            Config.Logs.webhooks.death,
            "☠️ Joueur mort",
            logMessage,
            Config.Logs.colors.death
        )
    end
end)

RegisterServerEvent('death:playerRevived')
AddEventHandler('death:playerRevived', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    
    MySQL.Async.execute('UPDATE users SET is_dead = 0 WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    })
end)

ESX.RegisterCommand('revive', 'admin', function(xPlayer, args, showError)
    if not xPlayer then
        return print('[^1ERROR^7] The xPlayer value is nil')
    end

    local targetPlayer
    if args.playerId then
        targetPlayer = ESX.GetPlayerFromId(args.playerId)
    else
        targetPlayer = xPlayer
    end

    if not targetPlayer then
        showError(Config.Messages.InvalidTarget)
        return
    end

    TriggerClientEvent('death:revivePlayer', targetPlayer.source, false)
    xPlayer.showNotification(string.format(Config.Messages.ReviveSuccess, targetPlayer.getName()))

    if Config.Logs.enabled then
        local logMessage = string.format("Admin: %s [%s]\nJoueur réanimé: %s [%s]",
            xPlayer.getName(), xPlayer.identifier,
            targetPlayer.getName(), targetPlayer.identifier
        )
        
        SendToDiscord(
            Config.Logs.webhooks.revive,
            "🔄 Revive effectué",
            logMessage,
            Config.Logs.colors.revive
        )
    end
end, false, {help = 'Réanimer un joueur', validate = false, arguments = {
    {name = 'playerId', help = 'ID du joueur (optionnel)', type = 'number', validate = false}
}})

RegisterServerEvent('death:requestEMS')
AddEventHandler('death:requestEMS', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    
    local emsOnline = false
    local xPlayers = ESX.GetPlayers()
    
    for i=1, #xPlayers do
        local xTarget = ESX.GetPlayerFromId(xPlayers[i])
        if xTarget.job.name == Config.Settings.EMSJob then
            emsOnline = true
            
            TriggerClientEvent('esx:showAdvancedNotification', xTarget.source,
                'Centrale EMS',
                'Appel d\'urgence',
                string.format('Raison: %s\nPatient: %s', Config.DeathReasons[data.reason] or "Inconnue", xPlayer.getName()),
                'CHAR_CALL911',
                1
            )
            
            TriggerClientEvent('death:setWaypoint', xTarget.source, data.coords)
        end
    end
    
    TriggerClientEvent('esx:showNotification', src, emsOnline and 'Les EMS ont été notifiés de votre situation.' or 'Aucun EMS en service actuellement.')
    
    if Config.Logs.enabled then
        local logMessage = string.format("Patient: %s [%s]\nRaison: %s\nEMS en service: %s\nPosition: vector3(%.2f, %.2f, %.2f)",
            xPlayer.getName(), xPlayer.identifier,
            Config.DeathReasons[data.reason] or "Inconnue",
            emsOnline and "Oui" or "Non",
            data.coords.x, data.coords.y, data.coords.z
        )
        
        SendToDiscord(
            Config.Logs.webhooks.emsCall,
            "🚑 Appel EMS",
            logMessage,
            Config.Logs.colors.emsCall
        )
    end
end)

RegisterServerEvent('death:acceptCall')
AddEventHandler('death:acceptCall', function(targetId)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local tPlayer = ESX.GetPlayerFromId(targetId)
    
    if not xPlayer or not tPlayer then return end
    if xPlayer.job.name ~= Config.Settings.EMSJob then return end
    
    TriggerClientEvent('death:doctorNotification', tPlayer.source, 'Un médecin est en route')
end)

RegisterServerEvent('death:timerEnded')
AddEventHandler('death:timerEnded', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    
    TriggerClientEvent('death:revivePlayer', src, true)
end)