AddEventHandler('nuiMessage', function(resource, ...)
    if GetCurrentResourceName() == resource then
        SendNUIMessage(...)
    end
end)

AddEventHandler('nuiFocus', function(resource, ...)
    if GetCurrentResourceName() == resource then
        SetNuiFocus(...)
    end
end)

AddEventHandler('nuiFocusKeepInput', function(resource, ...)
    if GetCurrentResourceName() == resource then
        SetNuiFocusKeepInput(...)
    end
end)

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "close" })
end)

RegisterNetEvent('nz:card:show')
AddEventHandler('nz:card:show', function(data)
    SendNUIMessage({
        action = "open", 
        name = data.name, 
        description = data.description, 
        number = data.number, 
        image = data.image,
        width = data.width, 
        height = data.height,
        blur = data.blur, 
        tilt = data.tilt
    })

    SetNuiFocus(true, true)
end) 