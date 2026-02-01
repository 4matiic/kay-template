ESX = exports["framework"]:getSharedObject()
local callback = nil

RegisterNUICallback('Keypad:Close', function(_, cb)
    callback = nil  
    cb('ok')  
    RemoveNuiFocus('keypad')
    SendReactMessage('Keypad:Visibility', {
        state = false,
        title = nil
    })
end)

RegisterNUICallback('Keypad:Response', function(data, cb)
    print("Keypad:Response event triggered with pin:", data.pin) 
    if callback then
        local tempCallback = callback  
        callback = nil  
        tempCallback(data.pin)  
    end
    cb('ok') 
end)


function OpenKeypad(cb, title)
    if callback then
        callback(nil)  
    end

    callback = cb
    AddNuiFocus('keypad')
    SendReactMessage('Keypad:Visibility', {
        state = true,
        title = title
    })
end

function CloseKeypad()
    callback = nil
    RemoveNuiFocus('keypad')
    SendReactMessage('Keypad:Visibility', {
        state = false,
        title = nil
    })
end

exports('OpenKeypad', OpenKeypad)
exports('CloseKeypad', CloseKeypad)

RegisterNetEvent('ava:OpenKeypad')
AddEventHandler('ava:OpenKeypad', function(title)
    OpenKeypad(function(pin)
        TriggerServerEvent('ava:ValidatePin', GetPlayerServerId(PlayerId()), pin)
    end, title)
end)

RegisterNetEvent('ava:CloseKeypad')
AddEventHandler('ava:CloseKeypad', function()
    CloseKeypad()
end)

RegisterNetEvent('ava:ValidationResult')
AddEventHandler('ava:ValidationResult', function(isCorrect)
    if isCorrect then
        SendReactMessage('Keypad:Response', { result = 'correct' }) 
    else
        SendReactMessage('Keypad:Response', { result = 'incorrect' }) 
    end
end)


-- RegisterCommand('tetet', function ()
--     TriggerEvent('ava:OpenKeypad')
-- end, false)