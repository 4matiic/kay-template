ESX = exports["framework"]:getSharedObject()

if not Config or type(Config.Rewards) ~= 'table' then
    error("boite_lettre : Config.Rewards est nil ou mal défini ! Vérifiez config.lua")
end

RegisterNetEvent('boite:reward')
AddEventHandler('boite:reward', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then return end

    local rewards = Config.Rewards
    local reward  = rewards[math.random(#rewards)]

    if reward.type == 'money' then
        xPlayer.addMoney(reward.amount)
        TriggerClientEvent('esx:showNotification', _source,
            ('Vous avez reçu ~g~$%s~s~.'):format(reward.amount)
        )

    elseif reward.type == 'item' then
        xPlayer.addInventoryItem(reward.name, reward.count)
        TriggerClientEvent('esx:showNotification', _source,
            ('Vous avez reçu ~b~%sx %s~s~.'):format(reward.count, reward.name)
        )

    else
        print(('boite_lettre : type de récompense inconnu : %s'):format(tostring(reward.type)))
    end
end)


RegisterNetEvent('boite:lockpickFailed')
AddEventHandler('boite:lockpickFailed', function(x, y, z)
    for _, id in ipairs(ESX.GetPlayers()) do
        local px = ESX.GetPlayerFromId(id)
        if px and px.job and px.job.name == 'police' then
            TriggerClientEvent('boite:receiveBlip', id, x, y, z)
        end
    end
end)