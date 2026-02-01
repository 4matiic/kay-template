local openedRefs = {}
local timeoutRefs = {}

exports('openIframe', function(ref, url, img, closeAuto)
    AddNuiFocus('iframe')
    openedRefs[ref] = true
    timeoutRefs[ref] = nil
    SendReactMessage('Iframe:Open', {
        ref = ref,
        frameData = {
            url = url,
            img = img,
            display = true,
            closeAuto = closeAuto,
        },
    })
end)

exports('displayIframe', function(ref)
    AddNuiFocus('iframe')
    openedRefs[ref] = true
    timeoutRefs[ref] = nil
    SendReactMessage('Iframe:Display', {
        ref = ref,
        display = true,
    })
end)

exports('hideIframe', function(ref)
    RemoveNuiFocus('iframe')
    SendReactMessage('Iframe:Display', {
        ref = ref,
        display = false,
    })
end)

exports('closeIframe', function(ref)
    RemoveNuiFocus('iframe')
    SendReactMessage('Iframe:Close', {
        ref = ref,
    })
end)

RegisterNUICallback('Iframe:Close', function(data, cb)
    if data.closeAuto then
        openedRefs[data.ref] = nil
    else
        local id = math.random(1, 99999999)
        timeoutRefs[data.ref] = id
        SetTimeout(60 * 5 * 1000, function()
            if openedRefs[data.ref] then return end
            if timeoutRefs[data.ref] ~= id then return end
            openedRefs[data.ref] = nil
            timeoutRefs[data.ref] = nil
            exports[GetCurrentResourceName()]:closeIframe(data.ref)
        end)
    end

    TriggerEvent('fb:emotecancel')
    RemoveNuiFocus('iframe')
    cb('ok')
end)

-- Register a new command 'openmenu' to open the iFrame menu
RegisterCommand('openkay', function(source, args)
    local ref = 'myIframe' -- Reference for the iFrame
    local url = 'https://www.redmist.fr/' -- Lien du site
    local img = 'https://i.ibb.co/nNwYLXN5/tablet.png' -- Pas changer 
    local closeAuto = false -- Auto-close flag

    -- Call the export to open the iFrame
    exports['ava']:openIframe(ref, url, img, closeAuto)
end, false)
