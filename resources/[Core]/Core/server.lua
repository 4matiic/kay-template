ESX = exports['framework']:getSharedObject()

AddEventHandler('__cfx_internal:sendEvent', function(eventName, payload, src)
    print("[DEBUG ALL EVENTS] Reçu event: " .. eventName)
end)


local sessionTimes = {}

ESX.RegisterServerCallback('kay_f5:getPermissions', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local isStaff = xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'mod'

    local identifier = xPlayer.getIdentifier()
    print("^5[DEBUG VIP]^0 Identifier demandé: " .. identifier)

    MySQL.Async.fetchScalar('SELECT expire_at FROM vip_users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(expire)
        print("^6[DEBUG VIP]^0 Résultat expire_at: " .. tostring(expire))

        local isVIP = false
        if expire then
            local expireTime = tonumber(expire) / 1000 
            isVIP = expireTime > os.time()
        end

        print("^2[PERMISSIONS]^0 VIP: " .. tostring(isVIP) .. " | STAFF: " .. tostring(isStaff))
        cb(isVIP, isStaff)
    end)
end)


RegisterNetEvent('kay_f5:getPlayerInfo')
AddEventHandler('kay_f5:getPlayerInfo', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local identifier = xPlayer.getIdentifier()
    local job = xPlayer.getJob()
    local cash = xPlayer.getMoney()


    MySQL.Async.fetchScalar('SELECT balance FROM bank_accounts WHERE owner = @owner', {
        ['@owner'] = identifier    
    }, function(bankAmount)
        local bank = bankAmount or 0

        MySQL.Async.fetchScalar('SELECT playtime_minutes FROM users WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(playtimeMinutes)
            local hours = math.floor((playtimeMinutes or 0) / 60)
            local minutes = (playtimeMinutes or 0) % 60
            local formattedPlaytime = ("%02d:%02d Heure(s)"):format(hours, minutes)

            TriggerClientEvent('kay_f5:setPlayerInfo', src, {
                cash = cash,
                bank = bank,
                job = job and job.label or "N/A",
                secondjob = "Aucun",
                playtime = formattedPlaytime
            })
        end)
    end)
end)




RegisterCommand("addvip", function(source, args)
    local targetId = tonumber(args[1])
    local days = tonumber(args[2])
    if not targetId or not days then
        TriggerClientEvent('esx:showNotification', source, "Utilisation: /addvip [id] [jours]")
        return
    end

    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xTarget then
        TriggerClientEvent('esx:showNotification', source, "Joueur introuvable.")
        return
    end

    local identifier = xTarget.identifier
    local expireAt = (os.time() + (days * 86400)) * 1000 
    print("^2[ADDVIP]^0 Ajout VIP pour: " .. identifier .. " jusqu'à " .. tostring(expireAt))

    MySQL.Async.execute([[
        INSERT INTO vip_users (identifier, expire_at)
        VALUES (@identifier, @expire_at)
        ON DUPLICATE KEY UPDATE expire_at = @expire_at
    ]], {
        ['@identifier'] = identifier,
        ['@expire_at'] = expireAt
    }, function()
        TriggerClientEvent('esx:showNotification', source, "VIP ajouté pour " .. days .. " jour(s).")
        TriggerClientEvent('esx:showNotification', targetId, "Tu es maintenant VIP pour " .. days .. " jour(s)!")
    end)
end, true)


RegisterCommand("removevip", function(source, args)
    local targetId = tonumber(args[1])
    if not targetId then
        TriggerClientEvent('esx:showNotification', source, "Utilisation: /removevip [id]")
        return
    end

    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xTarget then
        TriggerClientEvent('esx:showNotification', source, "Joueur introuvable.")
        return
    end

    local identifier = xTarget.identifier

    MySQL.Async.execute('DELETE FROM vip_users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function()
        TriggerClientEvent('esx:showNotification', source, "VIP retiré.")
        TriggerClientEvent('esx:showNotification', targetId, "Ton statut VIP a été retiré.")
    end)
end, true)


RegisterCommand("checkvip", function(source, args)
    local targetId = tonumber(args[1])
    if not targetId then
        TriggerClientEvent('esx:showNotification', source, "Utilisation: /checkvip [id]")
        return
    end

    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xTarget then
        TriggerClientEvent('esx:showNotification', source, "Joueur introuvable.")
        return
    end

    local identifier = xTarget.identifier

    MySQL.Async.fetchScalar('SELECT expire_at FROM vip_users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(expire)
        if not expire then
            TriggerClientEvent('esx:showNotification', source, "Ce joueur n'est pas VIP.")
        else
            local expireTime = os.date('%Y-%m-%d %H:%M:%S', tonumber(expire) / 1000)
            TriggerClientEvent('esx:showNotification', source, "VIP actif jusqu'au ~g~" .. expireTime)
        end
    end)
end, true)


CreateThread(function()
    while true do
        Wait(60 * 1000)
        for _, playerId in ipairs(GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(playerId)
            if xPlayer then
                MySQL.Async.execute('UPDATE users SET playtime_minutes = playtime_minutes + 1 WHERE identifier = @identifier', {
                    ['@identifier'] = xPlayer.getIdentifier()
                })
            end
        end
    end
end)


local itemUsageTracker = {}

function canUseItemReward(identifier)
    local currentDay = os.date("%Y-%m-%d")
    if not itemUsageTracker[identifier] then
        itemUsageTracker[identifier] = { date = currentDay, count = 0 }
    end

    if itemUsageTracker[identifier].date ~= currentDay then
        itemUsageTracker[identifier] = { date = currentDay, count = 0 }
    end

    if itemUsageTracker[identifier].count >= 2 then
        return false
    end

    itemUsageTracker[identifier].count = itemUsageTracker[identifier].count + 1
    return true
end


ESX.RegisterServerCallback("kay_f5:getRandomItem", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return cb(false, "Erreur joueur") end

    local identifier = xPlayer.getIdentifier()
    if not canUseItemReward(identifier) then
        return cb(false, "~r~Tu as déjà utilisé cette option 2 fois aujourd'hui.")
    end

    local items = {
        { item = "water", chance = 60 },
        { item = "bread", chance = 30 },
        { item = "burger", chance = 10 }
    }
    

    local rnd = math.random(1, 100)
    local givenItem = nil

    for _, data in ipairs(items) do
        if rnd <= data.chance then
            givenItem = data.item
            break
        else
            rnd = rnd - data.chance
        end
    end

    print("^2[RANDOM_ITEM]^0 Item choisi : " .. tostring(givenItem))
    if givenItem then
        xPlayer.addInventoryItem(givenItem, 1)
        cb(true, "~g~Tu as reçu : ~s~" .. givenItem)
    else
        cb(false, "~r~Aucun item gagné.")
    end
end)


