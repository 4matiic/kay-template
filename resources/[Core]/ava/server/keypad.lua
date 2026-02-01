ESX = exports["framework"]:getSharedObject()

-- Enregistre l'événement 'OpenKeypad' côté serveur pour recevoir le code PIN
RegisterNetEvent('ava:OpenKeypad')
AddEventHandler('ava:OpenKeypad', function(title, callbackEvent)
    local _source = source
    TriggerClientEvent('ava:OpenKeypad', _source, title)

    -- Attendre la réponse du client
    local receivedPin = nil
    local callback = function(pin)
        receivedPin = pin
    end

    local timeout = 5000 -- Temps d'attente maximum pour la saisie du code PIN (en millisecondes)
    local start = GetGameTimer()

    while receivedPin == nil and GetGameTimer() - start < timeout do
        Citizen.Wait(100)
    end

    if receivedPin then
        TriggerEvent(callbackEvent, _source, receivedPin)
    else
        -- Gérer le cas où l'utilisateur n'a pas entré de code PIN
        print('Temps écoulé sans réponse du joueur.')
    end
end)

RegisterNetEvent('ava:ValidatePin')
AddEventHandler('ava:ValidatePin', function(source, pin)
    local correctPin = "1234" -- Code PIN correct
    pin = tostring(pin) -- Assurez-vous que le PIN est traité comme une chaîne de caractères
    print('Reçu pin:', pin) -- Débogage : afficher le PIN reçu

    if pin == correctPin then
        TriggerClientEvent('esx:showNotification', source, 'Code correct')
        TriggerClientEvent('ava:ValidationResult', source, 'correct') -- Envoi "true" si le PIN est correct
        Wait(1000)
        TriggerClientEvent('ava:CloseKeypad', source)
        TriggerClientEvent('esx:showNotification', source, "Le code est ~g~correct")
    else
        TriggerClientEvent('ava:CloseKeypad', source)
        TriggerClientEvent('esx:showNotification', source, 'Code incorrect')
        TriggerClientEvent('ava:ValidationResult', source, 'incorrect') -- Envoi "false" si le PIN est incorrect
        Wait(1000)
        TriggerClientEvent('ava:CloseKeypad', source)
        TriggerClientEvent('esx:showNotification', source, "Le code est ~r~incorrect")
    end
end)
