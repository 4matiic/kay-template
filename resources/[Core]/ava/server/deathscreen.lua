local ESX = exports['framework']:getSharedObject()
RegisterServerEvent(GetCurrentResourceName() .. ':callEMS')
AddEventHandler(GetCurrentResourceName() .. ':callEMS', function(x, y, z, deathReason)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            TriggerClientEvent(GetCurrentResourceName() .. ':callEMS', xPlayers[i], x, y, z, deathReason)
        end
    end
end)