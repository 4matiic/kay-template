-- Événement pour afficher l'interface utilisateur
RegisterNetEvent('fb:warn:showUI')
AddEventHandler('fb:warn:showUI', function(reason)
    -- Affiche l'interface utilisateur avec la raison donnée
    AddNuiFocus('warn') 
    SendReactMessage('Warn:setReason', reason)
end)

-- Callback NUI lorsque l'interface d'avertissement est fermée
RegisterNUICallback('Warn:Close', function(data, cb)
    RemoveNuiFocus('warn')
    cb('ok')
end)
