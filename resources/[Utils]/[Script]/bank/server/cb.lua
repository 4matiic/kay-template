RegisterServerEvent(GetCurrentResourceName() .. ':giveCreditCard')
AddEventHandler(GetCurrentResourceName() .. ':giveCreditCard', function(source, iban, pin, name)
    exports.ox_inventory:AddItem(source, "cb", 1, {
        iban = iban,
        pin = pin,
        name = name
    })
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.showNotification('Compte bancaire créé avec successe.')
end)

RegisterServerEvent(GetCurrentResourceName() .. ':changeData')
AddEventHandler(GetCurrentResourceName() .. ':changeData', function(source, type, old, new)
    local cbItems = exports.ox_inventory:Search(source, 1, "cb")
    for _, v in pairs(cbItems) do
        if v.metadata and v.metadata[type] == old then
            v.metadata[type] = new
            exports.ox_inventory:SetMetadata(source, v.slot, v.metadata)
            ESX.GetPlayerFromId(source).showNotification(type .. ' mis à jour.')
            break
        end
    end
end)

function SendNotificationPlayer(source, message)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.showNotification(message)
end