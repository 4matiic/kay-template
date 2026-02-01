local currentSDCard, SDCardViewerMode = nil, false

-- Ouverture de l'interface de la carte SD avec un slot spécifique
RegisterNetEvent('fb:sdcard:open', function(images, slot)
    assert(type(images) == 'table', 'Invalid data for fb:sdcard:open')
    assert(type(slot) == 'number', 'Invalid slot type for fb:sdcard:open')

    currentSDCard, SDCardViewerMode = slot, false

    AddNuiFocus('sdcard')
    SendReactMessage('SDCard:SetImages', images)
    SendReactMessage('SDCard:SetViewerMode', false)
    SendReactMessage('SDCard:SetVisibility', true)
    TriggerEvent('fb:disableControlActions', 'sdcard', true)
    exports[GetCurrentResourceName()]:tmpHideHud(true, 'sdcard')
end)

-- Ouverture de l'interface de la carte SD en mode visualisation
RegisterNetEvent('fb:sdcard:show', function(images)
    assert(type(images) == 'table', 'Invalid data for fb:sdcard:show')

    currentSDCard, SDCardViewerMode = nil, true

    AddNuiFocus('sdcard')
    SendReactMessage('SDCard:SetImages', images)
    SendReactMessage('SDCard:SetViewerMode', true)
    SendReactMessage('SDCard:SetVisibility', true)
    TriggerEvent('fb:disableControlActions', 'sdcard', true)
    exports[GetCurrentResourceName()]:tmpHideHud(true, 'sdcard')
end)

-- Fermeture de l'interface de la carte SD
RegisterNetEvent('fb:sdcard:close', function()
    currentSDCard, SDCardViewerMode = nil, false

    RemoveNuiFocus('sdcard')
    SendReactMessage('SDCard:SetViewerMode', false)
    SendReactMessage('SDCard:SetVisibility', false)
    TriggerEvent('fb:disableControlActions', 'sdcard', false)
    exports[GetCurrentResourceName()]:tmpHideHud(false, 'sdcard')
end)

-- Callback NUI pour fermer l'interface de la carte SD
RegisterNUICallback('SDCard:Close', function(data, cb)
    currentSDCard, SDCardViewerMode = nil, false

    RemoveNuiFocus('sdcard')
    TriggerEvent('fb:disableControlActions', 'sdcard', false)
    exports[GetCurrentResourceName()]:tmpHideHud(false, 'sdcard')
    cb('ok')
end)

-- Callback NUI pour supprimer une image de la carte SD
RegisterNUICallback('SDCard:RemoveImage', function(data, cb)
    if SDCardViewerMode or not currentSDCard or not data or not data.src then return end
    exports[GetCurrentResourceName()]:displayPrompt('Carte SD', 'Voulez-vous vraiment supprimer cette image de la carte SD ?', false, {
        {
            text = "Refuser",
            style = { color = "red", active = true, icon = "cancel" },
            cb = function()
                cb(false)
            end,
        },
        {
            text = "Accepter",
            style = { color = "green", active = true, icon = "confirm" },
            cb = function()
                TriggerServerEvent('fb:sdcard:removeImage', data.src, currentSDCard)
                cb('ok')
            end,
        }
    })
end)

-- Callback NUI pour exporter/imprimer une image de la carte SD
RegisterNUICallback('SDCard:Export', function(data, cb)
    if SDCardViewerMode or not currentSDCard or not data or not data.src then return end
    exports[GetCurrentResourceName()]:displayPrompt('Carte SD', 'Voulez-vous vraiment imprimer cette image ?', false, {
        {
            text = "Refuser",
            style = { color = "red", active = true, icon = "cancel" },
            cb = function()
                cb(false)
            end,
        },
        {
            text = "Accepter",
            style = { color = "green", active = true, icon = "confirm" },
            cb = function()
                TriggerServerEvent('fb:sdcard:print', data.src, currentSDCard)
                cb('ok')
            end,
        }
    })
end)

-- Commande pour ouvrir l'interface de la carte SD avec un slot spécifique
RegisterCommand('opensdcard', function(source, args, rawCommand)
    local slot = tonumber(args[1]) or 1 -- Utilise le premier argument comme slot, par défaut 1

    -- Image par défaut
    local defaultImage = {
        { src = 'https://media.discordapp.net/attachments/1268670313659629580/1275857137142337556/image.png?ex=66c76a0d&is=66c6188d&hm=6c410b544fa7e804d875009df7e99440f70cec3f6bca914f77af8a2486b0491b&=&format=webp&quality=lossless&width=1193&height=671' } -- Remplacez cette URL par l'URL de votre image par défaut
    }

    -- Envoi de l'événement pour ouvrir l'interface avec l'image par défaut
    TriggerEvent('fb:sdcard:open', defaultImage, slot)
end, false)

-- Commande pour ouvrir l'interface de la carte SD en mode visualisation
RegisterCommand('showsdcard', function(source, args, rawCommand)
    local images = {} -- Remplacez ceci par une récupération réelle des images

    TriggerEvent('fb:sdcard:show', images)
end, false)

-- Commande pour fermer l'interface de la carte SD
RegisterCommand('closesdcard', function()
    TriggerEvent('fb:sdcard:close')
end, false)
