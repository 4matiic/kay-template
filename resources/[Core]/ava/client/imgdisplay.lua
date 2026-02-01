local currentRef = nil

-- Événement pour afficher une image avec une URL et une durée optionnelle
RegisterNetEvent('ava:imgdisplay', function(ref, url, duration)
    currentRef = ref
    SendReactMessage('ImgDisplay:setUrl', url)

    if not duration then return end
    SetTimeout(duration, function()
        if currentRef ~= ref then return end
        currentRef = nil
        SendReactMessage('ImgDisplay:setUrl', nil)
    end)
end)

-- Commande pour afficher une image
RegisterCommand('displayimg', function(source, args, rawCommand)
    -- Récupère les arguments de la commande
    local ref = args[1] or "defaultRef" -- Référence par défaut si non spécifiée
    local url = args[2] or "https://media.discordapp.net/attachments/1265271601860186255/1275499225416994836/image.png?ex=66c76e38&is=66c61cb8&hm=5652863d69bd1b50b9ea0139bf13d36d211d697924f4d8faed820838ea9a323a&=&format=webp&quality=lossless&width=746&height=468" -- URL par défaut si non spécifiée
    local duration = tonumber(args[3]) or 5000 -- Durée par défaut de 5 secondes si non spécifiée

    -- Appelle l'événement pour afficher l'image
    TriggerEvent('ava:imgdisplay', ref, url, duration)
end, false)


