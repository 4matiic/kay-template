RegisterNetEvent('vape:bmx-useItem', function()
    local src = source
    local itemCount = exports.ox_inventory:GetItemCount(src, 'bmx')

    if itemCount > 0 then
        local success = exports.ox_inventory:RemoveItem(src, 'bmx', 1) 
        if success then
            TriggerClientEvent('vape:bmx-useItem', src)
            --TriggerClientEvent('esx:showNotification', src, '~g~Vous avez sorti un BMX.')
        else
            TriggerClientEvent('esx:showNotification', src, '~r~Erreur')
        end
    else
        TriggerClientEvent('esx:showNotification', src, '~r~Vous n\'avez pas de BMX dans votre inventaire.')
    end
end)


RegisterNetEvent('vape:bmx-returnItem', function()
    local src = source
    local canCarry = exports.ox_inventory:CanCarryItem(src, 'bmx', 1)
    if canCarry then
        local success = exports.ox_inventory:AddItem(src, 'bmx', 1)
        if success then
            --TriggerClientEvent('esx:showNotification', src, '~g~BMX ajouté à votre inventaire.')
        else
            TriggerClientEvent('esx:showNotification', src, '~r~Erreur')
        end
    else
        TriggerClientEvent('esx:showNotification', src, '~r~Vous n\'avez pas assez de place')
    end
end)

