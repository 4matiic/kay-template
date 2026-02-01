ESX = exports['framework']:getSharedObject()

RegisterServerEvent('giveAmmo')
AddEventHandler('giveAmmo', function(boxItem)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ammoItem = Config.AmmoBoxes[boxItem]

    if not ammoItem then
        TriggerClientEvent('esx:showNotification', source, '~r~Cette boîte de munitions n\'est pas configurée.')
        return
    end

    if xPlayer.getInventoryItem(boxItem).count > 0 then
        local ammo = Config.RandomAmmo
            and math.random(Config.RandomAmmoRange.min, Config.RandomAmmoRange.max)
            or Config.FixedAmmo

        xPlayer.removeInventoryItem(boxItem, 1)
        xPlayer.addInventoryItem(ammoItem, ammo)

        TriggerClientEvent('esx:showNotification', source, ('Vous avez reçu ~g~%d~s~ munitions.'):format(ammo))
    else
        TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas cette boîte de munitions.')
    end
end)

for box, ammo in pairs(Config.AmmoBoxes) do
    ESX.RegisterUsableItem(box, function(source)
        TriggerClientEvent('useAmmoBox', source, box)
    end)
end