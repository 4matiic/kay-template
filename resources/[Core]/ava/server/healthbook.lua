ESX = exports['framework']:getSharedObject()


RegisterServerEvent('fb:character:healthbook:edit')
AddEventHandler('fb:character:healthbook:edit', function(source, data)
    print("Événement de modification de healthbook reçu")
    local xPlayer = ESX.GetPlayerFromId(source)
    local characterId = xPlayer.getCharacterId()

    print("Joueur ID : " .. characterId)

    -- Mettre à jour les informations du joueur
    MySQL.update('UPDATE users SET health = ?, armor = ?, hunger = ?, thirst = ? WHERE id = ?', {
        data.health,
        data.armor,
        data.hunger,
        data.thirst,
        characterId
    }, function(rowsChanged)
        print("Informations du joueur mises à jour")
    end)
end)

RegisterCommand('healthbook', function(source, args, rawCommand)
    print("Commande /healthbook reçue")
    local xPlayer = ESX.GetPlayerFromId(source)
    local characterId = xPlayer.getCharacterId()

    print("Joueur ID : " .. characterId)

    -- Récupérer les informations du joueur
    MySQL.query('SELECT health, armor, hunger, thirst FROM users WHERE id = ?', {characterId}, function(result)
        print("Informations du joueur récupérées")
        if result[1] then
            -- Ouvrir le healthbook
            TriggerClientEvent('ava:healthbook:open', source, {
                characterId = characterId,
                health = result[1].health,
                armor = result[1].armor,
                hunger = result[1].hunger,
                thirst = result[1].thirst
            })
            print("Healthbook ouvert")
        end
    end)
end)