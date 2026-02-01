-- Ouverture de l'interface du télégramme
RegisterNetEvent('ava:telegram:open', function()
    AddNuiFocus('telegram')
    AddNuiFocusKeepInput('telegram')
    TriggerEvent('fb:disableControlActions', 'telegram', true)
    SendReactMessage('Telegram:Visibility', true)


end)

-- Fermeture de l'interface du télégramme
RegisterNetEvent('ava:telegram:close', function()
    RemoveNuiFocus('telegram')
    RemoveNuiFocusKeepInput('telegram')
    TriggerEvent('fb:disableControlActions', 'telegram', false)
    SendReactMessage('Telegram:Visibility', false)
end)

-- Callback NUI pour fermer l'interface du télégramme
RegisterNUICallback('Telegram:Close', function(data, cb)
    RemoveNuiFocus('telegram')
    RemoveNuiFocusKeepInput('telegram')
    TriggerEvent('fb:disableControlActions', 'telegram', false)
    cb('ok')
end)

-- Commande pour ouvrir l'interface du télégramme
RegisterCommand('opentelegram', function()
    TriggerEvent('ava:telegram:open')
end, false)
